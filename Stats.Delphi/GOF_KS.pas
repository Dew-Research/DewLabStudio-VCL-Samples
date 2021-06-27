unit GOF_KS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Form, StdCtrls, ExtCtrls, Statistics, MtxVec, Math387, Series,
  TeEngine, StatChar, TeeProcs, Chart;

type
  TfrmGOFKS = class(TfrmBasic)
    Panel2: TPanel;
    Panel3: TPanel;
    Memo2: TMemo;
    Button1: TButton;
    Chart1: TChart;
    Series1: THistogramSeries;
    Series2: TLineSeries;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
    Data: TVec;
    X,ECDF,TCDF: TVec;
    DStat: double;
    procedure Tests;
    procedure RefreshChart;
    procedure DoTest(Alpha: double);
  public
    { Public declarations }
  end;

var
  frmGOFKS: TfrmGOFKS;

implementation

Uses MtxVecTee, Probabilities, StatRandom;
{$R *.dfm}

procedure TfrmGOFKS.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('New in Stats master 2.1: The Kolmogorov-Smirnov GOF test');
    Add('In the example 100 random numbers (for Normal, Log-normal, Student(T) and Weibull distribution) '
        + 'are generated and then '
        + 'used in K-S test to test if data comes from normal distribution.');
    Add('');
    Add('The graph below is a plot of the empirical '
        + 'distribution function with a theoretical cumulative '
        + 'distribution function for 100 random '
        + 'numbers. The K-S test is based on the maximum distance '
        + 'between these two curves.');
    Add('');
    Add('Press the "Run Test" button to regenerate random values and '
        + 'perform K-S test for different alpha levels');
  end;

  Data := TVec.Create;
  X := TVec.Create;
  ECDF := TVec.Create;
  TCDF := TVec.Create;
  Data.Size(100,False);
end;

procedure TfrmGOFKS.FormDestroy(Sender: TObject);
begin
  Data.Destroy;
  X.Destroy;
  ECDF.Destroy;
  TCDF.Destroy;
  inherited;
end;


procedure TfrmGOFKS.Button1Click(Sender: TObject);
begin
  { Perform KS normality test on three different distributions }
  Case RadioGroup1.ItemIndex of
    0 : begin
          Data.RandGauss;
          Tests;
        end;
    1 : begin
          RandomLogNormal(0.0,1.0,Data);
          Tests;
        end;
    2 : begin
          RandomStudent(3,Data);
          Tests;
        end;
    3 : begin
          RandomWeibull(1,1.3,Data);
          Tests;
        end;
  end;
  RefreshChart;
end;

procedure TfrmGOFKS.DoTest(Alpha: double);
var hRes: THypothesisResult;
  Signif: double;
  st: String;
begin
  With Memo2.Lines do
  begin
    DStat := GOFKolmogorov(Data,hRes,Signif,nil,nil,htTwoTailed,Alpha);
    st := FormatSample('0.0000',Alpha)+#9+#9+FormatSample('0.0000',Signif)+#9;
    if hRes = hrNotReject then st := st+'Accept H0' else st := st+'Reject H0';
    Add(st);
  end;
end;

procedure TfrmGOFKS.Tests;
begin
  With Memo2.Lines do
  begin
    Clear;
    Add('KOLMOGOROV-SMIRNOV GOF TEST');
    Add('');
    Add('H0:'+#9+'Distribution fits the data');
    Add('HA:'+#9+'Distribution does not fit the data');
    Add('Distribution:'+#9+'Normal');
    Add('Number of observations:'+#9+IntToStr(Data.Length));
    Add('');
    Add('Alpha level'+#9+'p-value'+#9+'Conclusion');
    Add('----------------------------------------------');
  end;
  { Perform tests for different alphas }
  DoTest(0.005);
  DoTest(0.01);
  DoTest(0.05);
  DoTest(0.1);
  DoTest(0.15);
  DoTest(0.25);
  With Memo2.Lines do
  begin
    Add('----------------------------------------------');
    Insert(6,'KS statistic:'+#9+FormatFloat('0.0000',DStat));
  end;
end;

procedure TfrmGOFKS.RefreshChart;
begin
  { EmpiricalCDF needs sorted data ! }
  Data.SortAscend;
  EmpiricalCDF(Data,x,ECDF); { Empirical CDF }
  NormalCDF(X,0.0,1.0,TCDF); { Theoretical standard CDF }
  ECDF.SetSubRange(0,ECDF.Length-1); { ignore last value for yCDF (see help) }
  DrawValues(X,ECDF,Series1,True);
  DrawValues(X,TCDF,Series2,True);
  ECDF.SetSubRange; { reset subrange }
end;

procedure TfrmGOFKS.RadioGroup1Click(Sender: TObject);
var i: Integer;
begin
  for i := 0 to Chart1.SeriesCount - 1 do
    Chart1.Series[i].Clear;
  Memo2.Lines.Clear;
end;

initialization
  RegisterClass(TfrmGOFKS);


end.
