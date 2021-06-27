unit Fit_Model;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Chart, StdCtrls, TeeProcs, TeEngine, Chart, ExtCtrls, Series,
  MtxVec, Math387, VclTee.TeeGDIPlus;

type
  TfrmModels = class(TfrmBasicChart)
    Series1: TPointSeries;
    Series2: TLineSeries;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    X,Y: TVec; { X,Y values ...}
    B: TVec; { Parameters }
    YCalc: TVec;
    Residuals: TVec;
    MsgText : String;
  public                                         
    { Public declarations }
  end;

var
  frmModels: TfrmModels;

implementation

{$R *.DFM}

Uses MtxVecTee,MtxVecEdit, RegModels, Polynoms, AbstractMtxVec, Types;

procedure TfrmModels.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
  ComboBox1Change(Self);
end;

procedure TfrmModels.Button2Click(Sender: TObject);
begin
  ViewValues(X,'Editing X...',True,False);
  ComboBox1Change(Self);
end;

procedure TfrmModels.Button3Click(Sender: TObject);
begin
  ViewValues(Y,'Editing Y...',True,False);
  ComboBox1Change(Self);
end;

procedure TfrmModels.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Statistics includes several basic fitting models. The following "linear" models are supported:');
    Add('(+) Simple exponential model : y=a*Exp[b*x]');
    Add('(+) Simple linear mode : y=k*x+n');
    Add('(+) Simple power model: y=a*x^b');
    Add('(+) Simple polynomial model : y=a[n]*x^n + a[n-1]*x^(n-1) + ... + a[1]*x + a[0]');
    Add('(+) Rational function model: y=(p0 + p1.x + p2.x^2 + ...)/(1 + q1.x + q2.x^2 + ...)');
    Add('(+) Logistic function model: y=A+(B-A)/(1+Exp(-a*x+b))');
    Add('(+) Natural logarithm model: y=A+B*Ln(x)');
    Add('');
    Add('These models are located in RegModels.pas unit. You can easily add new models. '+
        'Using Statistics procedures you can construct new models. '+
        ' To construct fitted values you need:');
    Add('1) Evaluate function : evaluates model for given parameters at specific value');
    Add('2) Fit function : fits model to given values');
    Add('');
    Add('An example : Power function :  y = B[0] * X ^ B[1]');
    Add('1) Evaluate function :');
    Add(' function PowerEval(B: Array of double; X: double): double;');
    Add(' begin');
    Add('   Result := B[0] * Power(X,B[1]);');
    Add(' end;');
    Add('');
    Add('2) Fit function :');
    Add(' procedure PowerFit(B: TVec; X,Y: TVec; Weights: TVec = nil);');
    Add(' var X1,Y1,W1 : TVec;');
    Add('     i,n      : Integer;');
    Add(' begin');
    Add('   if X.Length <> Y.Length then raise Exception.Create(''X.Lenght <> Y.Length'');');
    Add('   CreateIt(X1,Y1,W1);');
    Add('   X1.Size(X);');
    Add('   Y1.Size(X);');
    Add('   W1.Size(X);');
    Add('   try');
    Add('     n := 0;');
    Add('     for i := 0 to X.Length-1 do');
    Add('       if (X[i] > 0) and (Y[i] > 0) then');
    Add('       begin');
    Add('         { linearize equation }');
    Add('         X1[n] := Ln(X[i]);');
    Add('         Y1[n] := Ln(Y[i]);');
    Add('         W1[n] := Sqr(Y[i]);');
    Add('         if Weights <> nil then W1[n] := W1[n]*Weights[i];');
    Add('         Inc(n);');
    Add('       end;');
    Add('     X1.Resize(n);');
    Add('     Y1.Resize(n);');
    Add('     W1.Resize(n);');
    Add('     if n > 0 then');
    Add('     begin');
    Add('       { now do least-square fit }');
    Add('       LinRegress(X1,Y1,B,W1,nil,nil);');
    Add('       B.Exp(0,1);');
    Add('     end;');
    Add('   finally');
    Add('     FreeIt(X1,Y1,W1);');
    Add('   end;');
    Add(' end;');
    Add('');
    Add('Click on "X" and "Y" buttons to change x and y values.');
    Add('If you cannot linearize your model, you can try using TMtxNonLinReg '+
        ' component and calculate model parameters by using several ' +
        ' optimization methods (Marquardt, several Quasi-Newton methods, Simplex, ...');
  end;
  X := TVec.Create;
  Y := TVec.Create;
  B := TVec.Create;
  YCalc := TVec.Create;
  Residuals := TVec.Create;
  try
    X.SetIt(false,[0.53, 0.88, 1.07, 1.1, 1.14, 1.49, 1.60, 1.61, 1.87, 2.61]);

    Y.SetIt(false,[27.10, 22.50, 26.8, 22, 18.5, 18.1, 15.3, 12.1, 16.1, 9.4]);
