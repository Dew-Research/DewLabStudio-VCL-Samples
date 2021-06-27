unit SignalAnalysisDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, MtxBaseComp,Series, StdCtrls, TeeTools,
  MtxDialogs, SignalUtils, MtxComCtrls, SignalToolsDialogs, SignalAnalysis,
  SignalTools, FileSignal, TeeGDIPlus;

type
  TSignalAnalysisDemoForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    Splitter1: TSplitter;
    SignalChart1: TSignalChart;
    Series3: TFastLineSeries;
    FilterBox: TComboBox;
    Label1: TLabel;
    SignalRead1: TSignalRead;
    SignalAnalyzerDialog1: TSignalAnalyzerDialog;
    AnalysisButton: TToolButton;
    Series1: TPointSeries;
    SignalAnalyzer1: TSignalAnalyzer;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FilterBoxChange(Sender: TObject);
    procedure StepEditChange(Sender: TObject);
    procedure AnalysisButtonClick(Sender: TObject);
    procedure SignalAnalyzer1ParameterUpdate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SignalAnalysisDemoForm: TSignalAnalysisDemoForm;

implementation

uses Math387, MtxVec, MtxVecTee;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TSignalAnalysisDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TSignalAnalysisDemoForm.FormCreate(Sender: TObject);
begin
    Signalread1.IsDouble := DefaultIsDouble;
    SignalRead1.FileName := ExtractFilePath(Application.ExeName) + 'bz.SFS';
    SignalRead1.RecordPosition := 0;
    FilterBox.ItemIndex := 0;
    FilterBoxChange(Sender);
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('A simple drop-in component gives instant access to a wide array ' +
          'of standard signal processing operations like autocorrelation, discrete ' +
          'cosine transform, signal statistics and more...');
    end;
end;

procedure TSignalAnalysisDemoForm.FilterBoxChange(Sender: TObject);
begin
     SignalAnalyzer1.Transform := TTimeTransform(FilterBox.ItemIndex);
     SignalAnalyzer1.Update;
end;

procedure TSignalAnalysisDemoForm.StepEditChange(Sender: TObject);
begin
     FilterBoxChange(Sender);
end;

procedure TSignalAnalysisDemoForm.AnalysisButtonClick(Sender: TObject);
begin
     SignalAnalyzerDialog1.Execute;
end;

procedure TSignalAnalysisDemoForm.SignalAnalyzer1ParameterUpdate(
  Sender: TObject);
begin
     SignalAnalyzer1.Update;
end;

initialization
RegisterClass(TSignalAnalysisDemoForm);

end.
