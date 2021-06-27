unit FiltersDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, SignalProcessing, SignalSeriesTee, TeeGDIPlus;

type
  TFiltersDemoForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;                            
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    Signal1: TSignal;
    Panel2: TPanel;
    SpectrumChart: TSpectrumChart;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    Splitter1: TSplitter;
    SignalChart: TSignalChart;
    ToolButton1: TToolButton;                            
    ChartEditor1: TChartEditor;
    SignalChart1: TSignalChart;
    ChartTool1: TAxisScaleTool;
    FilterButton: TToolButton;
    SignalFilterDialog1: TSignalFilterDialog;
    Signal2: TSignal;
    Series3: TSignalDiscreteSeries;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SignalFilter1: TSignalFilter;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FilterButtonClick(Sender: TObject);
    procedure SignalFilter1ParameterUpdate(Sender: TObject);
    procedure SignalFilter1AfterUpdate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FiltersDemoForm: TFiltersDemoForm;

implementation

uses SignalUtils, Math387, TeePoEdi, MtxVec, Types, AbstractMtxVec;  //TeePoEdi is for TeeChart TPointSeries editor

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TFiltersDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TFiltersDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TFiltersDemoForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TFiltersDemoForm.FormCreate(Sender: TObject);
begin

     Signal1.UsesInputs := false;
     Signal1.Data.Size(4096, false, DefaultIsDouble);
     Signal1.Data.SetZero();
     Signal1[0] := Signal1.Length div 2;
     SpectrumAnalyzer.PhaseMode := pm360;
     SpectrumAnalyzer.Pull;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('A filter designer component is available. Click on the Filter editor ' +
            'in the example below to display a filter design window. The TSignalFilter ' +
            'component can be used to design almost any filter that comes with ' +
            'the package and provides a convinient user interface. The component ' +
            'can also be used for on-line filtering. All filter setups ' +
            'can be saved on disk as templates.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
end;

procedure TFiltersDemoForm.Panel2Resize(Sender: TObject);
begin
     SpectrumChart.Height := Trunc(Panel2.Height/1.8);
end;

procedure TFiltersDemoForm.ToolButton1Click(Sender: TObject);
begin
     ChartEditor1.Execute;
end;

procedure TFiltersDemoForm.FilterButtonClick(Sender: TObject);
begin
     SignalFilterDialog1.Execute;
end;

procedure TFiltersDemoForm.SignalFilter1ParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Pull;
end;

procedure TFiltersDemoForm.SignalFilter1AfterUpdate(Sender: TObject);
begin
     Signal2.Data.Copy(SignalFilter1.Taps);
     //In Delphi 4 and 5 this might cause floating point overflow message
     //when trying to draw axis labels.
     Signal2.UpdateNotify;
end;

initialization
RegisterClass(TFiltersDemoForm);

end.
