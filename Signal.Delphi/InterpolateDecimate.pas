unit InterpolateDecimate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalProcessing, MtxComCtrls, TeeGDIPlus;

type
  TInterpolateDecimateForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    Series1: TFastLineSeries;
    RichEdit1: TRichEdit;
    ChartTool1: TAxisScaleTool;
    Series2: TPointSeries;
    SignalRead1: TSignalRead;
    SignalDecimator1: TSignalDecimator;           
    SignalInterpolator1: TSignalInterpolator;
    SpectrumAnalyzer1: TSpectrumAnalyzer;                  
    SignalWrite1: TSignalWrite;
    SignalRead2: TSignalRead;
    SignalRead3: TSignalRead;
    Series3: TFastLineSeries;
    FilePositionEdit1: TMtxFloatEdit;
    FilePositionEdit2: TMtxFloatEdit;
    Label1: TLabel;
    Label2: TLabel;
    FilterDelayLabel: TLabel;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FilePositionEdit1Change(Sender: TObject);
    procedure FilePositionEdit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InterpolateDecimateForm: TInterpolateDecimateForm;

implementation

uses Math387, SignalUtils, MtxVecTee;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TInterpolateDecimateForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TInterpolateDecimateForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TInterpolateDecimateForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update;
    SpectrumAnalyzer1.AssignTemplate(SpectrumAnalyzer);
    SpectrumAnalyzer1.Update;
end;

procedure TInterpolateDecimateForm.FormCreate(Sender: TObject);
begin
    Signalread1.IsDouble := DefaultIsDouble; //specify processing precision
    Signalread2.IsDouble := DefaultIsDouble; //specify processing precision
    Signalread3.IsDouble := DefaultIsDouble; //specify processing precision

    SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
    SignalRead1.OpenFile;
    SignalWrite1.FileName := ExtractFileDir(Application.ExeName) + '\bz.dat';
    SignalWrite1.PullUntilEnd; //creates a new filtered file
    SignalRead1.CloseFile;
    SignalWrite1.CloseFile;

    SignalRead2.Length := 1024; //define the read block size (and frequency resolution)
    SignalRead3.Length := 1024; //define the read block size
    SignalRead2.FileName := SignalRead1.FileName;
    SignalRead3.FileName := SignalWrite1.FileName;

    SignalRead2.OpenFile;
    SignalRead2.RecordPosition := 0;
    with SpectrumAnalyzer do
    begin
         DCDump := False;
         LogType := ltAbsolute;
         LogSpan := ls150;
         Logarithmic := True;
         Window := wtKaiser;
         SidelobeAtt := 130;
    end;
    SpectrumAnalyzer1.AssignTemplate(SpectrumAnalyzer); //make it the same
    SpectrumAnalyzer.Update;
    FilePositionEdit2.Position := Round(2*SignalDecimator1.FilterDelay*SignalDecimator1.Factor); //SpectrumAnalyzer1.Update;

    FilterDelayLabel.Caption := 'Delay: ' + FormatSample('0.#',SignalDecimator1.FilterDelay*SignalDecimator1.Factor);

    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('High speed low-pass filter. When it is neccessary to obtain extremely ' +
          'narrow transition bands, eliptic IIR and ParksMcClellan FIR filters ' +
          'fail to perform. An alternative in such cases is to employ multi-rate ' +
          'multi-stage FIR decimation and then interpolation. ' +
          'In the example below, the signal has a cutoff at 73 Hz and stopband '+
          'attenuation of 80dB. The width of the ' +
          'transition region is only 3 Hz. The sampling frequency of the signal is 4666Hz. ' +
          '3 Hz is less then 0.1% of the bandwidth. Examine the chart and notice that in the pass band both frequency ' +
          'spectrums have an exact match. This type of low-pass filtering takes ' +
          'only a small fraction of time of a single FIR low pass filter whose length ' +
          'would exceed 3600 taps. To processing time required is about the same as ' +
          'filtering the original signal 4x with a 30 taps long filter. ' +
          'To make the strong attenuation in the passband evident, Kaiser window ' +
          'has been employed with sidelobe attenuation of 130dB. Try ' +
          'lowering the sidelobe attenuation in the spectrum analyzer dialog and observe '+
          'what happens. The transition band is not as narrow as ' +
          'was the filter specification, but this is only because ' +
          'the Kaiser has a very wide mainlobe (frequency spectrum does not ' +
          'show the true reality). With TSignalDemodulator and TSignalModulator ' +
          'components this filtering approach can be used for any lowpass, bandpass, highpass ' +
          'filter specification.' );
    end;
end;

procedure TInterpolateDecimateForm.FilePositionEdit1Change(Sender: TObject);
begin
    SignalRead2.RecordPosition := FilePositionEdit1.IntPosition;
    SpectrumAnalyzer.Update;
end;

procedure TInterpolateDecimateForm.FilePositionEdit2Change(
  Sender: TObject);
begin
    SignalRead3.RecordPosition := FilePositionEdit2.IntPosition;
    SpectrumAnalyzer1.Update;
end;

initialization
RegisterClass(TInterpolateDecimateForm);

end.
