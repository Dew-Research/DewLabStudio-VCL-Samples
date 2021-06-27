unit IirFiltering;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, Math387, MtxExpr, TeeGDIPlus;

type
  TIirFilteringForm = class(TForm)                          
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
    OrderEdit: TMtxFloatEdit;                      
    Label1: TLabel;
    Label2: TLabel;
    AttEdit: TMtxFloatEdit;
    Label3: TLabel;
    FreqEdit: TMtxFloatEdit;                               
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrderEditChange(Sender: TObject);
    procedure FreqEditChange(Sender: TObject);
  private
    procedure FillSeries(Order,Att: integer; Freq: TSample);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IirFilteringForm: TIirFilteringForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses SignalUtils, MtxVec, IIRFilters;

procedure TIirFilteringForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TIirFilteringForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TIirFilteringForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TIirFilteringForm.FormCreate(Sender: TObject);
var i: integer;
begin
     for i := 0 to 3 do SpectrumChart.AddSeries(TFastLineSeries.Create(SpectrumChart));
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('DSP for MtxVec features 4 different filter design methods for infinite impulse response filters: ' +
            'Butterworth, Chebyshev type I and type II and elliptic filters. Change the order and attenuation ' +
            'in the stop band of a low-pass IIR filter designed with all 4 methods.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
     FillSeries(5,40,0.1);
end;

procedure TIirFilteringForm.FillSeries(Order,Att: integer; Freq: TSample);
var i: integer;
    num,den: Vector;
begin
     SpectrumAnalyzer.Window := wtRectangular;
     SpectrumAnalyzer.Logarithmic := True;
     SpectrumAnalyzer.LogSpan := ls200;
     SpectrumAnalyzer.ZeroPadding := 128;

     num.Size(0, false, DefaultIsDouble); //specify processing precision
     den.Size(0, false, DefaultIsDouble); //specify processing precision
     for i := 0 to 3 do
     begin
         SpectrumChart.Spectrums[0].Series := SpectrumChart.Series[i];
         SpectrumChart.Series[i].Title := IIrFilterMethodToString(TIirFilterMethod(i));
         case TIirFilterMethod(i) of
         fimButter:      ButterFilter(Order,[Freq],ftLowPass,false,num,den);
         fimChebyshevI:  ChebyshevIFilter(Order,0.1,[Freq],ftLowPass,false,num,den);
         fimChebyshevII: ChebyshevIIFilter(Order,Att,[Freq],ftLowPass,false,num,den);
         fimElliptic:    EllipticFilter(Order,0.1,Att,[Freq],ftLowPass,false,num,den);
         end;
{            Alternative:

         FrequencyResponse(num,den,h,64);
         h.Abs;
         H.Log10;
         H.Scale(-20);
         DrawIt(h);}

         SpectrumAnalyzer.Process(num,den,nil,nil); //place result in self
     end;
     SpectrumChart.Legend.Visible := True;
end;

procedure TIirFilteringForm.OrderEditChange(Sender: TObject);
begin
     FillSeries(OrderEdit.IntPosition,AttEdit.IntPosition,FreqEdit.Position);
end;


procedure TIirFilteringForm.FreqEditChange(Sender: TObject);
begin

     FillSeries(OrderEdit.IntPosition,AttEdit.IntPosition, FreqEdit.Position);
end;

initialization
RegisterClass(TIirFilteringForm);

end.
