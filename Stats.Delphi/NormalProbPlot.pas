unit NormalProbPlot;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, TeeTools,
  MtxVec, Series, StatSeries, TeCanvas, TeePenDlg, Math387;

type
  TfrmNormalProb = class(TfrmBasic)
    Panel2: TPanel;
    Button1: TButton;
    Chart1: TChart;
    Button2: TButton;
    ButtonPen1: TButtonPen;
    GridBandTool1: TGridBandTool;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Data,X,Y: TVec;
    StdErrs: TVec;
    ub,lb: TVec;
    MinX,MaxX, MinY, MaxY: double;
    ProbSeries: TStatProbSeries;
    ubseries, lbseries: TLineSeries;
    procedure Recalc;
  public
    { Public declarations }
  end;

var
  frmNormalProb: TfrmNormalProb;

implementation

Uses EditChar, MtxVecTee, StatProbPlots, Probabilities;
{$R *.DFM}

procedure TfrmNormalProb.Button2Click(Sender: TObject);
begin
  EditSeries(Self,ProbSeries);
end;

procedure TfrmNormalProb.Button1Click(Sender: TObject);
var ResStr: String;
    Mu,Sigma: double;
begin
  ResStr := InputBox('Data size','Number of points to be generated : ','100');
  try
    Data.Size(StrToInt(ResStr), Data.FloatPrecision);
  except
    Data.Size(100, Data.FloatPrecision);
  end;
  ResStr := InputBox('Mu','Mu (average) : ',FormatFloat('0.00',3.5));
  try
    Mu := StrToFloat(ResStr);
  except
    Mu := 3.5;
  end;
  ResStr := InputBox('Sigma','Sigma (Std.dev.) : ',FormatFloat('0.00',0.1));
  try
    Sigma := StrToFloat(ResStr);
  except
    Sigma := 0.1;
  end;
  Data.RandGauss(Mu,Sigma);
  Recalc;
end;

procedure TfrmNormalProb.FormCreate(Sender: TObject);
begin
  inherited;
  { Setup probability plot series }
  Chart1.FreeAllSeries(nil);
  ProbSeries := TStatProbSeries.Create(Chart1);
  ProbSeries.Title := 'Probability';
  ProbSeries.ParentChart := Chart1;
  ProbSeries.SlopePen.Color := clBlack;

  ubSeries := TLineSeries.Create(Chart1);
  ubSeries.ParentChart := Chart1;
  ubSeries.Color := clRed;
  ubSeries.Title := '95% CI';
  lbSeries := TLineSeries.Create(Chart1);
  lbSeries.ParentChart := Chart1;
  lbSeries.Color := clRed;
  lbSeries.ShowInLegend := False;

  ButtonPen1.LinkPen(ProbSeries.SlopePen);
  With Memo1.Lines do
  begin
    Clear;
    Add('Normal probability plot');
    Add(chr(13));
    Add('The TStatSpecialSeries can be used to plot the Normal probability Chart. '+
        'Most properties can be customized (click the "Edit" button)');
  end;
  Data := TVec.Create;
  X := TVec.Create;
  Y := TVec.Create;
  StdErrs := TVec.Create;
  Ub := TVec.Create;
  Lb := TVec.Create;
  Data.Size(100, false, DefaultIsDouble);
  Data.RandGauss(3.5,0.1);
  Recalc;
end;

procedure TfrmNormalProb.FormDestroy(Sender: TObject);
begin
  Data.Destroy;
  X.Destroy;
  Y.Destroy;
  StdErrs.Destroy;
  Ub.Destroy;
  Lb.Destroy;
  inherited;
end;

procedure TfrmNormalProb.Recalc;
var zVal : double;
begin
  StatNormalPlot(Data,X,Y,MinX,MaxX,MinY,MaxY,StdErrs,false);
  zVal := NormalCDFInv(0.975,0,1);
  StdErrs.Mul(zVal);
  Ub.Add(Y,StdErrs);
  Lb.Sub(Y,StdErrs);
  ProbSeries.MinX := MinX;
  ProbSeries.MaxX := MaxX;
  ProbSeries.MinY := MinY;
  ProbSeries.MaxY := MaxY;
  DrawValues(X,Y,ProbSeries);
  DrawValues(X,ub,ubSeries);
  DrawValues(X,lb,lbSeries);
end;

initialization
  RegisterClass(TfrmNormalProb);

end.
