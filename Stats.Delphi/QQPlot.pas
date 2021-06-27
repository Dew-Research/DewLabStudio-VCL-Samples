unit QQPlot;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Form, TeEngine, TeeTools, Series, StatSeries,
  TeeProcs, Chart, StdCtrls, ExtCtrls, TeCanvas, TeePenDlg, MtxVec, Math387,
  MtxExpr;

type
  TfrmQQPlot = class(TfrmBasic)
    Panel2: TPanel;
    Chart1: TChart;
    Button1: TButton;
    ButtonPen1: TButtonPen;
    Button2: TButton;
    GridBandTool1: TGridBandTool;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Data: Vector;
    X,Y: Vector;
    minX,MaxX,MinY,MaxY: double;
    ProbSeries: TStatProbSeries;
    procedure Recalc;
  public
    { Public declarations }
  end;

var
  frmQQPlot: TfrmQQPlot;

implementation
{$R *.DFM}

Uses EditChar, MtxVecTee, StatProbPlots;

procedure TfrmQQPlot.Button1Click(Sender: TObject);
begin
  EditSeries(Self,ProbSeries);
end;

procedure TfrmQQPlot.FormCreate(Sender: TObject);
begin
  inherited;
  { Setup probability plot series and special axis label tool }
  Chart1.FreeAllSeries(nil);
  ProbSeries := TStatProbSeries.Create(Chart1);
  ProbSeries.Title := 'Probability';
  ProbSeries.ParentChart := Chart1;
  ProbSeries.SlopePen.Color := clBlack;

  With Memo1.Lines do
  begin
    Clear;
    Add('The Quantile-Quantile plot');
    Add(chr(13));
    Add('The TStatSpecialSeries can be used to plot the Quantile-Quantile Chart. '+
        'Most properties can be customized (click the "Edit" button)');
  end;
  ButtonPen1.LinkPen(ProbSeries.SlopePen);
  x.Size(0, false, DefaultIsDouble);
  y.Size(0, false, DefaultIsDouble);
  With Data do
  begin
    Size(100);
    RandGauss(5,0.1);
  end;
  Recalc;
end;

procedure TfrmQQPlot.Button2Click(Sender: TObject);
var ResStr: String;
    Mu,Sigma: double;
begin
  ResStr := InputBox('Data size','Number of points to be generated : ','100');
  try
    Data.Size(StrToInt(ResStr));
  except
    Data.Size(100);
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

procedure TfrmQQPlot.Recalc;
begin
  StatQQPlot(Data,X,Y,MinX,MaxX,MinY,MaxY,false);
  ProbSeries.MinX := MinX;
  ProbSeries.MaxX := MaxX;
  ProbSeries.MinY := MinY;
  ProbSeries.MaxY := MaxY;
  DrawValues(X,Y,ProbSeries);
end;

initialization
  RegisterClass(TfrmQQPlot);

end.
