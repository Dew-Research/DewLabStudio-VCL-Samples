unit CoherenceTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalUtils, MtxExpr, TeeGDIPlus;
                                               
type
  TCoherenceTestForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    Series1: TFastLineSeries;
    RichEdit1: TRichEdit;
    ChartTool1: TAxisScaleTool;
    Series2: TPointSeries;
    SignalRead1: TSignalRead;
    FilteredSignal: TSignal;
    SpectrumBox: TComboBox;
    Label1: TLabel;                                               
    PhaseBox: TCheckBox;
    EditSpectrumButton: TToolButton;
    CrossSpectrumAnalyzerDialog: TCrossSpectrumAnalyzerDialog;
    UpdateButton: TToolButton;
    FilterLengthLabel: TLabel;
    CrossAnalyzer: TCrossSpectrumAnalyzer;
    procedure SignalRead1AfterUpdate(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SpectrumBoxChange(Sender: TObject);
    procedure PhaseBoxClick(Sender: TObject);
    procedure EditSpectrumButtonClick(Sender: TObject);
    procedure CrossAnalyzerParameterUpdate(Sender: TObject);
    procedure UpdateButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FirState: TFirState;
  end;

var
  CoherenceTestForm: TCoherenceTestForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses MtxVec, Math387;


procedure TCoherenceTestForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TCoherenceTestForm.SignalRead1AfterUpdate(Sender: TObject);
begin
     if Assigned(FilteredSignal) then
     begin
           FirFilter(SignalRead1.Data, FilteredSignal.Data,FirState);
           FilteredSignal.SamplingFrequency := SignalRead1.SamplingFrequency;
     end;
end;

procedure TCoherenceTestForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     CrossAnalyzer.Update;
end;

procedure TCoherenceTestForm.FormCreate(Sender: TObject);
var h: Vector;
    Delay: integer;
begin
     SignalRead1.IsDouble := DefaultIsDouble; //select processing precision
     SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
     SignalRead1.OpenFile;

     h.IsDouble := DefaultIsDouble; //select processing precision
     h.Size(0); //required by .NET only
     KaiserImpulse(h, [0.2,0.25], 0.001, ftLowPass, 1, 2, true);
     Delay := (H.Length - 1) div 2;
     FilterLengthLabel.Caption := 'Filter delay = ' + IntToStr(Delay) + ' samples, ' +
                                  FormatSample('0.00000s',Delay*SignalRead1.Dt);

     FirInit(H,FirState);

     FilteredSignal.UsesInputs := false;
     SpectrumBox.ItemIndex := 4;
     SpectrumChart.Spectrums[0].Series := SpectrumChart.Series[0];
     ToolButton1Click(Sender);

     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('The cross spectral analysis is usefull when trying to determine:');
        Add('');
        Paragraph.FirstIndent := 10;
        Paragraph.Numbering := nsBullet;
        Add('What is the transfer function of the system.');
        Add('Is the system linear or not. If it is not linear, at which frequencies ' +
            'is the system non-linear.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
        Add('');
        Add('Change the value of the spectrum box to see the frequency spectrum of the signal that was' +
            'send in to the system (input spectrum), what came out (output spectrum), what is the ' +
            'frequency response of the system (transfer function) and the test for linearity (coherence). ' +
            'The system in this test case is a low pass FIR filter. With sufficient averaging, coherence ' +
            'would converge to 1. A coherence of 1 means that the system is linear at that frequency.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
    end;
end;

procedure TCoherenceTestForm.FormDestroy(Sender: TObject);
begin
     FirFree(FirState);
end;

procedure TCoherenceTestForm.ToolButton1Click(Sender: TObject);
begin
     SignalRead1.OpenFile;
     SignalRead1.RecordPosition := 0;
     SignalRead1.LastFrameCheck := lfcLastFullBlock;
//   SignalRead1.OverlappingPercent := 50;  we can not use this, because of the filter
     with CrossAnalyzer do
     begin
          ResetAveraging;
          Logarithmic := True;
          Window := wtHanning;
          LogType := ltRelative;
     end;
     CrossAnalyzer.CrossAnalyzer.Recursive := false;
     while (CrossAnalyzer.Pull <> pipeEnd) do
     begin
          //fast enough so there is no need for a progress indicator here
     end;
     CrossAnalyzer.CrossAnalyzer.Update;  //if recursive would be True, this would not be neccessary.
     SpectrumBoxChange(Sender);
end;

procedure TCoherenceTestForm.SpectrumBoxChange(Sender: TObject);
begin
     CrossAnalyzer.CrossAnalyzer.Transform := TCrossTransform(SpectrumBox.ItemIndex);
     SpectrumChart.Title.Text.Clear;
     SpectrumChart.Title.Text.Add(CrossTransformToString(CrossAnalyzer.CrossAnalyzer.Transform));
     CrossAnalyzer.UpdateSpectrum;
end;

procedure TCoherenceTestForm.PhaseBoxClick(Sender: TObject);
begin
     SpectrumChart.SpectrumPart := TSpectrumPart(PhaseBox.Checked);
     Case SpectrumChart.SpectrumPart of
     sppAmplt: SpectrumChart.LeftAxis.Title.Caption := 'Amplitude';
     sppPhase: SpectrumChart.LeftAxis.Title.Caption := 'Delay [seconds]';
     end;
end;

procedure TCoherenceTestForm.EditSpectrumButtonClick(Sender: TObject);
begin
     CrossSpectrumAnalyzerDialog.Execute;
end;

procedure TCoherenceTestForm.CrossAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumBox.ItemIndex := Byte(CrossAnalyzer.CrossAnalyzer.Transform);
     SpectrumChart.SpectrumPart := TSpectrumPart(PhaseBox.Checked);
     SpectrumChart.Title.Text.Clear;
     SpectrumChart.Title.Text.Add(CrossTransformToString(CrossAnalyzer.CrossAnalyzer.Transform));
     CrossAnalyzer.UpdateSpectrum;
end;

procedure TCoherenceTestForm.UpdateButtonClick(Sender: TObject);
begin
     SignalRead1.RecordPosition := 0;
     CrossAnalyzer.CrossAnalyzer.Recursive := false;
     CrossAnalyzer.PullUntilEnd;
     CrossAnalyzer.CrossAnalyzer.Update;  //if recursive would be True, this would not be neccessary.
     SpectrumBoxChange(Sender);
end;

initialization
RegisterClass(TCoherenceTestForm);

end.
