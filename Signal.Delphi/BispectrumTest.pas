unit BispectrumTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxVec, MtxComCtrls, Menus, TeeGDIPlus;

type
  TBiSpectrumTestForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;                                   
    ChartEditButton: TToolButton;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    SignalRead1: TSignalRead;
    BiSpectrumAnalyzer: TBiSpectrumAnalyzer;
    FreqEdit: TMtxFloatEdit;
    Label1: TLabel;
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
    SingleLinesOnlyBox: TCheckBox;
    ProgressLabel: TLabel;
    Button1: TToolButton;
    BiSpectrumAnalyzerDialog: TBiSpectrumAnalyzerDialog;
    ChartTool3: TSpectrumMarkTool;
    ChartTool4: TColorLineTool;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FreqEditChange(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BiSpectrumTestForm: TBiSpectrumTestForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses MtxVecEdit, MtxVecTee, SignalUtils, Math387;

procedure TBiSpectrumTestForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TBiSpectrumTestForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TBiSpectrumTestForm.SpectrumAnalyzerParameterUpdate(Sender: TObject);
begin
     SpectrumAnalyzer.Update;
end;

procedure TBiSpectrumTestForm.FormCreate(Sender: TObject);
begin
     SignalRead1.IsDouble := DefaultIsDouble; //select processing precision
     SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';

     BispectrumAnalyzer.Amplt.SetZero;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Bicoherence shows the frequencies related to the selected frequency. ' +
            'Relation is defined as e^jw1 * e^jw2 = e^j(w1+w2). Bicoherence  ' +
            'will be 1 for a frequency pair (w1,w2) which has a product of itself (e^jw1*e^jw2) ' +
            'in the frequency spectrum. Multiplication is also called modulation. ' +
            'Bicoherence will be 1, if there is modulation present. Change the Frequency ' +
            'parameter and observe the bicoherence to see, with which frequencies is ' +
            'the Frequency multiplied with. Modulation is probably the most often observed type ' +
            'of non-linearity in mechanical systems. You can also compute only ' +
            'preselected frequency lines by checking the Single lines only box. (see source code for more info)' +
            'This reduces the CPU and memory resources required considerably. ' +
            'The bicoherence is calculated on a vibration signal coming from a lathe machine, when there is chatter present. ' +
            'In the example below you can see that, next to the main harmonic series, ' +
            'a frequency of 20 Hz is the modulating frequency causing many additional peaks.' );
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
     Button1Click(Sender);
end;

procedure TBiSpectrumTestForm.Button1Click(Sender: TObject);
begin
     Screen.Cursor := crHourGlass;

     Signalread1.OpenFile;
     SignalRead1.RecordPosition := 0;
     SignalRead1.OverlappingPercent := 75;
     SpectrumAnalyzer.Update;
     with BispectrumAnalyzer do
     if SingleLinesOnlyBox.Checked then
     begin
          BiAnalyzer.SingleLinesOnly := True;
          BiAnalyzer.Lines.Length := 128;
          BiAnalyzer.Lines.Ramp(0,SpectrumAnalyzer.HzRes);
     end else BiAnalyzer.SingleLinesOnly := False;
     BispectrumAnalyzer.ResetAveraging;
//     BispectrumAnalyzer.BiAnalyzer.Recursive := False; !!! set in design time
     while (BispectrumAnalyzer.Pull <> pipeEnd) do  // do averaging
     begin
          ProgressLabel.Caption := 'Progress: ' + FormatSample('0',SignalRead1.FrameNumber/SignalRead1.MaxFrames*100) + ' [%]';
//          Update;
     end;
     BispectrumAnalyzer.BiAnalyzer.Update; //compute bicoherence
     FreqEdit.Increment := SampleToStr(SpectrumAnalyzer.HzRes);
     FreqEditChange(Sender); //get bicoherence line

     Screen.Cursor := crDefault;
end;

procedure TBiSpectrumTestForm.FreqEditChange(Sender: TObject);
begin
      BispectrumAnalyzer.BiAnalyzer.Frequency := FreqEdit.Position;
      BispectrumAnalyzer.UpdateSpectrum;
      if SpectrumChart.Tools.Count > 2 then 
      TColorLineTool(SpectrumChart.Tools[2]).Value := FreqEdit.Position;
end;

procedure TBiSpectrumTestForm.Panel2Resize(Sender: TObject);
begin
      SpectrumChart1.Height := Panel2.Height div 2;
end;

initialization
RegisterClass(TBispectrumTestForm);

end.
