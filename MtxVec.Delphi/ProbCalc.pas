unit ProbCalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic2, StdCtrls, ComCtrls, ExtCtrls,Probabilities, Math387, MtxVec, TeEngine, MtxVecInt, MtxExprInt,
  Series, TeeProcs, Chart, MtxVecEdit, Buttons, MtxExpr, VclTee.TeeGDIPlus;

type
  TProb1 = class(TBasicForm2)
    Chart1: TChart;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Series1: TLineSeries;
    Panel4: TPanel;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit5: TEdit;
    Edit2: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    TrackBar1: TTrackBar;
    Label8: TLabel;
    Series2: TLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit6Enter(Sender: TObject);
  private
     Decimals : Integer;
     XVec,PDFVec,CDFVec: Vector;
     XIntVec: VectorInt;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Prob1: TProb1;

implementation

{$R *.DFM}

Uses MtxVecTee;

procedure TProb1.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('The Probabilities unit introduces 24 most commonly '
      + 'used distributions. You can calculate "Probability '
      + 'density function" (PDF), "Cumulative distribution function" '
      + '(CDF) and inverse "Cumulative distribution function" '
      + '(InvCDF) for 7 discrete and 17 continuous distributions. '
      + 'Try changing distribution, distribution parameters and/or resulting CDF.');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('NOTE :');
    Add('"Calc  probability" button will use distribution parameters '
      + 'to calculate PDF and CDF. The "Calc x" button will use CDF '
      + '(must lie in the interval [0,1]) to calculate the x value of a '
      + 'given distribution. ');
  end;
  Chart1.Anchors := [akTop, akBottom, akLeft, akRight];
  XVec.Size(100);
  XIntVec.Size(100);
  TrackBar1Change(TrackBar1);
  RadioGroup1Click(RadioGroup1);
end;

