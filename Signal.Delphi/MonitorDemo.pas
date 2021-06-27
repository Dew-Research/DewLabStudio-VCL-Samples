unit MonitorDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalProcessing, AudioSignal, MtxComCtrls, SignalUtils,
  Buttons, Menus, TeeGDIPlus;

type
  TMonitorDemoForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;                   
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
    SignalChart: TSignalChart;
    Series3: TFastLineSeries;
    SignalTimer1: TSignalTimer;
    Signal1: TSignal;
    ChannelBox: TComboBox;
    Label1: TLabel;
    RecordToFileBox: TCheckBox;
    SignalWrite1: TSignalWrite;
    PopupMenu1: TPopupMenu;
    Spectrum1: TMenuItem;
    Spectrumchart1: TMenuItem;
    imechart1: TMenuItem;
    N1: TMenuItem;
    Recording1: TMenuItem;
    ChartEditor1: TChartEditor;
    SignalInDialog: TSignalInDialog;
    StartButton: TToolButton;
    SignalIn1: TSignalIn;
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure SignalTimer1Timer(Sender: TObject);
    procedure ChartButtonClick(Sender: TObject);
    procedure RecordToFileBoxClick(Sender: TObject);
    procedure Spectrum1Click(Sender: TObject);
    procedure imechart1Click(Sender: TObject);
    procedure Spectrumchart1Click(Sender: TObject);
    procedure Recording1Click(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MonitorDemoForm: TMonitorDemoForm;

implementation

uses Math387, MtxVec;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TMonitorDemoForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TMonitorDemoForm.FormCreate(Sender: TObject);
begin
    Signal1.Data.Size(4096);  //defines how much data to copy and consequently also frequency resolution
    Signal1.Data.SetZero;
    Signal1.UsesInputs := false;
    SignalWrite1.Precision := prSmallInt; //or prInteger or prByte (others will not work).

    ChannelBox.ItemIndex := 0;

    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('The recording is set up for 44kHz stereo. The best way to test this demo is to ' +
          'speak in to the microphone. You can select the channel you wish to monitor.' +
          'If Record to file checkbox is checked, the signal will be recorded to C:\test.wav.' +
          'Note the responsivnes of the charts (a very short delay from the time you speak  ' +
          'to when the display shows the change) while recording to file.');
    end;
end;


procedure TMonitorDemoForm.Panel2Resize(Sender: TObject);
begin
    SpectrumChart.Height := Panel2.Height div 2;
end;

procedure TMonitorDemoForm.SignalTimer1Timer(Sender: TObject);
begin
    if not SignalIn1.Active then Exit;
    SignalIn1.TriggerChannel := TChannel(ChannelBox.ItemIndex);
    case SignalIn1.TriggerChannel of
    chLeft:  SignalIn1.Trigger(Signal1, nil );
    chRight: SignalIn1.Trigger(nil, Signal1);
    end;
    SpectrumAnalyzer.Pull;  //calls update on Signal1 and Self
end;

procedure TMonitorDemoForm.Button1Click(Sender: TObject);
var aList: TStringList;
begin
    aList := TStringList.Create();
    try
        GetInSoundDevices(aList);
    finally
        aList.Free;
    end;
end;

procedure TMonitorDemoForm.ChartButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TMonitorDemoForm.RecordToFileBoxClick(Sender: TObject);
begin
    case SignalIn1.Quantization of
    8:  SignalWrite1.Precision := prByte;
    16: SignalWrite1.Precision := prSmallInt;
    24: SignalWrite1.Precision := prInt24;
    end;
    SignalWrite1.Active := RecordToFileBox.Checked;
end;

procedure TMonitorDemoForm.Spectrum1Click(Sender: TObject);
begin
    SpectrumAnalyzerDialog.Execute;
end;

procedure TMonitorDemoForm.imechart1Click(Sender: TObject);
begin
     ChartEditor1.Execute;
end;

procedure TMonitorDemoForm.Spectrumchart1Click(Sender: TObject);
begin
     ChartEditor.Execute;
end;

procedure TMonitorDemoForm.Recording1Click(Sender: TObject);
begin
     SignalInDialog.Execute;
end;

procedure TMonitorDemoForm.StartButtonClick(Sender: TObject);
begin
     SignalIn1.Start;
end;

initialization
RegisterClass(TMonitorDemoForm);

end.
