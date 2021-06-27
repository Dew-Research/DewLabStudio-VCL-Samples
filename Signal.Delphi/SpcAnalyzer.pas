unit SpcAnalyzer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, Menus, MtxComCtrls, SignalProcessing, TeeGDIPlus;

type
  TSpcAnalyzerForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    Series1: TFastLineSeries;
    ChartTool1: TAxisScaleTool;
    Series2: TPointSeries;
    SignalRead1: TSignalRead;
    PhaseBox: TCheckBox;
    ToolButton1: TToolButton;
    PopupMenu1: TPopupMenu;
    Saveconfiguration1: TMenuItem;
    Loadconfiguration1: TMenuItem;                     
    N1: TMenuItem;
    Copychart1: TMenuItem;
    Openfile1: TMenuItem;
    N2: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SignalReadDialog1: TSignalReadDialog;
    PopupMenu2: TPopupMenu;
    Spectrum1: TMenuItem;
    Chart1: TMenuItem;
    File1: TMenuItem;
    SignalDemux1: TSignalDemux;
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure PhaseBoxClick(Sender: TObject);
    procedure Copychart1Click(Sender: TObject);
    procedure Saveconfiguration1Click(Sender: TObject);
    procedure Openfile1Click(Sender: TObject);
    procedure Loadconfiguration1Click(Sender: TObject);
    procedure SignalRead1ParameterUpdate(Sender: TObject);
    procedure SignalRead1ProcessAll(Sender: TObject);
    procedure Spectrum1Click(Sender: TObject);
    procedure Chart1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SpcAnalyzerForm: TSpcAnalyzerForm;

implementation

uses Math387, MtxVecTee, SignalUtils, TeeStore
    {$IFDEF CLR}
     ,Borland.Vcl.Types
     {$ENDIF}
     ;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TSpcAnalyzerForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
    SpectrumAnalyzer.Update; 
end;

procedure TSpcAnalyzerForm.FormCreate(Sender: TObject);
begin
    SignalRead1.IsDouble := DefaultIsDouble;
//    SignalRead1.ScaleFactor := 1000;
end;


procedure TSpcAnalyzerForm.ComboBox1Change(Sender: TObject);
begin
//     GetMarkTool.MarkMode := TSpectrumMarkMode(ComboBox1.ItemIndex);
end;

procedure TSpcAnalyzerForm.PhaseBoxClick(Sender: TObject);
begin
     SpectrumChart.SpectrumPart := TSpectrumPart(PhaseBox.Checked);
     Case SpectrumChart.SpectrumPart of
     sppAmplt: SpectrumChart.LeftAxis.Title.Caption := 'Amplitude';
     sppPhase: SpectrumChart.LeftAxis.Title.Caption := 'Phase [degress]';
     end;     
end;

procedure TSpcAnalyzerForm.Copychart1Click(Sender: TObject);
begin
     TSpectrumMarkTool(SpectrumChart.Tools[1]).CursorActive := False;
     SpectrumChart.CopyToClipboardMetafile(True,Rect(0,0,750,350));
     TSpectrumMarkTool(SpectrumChart.Tools[1]).CursorActive := True;
end;

procedure TSpcAnalyzerForm.Saveconfiguration1Click(Sender: TObject);
var a: TFileStream;
begin
     SaveDialog.Filter := 'Config files (*.cfg)|*.cfg';
     if SaveDialog.Execute then
     begin
          a := TFileStream.Create(SaveDialog.FileName, fmOpenWrite or fmCreate);
          try
//               MtxSaveChartToStream(TCustomChart(SpectrumChart),a);
               SaveChartToStream(TCustomChart(SpectrumChart),a);
               SpectrumAnalyzer.SaveTemplateToStream(a);
          finally
               a.Free;
          end;
     end
end;

procedure TSpcAnalyzerForm.Openfile1Click(Sender: TObject);
begin
     OpenDialog.Filter := FileSignal.SignalDialogFilter;
     if OpenDialog.Execute then
     begin
          SignalRead1.FileName := OpenDialog.FileName;
          SpectrumAnalyzer.Pull;
     end;
end;

procedure TSpcAnalyzerForm.Loadconfiguration1Click(Sender: TObject);
var a: TFileStream;
    CustomChart: TCustomChart;
begin
     OpenDialog.Filter := 'Config files (*.cfg)|*.cfg';
     if OpenDialog.Execute then
     begin
          a := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
          try
//               MtxLoadChartFromStream(TCustomChart(SpectrumChart),a);
               CustomChart := TCustomChart(SpectrumChart);
               LoadChartFromStream(CustomChart,a);
               SpectrumAnalyzer.LoadTemplateFromStream(a);
               SpectrumChart.Spectrums[0].Input := SpectrumAnalyzer;
          finally
               a.Free;
          end;
     end;
end;

procedure TSpcAnalyzerForm.SignalRead1ParameterUpdate(Sender: TObject);
begin
     SignalRead1.Update;
     SignalDemux1.Update;
     SpectrumAnalyzer.Update;
end;

procedure TSpcAnalyzerForm.SignalRead1ProcessAll(Sender: TObject);
begin
     SpectrumAnalyzer.ResetAveraging;
     SpectrumAnalyzer.PullUntilEnd;
     SpectrumAnalyzer.UpdateNotify;
end;

procedure TSpcAnalyzerForm.Spectrum1Click(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TSpcAnalyzerForm.Chart1Click(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TSpcAnalyzerForm.File1Click(Sender: TObject);
begin
    SignalReadDialog1.Execute;
end;

initialization
RegisterClass(TSpcAnalyzerForm);

end.
