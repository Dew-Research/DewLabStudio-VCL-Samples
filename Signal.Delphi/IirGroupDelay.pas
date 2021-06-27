unit IirGroupDelay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, MtxExpr, TeeGDIPlus;

type
  TIirGroupDelayForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    ChartTool1: TAxisScaleTool;
    OrderEdit: TMtxFloatEdit;
    Label1: TLabel;
    Label2: TLabel;
    AttEdit: TMtxFloatEdit;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrderEditChange(Sender: TObject);
  private
    procedure FillSeries(Order,Att: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IirGroupDelayForm: TIirGroupDelayForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses SignalUtils, MtxVec, IIRFilters, MtxVecTee, Math387;


procedure TIirGroupDelayForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TIirGroupDelayForm.FormCreate(Sender: TObject);
var i: integer;
begin
     for i := 0 to 3 do SpectrumChart.AddSeries(TFastLineSeries.Create(SpectrumChart));
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Group delay of IIR filters. Group delay is the first ' +
            'derivate of the continuous phase. Change the filter parameters ' +
            'and observer what happens to the group delay!')
     end;
     FillSeries(5,40);
end;

procedure TIirGroupDelayForm.FillSeries(Order,Att: integer);
var i: integer;
    num,den,h: Vector;
begin
     num.Size(0, false, DefaultIsDouble);
     den.Size(0, false, DefaultIsDouble);
     h.Size(0, false, DefaultIsDouble);
     for i := 0 to 3 do
     begin
         SpectrumChart.SeriesList.Move(0,3);
         SpectrumChart.Series[0].Title := IIrFilterMethodToString(TIirFilterMethod(i));
         case TIirFilterMethod(i) of
         fimButter:      ButterFilter(Order,[0.2],ftLowPass,false,num,den);
         fimChebyshevI:  ChebyshevIFilter(Order,0.1,[0.2],ftLowPass,false,num,den);
         fimChebyshevII: ChebyshevIIFilter(Order,Att,[0.2],ftLowPass,false,num,den);
         fimElliptic:    EllipticFilter(Order,0.1,Att,[0.2],ftLowPass,false,num,den);
         end;
         GroupDelay(h,Num,Den,128);
         h.SetSubRange(0,Trunc(0.95*h.Length)); //problems on the right edge
         DrawValues(h,SpectrumChart.Series[0],0,0.95*0.5/h.Length);
         h.SetFullRange;
     end;
end;

procedure TIirGroupDelayForm.OrderEditChange(Sender: TObject);
begin
     FillSeries(OrderEdit.IntPosition,AttEdit.IntPosition);
end;

initialization
RegisterClass(TIirGroupDelayForm);

end.
