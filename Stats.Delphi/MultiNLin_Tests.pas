unit MultiNLin_Tests;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, StatTools, ComCtrls, Series, TeEngine,
  TeeProcs, Chart, Buttons, TeeGDIPlus;

type
  TfrmMultiNonLinTest = class(TfrmBasic)
    Panel2: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Label5: TLabel;
    Edit3: TEdit;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    Memo2: TMemo;
    Chart1: TChart;
    Series1: TPointSeries;
    Series2: TLineSeries;
    CheckBox1: TCheckBox;
    ConvergenceTolEdit: TEdit;
    Label6: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ConvergenceTolEditChange(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    MtxNonLinReg: TMtxMultiNonLinReg;
    procedure FillData(Const Index: Integer);
    procedure ResetEstimates(Const Index: Integer);
    procedure DisplayInfo(Const Index: Integer);
    procedure WriteToLog(Elapsed: double);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMultiNonLinTest: TfrmMultiNonLinTest;

implementation

Uses Optimization, MtxVecTee, Math387, MtxVecEdit, LogMemo, MtxVec,
  MtxIntDiff, AbstractMtxVec, Types, MtxExpr;

{$I BdsppDefs.inc}

{$R *.DFM}

procedure Eckerle4(const B: TVec; const X: TVecList; const Y: TVec);
begin
//  Result := B[0]/B[1] * Exp(-0.5*Sqr((X-B[2])/B[1]));

    Y.Normalize(X[0], B[2], B[1]);
    Y.Sqr;
    Y.Scale(-0.5);
    Y.Exp;
    Y.Scale(B[0]/B[1]);
end;

procedure Thurber(const B: TVec; const X: TVecList; const Y: TVec);
var num, den: Vector;
    xSqr: TVec;
begin
//  Result := (B[0] + B[1]*X + B[2]*Sqr(X) + B[3]*IntPower(X,3)) /
//            (1.0 + B[4]*X + B[5]*Sqr(X) + B[6]*IntPower(X,3));

   xSqr := y; //alias
   xSqr.Sqr(x[0]);

   num.Mul(xSqr, x[0]); //IntPower(X, 3)
   den.Copy(num);

   num.Scale(B[3]);
   num.AddScaled(xSqr, B[2]);
   num.AddScaled(X[0], B[1]);
   num.Add(B[0]);

   den.Scale(B[6]);
   den.AddScaled(xSqr, B[5]);
   den.AddScaled(X[0], B[4]);
   den.Add(1);

   y.Divide(num, den);
end;

procedure MultiThurber(const B: TVec; const X: TVecList; const Y: TVec);
var num, den: Vector;
begin
  //  Result := (B[0] + B[1]*X + B[2]*Sqr(X) + B[3]*IntPower(X,3)) /
  //            (1.0 + B[4]*X + B[5]*Sqr(X) + B[6]*IntPower(X,3));

  //x[2] = IntPower(x, 3), x[1] = sqr(x), x[0] = x, (precomputed !!)

   num.Mul(X[2], B[3]);
   num.AddScaled(X[1], B[2]);
   num.AddScaled(X[0], B[1]);
   num.Add(B[0]);

   den.Mul(x[2], B[6]);
   den.AddScaled(X[1], B[5]);
   den.AddScaled(X[0], B[4]);
   den.Add(1);

   y.Divide(num, den);
end;

procedure Rat42(const B: TVec; const X: TVecList; const Y: TVec);
begin
//  Result := B[0] / (1.0 + Exp(B[1] - B[2]*X));

   Y.Mul(X[0], -B[2]);
   Y.Add(B[1]);
   Y.Exp;
   Y.Add(1);
   Y.DivideBy(B[0]);
end;

procedure Misra1c(const B: TVec; const X: TVecList; const Y: TVec);
begin
//   Result := B[0]*(1 - Power(1 + 2*B[1]*X,-0.5));

   Y.Mul(X[0], 2*B[1]);
   Y.Add(1);
   Y.Sqrt;
   Y.Inv; // y = 1/y
   Y.SubFrom(1);
   Y.Scale(B[0]);
end;

procedure MGH09(const B: TVec; const X: TVecList; const Y: TVec);
var num, den: Vector;
    sqrX: TVec;
begin
//   Result := B[0]*(sqr(X) + X*B[1]) / (sqr(X) + X*B[2] + B[3]);

    sqrX := y; //alias

    sqrX.Sqr(X[0]);

    den.Mul(X[0], B[2]);
    den.Add(sqrX);
    den.Add(B[3]);

    num.Mul(x[0], B[1]);
    num.Add(sqrX);
    num.Mul(B[0]);

    y.Divide(num, den);
end;

procedure Chwirut2(const B: TVec; const X: TVecList; const Y: TVec);
var num, den: Vector;
begin
//    Result := Exp( -B[0] * X)/(B[1] + B[2] * X);

    num.Mul(X[0], -B[0]);
    num.Exp;

    den.Mul(X[0],  B[2]);
    den.Add(B[1]);

    y.Divide(num, den);
end;

procedure MGH10(const B: TVec; const X: TVecList; const y: TVec);
begin
//  Result := B[0]*Exp( B[1] / (X + B[2]) );

    y.Add(X[0], B[2]);
    y.DivideBy(B[1]);  // y = B[1]/y
    y.Exp;
    y.Scale(B[0]);
end;

procedure Roszman1(const B: TVec; const X: TVecList; const y: TVec);
begin
//  Result := B[0] - B[1]*X - ArcTan( B[2]/(X-B[3]))/PI;

    y.Sub(X[0], B[3]);
    Y.DivideBy(B[2]);
    Y.ArcTan;
    Y.Mul(1/PI);
    Y.AddScaled(X[0], B[1]);
    Y.SubFrom(B[0]);
end;

procedure Rat43(const B: TVec; const X: TVecList; const y: TVec);
var den: Vector;
begin
//  Result := B[0] / Power((1.0 + Exp(B[1] - B[2]*X)),1/B[3]);

    den.Mul(X[0], -B[2]);
    den.Add(B[1]);
    den.Exp;
    den.Add(1);

    y.Power(den, -1/B[3]);
    y.Scale(B[0]);
end;

procedure TfrmMultiNonLinTest.FormShow(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex := 1; { Default = Marquardt method }
  ComboBox2.ItemIndex := 0;
  ComboBox2Change(Self);
end;

procedure TfrmMultiNonLinTest.ComboBox1Change(Sender: TObject);
begin
  MtxNonLinReg.OptMethod := TOptMethod(ComboBox1.ItemIndex);
  SpeedButton1.Enabled := true;
end;

procedure TfrmMultiNonLinTest.ComboBox2Change(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
    0: MtxNonLinReg.RegressFunction := Eckerle4;
    1: MtxNonLinReg.RegressFunction := Thurber;
    2: MtxNonLinReg.RegressFunction := Rat42;
    3: MtxNonLinReg.RegressFunction := Misra1c;
    4: MtxNonLinReg.RegressFunction := MGH09;
    5: MtxNonLinReg.RegressFunction := Chwirut2;
    6: MtxNonLinReg.RegressFunction := MGH10;
    7: MtxNonLinReg.RegressFunction := Roszman1;
    8: MtxNonLinReg.RegressFunction := Rat43;
    9: MtxNonLinReg.RegressFunction := MultiThurber;
  end;
  SpeedButton1.Enabled := true;
  DisplayInfo(ComboBox2.ItemIndex);
  FillData(ComboBox2.ItemIndex);
  Series1.Clear;
  Series2.Clear;
  DrawValues(MtxNonLinReg.X[0], MtxNonLinReg.Y,Series1,false); { original data }
end;

procedure TfrmMultiNonLinTest.FillData(Const Index: Integer);
begin
  MtxNonLinReg.X.Clear;

  if Index = 0 then { Eckerle4 }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[400.0, 405.0, 410.0, 415.0,
                   420.0, 425.0, 430.0, 435.0,
                   436.5, 438.0, 439.5, 441.0,
                   442.5, 444.0, 445.5, 447.0,
                   448.5, 450.0, 451.5, 453.0,
                   454.5, 456.0, 457.5, 459.0,
                   460.5, 462.0, 463.5, 465.0,
                   470.0, 475.0, 480.0, 485.0,
                   490.0, 495.0, 500.0]);
    MtxNonLinReg.Y.SetIt(false,[0.0001575, 0.0001699, 0.0002350, 0.0003102,

                   0.0004917, 0.0008710, 0.0017418, 0.0046400,
                   0.0065895, 0.0097302, 0.0149002, 0.0237310,
                   0.0401683, 0.0712559, 0.1264458, 0.2073413,
                   0.2902366, 0.3445623, 0.3698049, 0.3668534,
                   0.3106727, 0.2078154, 0.1164354, 0.0616764,
                   0.0337200, 0.0194023, 0.0117831, 0.0074357,
                   0.0022732, 0.0008800, 0.0004579, 0.0002345,
                   0.0001586, 0.0001143, 0.0000710]);

  end
  else if Index = 1 then {Thurber }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[-3.067, -2.981, -2.921, -2.912,
                                -2.840, -2.797, -2.702, -2.699,
                                -2.633, -2.481, -2.363, -2.322,
                                -1.501, -1.460, -1.274, -1.212,
                                -1.100, -1.046, -0.915, -0.714,
                                -0.566, -0.545, -0.400, -0.309,
                                -0.109, -0.103, 0.010, 0.119,
                                0.377, 0.790, 0.963, 1.006,
                                1.115, 1.572, 1.841, 2.047, 2.200]);
    MtxNonLinReg.Y.SetIt(false,[80.574, 84.248, 87.264, 87.195,
                                89.076, 89.608, 89.868, 90.101,
                                92.405, 95.854, 100.696, 101.060,
                                401.672, 390.724, 567.534, 635.316,
                                733.054, 759.087, 894.206, 990.785,
                                1090.109, 1080.914, 1122.643, 1178.351,
                                1260.531, 1273.514, 1288.339, 1327.543,
                                1353.863, 1414.509, 1425.208, 1421.384,
                                1442.962, 1464.350, 1468.705, 1447.894, 1457.628]);

  end
  else if Index = 2 then { Rat42 }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[9.000, 14.000, 21.000, 28.000,
                                42.000, 57.000, 63.000, 70.000,
                                79.000]);
    MtxNonLinReg.Y.SetIt(false,[8.930, 10.800, 18.590, 22.330,
                                39.350, 56.110, 61.730, 64.620,
                                67.080]);
  end
  else if Index = 3 then { Misra1c }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[77.6, 114.9, 141.1, 190.8, 239.9,
                                289.0, 332.8, 378.4, 434.8, 477.3,
                                536.8, 593.1, 689.1, 760.0]);
    MtxNonLinReg.Y.SetIt(false,[10.07, 14.73, 17.94, 23.93, 29.61,
                                35.18, 40.02, 44.82, 50.76, 55.05,
                                61.01, 66.40, 75.47, 81.78]);
  end
  else if Index = 4 then { MGH09 }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[4.000000E+00, 2.000000E+00, 1.000000E+00,
                                5.000000E-01, 2.500000E-01, 1.670000E-01,
                                1.250000E-01, 1.000000E-01, 8.330000E-02,
                                7.140000E-02, 6.250000E-02]);
    MtxNonLinReg.Y.SetIt(false,[1.957000E-01, 1.947000E-01, 1.735000E-01,
                                1.600000E-01, 8.440000E-02, 6.270000E-02,
                                4.560000E-02, 3.420000E-02, 3.230000E-02,
                                2.350000E-02, 2.460000E-02]);
  end
  else if Index = 5 then { Chiwrut2 }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[0.50, 1.00, 1.75, 3.75, 5.75, 0.875, 2.25,
                                3.25, 5.25, 0.75, 1.75, 2.75, 4.75, 0.625,
                                1.25, 2.25, 4.25, 0.50, 3.00, 0.75, 3.00,
                                1.50, 6.00, 3.00, 6.00, 1.50, 3.00, 0.50,
                                2.00, 4.00, 0.75, 2.00, 5.00, 0.75, 2.25,
                                3.75, 5.75, 3.00, 0.75, 2.50, 4.00, 0.75,
                                2.50, 4.00, 0.75, 2.50, 4.00, 0.50, 6.00,
                                3.00, 0.50, 2.75, 0.50, 1.75]);
    MtxNonLinReg.Y.SetIt(false,[92.90,57.1, 31.05, 11.5875, 8.025, 63.6,
                                21.40, 14.25, 8.475, 63.80, 26.8, 16.4625,
                                7.125, 67.30, 41.00, 21.15, 8.175, 81.50, 13.12,
                                59.90, 14.62, 32.90, 5.44, 12.56, 5.44,
                                32.00, 13.95, 75.80, 20.00, 10.42, 59.50, 21.67,
                                8.55, 62.00, 20.20, 7.76, 3.75, 11.81, 54.70,
                                23.70, 11.55, 61.30, 17.70, 8.74, 59.20, 16.30,
                                8.62, 81.00, 4.87, 14.62, 81.70, 17.17, 81.30,
                                28.90]);
  end
  else if Index = 6 then { MGH10 }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].Size(16);
    MTxNonLinReg.X[0].Ramp(50,5);
    MtxNonLinReg.Y.SetIt(false,[3.478000E+04, 2.861000E+04, 2.365000E+04, 1.963000E+04,
                                1.637000E+04, 1.372000E+04, 1.154000E+04, 9.744000E+03,
                                8.261000E+03, 7.030000E+03, 6.005000E+03, 5.147000E+03,
                                4.427000E+03, 3.820000E+03, 3.307000E+03, 2.872000E+03]);
  end
  else if Index = 7 then { Roszman1 }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[-4868.68,-4868.09,-4867.41,-3375.19,-3373.14,-3372.03,
                                -2473.74,-2472.35,-2469.45,-1894.65,-1893.40,-1497.24,
                                -1495.85,-1493.41,-1208.68,-1206.18,-1206.04,-997.92,
                                -996.61,-996.31,-834.94,-834.66,-710.03,-530.16,-464.17]);
    MtxNonLinReg.Y.SetIt(false,[0.252429,0.252141,0.251809,0.297989,0.296257,0.295319,
                                0.339603,0.337731,0.333820,0.389510,0.386998,0.438864,
                                0.434887,0.427893,0.471568,0.461699,0.461144,0.513532,
                                0.506641,0.505062,0.535648,0.533726,0.568064,0.612886,0.624169]);
  end
  else if Index = 8 then { Rat43 }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].Size(15);
    MtxNonLinReg.X[0].Ramp(1,1);
    MtxNonLinReg.Y.SetIt(false,[16.08,33.83,65.80,97.20,191.55,326.20,386.87,520.53,590.03,
                                651.92,724.93,699.56,689.96,637.56,717.41]);
  end
  else if Index = 9 then {Thurber }
  begin
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X.Add;
    MtxNonLinReg.X[0].SetIt(false,[-3.067, -2.981, -2.921, -2.912,
                                  -2.840, -2.797, -2.702, -2.699,
                                  -2.633, -2.481, -2.363, -2.322,
                                  -1.501, -1.460, -1.274, -1.212,
                                  -1.100, -1.046, -0.915, -0.714,
                                  -0.566, -0.545, -0.400, -0.309,
                                  -0.109, -0.103, 0.010, 0.119,
                                  0.377, 0.790, 0.963, 1.006,
                                  1.115, 1.572, 1.841, 2.047, 2.200]);
    MtxNonLinReg.X[1].Sqr(MtxNonLinReg.X[0]); //x^2
    MtxNonLinReg.X[2].Mul(MtxNonLinReg.X[0], MtxNonLinReg.X[1]); //x^3
    MtxNonLinReg.Y.SetIt(false,[80.574, 84.248, 87.264, 87.195,
                                89.076, 89.608, 89.868, 90.101,
                                92.405, 95.854, 100.696, 101.060,
                                401.672, 390.724, 567.534, 635.316,
                                733.054, 759.087, 894.206, 990.785,
                                1090.109, 1080.914, 1122.643, 1178.351,
                                1260.531, 1273.514, 1288.339, 1327.543,
                                1353.863, 1414.509, 1425.208, 1421.384,
                                1442.962, 1464.350, 1468.705, 1447.894, 1457.628]);
  end;
