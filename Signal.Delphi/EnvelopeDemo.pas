unit EnvelopeDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalProcessing, TeeGDIPlus;

type
  TEnvelopeDemoForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    SignalRead1: TSignalRead;
    Panel2: TPanel;
    SpectrumChart: TSpectrumChart;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    ChartTool1: TAxisScaleTool;                       
    Splitter1: TSplitter;                           
    SignalChart1: TSignalChart;
    Series3: TFastLineSeries;
    SignalDecimator1: TSignalDecimator;
    SignalIncBuffer1: TSignalIncBuffer;
    SignalIncBuffer2: TSignalIncBuffer;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EnvelopeDemoForm: TEnvelopeDemoForm;

implementation

uses Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TEnvelopeDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
    SpectrumAnalyzerDialog.Execute;
end;

procedure TEnvelopeDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TEnvelopeDemoForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TEnvelopeDemoForm.FormCreate(Sender: TObject);
begin
    SignalRead1.IsDouble := DefaultIsDouble;
    SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
    SignalRead1.OpenFile;
    SignalIncBuffer2.SuspendNotifyUpdate := True; //prevent chart updates for every call to Update
    SignalIncBuffer2.Factor := 13;  //increase the buffer by 13x, because SignalRead1.Length = 1024 and SignalRead1.RecordLength = 14000
    SignalIncBuffer1.Factor := 11;  //increase the buffer of the decimator output only by 11x,
                             //because the first two blocks will contain FIR filter delay
                             //in that way the 12th and 13th block will push out blocks 0 and 1
                             //from the circular buffer
    while (SignalIncBuffer1.Pull <> pipeEnd) do //Pull is True until the end of file. (Until the last full frame)
    begin
        SignalincBuffer2.Update; //Copy data from SignalRead1 to SignalIncBuffer2
    end;
    SpectrumAnalyzer.ZeroPadding := 4;
    SpectrumAnalyzer.Update; //compute the spectrum and update TSpectrumChart
    SignalIncBuffer2.UpdateNotify;  //update TSignalChart
    With RichEdit1.Lines, RichEdit1 do
    begin
        Clear;
        Add('The strongest peak in the spectrum shows the frequency of the envelope. ' +
            'That frequency is noticed on the bottom chart when looking at the peaks ' +
            'of the time signal only. The sampling frequency is reduced by 64 times.');
    end;
end;


procedure TEnvelopeDemoForm.Panel2Resize(Sender: TObject);
begin
    SpectrumChart.Height := Panel2.Height div 2;
end;

initialization
RegisterClass(TEnvelopeDemoForm);

end.
