unit CepstrumDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, MtxBaseComp, SignalTools, SignalAnalysis, SignalToolsDialogs,
  SpectrumAna, TeeProcs, TeEngine, Chart, SignalToolsTee, StdCtrls,
  ExtCtrls, FileSignal, Series, SignalSeriesTee, TeeTools, TeeEdit,
  SignalProcessing, MtxVec, MtxComCtrls, MtxDialogs, ComCtrls, ToolWin,
  math387, MtxExpr, TeeGDIPlus;

type
  TCepstrumDemoForm = class(TForm)
    SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog;
    SignalRead1: TSignalRead;
    ChartEditor1: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    Panel1: TPanel;
    SpectrumChart2: TSpectrumChart;
    FastLineSeries1: TFastLineSeries;
    SignalDiscreteSeries1: TSignalDiscreteSeries;     
    AxisScaleTool1: TAxisScaleTool;
    Splitter2: TSplitter;
    CepstrumBox: TComboBox;
    Label1: TLabel;
    SignalChart1: TSignalChart;
    Signal1: TSignal;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    ToolButton1: TToolButton;
    ChartEditor2: TChartEditor;
    SpectrumAnalyzer1: TSpectrumAnalyzer;
    procedure FormCreate(Sender: TObject);
    procedure SpectrumAnalyzer1ParameterUpdate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure CepstrumBoxChange(Sender: TObject);
    procedure SpectrumAnalyzer1AfterUpdate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Data: Vector;
  end;

var
  CepstrumDemoForm: TCepstrumDemoForm;

implementation

uses SignalUtils, AbstractMtxVec, Types;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TCepstrumDemoForm.FormCreate(Sender: TObject);
begin
     SignalRead1.IsDouble := DefaultIsDouble; //select processing precision
     SignalRead1.Length := 4096;
     SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
     SignalRead1.OverlappingPercent := 50;
     SignalRead1.OpenFile;
     With RichEdit1.Lines, RichEdit1 do
     begin
         Clear;
         Add('Complex cepstrum can be used to measure echo delays and for homomorphic filtering.' +
             'Real cepstrum can detect periodicities in the frequency spectrum. ');
         Paragraph.FirstIndent := 0;
         Paragraph.Numbering := nsNone;
     end;
     CepstrumBox.ItemIndex := 0;
     CepstrumBoxChange(Sender);
end;

procedure TCepstrumDemoForm.FormDestroy(Sender: TObject);
begin
    //
end;

procedure TCepstrumDemoForm.SpectrumAnalyzer1ParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer1.Update;
end;

procedure TCepstrumDemoForm.FormResize(Sender: TObject);
begin
     SpectrumChart2.Height := Panel1.Height div 2;
end;

procedure TCepstrumDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor1.Execute;
end;

procedure TCepstrumDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog1.Execute();
end;

procedure TCepstrumDemoForm.CepstrumBoxChange(Sender: TObject);
begin
     SignalRead1.RecordPosition := 0;
     SpectrumAnalyzer1.ResetAveraging;
     SpectrumAnalyzer1.PullUntilEnd;
     SpectrumAnalyzer1.UpdateNotify; //Notify disabled within PullUntilEnd
     Signal1.SamplingTime := Signal1.Length;
     Signal1.UpdateNotify;  //update connected chart.
end;

procedure TCepstrumDemoForm.SpectrumAnalyzer1AfterUpdate(Sender: TObject);
begin
     Data.Size(0); //required by CLR only because data is passed as parameter and was initialized before
     case CepstrumBox.ItemIndex of
     0: RealCepstrum(SignalRead1.Data,Data,True,wtHanning,True);
     1: CplxCepstrum(SignalRead1.Data,Data);
     end;
     Signal1.Data[0] := 0; //set DC to zero
     RunningAverage(Signal1.Data,Data,SignalRead1.FrameNumber);
end;

procedure TCepstrumDemoForm.ToolButton1Click(Sender: TObject);
begin
     ChartEditor2.Execute;
end;

initialization
RegisterClass(TCepstrumDemoForm);

end.