end;

procedure TfrmMultiNonLinTest.SpeedButton1Click(Sender: TObject);
begin
    Screen.Cursor := crHourGlass;
    try
        Edit1Change(Self); { check if we have to calc more }
        Edit3Change(Self); { check if we have to calc more }
        ConvergenceTolEditChange(Self); { check if we have to calc more }

        ResetEstimates(ComboBox2.ItemIndex); { reset parameter estimates }
        StartTimer;
        MtxNonLinReg.Recalc; { main calculation }
        WriteToLog(StopTimer*1000);
        DrawValues(MtxNonLinReg.X[0], MtxNonLinReg.YCalc,Series2,false);
    finally
//        SpeedButton1.Enabled := false;
        CheckBox1Click(Self);
        Screen.Cursor := crDefault;
    end;
end;

procedure TfrmMultiNonLinTest.DisplayInfo(const Index: Integer);
begin
  Memo2.Lines.Clear;
  With Memo2.Lines do
    if Index = 0 then
    begin
      Add('Description :');
      Add('These data are the result of a NIST study involving circular interference'+
          ' transmittance.  The response variable is transmittance, and the predictor'+
          ' variable is wavelength.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y = transmittance)');
      Add('               1 Predictor Variable (x = wavelength)');
      Add('               35 Observations');
      Add('               Higher Level of Difficulty');
      Add('Model:');
      Add('               Exponential Class');
      Add('               3 Parameters (b[0] to b[2])');
      Add('               Y = B[0]/B[1] * Exp(-0.5*Sqr((X-B[2])/B[1]))');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 1.5543827178');
      Add('               b[1] = 4.0888321754');
      Add('               b[2] = 451.54121844');
    end
    else if Index = 1 then
    begin
      Add('Description :');
      Add('These data are the result of a NIST study involving semiconductor'+
          ' electron mobility.  The response variable is a measure of electron'+
          ' mobility, and the predictor variable is the natural log of the density.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y = electron mobility)');
      Add('               1 Predictor Variable (x = ln[density])');
      Add('               37 Observations');
      Add('               Higher Level of Difficulty');
      Add('Model:');
      Add('               Rational Class (cubic/cubic)');
      Add('               7 Parameters (b[0] to b[6])');
      Add('               Y = (B[0] + B[1]*X + B[2]*Sqr(X) + B[3]*IntPower(X,3)) / ');
      Add('                   (1.0 + B[4]*X + B[5]*Sqr(X) + B[6]*IntPower(X,3))');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 1288.1396800');
      Add('               b[1] = 1491.0792535');
      Add('               b[2] = 583.23836877');
      Add('               b[3] = 75.416644291');
      Add('               b[4] = 0.96629502864');
      Add('               b[5] = 0.39797285797');
      Add('               b[6] = 0.049727297349');
    end
    else if Index = 2 then
    begin
      Add('Description :');
      Add('This model and data are an example of fitting sigmoidal growth curves taken from Ratkowsky (1983).'+
          'The response variable is pasture yield, and the predictor variable is growing time.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y = pasture yield)');
      Add('               1 Predictor Variable (x = growing time)');
      Add('               9 Observations');
      Add('               Higher Level of Difficulty');
      Add('Model:');
      Add('               Rational Class (cubic/cubic)');
      Add('               3 Parameters (b[0] to b[2])');
      Add('               Y = B[0] / (1.0 + Exp(B[1]-B[2]*X))');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 72.462237576');
      Add('               b[1] = 2.6180768402');
      Add('               b[2] = 0.067359200066');
    end
    else if Index = 3 then
    begin
      Add('Description :');
      Add('These data are the result of a NIST study regarding dental research in monomolecular'+
          ' adsorption. The response variable is volume, and the predictor variable is pressure');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y = volume)');
      Add('               1 Predictor Variable (x = pressure)');
      Add('               14 Observations');
      Add('               Average Level of Difficulty');
      Add('Model:');
      Add('               Miscellaneous Class');
      Add('               2 Parameters (b[0] and b[1])');
      Add('               Y = B[0]*(1-Power(1+2*B[1]*X,-0.5))');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 636.42725809');
      Add('               b[1] = 0.00020813627256');
    end
    else if Index = 4 then
    begin
      Add('Description :');
      Add('This problem was found to be difficult for some very good algorithms. There'+
          ' is a local minimum at (+inf,-14.07..., -inf, -inf) with final sum of squares 0.00102734....');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y)');
      Add('               1 Predictor Variable (x)');
      Add('               11 Observations');
      Add('               Generated data');
      Add('               Higher Level of Difficulty');
      Add('Model:');
      Add('               Rational Class (linear/quadratic)');
      Add('               4 Parameters (b[0] to b[3])');
      Add('               Y = B[0]*(Sqr(X) + X*B[1]) / (Sqr(X) + X*B[2]+B[3])');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 0.19280693458');
      Add('               b[1] = 0.19128232873');
      Add('               b[2] = 0.12305650693');
      Add('               b[3] = 0.13606233068');
    end
    else if Index = 5 then
    begin
      Add('Description :');
      Add('These data are the result of a NIST study involving ultrasonic calibration.'+
          ' The response variable is ultrasonic response, and the predictor variable is'+
          ' metal distance.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y = ultrasonic response)');
      Add('               1 Predictor Variable (x = metal distance)');
      Add('               54 Observations');
      Add('               Observed Data');
      Add('               Lower Level of Difficulty');
      Add('Model:');
      Add('               Exponential Class');
      Add('               3 Parameters (b[0] to b[2])');
      Add('               Y = Exp(-B[0]*X)/(B[1]) + X*B[2])');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 0.16657666537');
      Add('               b[1] = 0.0051653291286');
      Add('               b[2] = 0.012150007096');
    end
    else if Index = 6 then
    begin
      Add('Description :');
      Add('This problem was found to be difficult for some very good algorithms.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y)');
      Add('               1 Predictor Variable (x)');
      Add('               16 Observations');
      Add('               Generated Data');
      Add('               Higher Level of Difficulty');
      Add('Model:');
      Add('               Exponential Class');
      Add('               3 Parameters (b[0] to b[2])');
      Add('               Y = B[0]*Exp(B[1]/(B[2]+X))');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 0.0056096364710');
      Add('               b[1] = 6181.3463463');
      Add('               b[2] = 345.22363462');
    end
    else if Index = 7 then
    begin
      Add('Description :');
      Add('These data are the result of a NIST study involving '+
          'quantum defects in iodine atoms.  The response'+
          'variable is the number of quantum defects, and the'+
          'predictor variable is the excited energy state. '+
          'The argument to the ArcTan function is in radians.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response  (y = quantum defect)');
      Add('               1 Predictor (x = excited state energy)');
      Add('               25 Observations');
      Add('               Observed Data');
      Add('               Average Level of Difficulty');
      Add('Model:');
      Add('               Miscellaneous Class');
      Add('               4 Parameters (b[0] to b[3])');
      Add('               Y =  B[0]-B[1]*X - ArcTan(B[2]/(X-B[3]))/PI');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 0.20196866396');
      Add('               b[1] = -6.1953516256E-06');
      Add('               b[2] = 1204.4556708');
      Add('               b[3] = -181.34269537');
    end
    else if Index = 8 then
    begin
      Add('Description :');
      Add('This model and data are an example of fitting '+
          'sigmoidal growth curves taken from Ratkowsky (1983). '+
          'The response variable is the dry weight of onion bulbs '+
          'and tops, and the predictor variable is growing time.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response  (y = onion bulb dry weight)');
      Add('               1 Predictor (x = growing time)');
      Add('               15 Observations');
      Add('               Observed Data');
      Add('               Higher Level of Difficulty');
      Add('Model:');
      Add('               Exponential Class');
      Add('               4 Parameters (b[0] to b[3])');
      Add('               Y =  B[0] / Power((1.0 + Exp(B[1]-B[2]*X)),1/B[3])');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 699.6415127');
      Add('               b[1] = 5.2771253025');
      Add('               b[2] = 0.75962938329');
      Add('               b[3] = 1.2792483859');
    end
    else if Index = 9 then
    begin
      Add('Description :');
      Add('These data are the result of a NIST study involving semiconductor'+
          ' electron mobility. The response variable is a measure of electron'+
          ' mobility, and the predictor variable is the natural log of the density.'+
          ' The test uses precomputed powers of x and relies on multiple non-linear regression.');
      Add(chr(13));
      Add('Data :');
      Add('               1 Response Variable  (y = electron mobility)');
      Add('               1 Predictor Variable (x = ln[density])');
      Add('               37 Observations');
      Add('               Higher Level of Difficulty');
      Add('Model:');
      Add('               Rational Class (cubic/cubic)');
      Add('               7 Parameters (b[0] to b[6])');
      Add('               Y = (B[0] + B[1]*X + B[2]*Sqr(X) + B[3]*IntPower(X,3)) / ');
      Add('                   (1.0 + B[4]*X + B[5]*Sqr(X) + B[6]*IntPower(X,3))');
      Add(chr(13));
      Add('Certified values :');
      Add('               b[0] = 1288.1396800');
      Add('               b[1] = 1491.0792535');
      Add('               b[2] = 583.23836877');
      Add('               b[3] = 75.416644291');
      Add('               b[4] = 0.96629502864');
      Add('               b[5] = 0.39797285797');
      Add('               b[6] = 0.049727297349');
    end
