unit CZTDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, TeeGDIPlus;

type
  TCZTDemoForm = class(TForm)
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
    CZTStartEdit: TMtxFloatEdit;
    Label1: TLabel;
    Label2: TLabel;                                  
    CZTBWEdit: TMtxFloatEdit;
    Label3: TLabel;
    CZTLinesEdit: TMtxFloatEdit;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CZTStartEditChange(Sender: TObject);
    procedure CZTBWEditChange(Sender: TObject);
    procedure CZTLinesEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CZTDemoForm: TCZTDemoForm;

implementation

uses Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TCZTDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TCZTDemoForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TCZTDemoForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TCZTDemoForm.FormCreate(Sender: TObject);
begin
    SignalRead1.IsDouble := DefaultIsDouble; //select processing precision
    SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
    SignalRead1.OpenFile;
    SpectrumAnalyzer.Method := smCZT;
    SpectrumAnalyzer.Pull;
    CZTStartEditChange(Sender);

    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('Chirp Z-transform allows efficient oversampling of '+
          'narrow frequency bands in the frequency spectrum. '+
          'Start Freq defines the left edge of the frequency band. ' +
          'BW is the bandwidth of the frequency band and ' +
          'Lines defines the number of lines to be computed within ' +
          'that frequency band. Hold down the CTRL key and double click ' +
          'the edit boxes to change the up/down step.');
      Add('');
    end;
end;

procedure TCZTDemoForm.CZTStartEditChange(Sender: TObject);
begin
    SpectrumAnalyzer.CZT.StartFrequency := CZTStartEdit.Position;
    CZTBWEditChange(Sender);
end;

procedure TCZTDemoForm.CZTBWEditChange(Sender: TObject);
begin
    SpectrumAnalyzer.CZT.StopFrequency := CZTStartEdit.Position+CZTBWEdit.Position;
    CZTLinesEditChange(Sender);
end;

procedure TCZTDemoForm.CZTLinesEditChange(Sender: TObject);
begin
    with SpectrumAnalyzer do
    begin
         CZT.FrequencyStep := (CZT.StopFrequency-CZT.StartFrequency)/CZTLinesEdit.Position;
    end;
    SpectrumAnalyzer.Update;
end;

initialization
RegisterClass(TCZTDemoForm);

end.
