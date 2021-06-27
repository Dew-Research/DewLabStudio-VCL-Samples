unit OptimalFilters;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, Math387, MtxVec, MtxExpr, TeeGDIPlus;

type
  TOptimalFiltersForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    Series1: TFastLineSeries;
    RichEdit1: TRichEdit;
    ChartTool1: TAxisScaleTool;
    Series2: TPointSeries;                                       
    FirLengthLabel: TLabel;
    TransBWEdit: TMtxFloatEdit;
    Label1: TLabel;                                      
    Label2: TLabel;
    AttEdit: TMtxFloatEdit;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    ImpulseButton: TToolButton;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TransBWEditChange(Sender: TObject);
    procedure ImpulseButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure FillSeries(TransBW, Ripple: TSample);
    { Private declarations }
  public
    { Public declarations }
    h: Vector;
  end;

var
  OptimalFiltersForm: TOptimalFiltersForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses OptimalFir, SignalUtils, MTxVecTee, MtxVecEdit;

procedure TOptimalFiltersForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TOptimalFiltersForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TOptimalFiltersForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TOptimalFiltersForm.FormCreate(Sender: TObject);
begin
    with SpectrumAnalyzer do
    begin
         LogSpan := ls350;
         Logarithmic := True;
         DCDump := False;
         Window := wtRectangular;
         ZeroPadding := 8;
    end;
    FillSeries(0.04,0.000000001);
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('Optimal FIR filters can be designed by using Parks-McClellan algorithm. ' +
          'On the chart below you can see an example of "auto-length" band-pass filter design.' +
          'Change the required stop band attenuation and the width of the transition regions. ' +
          'Not all combinations will result in a valid filter. You can design FIR filters ' +
          'with stop band attenuation down to -180 dB and filter length of up to 5000.' +
          'For typical aplications FIR filters of length not more then 500 are used.');
      Add('');
      Paragraph.FirstIndent := 0;
      Paragraph.Numbering := nsNone;
    end;
end;

procedure TOptimalFiltersForm.FormDestroy(Sender: TObject);
begin
    //
end;

procedure TOptimalFiltersForm.FillSeries(TransBW,Ripple: TSample);
begin
    H.Size(0, false, DefaultIsDouble);
    RemezImpulse(H, [0.1, 0.1 + TransBW, 0.22 - TransBW, 0.22], Ripple, ftBandPass);
    H.Scale(h.Length/2); //compensate for FFT scaling within SpectrumAnalzyer
    FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
    SpectrumAnalyzer.Process(H);
end;

procedure TOptimalFiltersForm.TransBWEditChange(Sender: TObject);
begin
     FillSeries(TransBWEdit.Position,Power(10, -AttEdit.Position/20));
end;

procedure TOptimalFiltersForm.ImpulseButtonClick(Sender: TObject);
begin
  ViewValues(h);
end;

initialization
RegisterClass(TOptimalFiltersForm);

end.
