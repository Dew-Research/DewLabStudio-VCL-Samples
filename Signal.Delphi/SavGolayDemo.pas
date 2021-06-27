unit SavGolayDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, TeeGDIPlus;

type
  TSavGolayDemoForm = class(TForm)
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
    Series2: TPointSeries;
    SignalRead1: TSignalRead;                              
    Label1: TLabel;                                  
    FrameSizeEdit: TMtxFloatEdit;
    Label2: TLabel;
    OrderEdit: TMtxFloatEdit;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpectrumAnalyzerAfterUpdate(Sender: TObject);
    procedure FrameSizeEditChange(Sender: TObject);
    procedure OrderEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SavGolayDemoForm: TSavGolayDemoForm;

implementation

uses Math387, SignalUtils, MtxVec;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TSavGolayDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TSavGolayDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TSavGolayDemoForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TSavGolayDemoForm.FormCreate(Sender: TObject);
begin
    SignalRead1.IsDouble := DefaultIsDouble;
    SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
    SignalRead1.OpenFile;
    SpectrumAnalyzer.Pull;
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('Savitzky-golay filter is a polynomial smoothing FIR filter. In the example ' +
          'below it is applied to the logarithmic frequency spectrum. ' +
          'Change the frame size and the order of the polynomial. The frame ' +
          'size must be odd and order can not be bigger then frame size. ' +
          'Set both parameters to zero to see the raw spectrum.');
      Paragraph.FirstIndent := 0;
      Paragraph.Numbering := nsNone;
    end;
end;

procedure TSavGolayDemoForm.SpectrumAnalyzerAfterUpdate(Sender: TObject);
var H,D: TMtx;
    Frs,Ord: integer;
begin
    CreateIt(H,D);
    try
        Frs := FrameSizeEdit.IntPosition;
        if not Odd(Frs) then Inc(Frs);
        Ord := OrderEdit.IntPosition;
        SavGolayImpulse(H,D,Frs,Ord,nil);
        SavGolayFilter(SpectrumAnalyzer.Amplt,H);
    finally
        FreeIt(H,D);
    end;
end;

procedure TSavGolayDemoForm.FrameSizeEditChange(Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TSavGolayDemoForm.OrderEditChange(Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

initialization
RegisterClass(TSavGolayDemoForm);

end.
