unit WindowFilters;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, Math387, MtxExpr, TeeGDIPlus;

type
  TWindowFiltersForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    ChartTool1: TAxisScaleTool;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    FreqEdit: TMtxFloatEdit;
    Label1: TLabel;
    Label2: TLabel;
    TransEdit: TMtxFloatEdit;
    Label3: TLabel;                                     
    FilterLengthEdit: TMtxFloatEdit;
    TeeGDIPlus1: TTeeGDIPlus;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FreqEditChange(Sender: TObject);
  private
    procedure FillSeries(Freq,Att: TSample; Length: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WindowFiltersForm: TWindowFiltersForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses SignalUtils, MtxVec;

procedure TWindowFiltersForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TWindowFiltersForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TWindowFiltersForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TWindowFiltersForm.FormCreate(Sender: TObject);
begin
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Change the length of the filter to see how the width the transition bandwidth changes. ' +
            'The attenuation in dB applies only to Kaiser in Chebyshev windows. Cutoff frequency '+
            'defines the start of the attenuation.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
     FillSeries(0.2,40,128);
end;

procedure TWindowFiltersForm.FillSeries(Freq,Att:TSample; Length: integer);
var i: integer;
    H: Vector;
begin
     SpectrumAnalyzer.Window := wtRectangular;
     SpectrumAnalyzer.Logarithmic := True;
     SpectrumAnalyzer.ZeroPadding := 16;
     SpectrumAnalyzer.LogSpan := ls200;
     if Odd(Length) then Inc(Length);
     h.IsDouble := DefaultIsDouble;
     h.Length := Length;
     for i := 0 to SpectrumChart.SeriesList.Count-1 do SpectrumChart.Series[0].Free;
     for i := 0 to 10 do
     begin
         SpectrumChart.AddSeries(TFastLineSeries.Create(SpectrumChart));
         SpectrumChart.Spectrums[0].Series := SpectrumChart.Series[i];
         SpectrumChart.Series[i].Title := SignalWindowToString(TSignalWindowType(i));
         case TSignalWindowType(i) of
         wtBlackman: FirImpulse(h,[Freq,Freq+0.05],0.3,ftLowPass, TSignalWindowType(i),h.Length/2);
         wtKaiser: FirImpulse(h,[Freq,Freq+0.05],KaiserBetaFir(Power(10,-Att/20)),ftLowPass, TSignalWindowType(i),h.Length/2);
         else FirImpulse(h,[Freq,Freq+0.05],Att,ftLowPass, TSignalWindowType(i),h.Length/2);
         end;
         SpectrumAnalyzer.Process(h); //no denominator and place result in self
     end;
     SpectrumChart.Legend.Visible := True;
end;

procedure TWindowFiltersForm.FreqEditChange(Sender: TObject);
begin
     FillSeries(FreqEdit.Position,TransEdit.Position,FilterLengthEdit.IntPosition);
end;

initialization
RegisterClass(TWindowFiltersForm);

end.
