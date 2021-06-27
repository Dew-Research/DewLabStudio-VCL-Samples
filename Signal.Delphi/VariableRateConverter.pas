unit VariableRateConverter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, SignalProcessing, MtxVecTee, TeeGDIPlus;

type
  TVariableRateConverterForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    RichEdit1: TRichEdit;
    FreqEdit: TMtxFloatEdit;
    Label1: TLabel;
    Label2: TLabel;
    PhaseEdit: TMtxFloatEdit;
    Label3: TLabel;
    AmpltEdit: TMtxFloatEdit;
    Panel2: TPanel;                                 
    SpectrumChart: TSpectrumChart;                       
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    Splitter1: TSplitter;
    SignalChart: TSignalChart;
    ToolButton1: TToolButton;
    SignalChart1: TSignalChart;
    ChartTool1: TAxisScaleTool;
    RateConverter: TSignalVariableRateConverter;
    Series4: TMtxFastLineSeries;
    Series5: TMtxFastLineSeries;
    Series3: TMtxFastLineSeries;
    cFreqEdit: TMtxFloatEdit;
    SpectrumAnalyzer1: TSpectrumAnalyzer;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    Series6: TMtxFastLineSeries;
    Label4: TLabel;
    cAmpltEdit: TMtxFloatEdit;
    Label5: TLabel;
    ccFreqEdit: TMtxFloatEdit;
    Label6: TLabel;
    Series7: TMtxFastLineSeries;
    SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor1: TChartEditor;
    Signal1: TSignal;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Signal1AfterUpdate(Sender: TObject);
    procedure FreqEditChange(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure MtxFloatEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VariableRateConverterForm: TVariableRateConverterForm;

implementation

uses SignalUtils, Math387, MtxExpr, MtxVec, AbstractMtxVec;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TVariableRateConverterForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.ExecuteModal;
     SpectrumAnalyzer1.AssignTemplate(SpectrumAnalyzer);
     SpectrumAnalyzer1.Update;
end;

procedure TVariableRateConverterForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor1.Execute;
end;

procedure TVariableRateConverterForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TVariableRateConverterForm.FormCreate(Sender: TObject);
begin
     Signal1.UsesInputs := false;
     SpectrumAnalyzer.PhaseMode := pm360;
     SpectrumAnalyzer.Pull;
     SpectrumAnalyzer1.Update;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Variable rate conversion allows the sampling frequency to change from ' +
            'sample to sample without aliasing. As other rate conversion based methods ' +
            'this one also features a maximum stop band attenuation of 160dB and ' +
            'user definable width of the transition band. In the example below we generate '+
            'a frequency modulated tone and then apply variable rate conversion to convert the ' +
            'signal in to one single straight tone. The algorithm uses a fixed filter bank, ' +
            'is very fast and suitable for ' +
            'real time processing also at high sampling frequencies (1Mhz and up).');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
end;

procedure TVariableRateConverterForm.Signal1AfterUpdate(Sender: TObject);
var //ts: TToneState;
    a,b,c,d,e,resV: Vector;
    Freq: TSample;
    Len: integer;
    ccFreqAmplt,ccFreq: TSample;
begin
     Len := 4096;
//     h := 1/Len;

     //The frequency of the tone generated, The average frequency
     Freq := cFreqEdit.IntPosition;

     //The frequency of the variation of the frequency of the tone
     ccFreq := ccFreqEdit.Position;
     //The amplitude of the frequency of the variation of the frequency of the tone
     ccFreqAmplt := cAmpltEdit.Position;

     c.Size(Len);  //needed only for VCL.NET  {
     d.Size(Len);
     e.Size(Len);  //  }

     Tone(c,Len,ccFreq/Len,0,ccFreqAmplt); //3 periods per window
     Tone(d,Len,ccFreq/Len,DegToRad(90),ccFreqAmplt); //derivate of the frequency variation (the cosine)

     b := Ramp(Len, c.FloatPrecision, 0,Freq/Len) + c;

     //now generate the resampling function to extract the original sine from the chirp
     Tone(e,Len,ccFreq/Len,DegToRad(180),ccFreqAmplt);  //180 degree out of phase with original to cancel out the variation
     ResV := Ramp(Len,e.FloatPrecision, 0,Freq/Len) + e;   //our resample vector.

     //Compute the frequency as the derivate using analyitical formula
     d := 2*Pi*ccFreq*d + Freq;                   //freq here is the derivate of the ramp
     DrawValues(d,Series6,0,Signal1.Dt); //draw the frequency

     //Alternative is to compute the derivate numerically:
 //    e := Difference(b)*Len;
//     DrawValues(e,Series7,0,Signal1.Dt);

     a := Sin(b*2*pi);  //generate the tone
     Signal1.Data.Copy(a);
end;

procedure TVariableRateConverterForm.FreqEditChange(Sender: TObject);
begin
     SpectrumAnalyzer.Pull;
end;

procedure TVariableRateConverterForm.MtxFloatEdit1Change(Sender: TObject);
begin
    Signal1AfterUpdate(Sender);
end;

procedure TVariableRateConverterForm.Panel2Resize(Sender: TObject);
begin
     SpectrumChart.Height := Trunc(Panel2.Height/1.8);
end;

procedure TVariableRateConverterForm.ToolButton1Click(Sender: TObject);
begin
     ChartEditor1.Execute;
end;

initialization
RegisterClass(TVariableRateConverterForm);

end.
