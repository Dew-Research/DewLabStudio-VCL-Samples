unit PhaseShifter;

interface

uses
  System.Types,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, Math387, MtxVec, MtxExpr, TeeGDIPlus;

type
  TPhaseShifterForm = class(TForm)
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
    FirLengthLabel: TLabel;
    TransBWEdit: TMtxFloatEdit;
    Label1: TLabel;
    DiffBox: TComboBox;                              
    Label2: TLabel;
    Series2: TFastLineSeries;
    Series3: TPointSeries;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TransBWEditChange(Sender: TObject);
  private
    procedure FillSeries(TransBW, Ripple: TSample; PINdex: integer);
    procedure ComputeError(h: TVec; Err: TVec);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PhaseShifterForm: TPhaseShifterForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses OptimalFir, SignalUtils, MTxVecTee, AbstractMtxVec;

procedure TPhaseShifterForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TPhaseShifterForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TPhaseShifterForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TPhaseShifterForm.FormCreate(Sender: TObject);
begin
    DiffBox.ItemIndex := 0;
    TransBWEditChange(Sender);
    SpectrumChart.Legend.Visible := True;    
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('Hilbert transformers are used to obtain analytical representation of a real signal. ' +
          'Analytical signal is a complex signal. ' +
          'Hilbert transformers generate a 90 degree phase shifted version of the original signal. ' +
          'The original signal becomes the real part and hilbert transformer becomes the imaginary part of ' +
          'the new analytical signal. Hilbert transformes can be left out in many cases, if the signal is ' +
          'multiplied with a complex exponential (a complex sine function), which of course also results ' +
          'in a complex signal.');
      Add('');
      Paragraph.FirstIndent := 0;
      Paragraph.Numbering := nsNone;
    end;
end;

procedure TPhaseShifterForm.ComputeError(h: TVec; Err: TVec);
var H1,A1: Vector;
begin
     H1.IsDouble := DefaultIsDouble;
     H1.Length := H.Length;
     H1.SetZero;
     H1[0] := H.Length/2; //simple impulse for testing
     with SpectrumAnalyzer do
     begin
         DCDump := False;
         Window := wtRectangular;
         ZeroPadding := 16;
         Process(H1);
         A1.Copy(Amplt);
         Process(H);
         Err.Copy(A1 - Amplt);
     end;
end;


procedure TPhaseShifterForm.FillSeries(TransBW,Ripple: TSample; Pindex: integer);
var h,Err: Vector;
    Title: string;
begin
    H.IsDouble := DefaultIsDouble;
    H.Size(0);
    Err.Size(0);

    case PIndex of
    0: begin
       Title := 'Frequency response of a type III Hilbert filter (Kaiser).';
       KaiserImpulse( H,[1-TransBW,1],Ripple, ftHilbertIII,1,2);
       SpectrumAnalyzer.Integration := inNone;
       H.Scale(H.Length/2);
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,err);
       end;
    1: begin
       Title := 'Frequency response of a type IV Hilbert filter (Kaiser).';
       KaiserImpulse( H,[1-TransBW,1],Ripple, ftHilbertIV,1,2);
       SpectrumAnalyzer.Integration := inNone;
       H.Scale(H.Length/2);
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,err);
       end;
    2: begin
       Title := 'Frequency response of a type III Hilbert filter (remez).';
       RemezImpulse(H,[TransBW,1-TransBW],Ripple, ftHilbertIII,1,2);
       SpectrumAnalyzer.Integration := inNone;
       H.Scale(H.Length/2);
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,err);
       end;
    3: begin
       Title := 'Frequency response of a type IV Hilbert filter (remez).';
       RemezImpulse( H,[TransBW,1],Ripple, ftHilbertIV,1,2);
       SpectrumAnalyzer.Integration := inNone;
       H.Scale(H.Length/2);
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,err);
       end;
    end;
    SpectrumChart.Title.Text.Clear;
    SpectrumChart.Title.Text.Add(Title);
    with SpectrumAnalyzer do
    begin
         DCDump := False;
         Window := wtRectangular;
         ZeroPadding := 16;
         Process(H);
    end;
    DrawValues(err,SpectrumChart.Series[1],0,SpectrumAnalyzer.HzRes);
end;

procedure TPhaseShifterForm.TransBWEditChange(Sender: TObject);
begin
     FillSeries(TransBWEdit.Position,0.02, DiffBox.ItemIndex);
end;

initialization
RegisterClass(TPhaseShifterForm);

end.
