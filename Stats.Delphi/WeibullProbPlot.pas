unit WeibullProbPlot;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, TeeTools,
  MtxVec, Series, StatSeries, TeCanvas, TeePenDlg, Math387, MtxExpr;

type
  TfrmWeibullProb = class(TfrmBasic)
    Panel2: TPanel;
    Button1: TButton;
    Chart1: TChart;
    Button2: TButton;
    ButtonPen1: TButtonPen;
    GridBandTool1: TGridBandTool;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Data,X,Y: Vector;
    MinX,MaxX, MinY, MaxY: double;
    ProbSeries: TStatProbSeries;
    procedure Recalc;
  public
    { Public declarations }
  end;

var
  frmWeibullProb: TfrmWeibullProb;

implementation

Uses EditChar, MtxVecTee, Statistics, StatProbPlots, StatRandom;
{$R *.DFM}

procedure TfrmWeibullProb.Button2Click(Sender: TObject);
begin
  EditSeries(Self,ProbSeries);
end;

procedure TfrmWeibullProb.Button1Click(Sender: TObject);
var ResStr: String;
    a,b: double;
begin
  ResStr := InputBox('Data size','Number of points to be generated : ','100');
  try
    Data.Size(StrToInt(ResStr));
  except
    Data.Size(100);
  end;
  ResStr := InputBox('a','a: ',FormatFloat('0.00',3.0));
  try
    a := StrToFloat(ResStr);
  except
    a := 3.0;
  end;
  ResStr := InputBox('b','b: ',FormatFloat('0.00',2.2));
  try
    b := StrToFloat(ResStr);
  except
    b := 2.2;
  end;
  RandomWeibull(a,b,Data);
  Recalc;
end;

procedure TfrmWeibullProb.Recalc;
begin
  StatWeibullPlot(Data,X,Y,MinX,MaxX,MinY,MaxY,false);
  ProbSeries.MinX := MinX;
  ProbSeries.MaxX := MaxX;
  ProbSeries.MinY := MinY;
  ProbSeries.MaxY := MaxY;
  DrawValues(X,Y,ProbSeries);
end;

procedure TfrmWeibullProb.FormCreate(Sender: TObject);
begin
  inherited;
  { Setup probability plot series and special axis label tool }
  Chart1.Tools.Clear;
  Chart1.FreeAllSeries(nil);
  ProbSeries := TStatProbSeries.Create(Chart1);
  ProbSeries.Title := 'Probability';
  ProbSeries.ParentChart := Chart1;
  ProbSeries.SlopePen.Color := clBlack;

  ButtonPen1.LinkPen(ProbSeries.SlopePen);
  With Memo1.Lines do
  begin
    Clear;
    Add('Weibull probability plot');
    Add(chr(13));
    Add('The TStatSpecialSeries can be used to plot the Weibull probability Chart. '+
        'Most properties can be customized (click the "Edit" button)');
  end;
  Data.Size(100);
  RandomWeibull(3,2.2,Data);
  Recalc;
end;

initialization
  RegisterClass(TfrmWeibullProb);

end.
