unit BiSpcAnalyzer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxVec, MtxComCtrls, Menus, TeeGDIPlus;

type
  TBiSpcAnalyzerForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    SignalRead1: TSignalRead;
    FrequencyEdit: TMtxFloatEdit;
    FrequencyLabel: TLabel;                               
    Panel2: TPanel;                                        
    SpectrumChart: TSpectrumChart;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    ChartTool1: TAxisScaleTool;
    Splitter1: TSplitter;
    SpectrumChart1: TSpectrumChart;
    FastLineSeries1: TFastLineSeries;
    PointSeries1: TPointSeries;
    AxisScaleTool1: TAxisScaleTool;
    ChartTool2: TSpectrumMarkTool;
    ProgressLabel: TLabel;
    Button1: TToolButton;
    PopupMenu: TPopupMenu;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SaveConfig: TMenuItem;
    LoadConfig: TMenuItem;
    N1: TMenuItem;
    Copy1: TMenuItem;
    N2: TMenuItem;
    Openfile1: TMenuItem;
    ToolButton1: TToolButton;
    Recalculate1: TMenuItem;
    BiSpectrumAnalyzerDialog: TBiSpectrumAnalyzerDialog;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    BiSpectrumAnalyzer: TBiSpectrumAnalyzer;
    ChartTool3: TSpectrumMarkTool;
    ChartTool4: TColorLineTool;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure Openfile1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SaveConfigClick(Sender: TObject);
    procedure LoadConfigClick(Sender: TObject);
    procedure BiSpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure Recalculate1Click(Sender: TObject);
    procedure FrequencyEditChange(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BiSpcAnalyzerForm: TBiSpcAnalyzerForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses MtxVecEdit, MtxVecTee, SignalUtils, Math387, TeeStore
    {$IFDEF CLR}
     ,Borland.Vcl.Types
     {$ENDIF}
     ;

procedure TBiSpcAnalyzerForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TBiSpcAnalyzerForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TBiSpcAnalyzerForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TBiSpcAnalyzerForm.FormCreate(Sender: TObject);
begin
     SignalRead1.IsDouble := DefaultIsDouble; //select processing precision

     SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
     BispectrumAnalyzer.Amplt.SetZero;
     FrequencyEditChange(Sender);
end;


procedure TBiSpcAnalyzerForm.Panel2Resize(Sender: TObject);
begin
      SpectrumChart1.Height := Panel2.Height div 2;
end;

procedure TBiSpcAnalyzerForm.Openfile1Click(Sender: TObject);
begin
     OpenDialog.Filter := FileSignal.SignalDialogFilter;
     if OpenDialog.Execute then
     begin
          SignalRead1.FileName := OpenDialog.FileName;
          SignalRead1.OpenFile;
     end;
end;

procedure TBiSpcAnalyzerForm.ToolButton1Click(Sender: TObject);
begin
     BispectrumAnalyzerDialog.Execute;
end;

procedure TBiSpcAnalyzerForm.SaveConfigClick(Sender: TObject);
var a: TFileStream;
begin
     SaveDialog.Filter := 'Config files (*.cfg)|*.cfg';
     if SaveDialog.Execute then
     begin
          a := TFileStream.Create(SaveDialog.FileName, fmOpenWrite or fmCreate);
          try
//               MtxSaveChartToStream(TCustomChart(SpectrumChart),a);
//               MtxSaveChartToStream(TCustomChart(SpectrumChart1),a);
               SaveChartToStream(TCustomChart(SpectrumChart),a);
               SaveChartToStream(TCustomChart(SpectrumChart1),a);
               SpectrumAnalyzer.SaveTemplateToStream(a);
               BiSpectrumAnalyzer.SaveTemplateToStream(a);               
          finally
               a.Free;
          end;
     end
end;

procedure TBiSpcAnalyzerForm.LoadConfigClick(Sender: TObject);
var a: TFileStream;
    CustomChart: TCustomChart;
begin
     OpenDialog.Filter := 'Config files (*.cfg)|*.cfg';
     if OpenDialog.Execute then
     begin
          a := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
          try
//               MtxLoadChartFromStream(TCustomChart(SpectrumChart),a);
//               MtxLoadChartFromStream(TCustomChart(SpectrumChart1),a);
               CustomChart := TCustomChart(SpectrumChart);
               LoadChartFromStream(CustomChart,a);
               CustomChart := TCustomChart(SpectrumChart1);
               LoadChartFromStream(CustomChart,a);
               SpectrumAnalyzer.LoadTemplateFromStream(a);
               BiSpectrumAnalyzer.LoadTemplateFromStream(a);
               SpectrumChart.Spectrums[0].Input := SpectrumAnalyzer;
               SpectrumChart1.Spectrums[0].Input := BiSpectrumAnalyzer;
          finally
               a.Free;
          end;
     end;
end;

procedure TBiSpcAnalyzerForm.BiSpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
    TColorLineTool(SpectrumChart.Tools[2]).Value := BispectrumAnalyzer.BiAnalyzer.Frequency;
    BispectrumAnalyzer.UpdateSpectrum;
end;

procedure TBiSpcAnalyzerForm.Recalculate1Click(Sender: TObject);
begin
     Screen.Cursor := crHourGlass;
     try
         SignalRead1.Length := 1024;
         SignalRead1.RecordPosition := 0;
         Signalread1.LastFrameCheck := lfcLastFullBlock;
         SignalRead1.OverlappingPercent := 0;
         //just make sure that the processing does not take too long
         SignalRead1.SelectionStart := 0;
         SignalRead1.SelectionStop := 50000;
         SpectrumAnalyzer.Update;
         BispectrumAnalyzer.ResetAveraging;
         while (BispectrumAnalyzer.Pull <> pipeEnd) do  // do averaging
         begin
              ProgressLabel.Caption := 'Progress: ' + FormatSample('0',SignalRead1.FrameNumber/SignalRead1.MaxFrames*100) + ' [%]';
              Update;
         end;
         BispectrumAnalyzer.BiAnalyzer.Update; //compute bicoherence
         BispectrumAnalyzer.UpdateSpectrum;
     finally
         Screen.Cursor := crDefault;
     end;
end;

procedure TBiSpcAnalyzerForm.FrequencyEditChange(Sender: TObject);
begin
    BispectrumAnalyzer.BiAnalyzer.Frequency := FrequencyEdit.Position;
    BiSpectrumAnalyzerParameterUpdate(Sender);    
end;

procedure TBiSpcAnalyzerForm.Copy1Click(Sender: TObject);
begin
     TSpectrumMarkTool(SpectrumChart1.Tools[1]).CursorActive := False;
     SpectrumChart1.CopyToClipboardMetafile(True,Rect(0,0,750,400));
     TSpectrumMarkTool(SpectrumChart1.Tools[1]).CursorActive := True;
end;

initialization
RegisterClass(TBiSpcAnalyzerForm);

end.
