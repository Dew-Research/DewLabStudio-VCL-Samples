unit IirZeros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Types, Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, TeePolar, MtxExpr, TeePolarEditor, TeeGDIPlus;

type
  TIirZerosForm = class(TForm)
    ZeroPoleChart: TSpectrumChart;
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
    FilterBox: TComboBox;
    Label3: TLabel;
    Series1: TPolarSeries;
    Series2: TPolarSeries;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrderEditChange(Sender: TObject);
    procedure FilterBoxChange(Sender: TObject);
  private
    procedure FillSeries(Order,Att: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IirZerosForm: TIirZerosForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses SignalUtils, MtxVec, IIRFilters, MtxVecTee, Math387, AbstractMtxVec;

procedure TIirZerosForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;


procedure TIirZerosForm.FormCreate(Sender: TObject);
begin
     FilterBox.ItemIndex := 0;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('DSP for MtxVec features 4 different filter design methods for infinite impulse response filters: ' +
            'Butterworth, Chebyshev type I and type II and elliptic filters. Change the order and attenuation ' +
            'in the stop band of a low-pass IIR filter designed with all 4 methods.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
     FillSeries(5,40);
end;


procedure TIirZerosForm.OrderEditChange(Sender: TObject);
begin
     FillSeries(OrderEdit.IntPosition,AttEdit.IntPosition);
end;

procedure TIirZerosForm.FillSeries(Order,Att: integer);
var z,p,r,phi: Vector;
    k: double;
    i: integer;
begin
     z.Size(0, false, DefaultIsDouble);
     p.Size(0, false, DefaultIsDouble);
     r.Size(0, false, DefaultIsDouble);
     phi.Size(0, false, DefaultIsDouble);

     case TIirFilterMethod(FilterBox.ItemIndex) of
     fimButter:      ButterFilter(Order,[0.2],ftLowPass,false,z,p,k);
     fimChebyshevI:  ChebyshevIFilter(Order,0.1,[0.2],ftLowPass,false,z,p,k);
     fimChebyshevII: ChebyshevIIFilter(Order,Att,[0.2],ftLowPass,false,z,p,k);
     fimElliptic:    EllipticFilter(Order,0.1,Att,[0.2],ftLowPass,false,z,p,k);
     end;
     if not z.Complex then z.ExtendToComplex(True);
     z.CartToPolar(r,phi);
     phi := phi*(180/pi);
     Series1.Clear;
     for i := 0 to z.Length - 1 do
         series1.AddPolar(phi[i], r[i]);
//     DrawValues(phi,r, zeroPoleChart.Series[0]);
     if not p.Complex then p.ExtendToComplex(True);
     p.CartToPolar(r,phi);
     phi := phi*(180/pi);
     Series2.Clear;
     for i := 0 to z.Length - 1 do
         series2.AddPolar(phi[i], r[i]);
//     DrawValues(phi,r, zeroPoleChart.Series[1]);
end;

procedure TIirZerosForm.FilterBoxChange(Sender: TObject);
begin
     case FilterBox.ItemIndex of
     0,1: AttEdit.Enabled := False;
     2,3: AttEdit.Enabled := True;
     end;
     FillSeries(OrderEdit.IntPosition,AttEdit.IntPosition);
end;

initialization
RegisterClass(TIirZerosForm);

end.
