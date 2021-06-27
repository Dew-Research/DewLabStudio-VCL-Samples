unit QC_Pareto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic_Chart, StdCtrls, TeeProcs, TeEngine, Chart, ExtCtrls, Series,
  MtxVec, Math387, TeeTools, VclTee.TeeGDIPlus;

type
  TfrmParetoChart = class(TfrmBasicChart)
    Series1: TBarSeries;
    Series2: TLineSeries;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Series2GetMarkText(Sender: TChartSeries; ValueIndex: Integer;
      var MarkText: String);
  private
    { Private declarations }
    Data : TVec;
    Factor : double;
    procedure Recalc;
  public
    { Public declarations }
  end;

var
  frmParetoChart: TfrmParetoChart;

implementation

Uses MtxVecEdit, MtxVecTee, Statistics, TeeJPEG, TeeGIF;

{$R *.DFM}

procedure TfrmParetoChart.Button2Click(Sender: TObject);
begin
  ViewValues(Data,'Data',True,False);
end;

procedure TfrmParetoChart.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('The Pareto and Pareto Cumulative Charts');
    Add('As with all TeeChart series, all parts of chart are fully' +
        ' configurable (click the "Edit Chart" button). ' +
        'You can also export result chart to different graphic'+
        ' formats. Click on "Edit Chart" button. Then select the "Export" tab...');
  end;
  Data := TVec.Create;
  { load prepared data }
  try
    Data.LoadFromFile('QC_Pareto.vec');
  except
  end;
end;

procedure TfrmParetoChart.FormDestroy(Sender: TObject);
begin
  Data.Destroy;
  inherited;
end;

procedure TfrmParetoChart.Recalc;
var DrawVec,CumSumVec: TVec;
begin
  Series2.Active := RadioGroup1.ItemIndex = 1;
  Series1.Marks.Visible := RadioGroup1.ItemIndex = 0;
  DrawVec := TVec.Create;
  try
    DrawVec.Copy(Data);
    { that's all there is to Pareto }
    DrawVec.SortDescend;
    { draw pareto chart }
    DrawValues(DrawVec,Series1,0.0,1.0,false);
    if RadioGroup1.ItemIndex = 1 then
    begin
      CumSumVec := TVec.Create;
      try
        { Cumulative pareto }
        CumSumVec.CumSum(DrawVec);
        Factor := 100.0 / DrawVec.Sum;
	      CumSumVec.Scale(Factor);
        { draw cumulatiove pareto chart }
        Series2.GetVertAxis.SetMinMax(0.0,100);
        Series1.GetVertAxis.SetMinMax(0.0,DrawVec.Sum);
        DrawValues(CumSumVec,Series2, 0.0, 1.0,false);
      finally
        CumSumVec.Destroy;
      end;
    end else Series1.GetVertAxis.Automatic := True;
  finally
    DrawVec.Destroy;
  end;
end;

procedure TfrmParetoChart.RadioGroup1Click(Sender: TObject);
begin
  Recalc;
end;

procedure TfrmParetoChart.FormShow(Sender: TObject);
begin
  inherited;
  Recalc;
end;

procedure TfrmParetoChart.Series2GetMarkText(Sender: TChartSeries;
  ValueIndex: Integer; var MarkText: String);
begin
  MarkText := FormatFloat('0.00 %', Series2.YValues[ValueIndex]);
end;

initialization
  RegisterClass(TfrmParetoChart);

end.
