unit BicoherenceTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxVec, MtxComCtrls, TeeSurfa, MtxVecTee, SignalUtils,
  MtxExpr, MtxGridSerEdit, TeeGDIPlus;

type
  TBicoherenceTestForm = class(TForm)      
    Panel1: TPanel;                                          
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    Chart1: TChart;
    Series1: TMtxGridSeries;
    Button1: TToolButton;
    Splitter1: TSplitter;
    Label1: TLabel;
    Label2: TLabel;
    Freq1Edit: TMtxFloatEdit;
    Freq2Edit: TMtxFloatEdit;
    SpectrumChart: TSpectrumChart;
    FastLineSeries1: TFastLineSeries;
    Series2: TPointSeries;
    Signal1: TSignal;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    BiSpectrumAnalyzer: TBiSpectrumAnalyzer;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Freq2EditChange(Sender: TObject);
    procedure Freq1EditChange(Sender: TObject);
    procedure Signal1AfterUpdate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Bmtx: Matrix;
    ToneState1,ToneState2: TToneState;
  end;

var
  BicoherenceTestForm: TBicoherenceTestForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses MtxVecEdit, Math387, AbstractMtxVec;

procedure TBicoherenceTestForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TBicoherenceTestForm.FormCreate(Sender: TObject);
begin
     Signal1.IsDouble := DefaultIsDouble;
     Signal1.UsesInputs := false;

     BispectrumAnalyzer.Amplt.SetZero;
     Freq1EditChange(Self);
     Freq2EditChange(Self);
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('This test feeds the bispectrum analyzer with the '+
            'following test signal: Sin(w1)+Sin(w2)+Sin(w1)*Sin(w1)+Some_Gaussian_Noise. ' +
            'The result should be two dots. Sum and difference frequencies in the bicoherence spectrum ' +
            'located at (w1,w2-w1) and (w2,w1)');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
end;

procedure TBicoherenceTestForm.Freq2EditChange(Sender: TObject);
begin
     Button1Click(Sender);
end;

procedure TBicoherenceTestForm.Freq1EditChange(Sender: TObject);
begin
     Button1Click(Sender);
end;

procedure TBicoherenceTestForm.Signal1AfterUpdate(Sender: TObject);
var Tone1,Tone2: Vector;
begin   //write a formula: Tone1+Tone2+Tone1*Tone2 + gaussian_noise
     Tone1.Size(Signal1.Data);
     Tone2.Size(Signal1.Data);
     Tone(Tone1,ToneState1);
     Tone(Tone2,ToneState2);

     Signal1.Data.Copy(Tone1 + Tone2 + Tone1*Tone2 + RandGauss(Tone1.Length, Signal1.FloatPrecision, 0,0.1));
end;

procedure TBicoherenceTestForm.Button1Click(Sender: TObject);
var i: integer;
begin
     ToneInit(Freq1Edit.Position/Signal1.SamplingFrequency,0,1,ToneState1);
     ToneInit(Freq2Edit.Position/Signal1.SamplingFrequency,0,1,ToneState2);
     BispectrumAnalyzer.ResetAveraging;
     BispectrumAnalyzer.Window := SpectrumAnalyzer.Window;
     for i := 0 to 25 do
     begin
          BispectrumAnalyzer.Pull;
     end;
     BispectrumAnalyzer.BiAnalyzer.Update; //compute bicoherence
     BispectrumAnalyzer.BiAnalyzer.GetFullSpectrum(BMtx.Size(0,0),True);  //get result

     with Series1 do
     begin
         Clear;
         ColorPalette.TopColor := clBlue;
         ColorPalette.BottomColor := clWhite;
         Matrix := BMtx; //must be set... to copy the data;
//         CreateDefaultPalette;
         Repaint;
     end;

     SpectrumAnalyzer.Update;
end;

procedure TBicoherenceTestForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TBicoherenceTestForm.Panel2Resize(Sender: TObject);
begin
     Chart1.Height := Trunc(Panel2.Height*0.66);
end;

initialization
RegisterClass(TBicoherenceTestForm);

end.