procedure TProb1.RadioGroup1Click(Sender: TObject);
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit5.Text := '';
  Edit6.Text := '';
  Case RadioGroup1.ItemIndex of
  0 : begin  { BETA distribution }
           Label1.Caption := 'a; a > 0';
           Label2.Caption := 'b; b > 0';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(0.25,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(0.75,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(0.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  1 : begin  { BINOMIAL distribution }
           Label1.Caption := 'n; n > 0';
           Label2.Caption := 'p; p = [0,1]';
           Label3.Caption := 'x';
           Edit1.Text := IntToStr(4);
           Edit2.Text := FloatToStrF(0.75,ffFixed,Decimals,Decimals);
           Edit3.Text := IntToStr(3);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  2 : begin  { Cauchy distribution }
           Label1.Caption := 'm; m <> x';
           Label2.Caption := 'b; b <> 0';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(1.5,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(2.12,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(3,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  3 : begin  { Chi-squared distribution }
           Label1.Caption := 'Nu; Nu > 0';
           Label2.Caption := 'x';
           Edit1.Text := IntToStr(5);
           Edit2.Text := FloatToStrF(1.2,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  4 : begin  { Exponential distribution }
           Label1.Caption := 'Mu; Mu > 0';
           Label2.Caption := 'x';
           Edit1.Text := FloatToStrF(0.95,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(3.25,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  5 : begin  { F distribution }
           Label1.Caption := 'Nu1; Nu1 > 0';
           Label2.Caption := 'Nu2; Nu2 > 0';
           Label3.Caption := 'x';
           Edit1.Text := IntToStr(7);
           Edit2.Text := IntToStr(3);
           Edit3.Text := FloatToStrF(0.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  6 : begin  { Gamma distribution }
           Label1.Caption := 'a; a > 0';
           Label2.Caption := 'b; b > 0';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(1.95,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(5,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(0.32,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  7 : begin  { Geometric distribution }
           Label1.Caption := 'p; p =[0,1]';
           Label2.Caption := 'x';
           Edit1.Text := FloatToStrF(0.15,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(2.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  8 : begin  { Hypergeometric distribution }
           Label1.Caption := 'M; M >= K,N';
           Label2.Caption := 'K;K >= x';
           Label3.Caption := 'N; N >= x';
           Label4.Caption := 'x';
           Edit1.Text := IntToStr(10);
           Edit2.Text := IntToStr(6);
           Edit3.Text := IntToStr(5);
           Edit4.Text := FloatToStrF(2.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := true;
           Edit4.Visible := true;
      end;
  9 : begin  { Laplace }
           Label1.Caption := 'm';
           Label2.Caption := 'b';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(3,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(1,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(0.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  10 : begin  { Logistic }
           Label1.Caption := 'm';
           Label2.Caption := 'b';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(3,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(1,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(0.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  11 : begin  { Log-Normal distribution }
           Label1.Caption := 'Mu';
           Label2.Caption := 'Sigma; Sigma > 0';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(3,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(1,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(0.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  12 : begin  { Log-Weibull distribution }
           Label1.Caption := 'a; a>0';
           Label2.Caption := 'b; b>0';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(3,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(1,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(0.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  13 : begin  { Maxwell distribution }
           Label1.Caption := 'a; a > 0';
           Label2.Caption := 'x';
           Edit1.Text := FloatToStrF(0.95,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(1.2,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  14 : begin  { Negative binomial distribution }
           Label1.Caption := 'R; R > 1';
           Label2.Caption := 'p; P =[0,1]';
           Label3.Caption := 'x';
           Edit1.Text := IntToStr(5);
           Edit2.Text := FloatToStrF(0.75,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(2,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  15 : begin  { Normal distribution }
           Label1.Caption := 'Mu';
           Label2.Caption := 'Sigma; Sigma > 0';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(0,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(1,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(1,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  16 : begin  { Pareto distribution }
           Label1.Caption := 'a';
           Label2.Caption := 'b; b < x';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(1.1,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(0.3,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(2.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  17 : begin  { Poisson distribution }
           Label1.Caption := 'Lambda; Lambda > 0';
           Label2.Caption := 'x';
           Label1.Visible := true;
           Edit1.Text := FloatToStrF(13.2,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(7,ffFixed,Decimals,Decimals);
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
       end;
  18 : begin  { Student distribution }
           Label1.Caption := 'Nu; Nu > 1';
           Label2.Caption := 'x';
           Edit1.Text := IntToStr(3);
           Edit2.Text := FloatToStrF(5.5,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
       end;
  19 : begin  { Rayleigh distribution }
           Label1.Caption := 'b; b > 0';
           Label2.Caption := 'x; x >= 0';
           Label1.Visible := true;
           Edit1.Text := FloatToStrF(1.0,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(3.2,ffFixed,Decimals,Decimals);
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
       end;
  20 : begin  { Triangular }
           Label1.Caption := 'a; a<=x<=b';
           Label2.Caption := 'b;';
           Label3.Caption := 'c; a<=c<=b';
           Label4.Caption := 'x';
           Edit1.Text := FloatToStrF(1.3,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(5.4,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(3.3,ffFixed,Decimals,Decimals);
           Edit4.Text := FloatToStrF(4.2,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := true;
           Edit4.Visible := true;
      end;
  21 : begin  { Uniform distribution }
           Label1.Caption := 'a; a < b';
           Label2.Caption := 'b; b > a';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(-3,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(5,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(1,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
       end;
  22 : begin  { Discrete uniform distribution }
           Label1.Caption := 'N; N > 1';
           Label2.Caption := 'x';
           Edit1.Text := IntToStr(5);
           Edit2.Text := FloatToStrF(3.1,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := false;
           Edit3.Visible := false;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  23 : begin  { Weibull distribution }
           Label1.Caption := 'a; a > 0';
           Label2.Caption := 'b; b > 0';
           Label3.Caption := 'x';
           Edit1.Text := FloatToStrF(0.75,ffFixed,Decimals,Decimals);
           Edit2.Text := FloatToStrF(2.5,ffFixed,Decimals,Decimals);
           Edit3.Text := FloatToStrF(1.25,ffFixed,Decimals,Decimals);
           Label1.Visible := true;
           Edit1.Visible := true;
           Label2.Visible := true;
           Edit2.Visible := true;
           Label3.Visible := true;
           Edit3.Visible := true;
           Label4.Visible := false;
           Edit4.Visible := false;
      end;
  end;
end;

procedure TProb1.Button1Click(Sender: TObject);
var s1,s2,s3,s4: TSample;
    RPDF,RCDF  : TSample;
    i1,i2,i3,i4: Integer;
begin
  RPDF := 0;
  RCDF := 0;
  Case RadioGroup1.ItemIndex of
  0: begin  { BETA }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := BetaPDF(s3,s1,s2);
          RCDF := BetaCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0.01,0.0099);
               BetaPDF(XVec,s1,s2,PDFVec);
               BetaCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  1: begin { BINOMIAL }
          i1 := StrToInt(Edit1.Text); // N
          s1 := StrToFloat(Edit2.Text); // p
          i2 := StrToInt(Edit3.Text); // x
          RPDF := BinomPDF(i2,i1,s1);
          RCDF := BinomCDF(i2,i1,s1);
          if CheckBox1.Checked then
          begin
               XIntVec.Ramp(0,i1*0.01);
               BinomPDF(XIntVec,i1,s1,PDFVec);
               BinomCDF(XIntVec,i1,s1,CDFVec);
          end;
     end;
  2: begin  { Cauchy }
          s1 := StrToFloat(Edit1.Text); // b
          s2 := StrToFloat(Edit2.Text); // m
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := CauchyPDF(s3,s1,s2);
          RCDF := CauchyCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0,0.1);
               CauchyPDF(XVec,s1,s2,PDFVec);
               CauchyCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  3: begin  {CHI2 }
          i1 := StrToInt(Edit1.Text); // nu
          s1 := StrToFloat(Edit2.Text); // x
          RPDF := ChiSquarePDF(s1,i1);
          RCDF := ChiSquareCDF(s1,i1);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(1*0.02,s1*0.05);
               ChiSquarePDF(XVec,i1,PDFVec);
               ChiSquareCDF(XVec,i1,CDFVec);
          end;
     end;
  4: begin  { Exponential }
          s1 := StrToFloat(Edit1.Text); // Mu
          s2 := StrToFloat(Edit2.Text); // x
          RPDF := ExpPDF(s2,s1);
          RCDF := ExpCDF(s2,s1);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0,s1*0.05);
               ExpPDF(XVec,s1,PDFVec);
               ExpCDF(XVec,s1,CDFVec);
          end;
     end;
  5: begin  { F - Fisher }
          i1 := StrToInt(Edit1.Text); // Nu1
          i2 := StrToInt(Edit2.Text); // Nu2
          s1 := StrToFloat(Edit3.Text); // x
          RPDF := FPDF(s1,i1,i2);
          RCDF := FCDF(s1,i1,i2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp;
               FPDF(XVec,i1,i2,PDFVec);
               FCDF(XVec,i1,i2,CDFVec);
          end;
     end;
  6: begin  { GAMMA }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := GammaPDF(s3,s1,s2);
          RCDF :=GammaCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0.02,0.2);
               GammaPDF(XVec,s1,s2,PDFVec);
               GammaCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  7: begin  { Geometric }
          s1 := StrToFloat(Edit1.Text); // p
          i1 := StrToint(Edit2.Text); // x
          RPDF := GeometricPDF(i1,s1);
          RCDF := GeometricCDF(i1,s1);
          if CheckBox1.Checked then
          begin
               XIntVec.Ramp;
               GeometricPDF(XIntVec,s1,PDFVec);
               GeometricCDF(XIntVec,s1,CDFVec);
          end;
     end;
  8: begin  { Hypergeometric }
          i1 := StrToInt(Edit1.Text); //M
          i2 := StrToInt(Edit2.Text); //K
          i3 := StrToInt(Edit3.Text); //N
          i4 := StrToInt(Edit4.Text); // x
          RPDF := HypGeometricPDF(i4,i1,i2,i3);
          RCDF := HypGeometricCDF(i4,i1,i2,i3);
          if CheckBox1.Checked then
          begin
               XIntVec.Ramp(0,Math387.Min(i2,i3)*0.01);
               HypGeometricPDF(XIntVec,i1,i2,i3,PDFVec);
               HypGeometricCDF(XIntVec,i1,i2,i3,CDFVec);
          end;
     end;
  9: begin  { Laplace }
          s1 := StrToFloat(Edit1.Text); // m
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := LaplacePDF(s3,s1,s2);
          RCDF := LaplaceCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(-s2,s2*0.1);
               LaplacePDF(XVec,s1,s2,PDFVec);
               LaplaceCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  10: begin  { Logistic }
          s1 := StrToFloat(Edit1.Text); // m
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := LogisticPDF(s3,s1,s2);
          RCDF := LogisticCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0.01,s2*0.1);
               LogisticPDF(XVec,s1,s2,PDFVec);
               LogisticCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  11: begin  { Log-Normal }
          s1 := StrToFloat(Edit1.Text); // mu
          s2 := StrToFloat(Edit2.Text); // sigma
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := LogNormalPDF(s3,s1,s2);
          RCDF := LogNormalCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0.01,s2*0.1);
               LogNormalPDF(XVec,s1,s2,PDFVec);
               LogNormalCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  12: begin  { Log-Weibull }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := LogWeibullPDF(s3,s1,s2);
          RCDF := LogWeibullCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(-5*s2+s1,s2*0.1);
               LogWeibullPDF(XVec,s1,s2,PDFVec);
               LogWeibullCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  13: begin  { Maxwell }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // x
          RPDF := MaxwellPDF(s2,s1);
          RCDF := MaxwellCDF(s2,s1);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0,s2*0.05);
               MaxwellPDF(XVec,s1,PDFVec);
               MaxwellCDF(XVec,s1,CDFVec);
          end;
     end;
  14: begin  { Negative binomial }
          s1 := StrToFloat(Edit1.Text); //R
          s2 := StrToFloat(Edit2.Text); // p
          i1 := StrToInt(Edit3.Text); // x
          RPDF := NegBinomPDF(i1,s1,s2);
          RCDF := NegBinomCDF(i1,s1,s2);
          if CheckBox1.Checked then
          begin
               XIntVec.Ramp(0,0.02*i1);
               NegBinomPDF(XIntVec,s1,s2,PDFVec);
          end;
     end;
  15: begin  { Normal }
          s1 := StrToFloat(Edit1.Text); // mu
          s2 := StrToFloat(Edit2.Text); // sigma
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := NormalPDF(s3,s1,s2);
          RCDF := NormalCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(s1-10*s2,0.2*s2);
               NormalPDF(XVec,s1,s2,PDFVec);
               NormalCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  16: begin  { Pareto }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := ParetoPDF(s3,s1,s2);
          RCDF := ParetoCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(s2+0.1,0.1);
               ParetoPDF(XVec,s1,s2,PDFVec);
               ParetoCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  17: begin  { Poisson }
          s1 := StrToFloat(Edit1.Text); // lambda
          i1 := StrToInt(Edit2.Text); // x
          RPDF := PoissonPDF(i1,s1);
          RCDF := PoissonCDF(i1,s1);
          if CheckBox1.Checked then
          begin
               XIntVec.Ramp;
               PoissonPDF(XIntVec,s1,PDFVec);
               PoissonCDF(XIntVec,s1,CDFVec);
          end;
     end;
  18: begin  { Student }
          i1 := StrToInt(Edit1.Text); // NU
          s1 := StrToFloat(Edit2.Text); // x
          RPDF := StudentPDF(s1,i1);
          RCDF := StudentCDF(s1,i1);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(-3*i1,0.06*i1);
               StudentPDF(XVec,i1,PDFVec);
               StudentCDF(XVec,i1,CDFVec);
          end;
     end;
  19: begin  { Rayleigh }
          s1 := StrToFloat(Edit1.Text); // b
          s2 := StrToFloat(Edit2.Text); // x
          RPDF := RayleighPDF(s2,s1);
          RCDF := RayleighCDF(s2,s1);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0.1,s2*0.05);
               RayleighPDF(XVec,s1,PDFVec);
               RayleighCDF(XVec,s1,CDFVec);
          end;
     end;
  20: begin  { Trangular }
          s1 := StrToFloat(Edit1.Text); //a
          s2 := StrToFloat(Edit2.Text); //b
          s3 := StrToFloat(Edit3.Text); //c
          s4 := StrToFloat(Edit4.Text); // x
          RPDF := TriangularPDF(s4,s1,s2,s3);
          RCDF := TriangularCDF(s4,s1,s2,s3);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(s1-1,(s2-s1+2)*0.01);
               TriangularPDF(XVec,s1,s2,s3,PDFVec);
               TriangularCDF(XVec,s1,s2,s3,CDFVec);
          end;
     end;
  21: begin  { Uniform - continous }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := UniformPDF(s3,s1,s2);
          RCDF := UniformCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(s1,(s2-s1)*0.01);
               UniformPDF(XVec,s1,s2,PDFVec);
               UniformCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  22: begin  { Uniform - discrete }
          i1 := StrToInt(Edit1.Text); // N
          i2 := StrToInt(Edit2.Text); // x
          RPDF := UniformDPDF(i2,i1);
          RCDF := UniformDCDF(i2,i1);
          if CheckBox1.Checked then
          begin
               XINtVec.Ramp(1,i1*0.01);
               UniformDPDF(XIntVec,i1,PDFVec);
               UniformDCDF(XIntVec,i1,CDFVec);
          end;
     end;
  23: begin  { Weibull }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          s3 := StrToFloat(Edit3.Text); // x
          RPDF := WeibullPDF(s3,s1,s2);
          RCDF := WeibullCDF(s3,s1,s2);
          if CheckBox1.Checked then
          begin
               XVec.Ramp(0.02,0.1);
               WeibullPDF(XVec,s1,s2,PDFVec);
               WeibullCDF(XVec,s1,s2,CDFVec);
          end;
     end;
  end;
  Edit5.Text := FloatToStrF(RPDF,ffFixed,Decimals,Decimals);
  Edit6.Text := FloatToStrF(RCDF,ffFixed,Decimals,Decimals);
  if CheckBox1.Checked then
  begin
       DrawValues(XVec,PDFVec,Series1);
       DrawValues(XVec,CDFVec,Series2);
  end;
end;

procedure TProb1.TrackBar1Change(Sender: TObject);
begin
  Decimals := TrackBar1.Position;
  Label8.Caption := IntToStr(Decimals);
end;

procedure TProb1.Button2Click(Sender: TObject);
var p : TSample;
var s1,s2,s3: TSample;
    i1,i2,i3: Integer;
    x          : TSample;
begin
  p := StrToFloat(Edit6.Text);
  Case RadioGroup1.ItemIndex of
  0:  begin  { BETA }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          x := BetaCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
      end;
  1:  begin  { Binomial }
          i1 := StrToInt(Edit1.Text); // N
          s1 := StrToFloat(Edit2.Text); // p
          x := BinomCDFInv(p,i1,s1);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
      end;
  2:  begin  {Cauchy }
          s1 := StrToFloat(Edit1.Text); // b
          s2 := StrToFloat(Edit2.Text); // m
          x := CauchyCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
      end;
  3:  begin  {CHI2 }
          s1 := StrToFloat(Edit1.Text); // Nu
          x := ChiSquareCDFInv(p,Trunc(s1));
          Edit2.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
      end;
  4: begin  { Exponential }
          s1 := StrToFloat(Edit1.Text); // Mu
          x := ExpCDFInv(p,s1);
          Edit2.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  5: begin  { F - Fisher }
          i1 := StrToInt(Edit1.Text); // Nu1
          i2 := StrToInt(Edit2.Text); // Nu2
          x := FCDFInv(p,i1,i2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  6: begin  { GAMMA }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          x := GammaCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  7: begin  { Geometric }
          s1 := StrToFloat(Edit1.Text); // p
          x := GeometricCDFInv(p,s1);
          Edit2.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  8: begin  { Hypergeometric }
          i1 := StrToInt(Edit1.Text); //M
          i2 := StrToInt(Edit2.Text); //K
          i3 := StrToInt(Edit3.Text); //N
          x := HypGeometricCDFInv(p,i1,i2,i3);
          Edit4.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  9: begin  { Laplace }
          s1 := StrToFloat(Edit1.Text); // m
          s2 := StrToFloat(Edit2.Text); // b
          x := LaplaceCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  10: begin  { Logistic }
          s1 := StrToFloat(Edit1.Text); // m
          s2 := StrToFloat(Edit2.Text); // b
          x := LogisticCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  11: begin  { log-normal }
          s1 := StrToFloat(Edit1.Text); // mu
          s2 := StrToFloat(Edit2.Text); // sigma
          x := LogNormalCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  12: begin  { log-Weibull }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          x := LogWeibullCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  13: begin  { Maxwell }
          s1 := StrToFloat(Edit1.Text); // a
          x := MaxwellCDFInv(p,s1);
          Edit2.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  14: begin  { Negative binomial }
          i1 := StrToInt(Edit1.Text); //R
          s1 := StrToFloat(Edit2.Text); // p
          x := NegBinomCDFInv(p,i1,s1);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  15: begin  { Normal }
          s1 := StrToFloat(Edit1.Text); // mu
          s2 := StrToFloat(Edit2.Text); // sigma
          x := NormalCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  16:  begin  { Pareto }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          x := ParetoCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
      end;
  17: begin  { Poisson }
          s1 := StrToFloat(Edit1.Text); // lambda
          x := PoissonCDFInv(p,s1);
          Edit2.Text := FloatToStrF(Trunc(x),ffFixed,0,0);
     end;
  18: begin  { Student }
          i1 := StrToInt(Edit1.Text); // NU
          x := StudentCDFInv(p,i1);
          Edit2.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  19: begin  { Rayleigh }
          s1 := StrToFloat(Edit1.Text); // lambda
          x := RayleighCDFInv(p,s1);
          Edit2.Text := FloatToStrF(x,ffFixed, Decimals,Decimals);
     end;
  20: begin  { Hypergeometric }
          s1 := StrToFloat(Edit1.Text); //a
          s2 := StrToFloat(Edit2.Text); //b
          s3 := StrToFloat(Edit3.Text); //c
          x := TriangularCDFInv(p,s1,s2,s3);
          Edit4.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  21: begin  { Uniform - continous }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          x := UniformCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  22: begin  { Uniform - discrete }
          i1 := StrToInt(Edit1.Text); // N
          x := UniformDCDFInv(p,i1);
          Edit2.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  23: begin  { Weibull }
          s1 := StrToFloat(Edit1.Text); // a
          s2 := StrToFloat(Edit2.Text); // b
          x := WeibullCDFInv(p,s1,s2);
          Edit3.Text := FloatToStrF(x,ffFixed,Decimals,Decimals);
     end;
  end;
end;

procedure TProb1.Edit1Enter(Sender: TObject);
begin
  Button1.Enabled := true;
  Button2.Enabled := false;
end;

procedure TProb1.Edit6Enter(Sender: TObject);
begin
  Button1.Enabled := false;
  Button2.Enabled := true;
end;

initialization
   RegisterClass(TProb1);

end.
