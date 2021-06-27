unit CoherenceTest2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalUtils, Menus, TeeURL, TeeSeriesTextEd, TeeGDIPlus;

type
  TCoherenceTest2Form = class(TForm)
    SpectrumChart: TSpectrumChart;                                
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    Series1: TFastLineSeries;
    ChartTool1: TAxisScaleTool;                              
    Series2: TPointSeries;
    SignalRead1: TSignalRead;
    PhaseBox: TCheckBox;
    EditSpectrumButton: TToolButton;
    CrossSpectrumAnalyzerDialog: TCrossSpectrumAnalyzerDialog;
    CrossAnalyzer: TCrossSpectrumAnalyzer;
    UpdateButton: TToolButton;
    FirstFileButton: TToolButton;
    OpenDialog: TOpenDialog;
    SignalRead2: TSignalRead;
    SamplesBox: TComboBox;
    Label2: TLabel;
    ProgressLabel: TLabel;
    PopupMenu1: TPopupMenu;
    Openfile1: TMenuItem;
    OpenFile2: TMenuItem;
    N1: TMenuItem;
    Copychart: TMenuItem;
    Saveconfiguration: TMenuItem;
    Loadconfiguration: TMenuItem;
    N2: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpectrumBoxChange(Sender: TObject);
    procedure PhaseBoxClick(Sender: TObject);
    procedure EditSpectrumButtonClick(Sender: TObject);
    procedure CrossAnalyzerParameterUpdate(Sender: TObject);
    procedure UpdateButtonClick(Sender: TObject);
    procedure SamplesBoxChange(Sender: TObject);
    procedure CopychartClick(Sender: TObject);
    procedure SaveconfigurationClick(Sender: TObject);
    procedure OpenFile2Click(Sender: TObject);
    procedure Openfile1Click(Sender: TObject);
    procedure LoadconfigurationClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CoherenceTest2Form: TCoherenceTest2Form;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses MtxVec, Math387, MtxVecTee, TeeStore
     {$IFDEF CLR}
     ,Borland.Vcl.Types
     {$ENDIF}
     ;


procedure TCoherenceTest2Form.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TCoherenceTest2Form.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     CrossAnalyzer.Update;
end;

procedure TCoherenceTest2Form.FormCreate(Sender: TObject);
begin
     SignalRead1.IsDouble := DefaultIsDouble; //select processing precision
     SignalRead2.IsDouble := DefaultIsDouble; //select processing precision

     OpenDialog.Filter := FileSignal.SignalDialogFilter;
     SamplesBox.ItemIndex := 10;
     SamplesBoxChange(Sender);
end;

procedure TCoherenceTest2Form.SpectrumBoxChange(Sender: TObject);
begin
//     SpectrumChart.Title.Text.Clear;
//     SpectrumChart.Title.Text.Add(CrossTransformToString(CrossAnalyzer.CrossAnalyzer.Transform));
     CrossAnalyzer.UpdateSpectrum;
end;

procedure TCoherenceTest2Form.PhaseBoxClick(Sender: TObject);
begin
     SpectrumChart.SpectrumPart := TSpectrumPart(PhaseBox.Checked);
     Case SpectrumChart.SpectrumPart of
     sppAmplt: SpectrumChart.LeftAxis.Title.Caption := 'Amplitude';
     sppPhase: SpectrumChart.LeftAxis.Title.Caption := 'Phase [degress]';
     end;
end;

procedure TCoherenceTest2Form.EditSpectrumButtonClick(Sender: TObject);
begin
     CrossSpectrumAnalyzerDialog.Execute;
end;

procedure TCoherenceTest2Form.CrossAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumChart.SpectrumPart := TSpectrumPart(PhaseBox.Checked);
//     SpectrumChart.Title.Text.Clear;
//     SpectrumChart.Title.Text.Add(CrossTransformToString(CrossAnalyzer.CrossAnalyzer.Transform));
     CrossAnalyzer.UpdateSpectrum;
end;