//    Y.Mul(2);
//    X.LoadFromFile('FIT_X.VEC');
//    Y.LoadFromFile('FIT_Y.VEC');
    DrawValues(X,Y,Series1);
  except
  end;
end;

procedure TfrmModels.FormDestroy(Sender: TObject);
begin
  X.Free;
  Y.Free;
  B.Free;
  YCalc.Free;
  Residuals.Destroy;
  inherited;
end;

procedure TfrmModels.ComboBox1Change(Sender: TObject);
var PolyDeg: Integer;
    PolyStr: String;
    DegNom, DegDenom: Integer;
    i : Integer;
    bvals: TDoubleArray;
begin
  Case ComboBox1.ItemIndex of
  0:  begin { Y=B*Exp[A*X] }
        ExpFit(B,X,Y,nil);
        MsgText := 'Y='+FormatFloat('0.00;-0.00)',B[0])+'*'+
                   'Exp['+FormatFloat('0.00;-0.00',B[1])+'*X]';
        B.CopyToArray(bvals);
        ExpEval(bvals,X,YCalc);
      end;
  1:  begin { Y=k*X+n }
        LineFit(B,X,Y,nil);
        MsgText := 'Y='+FormatFloat('0.00', B[1])+'*'+
                   'X '+FormatFloat('+0.00;-0.00', B[0]);
        B.CopyToArray(bvals);
        LineEval(bvals,X,YCalc);
      end;
  2:  begin { Y=a*X^B }
        PowerFit(B,X,Y,nil);
        MsgText := 'Y='+FormatFloat('(0.00)', B[0])+'*'+
                   'X^['+FormatFloat('+0.00;-0.00', B[1])+']';
        B.CopyToArray(bvals);
        PowerEval(bvals,X,YCalc);
      end;
  3:  begin { Poly fit }
        PolyStr := InputBox('Polynomial degree','Enter poly degree : ','5');
        try
          PolyDeg := StrToInt(PolyStr);
        except
          PolyDeg := 5;
        end;
        PolyFit(X,Y,PolyDeg,B);
        MsgText := 'Y=';
        for i := 0 to PolyDeg-1 do
          MsgText := MsgText + FormatFloat('(0.00)',B[i])+'X^'+IntToStr(PolyDeg-i)+'+';
        MsgText := MsgText + FormatFloat('(0.00)',B[PolyDeg]);
        PolyEval(X,B,YCalc);
      end;
  4:  begin { Rational function with constant term}
        PolyStr := InputBox('Nominator degree','Enter nominator degree : ','2');
        try
          DegNom := StrToInt(PolyStr);
        except
          DegNom := 2;
        end;
        PolyStr := InputBox('Denominator degree','Enter denominator degree : ','4');
        try
          DegDenom := StrToInt(PolyStr);
        except
          DegDenom := 4;
        end;
        FracFit(B,X,Y,DegNom,DegDenom,True,nil);
        YCalc.SetZero;
        FracEval(B,X,YCalc,DegNom,True);
        MsgText := 'Y=(';
        for i := DegNom downto 1 do
          MsgText := MsgText + FormatFloat('(0.00)',B[i])+'X^'+IntToStr(i)+'+';
        MsgText := MsgText + FormatFloat('(0.00)',B[0])+')/(';
        if DegDenom > 0 then
        begin
          for i := DegNom+DegDenom downto DegNom+1 do
            MsgText := MsgText + FormatFloat('(0.00)',B[i])+'X^'+IntToStr(i-DegNom)+'+';
        end else MsgText := MsgText+'+';
        MsgText := MsgText + '1.0)';
      end;
  5:  begin { Logistic fit with constant term }
        LogisticFit(B,X,Y,True);
        LogisticEval(B,X,YCalc,True);
        MsgText := 'Y='+FormatFloat('0.00',B[0]);
        MsgText := MsgText +'+['+FormatFloat('0.00',B[1])+FormatFloat('-0.00;+0.00',B[0])+']/';
        MsgText := MsgText+'[1+Exp('+FormatFloat('-0.00;+0.00',B[2])+'x '+FormatFloat('+0.00;-0.00',B[3])+']';
      end;
  6:  begin { Y=A+B*Ln(X) }
        LnFit(B,X,Y,nil);
        LnEval(B,X,YCalc);
        MsgText := 'Y='+FormatSample('+0.00;-0.00',B[0])+
        FormatSample('+0.00;-0.00',B[1])+'*Ln[X]';
      end;
  end;
  { calculate RSS }
  Residuals.Sub(Y,YCalc);
  Label2.Caption := 'RSS : ' + FormatSample('0.0000',Residuals.SumOfSquares);
  { update chart }
  DrawValues(X,Y,Series1,False);
  DrawValues(X,YCalc,Series2,False);
  With Chart1.Subtitle.Text do
  begin
    Clear;
    Add(MsgText);
  end;
end;

initialization
  RegisterClass(TfrmModels);

end.
