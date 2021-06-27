unit DiscreteSeriesDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, MtxBaseComp,Series, StdCtrls, TeeTools,
  MtxDialogs, SignalUtils, MtxComCtrls, SignalSeriesTee, MtxExpr, TeeGDIPlus;

type
  TDiscreteSeriesDemoForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    Splitter1: TSplitter;
    SignalChart1: TSignalChart;
    Series1: TSignalDiscreteSeries;
    StepEdit: TMtxFloatEdit;
    Label1: TLabel;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StepEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DiscreteSeriesDemoForm: TDiscreteSeriesDemoForm;

implementation

uses Math387, MtxVec, MtxVecTee;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TDiscreteSeriesDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TDiscreteSeriesDemoForm.FormCreate(Sender: TObject);
begin
    StepEditChange(Sender); 
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('A new chart series for drawing discrete signals. The example below ' +
          'shows an oversampled FIR filter.');
    end;
end;

procedure TDiscreteSeriesDemoForm.StepEditChange(Sender: TObject);
var H: Vector;
    Step: double;
begin
    H.Size(0, false, DefaultIsDouble);
    Step := StepEdit.Position;
    FractionalFirImpulse(30,H,[0.2,0.25],0,Step,ftLowpass,1);
    SignalChart1.Series[0].Clear;
    DrawValues(H,SignalChart1.Series[0],0,Step);
end;

initialization
RegisterClass(TDiscreteSeriesDemoForm);

end.
