unit TriggerDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalProcessing, AudioSignal, MtxComCtrls, SignalUtils,TeeGDIPlus;

type
  TTriggerDemoForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ResetButton: TToolButton;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    SpectrumChart: TSpectrumChart;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    ChartTool1: TAxisScaleTool;
    Splitter1: TSplitter;                            
    SignalChart1: TSignalChart;                    
    Series3: TFastLineSeries;
    SignalTimer1: TSignalTimer;
    SignalIn1: TSignalIn;
    Signal1: TSignal;
    ChannelBox: TComboBox;
    Label1: TLabel;
    AboveEdit: TMtxFloatEdit;
    Label2: TLabel;
    PositionEdit: TComboBox;
    Label3: TLabel;
    CountLabel: TLabel;
    TeeGDIPlus1: TTeeGDIPlus;
    TeeGDIPlus2: TTeeGDIPlus;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure SignalTimer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TriggerDemoForm: TTriggerDemoForm;

implementation

uses Math387;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TTriggerDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
    SpectrumAnalyzerDialog.Execute;
end;

procedure TTriggerDemoForm.ResetButtonClick(Sender: TObject);
begin
    SignalIn1.ResetTriggers;
end;

procedure TTriggerDemoForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TTriggerDemoForm.FormCreate(Sender: TObject);
begin
    SignalIn1.IsDouble := DefaultIsDouble;

    Signal1.IsDouble := DefaultIsDouble;
    Signal1.Data.Size(4096);  //defines how much data to copy
    Signal1.Data.SetZero;
    Signal1.UsesInputs := false;

    ChannelBox.ItemIndex := 0;
    PositionEdit.ItemIndex := 0;
    Signal1.SamplingFrequency := SignalIn1.SamplingFrequency;
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('The recording is setup for 11025 kHz stereo. The channel displayed is always ' +
          'Left, but the channel on which the trigger condition is searched for can be altered. ' +
          'The best way to test this demo is to ' +
          'speak in to the microphone. You can select the trigger channel, trigger ' +
          'condition and which part of the signal to view relative to the trigger found. ' +
          'The trigger has to be reset manually by pressing the Reset button. '+
          'The trigger can also be set to trigger automatically each time a trigger ' +
          'condition is found. The trigger condition can be searched for on a different channel ' +
          'from the one from which the data will be fetched. Catch-ups displayed in the title of the time signal ' +
          'show how many times the samples had to be skipped (see help for more info). ' +
          'There are many other options available.');
    end;
end;

procedure TTriggerDemoForm.Panel2Resize(Sender: TObject);
begin
    SpectrumChart.Height := Panel2.Height div 2;
end;

procedure TTriggerDemoForm.SignalTimer1Timer(Sender: TObject);
begin
    if not SignalIn1.Active then SignalIn1.Start;
    SignalIn1.TriggerChannel := TChannel(ChannelBox.ItemIndex);
    SignalIn1.TriggerAbove := AboveEdit.Position;
    SignalIn1.TriggerBelow := -INF;
    SignalIn1.TriggerDelay := 0;
    SignalIn1.TriggerPosition := TTriggerPosition(PositionEdit.ItemIndex);
    SignalIn1.TriggerMode := trAboveBelow;
    SignalIn1.Triggering := trSingle;
    if SignalIn1.Trigger(Signal1,nil) then
    begin
        SpectrumAnalyzer.Pull;  //calls update on Signal1 and Self
        SignalChart1.Title.Text.Clear;
        SignalChart1.Title.Text.Add('Signal just after the sample, which triggered (Catch ups =' +
                                   IntToStr(SignalIn1.TriggerCatchUps[ChannelBox.ItemIndex]) + ')');
        CountLabel.Caption := 'Count = ' + IntToStr(SignalIn1.TriggerCount[ChannelBox.ItemIndex]);
    end;
end;

initialization
RegisterClass(TTriggerDemoForm);

end.
