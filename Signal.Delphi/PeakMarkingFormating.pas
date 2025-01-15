unit PeakMarkingFormating;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, TeeGDIPlus;

type
  TPeakMarkingFormatingForm = class(TForm)
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
    ToolButton1: TToolButton;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PeakMarkingFormatingForm: TPeakMarkingFormatingForm;

implementation

uses TeeEditCha, Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TPeakMarkingFormatingForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TPeakMarkingFormatingForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.DefaultTab := cetSeriesMarks;
    ChartEditor.Execute;
end;

procedure TPeakMarkingFormatingForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TPeakMarkingFormatingForm.FormCreate(Sender: TObject);
begin
     Signalread1.IsDouble := DefaultIsDouble;
     SignalRead1.FileName := ExtractFilePath(ParamStr(0)) + 'bz.sfs';;
     SignalRead1.OpenFile;
     SpectrumAnalyzer.Pull;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Marked peaks can be formated in many ways:');
        Add('');
        Paragraph.FirstIndent := 10;
        Paragraph.Numbering := nsBullet;
        Add('Change the formating of the associated chart series2 by clicking on the Chart button.');
        Add('Change the formating of displayed amplitude labels, by clicking on the Mark tool.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
end;

procedure TPeakMarkingFormatingForm.ToolButton1Click(Sender: TObject);
begin
    ChartEditor.DefaultTab := cetTools; 
    ChartEditor.Execute;
end;

initialization
RegisterClass(TPeakMarkingFormatingForm);

end.
