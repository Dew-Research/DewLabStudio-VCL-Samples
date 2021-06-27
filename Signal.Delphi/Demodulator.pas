unit Demodulator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, MtxBaseComp, SignalTools, SignalAnalysis, SignalToolsDialogs,
  SpectrumAna, TeeProcs, TeEngine, Chart, SignalToolsTee, StdCtrls,
  ExtCtrls, FileSignal, Series, SignalSeriesTee, TeeTools, TeeEdit,
  SignalProcessing, MtxVec, MtxComCtrls, MtxDialogs, ComCtrls, ToolWin,
  TeeGDIPlus;

type
  TDemodulatorForm = class(TForm)
    SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog;
    SignalRead1: TSignalRead;
    ChartEditor1: TChartEditor;
    Demodulator: TSignalDemodulator;
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
    FilterDelayLabel: TLabel;
    AttBox: TComboBox;
    Label3: TLabel;
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
  DemodulatorForm: TDemodulatorForm;

implementation

uses Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TDemodulatorForm.FormCreate(Sender: TObject);
begin
    AttBox.ItemIndex := 0;

    SignalRead1.IsDouble := DefaultIsDouble; //select processing precision
    SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';

    RichEdit1.Clear;
    RichEdit1.Lines.Add('TSignalDemodulator component moves the selected bandwidth down to 0Hz. ' +
          'The component features multi-rate, multi-stage decimation which allows ' +
          'demodulation of very narrow frequency bands (less then 0.01% of original bandwidth ' +
          'is not a problem). In the example below you can change the Frequency and Bandwidth ' +
          'parameters. Bandwidth changes can be made in any step but  ' +
          'fastest will be with sampling frequency reduction/increase by 2x. Both frequency and bandwidth are '+
          'defined in radians and must range between 0 and 0.5 and frequency + bandwidth may not be bigger then 0.5. '+
          'The component also allows you to sample with sampling frequency of 44.1Khz directly from ' +
          'the sound card and have a real time frequency spectrum display of bandwidth between 20 and 20.1 Khz ' +
          'with frequency resolution of 1 mHz (for example).');
    RichEdit1.Paragraph.FirstIndent := 0;
    RichEdit1.Paragraph.Numbering := nsNone;

    Demodulator.SubBandFrequency := MtxFloatEdit1.Position;
    Demodulator.SubBandWidth := MtxFloatEdit2.Position;

    SignalRead1.OpenFile;
    SignalRead1.RecordPosition := 0;
    SignalBuffer.Reset();
    SpectrumAnalyzer3.Update;
    while (SignalBuffer.Pull <> pipeOK) do
    begin
        if SignalBuffer.PipeState = pipeEnd then Break;
    end;
    SpectrumAnalyzer1.Update;
end;

procedure TDemodulatorForm.SpectrumAnalyzer1ParameterUpdate(Sender: TObject);
begin
    SpectrumAnalyzer1.Update;
    SpectrumAnalyzer3.Update;
end;

procedure TDemodulatorForm.MtxFloatEdit1Change(Sender: TObject);
begin
     Demodulator.SubBandFrequency := MtxFloatEdit1.Position;
     Demodulator.SubBandWidth := MtxFloatEdit2.Position;
     Demodulator.Ripple := Exp10(StrToInt(AttBox.Text)/-20);
     SignalRead1.RecordPosition := 0;
     SignalBuffer.Reset();
     SpectrumAnalyzer3.Update;
     while (SignalBuffer.Pull <> pipeOK) do
     begin
        if SignalBuffer.PipeState = pipeEnd then Break;
     end;
     SpectrumAnalyzer1.Update;

     //delay in terms of the original sampling frequency
     FilterDelayLabel.Caption := 'Delay = ' + FormatSample('0', Demodulator.FilterDelay/Demodulator.Factor);
end;

procedure TDemodulatorForm.FormResize(Sender: TObject);
begin
     SpectrumChart3.Height := Panel1.Height div 2;
end;

procedure TDemodulatorForm.AttBoxChange(Sender: TObject);
begin
   MtxFloatEdit1Change(Sender);
end;

procedure TDemodulatorForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor1.Execute;
end;

procedure TDemodulatorForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog1.Execute();
end;

initialization
RegisterClass(TDemodulatorForm);

end.
