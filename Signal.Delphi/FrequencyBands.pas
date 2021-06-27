unit FrequencyBands;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, GanttCh, TeeGDIPlus;

type
  TFrequencyBandsForm = class(TForm)
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
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function GetMarkTool: TSpectrumMarkTool;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrequencyBandsForm: TFrequencyBandsForm;

implementation

uses Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TFrequencyBandsForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TFrequencyBandsForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TFrequencyBandsForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update; 
end;

procedure TFrequencyBandsForm.FormCreate(Sender: TObject);
begin
    SignalRead1.IsDouble := DefaultIsDouble;
    SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
    SignalRead1.OpenFile;
    ComboBox1.ItemIndex := 0; 
    SpectrumAnalyzer.Pull;
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('The frequency analyzer allows you to define frequency regions ' +
          'of interest and compute RMS of those regions. Click ' +
          'the spectrum button and then switch to Bands panel. ' +
          'First create a new template and then define a band and ' +
          'press the Update button.');
    end;
end;

function TFrequencyBandsForm.GetMarkTool: TSpectrumMarkTool;
var i: integer;
begin
     Result := nil;
     for i := 0 to SPectrumChart.Tools.Count-1 do
     begin
          if SPectrumChart.Tools[i] is TSpectrumMarkTool then
          begin
               Result := TSpectrumMarkTool(SpectrumChart.Tools[i]);
               Break;
          end;
     end;
     if Result = nil then ERaise('Spectrum mark tool not found!');
end;

procedure TFrequencyBandsForm.ComboBox1Change(Sender: TObject);
begin
     GetMarkTool.MarkMode := TSpectrumMarkMode(ComboBox1.ItemIndex);
end;

procedure TFrequencyBandsForm.Button1Click(Sender: TObject);
begin
     SpectrumChart.Series[2].Clear;
     SpectrumChart.Series[2].AddXY(100,40);
     SpectrumChart.Series[2].AddXY(500,40);
end;

initialization
RegisterClass(TFrequencyBandsForm);

end.