end;

procedure TfrmMultiNonLinTest.Edit3Change(Sender: TObject);
begin
  try
    MtxNonLinReg.GradTolerance:= StrToFloat(Edit3.Text);
    SpeedButton1.Enabled := true;
  except
  end;
end;

procedure TfrmMultiNonLinTest.FormCreate(Sender: TObject);
begin
  inherited;
  MtxNonLinReg := TMtxMultiNonLinReg.Create(nil);
  frmLogForm := TfrmLogForm.Create(Self);
  With Memo1.Lines do
  begin
    Add('NIST non-linear regression tests : ');
    Add('');
    Add('Examples for multiple vectorized non-linear regression (scroll down to see more). The vectorized variant ' +
        'allows 10-20x faster computation provided that number of points is large (more than 500 samples). ' +
        'If number of samples is around 30, the speed can be around 3x faster than TMtxNonLinReg. ' +
        'Additionally the component allows multiple input variables (x1 .. xn)');
    Add('');
    Add('Eckerle4 : These data are the result of a NIST study involving'+
        ' circular interference transmittance.  The response'+
        ' variable is transmittance, and the predictor variable'+
        ' is wavelength. (Higher level of difficulty)');
    Add(chr(13));
    Add('Thurber : These data are the result of a NIST study involving'+
        ' semiconductor electron mobility.  The response variable is a measure'+
        ' of electron mobility, and the predictor variable is the natural log'+
        ' of the density (Higher level of diffuculty).');
    Add(chr(13));
    Add('Rat42 : This model and data are an example of fitting sigmoidal growth'+
        ' curves taken from Ratkowsky (1983). The response variable is pasture'+
        ' yield, and the predictor variable is growing time (Average level of difficulty).');
    Add(chr(13));
    Add('Misra1C : These data are the result of a NIST study regarding dental research'+
        ' in monomolecular adsorption. The response variable is volume, and the predictor'+
        ' variable is pressure (Average level of difficulty).');

    Add(chr(13));
    Add('MHG09 : This problem was found to be difficult for some very good algorithms.'+
        ' There is a local minimum at (+inf,-14.07..., -inf, -inf) with final sum of'+
        ' squares 0.00102734... (Higher level of difficulty).');
    Add(chr(13));
    Add('Chiwrut2: These data are the result of a NIST study involving ultrasonic calibration.'+
          ' The response variable is ultrasonic response, and the predictor variable is'+
          ' metal distance.');
    Add(chr(13));
    Add('MHG10: This problem was found to be difficult for some very good algorithms.');
    Add(chr(13));
    Add('Roszman1: These data are the result of a NIST study involving '+
          'quantum defects in iodine atoms.  The response'+
          'variable is the number of quantum defects, and the'+
          'predictor variable is the excited energy state. ');
  end;
  Edit2.Text := FormatFloat('0.00e+00',Sqrt(EPS));
  Edit3.Text := FormatFloat('0.00e+00',Sqrt(EPS));
  ConvergenceTolEdit.Text := FormatFloat('0.00e+00',1.0e-6);
