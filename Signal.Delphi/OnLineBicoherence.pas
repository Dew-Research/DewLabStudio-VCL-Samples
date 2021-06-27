unit OnLineBicoherence;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxVec, MtxComCtrls, AudioSignal, TeeGDIPlus;

type
  TOnLineBicoherenceForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    FreqEdit: TMtxFloatEdit;
    Label1: TLabel;
    Panel2: TPanel;
    SpectrumChart: TSpectrumChart;                           
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    ChartTool1: TAxisScaleTool;                    
    Splitter1: TSplitter;
    SpectrumChart1: TSpectrumChart;
    FastLineSeries1: TFastLineSeries;
    PointSeries1: TPointSeries;
    AxisScaleTool1: TAxisScaleTool;
    ChartTool2: TSpectrumMarkTool;
    SignalIn1: TSignalIn;
    Signal1: TSignal;
    SignalTimer1: TSignalTimer;
    ChannelBox: TComboBox;
    Label2: TLabel;
    ToolButton1: TToolButton;
    BiSpectrumAnalyzerDialog1: TBiSpectrumAnalyzerDialog;
    BiSpectrumAnalyzer: TBiSpectrumAnalyzer;
    ChartTool3: TSpectrumMarkTool;
    ChartTool4: TColorLineTool;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FreqEditChange(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure SignalTimer1Timer(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ChannelBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OnLineBicoherenceForm: TOnLineBicoherenceForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses MtxVecEdit, MtxVecTee, SignalUtils, Math387;

procedure TOnLineBicoherenceForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TOnLineBicoherenceForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TOnLineBicoherenceForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TOnLineBicoherenceForm.FormCreate(Sender: TObject);
begin
     SignalIn1.IsDouble := DefaultIsDouble;
     Signal1.IsDouble := DefaultIsDouble;

     Signal1.Data.Size(1024);  // defines how much data to copy and consequently also frequency resolution
     Signal1.Data.SetZero;
     Signal1.UsesInputs := false;
     Signal1.SamplingFrequency := SignalIn1.SamplingFrequency;
     BiSpectrumAnalyzer.Stats.Averaging := avExponentInf;
     BispectrumAnalyzer.Stats.ExpDecay := 20;
     with BispectrumAnalyzer do
     begin
          Amplt.SetZero;
          BiAnalyzer.SingleLinesOnly := True;
          BispectrumAnalyzer.BiAnalyzer.Lines.Size(100, Signal1.Data);
          BispectrumAnalyzer.BiAnalyzer.Lines.Ramp(20,10);  //becase resolution is about 10 Hz/line
     end;
     ChannelBox.ItemIndex := 0;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Bicoherence shows the frequencies related to the selected frequency. ' +
            'The bicoherence can also be run in real time, but before the ' +
            'spectrum is representative, sufficient number of running averages must be made.' +
            'A very limiting condition is that the frequency spectrum of the analyzed ' +
            'signal may not change significantly during the analysis.' +
            'Bicoherence can therefore be applied only in cases where it is possible ' +
            'to acquire sufficiently long signals whose frequency content does not change with time ' +
            'very quickly. For example, usually about 20 averages will be sufficient and with 90% ' +
            'overlapping. With a sampling frequency of 11kHz and frequency spectrum length of ' +
            '1024 frequency bins, that would mean that at least 6144/11025 = 0.4 seconds are needed ' +
            'during which the frequency content of the signal may not change significantly.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
//     SignalIn1.Start(SignalIn1)  //will not work from here...
     FreqEditChange(Sender);
end;

procedure TOnLineBicoherenceForm.FreqEditChange(Sender: TObject);
begin
      BispectrumAnalyzer.SamplingFrequency := SignalIn1.SamplingFrequency; //needed only for the first call
      //because the sampling frequency has not yet been set by the Update method,
      //simply because the timer has not yet triggered.  
      BispectrumAnalyzer.BiAnalyzer.Frequency := FreqEdit.Position;
      TColorLineTool(SpectrumChart.Tools[2]).Value := FreqEdit.Position;
      SpectrumChart1.Title.Text.Clear;
      SpectrumChart1.Title.Text.Add('Bicoherence of frequency: ' + FormatSample('0',FreqEdit.Position) + 'Hz');
end;

procedure TOnLineBicoherenceForm.Panel2Resize(Sender: TObject);
begin
      SpectrumChart1.Height := Panel2.Height div 2;
end;

procedure TOnLineBicoherenceForm.SignalTimer1Timer(Sender: TObject);
begin
     if not SignalIn1.Active then SignalIn1.Start;
     case TChannel(ChannelBox.ItemIndex) of
     chLeft:  SignalIn1.MonitorData(Signal1, nil    );
     chRight: SignalIn1.MonitorData(nil    , Signal1);
     end;
     SpectrumAnalyzer.Pull;
     BispectrumAnalyzer.Pull;
end;

procedure TOnLineBicoherenceForm.ToolButton1Click(Sender: TObject);
begin
     BispectrumAnalyzerDialog1.Execute;
end;

procedure TOnLineBicoherenceForm.ChannelBoxChange(Sender: TObject);
begin
     BispectrumAnalyzer.ResetAveraging;
end;

initialization
RegisterClass(TOnLineBicoherenceForm);

end.
