unit WindowsDemo;

interface
                                                       
uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalProcessing, TeeGDIPlus;

type
  TWindowsDemoForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    ChartTool1: TAxisScaleTool;
    Signal1: TSignal;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    TeeGDIPlus1: TTeeGDIPlus;
    procedure Signal1AfterUpdate(Sender: TObject);       
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure FillSeries;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WindowsDemoForm: TWindowsDemoForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}                                                     

uses SignalUtils, MtxVec, Math387;

procedure TWindowsDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TWindowsDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TWindowsDemoForm.Signal1AfterUpdate(Sender: TObject);
begin
     Signal1.Data.SetVal(0.5);
end;

procedure TWindowsDemoForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TWindowsDemoForm.FormCreate(Sender: TObject);
begin
     Signal1.IsDouble := DefaultIsDouble;
     Signal1.UsesInputs := false;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Different time signal windows have different mainlobe width and different sidelobe ' +
            'attenuation. Press the spectrum button to modify the parameters ' +
            'for the first series. Press the chart button and move the series ' +
            'of your choice to the first place so that it can be modified '+
            'with the spectrum analyzer dialog.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
     FillSeries;
end;

procedure TWindowsDemoForm.FillSeries;
var i: integer;
begin
     for i := 0 to 10 do
     begin
         SpectrumChart.AddSeries(TFastLineSeries.Create(SpectrumChart));
         SpectrumChart.SeriesList.Exchange(0,SpectrumChart.SeriesList.Count-1);
         SpectrumAnalyzer.SamplingFrequency := 2;
         SpectrumAnalyzer.SidelobeAtt := 60;
         SpectrumAnalyzer.Window := TSignalWindowType(i);
         SpectrumChart.Series[0].Title := SignalWindowToString(SpectrumAnalyzer.Window);
         SpectrumChart.Spectrums[0].Series := SpectrumChart.Series[0];
         SpectrumAnalyzer.Pull;
     end;
     SpectrumChart.Legend.Visible := True;
end;


initialization
RegisterClass(TWindowsDemoForm);

end.
