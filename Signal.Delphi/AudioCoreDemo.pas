unit AudioCoreDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DewMMDevApi, DewAudioClient, StdCtrls, SignalTools, Math387, SyncObjs,
  AsioAudioSignal, CoreAudioSignal, MtxVec, MtxBaseComp, ExtCtrls, SignalToolsTee, TeEngine,
  TeeProcs, Chart, SignalProcessing, FileSignal, Series,
  MtxVecTee, SignalAnalysis, MtxComCtrls, TeeGDIPlus;

type
  TAudioCoreDemoForm = class(TForm)
    SignalCoreAudioIn: TSignalCoreAudioIn;
    SignalCoreAudioOut: TSignalCoreAudioOut;
    Panel1: TPanel;
    Panel2: TPanel;
    PlaybackButton: TButton;
    Button2: TButton;
    SignalChart: TSignalChart;
    SpectrumChart: TSpectrumChart;
    Splitter1: TSplitter;
    RecordButton: TButton;
    ChannelNumberGroup: TRadioGroup;
    SignalRead: TSignalRead;
    SignalDemuxList: TSignalDemuxList;
    SignalWrite: TSignalWrite;
    SignalMux: TSignalMux;
    Timer1: TTimer;
    RecordingList: TSignalList;
    Series1: TMtxFastLineSeries;
    Series2: TMtxFastLineSeries;
    PlaybackSpectrumAnalyzer: TSpectrumAnalyzer;
    RecordingSpectrumAnalyzer: TSpectrumAnalyzer;
    TeeGDIPlus1: TTeeGDIPlus;
    TeeGDIPlus2: TTeeGDIPlus;
    ChartTool1: TAxisScaleTool;
    LatencyLabel: TLabel;
    ElapsedTimeLabel: TLabel;
    ElapsedSamplesLabel: TLabel;
    PlaybackList: TSignalList;
    ChartTool2: TAxisScaleTool;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    PlaybackDeviceEdit: TComboBox;
    PlaybackFSEdit: TComboBox;
    Label5: TLabel;
    PlaybackBitsEdit: TComboBox;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RecordDeviceEdit: TComboBox;
    RecordBitsEdit: TComboBox;
    RecordFSEdit: TComboBox;
    RecordingExclusiveBox: TCheckBox;
    PlaybackExclusiveBox: TCheckBox;
    OpenDialog: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PlaybackLatencyEdit: TMtxFloatEdit;
    Label7: TLabel;
    RecordingLatencyEdit: TMtxFloatEdit;
    Label8: TLabel;
    ExtBufferLabel: TLabel;
    ExtBufferInLabel: TLabel;
    procedure PlaybackButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RecordDeviceEditChange(Sender: TObject);
    procedure PlaybackDeviceEditChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RecordButtonClick(Sender: TObject);
    procedure SignalCoreAudioInInputBufferReady(Sender: TObject);
    procedure SignalCoreAudioInStop(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RecordBitsEditChange(Sender: TObject);
    procedure RecordingExclusiveBoxClick(Sender: TObject);
    procedure PlaybackExclusiveBoxClick(Sender: TObject);
    procedure PlaybackBitsEditChange(Sender: TObject);
    procedure PlaybackFSEditChange(Sender: TObject);
    procedure RecordFSEditChange(Sender: TObject);
    procedure RecordingLatencyEditChange(Sender: TObject);
    procedure PlaybackLatencyEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AudioCoreDemoForm: TAudioCoreDemoForm;

implementation

uses MtxVecInt, ActiveX, ComObj, StringVar, MMSystem;

{$R *.dfm}

procedure TAudioCoreDemoForm.PlaybackBitsEditChange(Sender: TObject);
begin
    SignalCoreAudioOut.GetSupportedSamplingFrequencies(PlaybackFSEdit.Items);
    PlaybackFSEdit.ItemIndex := 0;
end;

procedure TAudioCoreDemoForm.PlaybackButtonClick(Sender: TObject);
begin

    OpenDialog.Title := 'Specifying uncompressed wav file for playback!';
    OpenDialog.DefaultExt := '.wav';
    if OpenDialog.Execute then
    begin
        SignalRead.FileName := OpenDialog.FileName;
        if SignalRead.IsEndOfFile then SignalRead.RecordPosition := 0;

        SignalCoreAudioOut.SamplingFrequency := StrToInt(PlaybackFSEdit.Text);
        signalCoreAudioOut.PrecisionHw := StrToCoreAudioPrecision(PlaybackBitsEdit.Text);
        SignalCoreAudioOut.Precision := SignalRead.Precision;

        SignalCoreAudioOut.Start;
    end;
end;

procedure TAudioCoreDemoForm.Button2Click(Sender: TObject);
begin
    SignalCoreAudioOut.Stop;
    SignalCoreAudioIn.Stop;
//    SignalCoreAudioOut.StopGracefully;
end;

procedure TAudioCoreDemoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    SignalCoreAudioOut.Stop; //to avoid any errors when closing
    SignalCoreAudioIn.Stop;
end;

procedure TAudioCoreDemoForm.FormCreate(Sender: TObject);
begin
    SignalRead.IsDouble := DefaultIsDouble;
    SignalCoreAudioOut.IsDouble := DefaultIsDouble;

    SignalCoreAudioOut.GetDeviceList(PlaybackDeviceEdit.Items);
    PlaybackDeviceEdit.ItemIndex := -1;
    SignalCoreAudioOut.DeviceIndex := PlaybackDeviceEdit.ItemIndex;
    PlaybackDeviceEditChange(nil);

    SignalCoreAudioIn.IsDouble := DefaultIsDouble;

    SignalCoreAudioIn.GetDeviceList(RecordDeviceEdit.Items);
    RecordDeviceEdit.OnChange := nil;
    RecordDeviceEdit.ItemIndex := -1;
    RecordDeviceEdit.OnChange := RecordDeviceEditChange;
    SignalCoreAudioIn.DeviceIndex := RecordDeviceEdit.ItemIndex;
    RecordDeviceEditChange(nil);

    PlaybackLatencyEdit.Position := SignalCoreAudioOut.DesiredLatency;
    RecordingLatencyEdit.Position := SignalCoreAudioIn.DesiredLatency;
end;

procedure TAudioCoreDemoForm.PlaybackDeviceEditChange(Sender: TObject);
begin
    SignalCoreAudioOut.DeviceIndex := PlaybackDeviceEdit.ItemIndex;
    SignalCoreAudioOut.GetSupportedPrecisionHWs(PlaybackBitsEdit.Items);
    PlaybackBitsEdit.ItemIndex := 0;
    signalCoreAudioOut.PrecisionHw := StrToCoreAudioPrecision(PlaybackBitsEdit.Text);
    SignalCoreAudioOut.GetSupportedSamplingFrequencies(PlaybackFSEdit.Items);
    PlaybackFSEdit.ItemIndex := 0;
end;

procedure TAudioCoreDemoForm.PlaybackExclusiveBoxClick(Sender: TObject);
begin
    SignalCoreAudioOut.SettingsWin.Exclusive := PlaybackExclusiveBox.Checked;
    PlaybackLatencyEdit.Enabled := SignalCoreAudioOut.SettingsWin.Exclusive;
    PlaybackDeviceEditChange(nil);
end;

procedure TAudioCoreDemoForm.PlaybackFSEditChange(Sender: TObject);
begin
    //
end;

procedure TAudioCoreDemoForm.PlaybackLatencyEditChange(Sender: TObject);
begin
    SignalCoreAudioOut.DesiredLatency := PlaybackLatencyEdit.IntPosition;
end;

procedure TAudioCoreDemoForm.RecordBitsEditChange(Sender: TObject);
begin
    SignalCoreAudioIn.GetSupportedSamplingFrequencies(RecordFSEdit.Items);
    RecordFSEdit.ItemIndex := 0;
end;

procedure TAudioCoreDemoForm.RecordButtonClick(Sender: TObject);
begin
    if RecordDeviceEdit.Items.Count = 0 then ERaise('No recording devices were detected!');

    SaveDialog1.Title := 'Specify recording file name (.wav)';
    SaveDialog1.DefaultExt := '*.wav';
    if SaveDialog1.Execute then
    begin
        SignalWrite.FileName := SaveDialog1.FileName;
        SignalCoreAudioIn.SamplingFrequencyHW := StrToInt(RecordFSEdit.Text);
        SignalCoreAudioIn.PrecisionHw := StrToCoreAudioPrecision(RecordBitsEdit.Text);
        SignalCoreAudioIn.Precision := prSmallInt;

        SignalCoreAudioIn.Start;
    end;
end;

procedure TAudioCoreDemoForm.RecordDeviceEditChange(Sender: TObject);
begin
    SignalCoreAudioIn.DeviceIndex := RecordDeviceEdit.ItemIndex;
    SignalCoreAudioIn.GetSupportedPrecisionHWs(RecordBitsEdit.Items);
    RecordBitsEdit.ItemIndex := 0;
    signalCoreAudioIn.PrecisionHw := StrToCoreAudioPrecision(RecordBitsEdit.Text);
    SignalCoreAudioIn.GetSupportedSamplingFrequencies(RecordFSEdit.Items);
    RecordFSEdit.ItemIndex := 0;
end;

procedure TAudioCoreDemoForm.RecordFSEditChange(Sender: TObject);
begin
     //
end;

procedure TAudioCoreDemoForm.RecordingExclusiveBoxClick(Sender: TObject);
begin
    SignalCoreAudioIn.SettingsWin.Exclusive := RecordingExclusiveBox.Checked;
    RecordingLatencyEdit.Enabled := SignalCoreAudioIn.SettingsWin.Exclusive;
    RecordDeviceEditChange(nil);
end;

procedure TAudioCoreDemoForm.RecordingLatencyEditChange(Sender: TObject);
begin
    SignalCoreAudioIn.DesiredLatency := RecordingLatencyEdit.IntPosition;
end;

procedure TAudioCoreDemoForm.SignalCoreAudioInInputBufferReady(Sender: TObject);
begin
    SignalWrite.Pull; //update the pipe, (fetches data and writes to file)
end;

procedure TAudioCoreDemoForm.SignalCoreAudioInStop(Sender: TObject);
begin
    SignalWrite.CloseFile;
end;

procedure TAudioCoreDemoForm.Timer1Timer(Sender: TObject);
var bSampleCount, bBufferCount: Integer;
begin
    if SignalCoreAudioOut.Active then
    begin
        SignalCoreAudioOut.MonitorOutput(PlaybackList);

        //setup signal chart
        SignalChart.Signals[0].Inputs := PlaybackList;
        SignalChart.Signals[0].InputsItemIndex := ChannelNumberGroup.ItemIndex;
        SignalChart.Signals[0].Series := Series1;

        //setup spectrum chart
        SpectrumChart.Spectrums[0].Input := PlaybackSpectrumAnalyzer;
        SpectrumChart.Spectrums[0].InputsItemIndex := ChannelNumberGroup.ItemIndex;
        SpectrumChart.Spectrums[0].Series := Series2;

        //compute and update everything
        PlaybackSpectrumAnalyzer.Input := PlaybackList[ChannelNumberGroup.ItemIndex];
        PlaybackSpectrumAnalyzer.Pull;

        ElapsedTimeLabel.Caption := 'Elapsed time: ' + FormatSample('0.000s', SignalCoreAudioOut.ElapsedTime);
        ElapsedSamplesLabel.Caption := 'Elapsed samples: ' + IntToStr(SignalCoreAudioOut.ElapsedSamples);
        LatencyLabel.Caption := 'Latency: ' + FormatSample('0.000ms',SignalCoreAudioOut.ActualLatency);

    end;

    SignalCoreAudioOut.BufferStats(bBufferCount, bSampleCount);
    ExtBufferLabel.Caption := Format('Ext buffer duration: %d [ms], Ext buffer length: %d [ms]',[Round(1000*bSampleCount/SignalCoreAudioOut.SamplingFrequency)
                                                                                                ,Round(1000*bBufferCount/SignalCoreAudioOut.SamplingFrequency)]);

    if SignalCoreAudioIn.Active then
    begin
        SignalCoreAudioIn.MonitorInput(RecordingList);
        SignalChart.Signals[0].Inputs := RecordingList;
        SignalChart.Signals[0].InputsItemIndex := ChannelNumberGroup.ItemIndex;
        SignalChart.Signals[0].Series := Series1;

        SpectrumChart.Spectrums[0].Input := RecordingSpectrumAnalyzer;
        SpectrumChart.Spectrums[0].InputsItemIndex := ChannelNumberGroup.ItemIndex;
        SpectrumChart.Spectrums[0].Series := Series2;

        RecordingSpectrumAnalyzer.Input := RecordingList[ChannelNumberGroup.ItemIndex];
        RecordingSpectrumAnalyzer.Pull;

        ElapsedTimeLabel.Caption := 'Elapsed time: ' + FormatSample('0.000s', SignalCoreAudioIn.ElapsedTime);
        ElapsedSamplesLabel.Caption := 'Elapsed samples: ' + IntToStr(SignalCoreAudioIn.ElapsedSamples);
        LatencyLabel.Caption := 'Latency: ' + FormatSample('0.000ms',SignalCoreAudioIn.ActualLatency);
    end;

    SignalCoreAudioIn.BufferStats(bBufferCount, bSampleCount);
    ExtBufferInLabel.Caption := Format('Ext buffer duration: %d [ms], Ext buffer length: %d [ms]',[Round(1000*bSampleCount/SignalCoreAudioIn.SamplingFrequency)
                                                                                                ,Round(1000*bBufferCount/SignalCoreAudioIn.SamplingFrequency)]);
end;

initialization
RegisterClass(TAudioCoreDemoForm);


end.