procedure TCoherenceTest2Form.UpdateButtonClick(Sender: TObject);
begin
     SignalRead1.SelectionStart := 0;
     SignalRead2.SelectionStart := 0;
     SignalRead1.OverlappingPercent := 90;
     SignalRead2.OverlappingPercent := 90;
     SignalRead1.LastFrameCheck := lfcLastFullBlock; //because of averaging
     SignalRead2.LastFrameCheck := lfcLastFullBlock; //because of averaging

     SignalRead1.SelectionStop := SignalRead1.RecordLength;
     SignalRead1.RecordPosition := 0;
     SignalRead2.RecordPosition := 0;
     CrossAnalyzer.Input := SignalRead1;
     CrossAnalyzer.Output := SignalRead2;
     CrossAnalyzer.CrossAnalyzer.Recursive := false;
     CrossAnalyzer.ResetAveraging;
     while (CrossAnalyzer.Pull <> pipeEnd) do
     begin
          ProgressLabel.Caption := 'Progress: ' + FormatSample('0',SignalRead1.RecordPosition/SignalRead1.SelectionStop*100) + ' [%]';
          Self.Update;
     end;
     CrossAnalyzer.CrossAnalyzer.Update;  //if recursive would be True, this would not be neccessary.
     SpectrumBoxChange(Sender);
end;

procedure TCoherenceTest2Form.SamplesBoxChange(Sender: TObject);
begin
     SignalRead1.Length := StrToInt(SamplesBox.Text);
     SignalRead2.Length := StrToInt(SamplesBox.Text);
end;


procedure TCoherenceTest2Form.CopychartClick(Sender: TObject);
var bTemp: boolean;
begin
     btemp := TSpectrumMarkTool(SpectrumChart.Tools[1]).CursorActive;
     TSpectrumMarkTool(SpectrumChart.Tools[1]).CursorActive := False;
     SpectrumChart.CopyToClipboardMetafile(True, Rect(0,0,750,350));
     TSpectrumMarkTool(SpectrumChart.Tools[1]).CursorActive := btemp;
end;

procedure TCoherenceTest2Form.SaveconfigurationClick(Sender: TObject);
var a: TFileStream;
begin
     SaveDialog.Filter := 'Config files (*.cfg)|*.cfg';
     if SaveDialog.Execute then
     begin
          a := TFileStream.Create(SaveDialog.FileName, fmOpenWrite or fmCreate);     
          try
//               MtxSaveChartToStream(TCustomChart(SpectrumChart),a);
               SaveChartToStream(TCustomChart(SpectrumChart),a);
               CrossAnalyzer.SaveTemplateToStream(a);
          finally
               a.Free;
          end;
     end
end;

procedure TCoherenceTest2Form.OpenFile2Click(Sender: TObject);
begin
     OpenDialog.Filter := FileSignal.SignalDialogFilter;
     if OpenDialog.Execute then
     begin
           SignalRead2.FileName := OpenDialog.FileName;
           SignalRead2.OpenFile;
     end;
end;

procedure TCoherenceTest2Form.Openfile1Click(Sender: TObject);
begin
     OpenDialog.Filter := FileSignal.SignalDialogFilter;
     if OpenDialog.Execute then
     begin
          SignalRead1.FileName := OpenDialog.FileName;
          SignalRead1.OpenFile;
     end;
end;

procedure TCoherenceTest2Form.LoadconfigurationClick(Sender: TObject);
var a: TFileStream;
    b: TCustomChart;
begin
     OpenDialog.Filter := 'Config files (*.cfg)|*.cfg';
     if OpenDialog.Execute then
     begin
          a := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
          try
//               MtxLoadChartFromStream(TCustomChart(SpectrumChart),a);
               b := TCustomChart(SpectrumChart);
               LoadChartFromStream(b,a);
               CrossAnalyzer.LoadTemplateFromStream(a);
               SpectrumChart.Spectrums[0].Input := CrossAnalyzer;
          finally
               a.Destroy;
          end;
     end;
end;

initialization
RegisterClass(TCoherenceTest2Form);

end.
