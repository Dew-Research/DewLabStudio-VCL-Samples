unit Modulator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, MtxBaseComp, SignalTools, SignalAnalysis, SignalToolsDialogs,
  SpectrumAna, TeeProcs, TeEngine, Chart, SignalToolsTee, StdCtrls,
  ExtCtrls, FileSignal, Series, SignalSeriesTee, TeeTools, TeeEdit,
  SignalProcessing, MtxVec, MtxComCtrls, MtxDialogs, ComCtrls, ToolWin,
  TeeGDIPlus;

type
  TModulatorForm = class(TForm)
    SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog;
    SignalRead1: TSignalRead;
    ChartEditor1: TChartEditor;
    SpectrumAnalyzer1: TSpectrumAnalyzer;
    SpectrumAnalyzer3: TSpectrumAnalyzer;
    RichEdit1: TRichEdit;
    Panel2: TPanel;                                  
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    Label1: TLabel;
    MtxFloatEdit1: TMtxFloatEdit;                           
    Label2: TLabel;
    MtxFloatEdit2: TMtxFloatEdit;
    Panel1: TPanel;
    SpectrumChart2: TSpectrumChart;
    FastLineSeries1: TFastLineSeries;
    SignalDiscreteSeries1: TSignalDiscreteSeries;
    AxisScaleTool1: TAxisScaleTool;
    Splitter2: TSplitter;
    SpectrumChart3: TSpectrumChart;
    FastLineSeries2: TFastLineSeries;
    SignalDiscreteSeries2: TSignalDiscreteSeries;
    AxisScaleTool2: TAxisScaleTool;
    ChartTool1: TSpectrumMarkTool;
    SignalBuffer: TSignalBuffer;
    SignalModulator: TSignalModulator;
    FilterDelayLabel: TLabel;
    Label3: TLabel;
    AttBox: TComboBox;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpectrumAnalyzer1ParameterUpdate(Sender: TObject);
    procedure MtxFloatEdit1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure AttBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModulatorForm: TModulatorForm;

implementation

uses SignalUtils, Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TModulatorForm.FormCreate(Sender: TObject);
begin
     AttBox.ItemIndex := 0;
     SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('TSignalModulator component moves the selected bandwidth from 0Hz to any ' +
            'user defined frequency. It is the reverse procedure to the zoom-spectrum ' +
            'or demodulation. The linear phase modulator features exceptional performance ' +
            'and accuracy with up to 160dB SNR speed exceeding standard multi-rate implementations ' +
            'by multiple times. The carrier frequency can be specified as a multiple of the ' +
            'sampling frequency of the original signal. The Factor parameter is used to specify ' +
            'the final sampling frequency.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
    end;

    SignalModulator.Factor := MtxFloatEdit2.Position;
    SignalModulator.CarrierFrequency := MtxFloatEdit1.Position;
    SignalRead1.OpenFile;
    SignalRead1.RecordPosition := 0;
    SignalBuffer.Reset();
    SpectrumAnalyzer3.Update;
    while (SignalBuffer.Pull <> pipeOK) do
    begin
        if SignalBuffer.PipeState = pipeEnd then Break;
    end;
    SpectrumAnalyzer1.Update;

    FilterDelayLabel.Caption := 'Delay: ' + FormatSample('0.#',SignalModulator.FilterDelay);    
end;

procedure TModulatorForm.SpectrumAnalyzer1ParameterUpdate(Sender: TObject);
begin
    SpectrumAnalyzer1.Update;
    SpectrumAnalyzer3.Update;
end;

procedure TModulatorForm.MtxFloatEdit1Change(Sender: TObject);
begin
    SignalModulator.Factor := MtxFloatEdit2.Position;
    SignalModulator.CarrierFrequency := MtxFloatEdit1.Position;
    SignalModulator.Ripple := Exp10(StrToInt(AttBox.Text)/-20);
    SignalRead1.RecordPosition := 0;
    SignalBuffer.Length := LargestExp2(Round(1024*SignalModulator.Factor));
    SignalBuffer.Reset();
    SpectrumAnalyzer3.Update;
    while (SignalBuffer.Pull <> pipeOK) do
    begin
        if SignalBuffer.PipeState = pipeEnd then Break;
    end;
    SpectrumAnalyzer1.Update;

    FilterDelayLabel.Caption := 'Delay: ' + FormatSample('0.#',SignalModulator.FilterDelay);
end;

procedure TModulatorForm.FormResize(Sender: TObject);
begin
    SpectrumChart3.Height := Panel1.Height div 2;
end;

procedure TModulatorForm.AttBoxChange(Sender: TObject);
begin
    MtxFloatEdit1Change(Sender);
end;

procedure TModulatorForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor1.Execute;
end;

procedure TModulatorForm.SpectrumEditButtonClick(Sender: TObject);
begin
    SpectrumAnalyzerDialog1.Execute();
end;

initialization
RegisterClass(TModulatorForm);

end.
