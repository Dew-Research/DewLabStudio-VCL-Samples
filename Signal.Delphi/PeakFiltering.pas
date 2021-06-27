unit PeakFiltering;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxExpr, TeeGDIPlus;

type
  TPeakFilteringForm = class(TForm)
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
    SignalRead1: TSignalRead;
    CheckBox1: TCheckBox;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    ComboBox1: TComboBox;
    Label1: TLabel;                                 
    Signal1: TSignal;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Signal1AfterUpdate(Sender: TObject);
  private
    function GetAxisScaleTool: TAxisScaleTool;
    function GetMarkTool: TSpectrumMarkTool;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PeakFilteringForm: TPeakFilteringForm;

implementation

uses SignalUtils, MtxVec, Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TPeakFilteringForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TPeakFilteringForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TPeakFilteringForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TPeakFilteringForm.FormCreate(Sender: TObject);
begin
     Signal1.IsDouble := DefaultIsDouble;
     SignalRead1.IsDouble := DefaultIsDouble;
     SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
     SignalRead1.OpenFile;
     ComboBox1.ItemIndex := 0;
     SpectrumAnalyzer.Pull;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Mark a peak to filter it from the signal:');
        Add('');
        Paragraph.FirstIndent := 10;
        Paragraph.Numbering := nsBullet;
        Add('The "filter" computes Amplitude and Phase from the frequency spectrum '+
            'and then subtracts a single sine from the time series. The frequency spectrum '+
            'is then recalculated.');
        Add('There are two data sets to chose from and it is possible to switch between ' +
            'logarithmic and linear axis.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
    end;
end;

procedure TPeakFilteringForm.CheckBox1Click(Sender: TObject);
begin
     SpectrumAnalyzer.Logarithmic := CheckBox1.Checked;
     SpectrumAnalyzer.Update;
end;

function TPeakFilteringForm.GetAxisScaleTool: TAxisScaleTool;
var i: integer;
begin
     Result := nil;
     for i := 0 to SPectrumChart.Tools.Count-1 do
     begin
          if SPectrumChart.Tools[i] is TAxisScaleTool then
          begin
               Result := TAxisScaleTool(SpectrumChart.Tools[i]);
               Break;
          end;
     end;
     if Result = nil then ERaise('Axis scale tool not found!');
end;

function TPeakFilteringForm.GetMarkTool: TSpectrumMarkTool;
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

procedure TPeakFilteringForm.ComboBox1Change(Sender: TObject);
begin
     Signal1.UsesInputs := false;  //indicate there is nothing connected to it
     SignalRead1.RecordPosition := 0; //reset the file position.
     case ComboBox1.ItemIndex of
     0: SpectrumAnalyzer.Input := SignalRead1;
     1: SpectrumAnalyzer.Input := Signal1;
     end;
     //Peak hold must be reset because its two different sets of data.
     GetAxisScaleTool.Reset;
     GetMarkTool.ClearMarks;
     //end peak hold reset
     SpectrumAnalyzer.Pull;
end;

procedure TPeakFilteringForm.Signal1AfterUpdate(Sender: TObject);
var ToneState: TToneState;
    a: Vector;  //generate two sine signal
begin
     a.Size(1024,false,DefaultIsDouble);
     ToneInit(0.1,0,1,ToneState);
     Tone(a,ToneState);
     Signal1.Data.Copy(a);
     ToneInit(0.12,0,1,ToneState);
     Tone(a,ToneState);
     Signal1.Data.Add(a);
end;

initialization
RegisterClass(TPeakFilteringForm);

end.
