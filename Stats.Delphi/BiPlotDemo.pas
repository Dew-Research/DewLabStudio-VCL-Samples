unit BiPlotDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Chart, StdCtrls, TeeProcs, TeEngine, Chart, ExtCtrls,
  StatTools, StatSeries, Series, Math387, VclTee.TeeGDIPlus;

type
  TfrmBiPlot = class(TfrmBasicChart)
    Button2: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    mtxPCA: TMtxPCA;
    points1: TPointSeries;
    biplot1: TBiPlotSeries;
    procedure PopulateSeries;
  public
    { Public declarations }
  end;

var
  frmBiPlot: TfrmBiPlot;

implementation

{$R *.dfm}

Uses MtxVec,MtxVecEdit, Types;

procedure TfrmBiPlot.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Biplots are statistical graphics that represent in the same plane both the variables  and the cases. Usually variables are represented by arrows, while points represent cases.');
    Add('');
    Add('In this example the famous Fisher Iris data is used in Principal Component Analysis.');
  end;

  // for coefficients
  biplot1 := TBiPlotSeries.Create(Chart1);
  biplot1.Title := 'Coefficients';
  biplot1.Marks.Visible := True;
  biplot1.ParentChart := Chart1;
  biplot1.GetHorizAxis.LabelStyle := talValue;

  // for scores
  points1 := TPointSeries.Create(Chart1);
  points1.Title := 'Scores';
  points1.ParentChart := Chart1;

  mtxPCA := TMtxPCA.Create(Self);
  try
    mtxPCA.Data.LoadFromFile('FisherIris.mtx');
  except
    mtxPCA.Data.Size(100,4);
    mtxPCA.Data.RandGauss;
  end;

  PopulateSeries;
end;

procedure TfrmBiPlot.PopulateSeries;
var i: Integer;
begin
  points1.Clear;
  biplot1.Clear;
  mtxPCA.Recalc;
  // scores
  if mtxPCA.ZSCores.Length > 0 then
  for i := 0 to mtxPCa.Data.Rows -1 do
    points1.AddXY(mtxPCA.ZScores[i,0],mtxPCA.ZScores[i,1]);
  // first two components of eigenvectors (coefficients)
  for i := 0 to mtxPCa.PC.Cols -1 do
    biplot1.AddXY(mtxPCA.PC[0,i],mtxPCA.PC[1,i],IntToStr(i));
end;

procedure TfrmBiPlot.Button2Click(Sender: TObject);
begin
  ViewValues(mtxPCa.Data,'PCA data',true,false,true);
  PopulateSeries;
end;

procedure TfrmBiPlot.CheckBox1Click(Sender: TObject);
begin
  biplot1.ShowArrows := CheckBox1.Checked;
end;

initialization
  RegisterClass(TfrmBiPlot);

end.
