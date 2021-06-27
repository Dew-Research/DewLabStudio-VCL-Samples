unit Random_Generator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, ComCtrls, Statistics, MtxVec, MtxExpr, MtxExprInt,
  TeeProcs, TeEngine, Chart, Buttons, Series, TeeGDIPlus;

type
  TfrmRandomGen = class(TfrmBasic)
    Panel2: TPanel;
    Label1: TLabel;
    CBRandomG: TComboBox;
    Label2: TLabel;
    EditNumber: TEdit;
    UpDown1: TUpDown;
    Chart1: TChart;                          
    SpeedButton1: TSpeedButton;           
    GroupBox1: TGroupBox;
    lblPar1: TLabel;
    lblPar2: TLabel;
    lblPar3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    UpDown2: TUpDown;
    CheckBox1: TCheckBox;
    Series2: TLineSeries;
    Series1: TBarSeries;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CBRandomGChange(Sender: TObject);
    procedure Chart1UndoZoom(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    v1, v2: Vector;
    v1Int: VectorInt;
    VecCount, VecBins: Vector;
    MsgText : String;
    function Estimate(X: TVec): boolean;
  public
    { Public declarations }
  end;

var
  frmRandomGen: TfrmRandomGen;

implementation

Uses MtxVecTee, Math387, Probabilities, StatRandom;

{$R *.DFM}

procedure TfrmRandomGen.FormCreate(Sender: TObject);
begin
  inherited;
  VecCount.Size(0, false, DefaultIsDouble);
  VecBins.Size(0, false, DefaultIsDouble);
  v2.Size(0, false, DefaultIsDouble);
end;

procedure TfrmRandomGen.FormShow(Sender: TObject);
begin
  CBRandomG.ItemIndex := 4;
  CBRandomGChange(Self);
  SpeedButton1Click(Self); { show data }
end;

procedure TfrmRandomGen.SpeedButton1Click(Sender: TObject);
var s1,s2,s3: double;
    i1,i2,i3: Integer;
begin
  v1.Size(UpDown1.Position, v1.FloatPrecision);
  v1Int.Size(UpDown1.Position);
  case CBRandomG.ItemIndex of
    0 : begin { Beta }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomBeta(s1,s2,v1);
        end;
    1 : begin { Binomial }
          i1 := StrToInt(Edit1.Text);
          s1 := StrToFloat(Edit2.Text);
          RandomBinom(i1,s1,v1Int);
          v1.Copy(v1Int, v1.FloatPrecision);
        end;
    2 : begin { Cauchy }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomCauchy(s1,s2,v1);
        end;
    3 : begin { ChiSquared }
          i1 := StrToInt(Edit1.Text);
          RandomChiSquare(i1,v1);
        end;
    4 : begin { Erlang }
          i1 := StrToInt(Edit1.Text);
          s1 := StrToFloat(Edit2.Text);
          RandomErlang(i1,s1,v1);
        end;
    5 : begin { Exponential }
          s1 := StrToFloat(Edit1.Text);
          RandomExponent(s1,v1);
        end;
    6 : begin { F }
          i1 := StrToInt(Edit1.Text);
          i2 := StrToInt(Edit2.Text);
          RandomF(i1,i2,v1);
        end;
    7 : begin { Gamma }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomGamma(s1,s2,v1);
        end;
    8 : begin { Geometric }
          s1 := StrToFloat(Edit1.Text);
          RandomGeometric(s1,v1);
        end;
    10 : begin { Gumbel - max }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomGumbel(s1,s2,v1,-1);
         end;

    11 : begin { Hypergeometric }
          i1 := StrToInt(Edit1.Text);
          i2 := StrToInt(Edit2.Text);
          i3 := StrToInt(Edit3.Text);
          RandomHypGeometric(i1,i2,i3,v1Int);
          v1.Copy(v1Int, v1.FloatPrecision);
        end;
    12 : begin { Laplace }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomLaplace(s1,s2,v1);
        end;
    13 : begin { Logistic }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomLogistic(s1,s2,v1);
        end;
    14 : begin { Log Normal }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomLogNormal(s1,s2,v1);
        end;
    15 : begin { Maxwell }
          s1 := StrToFloat(Edit1.Text);
          RandomMaxwell(s1,v1);
        end;
    16 : begin { Negative binomial }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomNegBinom(s1,s2,v1Int);
          v1.Copy(v1Int, v1.FloatPrecision);
        end;
    17 : begin { Normal }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomNormal(s1,s2,v1);
        end;
    18 : begin { Poisson }
          s1 := StrToFloat(Edit1.Text);
          RandomPoisson(s1,v1Int);
          v1.Copy(v1Int, v1.FloatPrecision);
        end;
    19 : begin { Rayleigh }
          s1 := StrToFloat(Edit1.Text);
          RandomRayleigh(s1,v1);
        end;
    20 : begin { Student }
          i1 := StrToInt(Edit1.Text);
          RandomStudent(i1,v1);
        end;
    21 : begin { Triangular }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          s3 := StrToFloat(Edit3.Text);
          RandomTriangular(s1,s2,s3,v1);
          end;
    22 : begin { continuous uniform }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomUniform(s1,s2,v1);
        end;
    23 : begin { Discrete uniform }
          i1 := StrToInt(Edit1.Text);
          RandomUniformD(i1,v1);
        end;
    24 : begin { Weibull }
          s1 := StrToFloat(Edit1.Text);
          s2 := StrToFloat(Edit2.Text);
          RandomWeibull(s1,s2,v1);
        end;
  end;

  Histogram(v1,UpDown2.Position,VecCount,VecBins,true);
  Series2.Active := CheckBox1.Checked;
  Chart1.SubTitle.Text.Clear;
  { do this only if you want to calculate parameters }
  if CheckBox1.Checked then
  begin
    if Estimate(VecBins) then
    begin
      DrawValues(VecBins,v2,Series2,False);
    end;
    Chart1.SubTitle.Text.Add(MsgText);
  end;
  { draw dataset }
  DrawValues(VecBins,VecCount,Series1,false);
end;

procedure TfrmRandomGen.CBRandomGChange(Sender: TObject);
begin
  Series1.Clear;
  Series2.Clear;
  Chart1.SubTitle.Text.Clear;
  Case CBRandomG.ItemIndex of
    0:  begin { Beta }
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',1.5);
          Edit2.Text := FormatFloat('0.00',0.9);
        end;
    1:  begin { Binomial }
          lblPar1.Caption := 'N';
          lblPar2.Caption := 'p';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := '10';
          Edit2.Text := FormatFloat('0.00',0.4);
        end;
    2:  begin { Cauchy }
          lblPar1.Caption := 'm';
          lblPar2.Caption := 'b';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',0);
          Edit2.Text := FormatFloat('0.00',0.5);
        end;
    3:  begin { ChiSquared }
          lblPar1.Caption := 'Nu';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := '4';
        end;
    4:  begin { Erlang }
          lblPar1.Caption := 'k';
          lblPar2.Caption := 'lambda';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := IntToStr(2);
          Edit2.Text := FormatFloat('0.00',0.37);
        end;
    5:  begin { Exponential }
          lblPar1.Caption := 'Mu';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00', 1.8);
        end;
    6:  begin { F }
          lblPar1.Caption := 'Nu1';
          lblPar2.Caption := 'Nu2';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := '3';
          Edit2.Text := '8';
        end;
    7:  begin { Gamma }
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',2.1);
          Edit2.Text := FormatFloat('0.00',0.3);
        end;
    8:  begin { Geometric }
          lblPar1.Caption := 'P';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',0.7);
        end;
    10 : begin { Gumbel - MAX }
          lblPar1.Caption := 'mu';
          lblPar2.Caption := 'beta';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',1.5);
          Edit2.Text := FormatFloat('0.00',0.8);
        end;


    11:  begin { HyperGeometric }
          lblPar1.Caption := 'M';
          lblPar2.Caption := 'K';
          lblPar3.Caption := 'N';
          lblPar2.Visible := true;
          lblPar3.Visible := true;
          Edit1.Text := '50';
          Edit2.Text := '30';
          Edit3.Text := '20';
        end;
    12:  begin { Laplace }
          lblPar1.Caption := 'm';
          lblPar2.Caption := 'b';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',1.5);
          Edit2.Text := FormatFloat('0.00',0.8);
        end;
    13:  begin { Logistic }
          lblPar1.Caption := 'm';
          lblPar2.Caption := 'b';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',0.9);
          Edit2.Text := FormatFloat('0.00',1.2);
        end;
    14:  begin { LogNormal }
          lblPar1.Caption := 'mu';
          lblPar2.Caption := 'sigma';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',5.0);
          Edit2.Text := FormatFloat('0.00',0.2);
        end;
    15:  begin { Maxwellian }
          lblPar1.Caption := 'a';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',2.3);
        end;
    16:  begin { Negative binomial }
          lblPar1.Caption := 'R';
          lblPar2.Caption := 'p';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := '15';
          Edit2.Text := FormatFloat('0.00',0.65);
        end;
    17:  begin { Normal-Gauss }
          lblPar1.Caption := 'mu';
          lblPar2.Caption := 'sigma';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',5.0);
          Edit2.Text := FormatFloat('0.00',0.2);
        end;
    18:  begin { Poisson }
          lblPar1.Caption := 'Lambda';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',7.2);
        end;
    19:  begin { Rayleigh }
          lblPar1.Caption := 'b';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',0.2);
        end;
    20:  begin { Student }
          lblPar1.Caption := 'Nu';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := '4';
        end;
    21:  begin { Triangular }
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          lblPar3.Caption := 'c';
          lblPar2.Visible := true;
          lblPar3.Visible := true;
          Edit1.Text := FormatFloat('0.00',1.2);
          Edit2.Text := '5';
          Edit3.Text := '4';
        end;
    22:  begin { Continuous Uniform }
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',-2.5);
          Edit2.Text := FormatFloat('0.00',3.9);
        end;
    23:  begin { Discrete Uniform }
          lblPar1.Caption := 'N';
          lblPar2.Visible := false;
          lblPar3.Visible := false;
          Edit1.Text := '20';
        end;
    24:  begin { Weibull }
          lblPar1.Caption := 'a';
          lblPar2.Caption := 'b';
          lblPar2.Visible := true;
          lblPar3.Visible := false;
          Edit1.Text := FormatFloat('0.00',1.5);
          Edit2.Text := FormatFloat('0.00',2.3);
        end;
    end;
    Edit2.Visible := lblPar2.Visible;
    Edit3.Visible := lblPar3.Visible;
    SpeedButton1Click(Self); { show data }
end;

procedure TfrmRandomGen.Chart1UndoZoom(Sender: TObject);
begin
  Chart1.LeftAxis.AutomaticMaximum := true;
end;

function TfrmRandomGen.Estimate(X: TVec): boolean;
var Par0,Par1,Par2: double;
    Int0,Int1: Integer;
    CA, CB: TTwoElmReal;
    xInt: VectorInt;
begin
  Screen.Cursor := crHourGlass;
  Series2.Active := True;
  Result := True;
  X.CopyTo(xInt, rnRound);
  Case CBRandomG.ItemIndex of
    0:  begin
          BetaFit(v1,Par0,Par1, CA, CB);
          BetaPDF(X,Par0,Par1,v2);
          MsgText := 'a = '+FormatFloat('0.0000',Par0)+' ; '+ 'b = '+FormatFloat('0.0000',Par1);
        end;
    1:
        begin
          BinomFit(v1,Int0,Par0);
          BinomPDF(XInt,Int0,Par0,v2);
          MsgText := 'N = '+IntToStr(Int0)+' ; '+ 'p = '+FormatFloat('0.0000',Par0);
        end;
    2:  begin
          CauchyFit(v1,Par0,Par1);
          CauchyPDF(X,Par0,Par1,v2);
          MsgText := 'm = '+FormatFloat('0.0000',Par0)+' ; '+ 'b = '+FormatFloat('0.0000',Par1);
        end;
    3: begin
          ChiSquareFit(v1,Int0);
          ChiSquarePDF(X,Int0,v2);
          MsgText := 'nu = '+IntToStr(Int0);
        end;
    4:  begin
          ErlangFit(v1,Int0,Par0);
          ErlangPDF(X,Int0,Par0,v2);
          MsgText := 'k = '+IntToStr(Int0)+' ; '+ 'lambda = '+FormatFloat('0.0000',Par0);
        end;
    5: begin
          ExponentFit(v1,Par0);
          ExpPDF(X,Par0,v2);
          MsgText := 'mu = '+FormatFloat('0.0000',Par0);
        end;
    6:  begin
          FFit(v1,Int0,Int1);
          FPDF(X,Int0,Int1,v2);
          MsgText := 'Nu1 = '+IntToStr(Int0)+' ; '+ 'Nu2 = '+IntToStr(Int1);
        end;
    7:  begin
          GammaFit(v1,Par0,Par1);
          GammaPDF(X,Par0,Par1,v2);
          MsgText := 'a = '+FormatFloat('0.0000',Par0)+' ; '+ 'b = '+FormatFloat('0.0000',Par1);
        end;
    8:  begin
          GeometricFit(v1,Par0);
          GeometricPDF(XInt,Par0,v2);
          MsgText := 'P = '+FormatFloat('0.0000',Par0);
        end;
    12:  begin
          LaplaceFit(v1,Par0,Par1);
          LaplacePDF(X,Par0,Par1,v2);
          MsgText := 'mu = '+FormatFloat('0.0000',Par0)+' ; '+ 'b = '+FormatFloat('0.0000',Par1);
        end;
    13:  begin
          LogisticFit(v1,Par0,Par1);
          LogisticPDF(X,Par0,Par1,v2);
          MsgText := 'm = '+FormatFloat('0.0000',Par0)+' ; '+ 'n = '+FormatFloat('0.0000',Par1);
        end;
    14:  begin
          LogNormalFit(v1,Par0,Par1);
          LogNormalPDF(X,Par0,Par1,v2);
          MsgText := 'mu = '+FormatFloat('0.0000',Par0)+' ; '+ 'sigma = '+FormatFloat('0.0000',Par1);
        end;
    15:  begin
          MaxwellFit(v1,Par0);
          MaxwellPDF(X,Par0,v2);
          MsgText := 'a = '+FormatFloat('0.0000',Par0);
        end;
    16:  begin
          NegBinomFit(v1,Par0,Par1);
          NegBinomPDF(XInt,Par0,Par1,v2);
          MsgText := 'r = '+FormatFloat('0.0000',Par0)+' ; '+ 'p = '+FormatFloat('0.0000',Par1);
        end;
    17:  begin
          NormalFit(v1,Par0,Par1);
          NormalPDF(X,Par0,Par1,v2);
          MsgText := 'mu = '+FormatFloat('0.0000',Par0)+' ; '+ 'sigma = '+FormatFloat('0.0000',Par1);
        end;
    18: begin
          PoissonFit(v1,Par0);
          PoissonPDF(xInt,Par0,v2);
          MsgText := 'lambda = '+FormatFloat('0.0000',Par0);
        end;
    19: begin
          RayleighFit(v1,Par0);
          RayleighPDF(X,Par0,v2);
          MsgText := 'b = '+FormatFloat('0.0000',Par0);
        end;
    20: begin
          StudentFit(v1,Int0);
          StudentPDF(X,Int0,v2);
          MsgText := 'Nu = '+IntToStr(Int0);
        end;
    21: begin
          TriangularFit(v1,Par0,Par1,Par2);
          TriangularPDF(X,Par0,Par1,Par2,v2);
          MsgText := 'a = '+FormatFloat('0.0000',Par0)+' ; '+ 'b = '+FormatFloat('0.0000',Par1)+ ' ; '
            +'c = '+FormatFloat('0.0000',Par2);
        end;
    22: begin
          UniformFit(v1,Par0,Par1);
          UniformPDF(X,Par0,Par1,v2);
          MsgText := 'a = '+FormatFloat('0.0000',Par0)+' ; '+ 'b = '+FormatFloat('0.0000',Par1);
        end;
    23: begin
          UniformDFit(v1,Int0);
          UniformDPDF(XInt,Int0,v2);
          MsgText := 'N = '+IntToStr(Int0);
        end;
    24: begin
          WeibullFit(v1,Par0,Par1);
          WeibullPDF(X,Par0,Par1,v2);
          MsgText := 'a = '+FormatFloat('0.0000',Par0)+' ; '+ 'b = '+FormatFloat('0.0000',Par1);
        end;
    else begin
            Series2.Active := False;
            MsgText := 'Not supported';
            Result := False;
          end;
  end;
  Chart1.Legend.Visible := Series2.Active;
  MsgText := 'Estimates: ' + MsgText;
  Screen.Cursor := crDefault;
end;

procedure TfrmRandomGen.CheckBox1Click(Sender: TObject);
begin
  Series2.Active := CheckBox1.Checked;
  Chart1.Legend.Visible := Series2.Active;
end;

initialization
  RegisterClass(TfrmRandomGen);

end.