end;

procedure TfrmMultiNonLinTest.Edit1Change(Sender: TObject);
begin
  try
    MtxNonLinReg.MaxIteration := StrToInt(Edit1.Text);
    SpeedButton1.Enabled := true;
  except
    MtxNonLinReg.MaxIteration := 500;
  end;
end;

procedure TfrmMultiNonLinTest.WriteToLog(Elapsed: double);
var i: Integer;
    tmpStr: String;
begin
  case ComboBox2.ItemIndex of
    0 : tmpStr := 'Problem : Eckerle4';
    1 : tmpStr := 'Problem : Thurber';
    2 : tmpStr := 'Problem : Rat42';
    3 : tmpStr := 'Problem : Misra1c';
    4 : tmpStr := 'Problem : MGH09';
    5 : tmpStr := 'Problem : Chiwrut2';
    6 : tmpStr := 'Problem : MGH10';
    7 : tmpStr := 'Problem : Roszman1';
    8 : tmpStr := 'Problem : Rat43';
    9 : tmpStr := 'Problem : Multi-Thurber';
  end;
  frmLogForm.Memo1.Lines.Add(tmpStr);
  tmpStr := 'Method : ';
  case MtxNonLinReg.OptMethod of
    optSimplex : tmpStr := tmpStr + 'Simplex  - ';
    optMarquardt : tmpStr := tmpStr + 'Marquardt - ';
    optBFGS : tmpStr := tmpStr + 'Quasi-Newton (BFGS) - ';
    optDFP : tmpStr := tmpStr + 'Quasi-Newton (DFP) - ';
    optConjGradFR : tmpStr := tmpStr + 'Conjugate Gradient (Fletcher) - ';
    optConjGradPR : tmpStr := tmpStr + 'Conjugate Gradient (Polak) - ';
  end;
  tmpStr := tmpStr + IntToStr(MtxNonLinReg.Iterations)+' iterations';
  frmLogForm.Memo1.Lines.Add(tmpStr);
  frmLogForm.Memo1.Lines.Add('Elapsed time : '+FormatFloat('0.000',Elapsed)+'ms');
  tmpStr := 'Stop reason : ';
  case MtxNonLinReg.StopReason of
    OptResNotFound: tmpStr := tmpStr + 'Failed to converge'; 
    OptResMaxIter: tmpStr := tmpStr + 'Iterations > Max. iterations';
    OptResSmallGrad: tmpStr := tmpStr + 'Too small gradient';
    OptResSingular: tmpStr := tmpStr + 'Singular Hessian matrix';
    OptResBigLambda: tmpStr := tmpStr + 'Marquardt : Big lambda';
    OptResZeroStep: tmpStr := tmpStr + 'Zero x step';
    OptResSmallStep: tmpStr := tmpStr + 'Too small x step';
    OptResSmallLambda: tmpStr := tmpStr + 'Too small lambda';
    OptResConverged: tmpStr := tmpStr + 'Converged within given tolerance';
  end;
  frmLogForm.Memo1.Lines.Add(tmpStr);
  frmLogForm.Memo1.Lines.Add('Calculated values:');
    for i := 0 to MtxNonLinReg.B.Length -1 do
  frmLogForm.Memo1.Lines.Add('               b['+IntToStr(i)+'] = '+FormatFloat('0.0000000000',MtxNonLinReg.B[i]));
  frmLogForm.Memo1.Lines.Add('+++++++++++++++++++++++++++');
end;

procedure TfrmMultiNonLinTest.Button1Click(Sender: TObject);
begin
  frmLogForm.Show;
end;

procedure TfrmMultiNonLinTest.FormDestroy(Sender: TObject);
begin //reset any changes to global vars
  GradStepSize := GradStepSizeDefault;
  GradStepSizeSingle := GradStepSizeSingleDefault;

  MtxNonLinReg.Free;
  frmLogForm.Free;
  inherited;
end;

procedure TfrmMultiNonLinTest.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then frmLogForm.Show
  else frmLogForm.Hide;
end;

procedure TfrmMultiNonLinTest.ResetEstimates(const Index: Integer);
begin
  if Index = 0 then { Eckerle4 }
    MtxNonLinReg.b.SetIt(false,[1.0, 10.0, 500.0]) { initial estimates }
  else if Index = 1 then {Thurber }
    MtxNonLinReg.b.SetIt(false,[1000, 1000, 400, 40, 0.7, 0.3, 0.03]) { initial estimates }
  else if Index = 2 then { Rat42 }
    MtxNonLinReg.b.SetIt(false,[100.0, 1.0, 0.1]) { initial estimates }
  else if Index = 3 then { Misra1c }
    MtxNonLinReg.b.SetIt(false,[500.0, 0.0001]) { initial estimates }
  else if Index = 4 then { MGH09 }
    MtxNonLinReg.b.SetIt(false,[25.0, 39.0, 41.5, 39]) { initial estimates }
  else if Index = 5 then { Chiwrut2 }
    MtxNonLinReg.b.SetIt(false,[0.1, 0.01, 0.02]) { initial estimates }
  else if Index = 6 then { MGH10 }
    MtxNonLinReg.b.SetIt(false,[2, 400000, 25000]) { initial estimates }
  else if Index = 7 then { Roszman1 }
    MtxNonLinReg.b.SetIt(false,[0.1, -0.00001, 1000, -100]) { initial estimates }
  else if Index = 8 then { Rat43 }
    MtxNonLinReg.b.SetIt(false,[100,10,1,1]) { initial estimates }
  else if Index = 9 then {Multi-Thurber }
    MtxNonLinReg.b.SetIt(false,[1000, 1000, 400, 40, 0.7, 0.3, 0.03]) { initial estimates }
end;

procedure TfrmMultiNonLinTest.ConvergenceTolEditChange(Sender: TObject);
begin
    try
        MtxNonLinReg.Tolerance:= StrToFloat(ConvergenceTolEdit.Text);
        SpeedButton1.Enabled := true;
    except

    end;
end;

procedure TfrmMultiNonLinTest.Edit2Change(Sender: TObject);
begin
    try
        Math387.GradStepSize := StrToFloat(Edit2.Text);
        SpeedButton1.Enabled := true;
    except

    end;
end;

initialization
  RegisterClass(TfrmMultiNonLinTest);

end.
