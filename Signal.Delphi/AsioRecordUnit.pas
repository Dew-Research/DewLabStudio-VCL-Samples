unit AsioRecordUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, MtxBaseComp, SignalTools, AsioAudioSignal,
  ExtCtrls, TeEngine, TeeProcs, Chart, SignalToolsTee, Series, MtxVecTee,
  TeeEdit, FileSignal, SignalProcessing, TeeGDIPlus;

type
  TAsioRecordForm = class(TForm)
    Timer: TTimer;
    TopChart: TSignalChart;
    Panel1: TPanel;
    DriverNameListBox: TListBox;
    Label2: TLabel;
    FSListBox: TListBox;
    Label1: TLabel;
    Label3: TLabel;
    OutputChBox: TListBox;
    Label4: TLabel;
    InputChBox: TListBox;
    StartButton: TButton;
    StopButton: TButton;
    BottomChart: TSignalChart;
    Splitter1: TSplitter;
    SignalList: TSignalList;
    ChartEditor1: TChartEditor;
    Series2: TMtxFastLineSeries;
    ChartTool1: TAxisScaleTool;
    ChartTool2: TAxisScaleTool;
    SignalMux: TSignalMux;
    SignalWrite1: TSignalWrite;
    SignalRead: TSignalRead;
    SignalDemuxList: TSignalDemuxList;
    Series3: TFastLineSeries;
    Button1: TButton;
    SignalRateConverterList: TSignalRateConverterList;
    SignalAsio: TSignalAsio;
    StatusLabel: TLabel;
    OpenDialog: TOpenDialog;
    Label5: TLabel;
    SaveDialog: TSaveDialog;
    procedure StopButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DriverNameListBoxClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SignalRateConverterListBeforeUpdate(Sender: TObject);
    procedure SignalAsioInputBufferReady(Sender: TObject);
    procedure SignalAsioProcessRealTime(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SignalAsioStop(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AsioRecordForm: TAsioRecordForm;

implementation

uses Math387, MtxVec, AbstractMtxVec, MtxExpr, Stringvar;

{$R *.dfm}

procedure TAsioRecordForm.Button1Click(Sender: TObject);
begin
    SignalAsio.ShowControlPanel;
end;

procedure TAsioRecordForm.Button2Click(Sender: TObject);
begin
//    a := TBandlimitedInterpolator.Create(self);
end;

procedure TAsioRecordForm.DriverNameListBoxClick(Sender: TObject);
begin
    SignalAsio.DriverIndex := DriverNameListBox.ItemIndex;
    SignalAsio.GetSupportedSamplingFrequencies(FSListBox.Items);
    SignalAsio.GetInputChannels(InputChBox.Items);
    SignalAsio.GetOutputChannels(OutputChBox.Items);

    if FSListBox.Items.Count > 0 then
    begin
      FSListBox.Selected[0] := True;
      SignalAsio.SamplingFrequency := StrToSample(FSListBox.Items[0])
    end else ShowMessage('Supported sampling frequency not found!');
end;

procedure TAsioRecordForm.FormCreate(Sender: TObject);
begin
    SignalRead.IsDouble := DefaultIsDouble;
    SignalAsio.IsDouble := DefaultIsDouble;
    SignalAsio.GetDriverList(DriverNameListBox.Items);
end;

procedure TAsioRecordForm.FormResize(Sender: TObject);
begin
     TopChart.Height := (ClientHeight - Panel1.Height) div 2;
end;

procedure TAsioRecordForm.StopButtonClick(Sender: TObject);
begin
    SignalAsio.StopGracefully;
    Timer.Enabled := false;
end;

procedure TAsioRecordForm.TimerTimer(Sender: TObject);
var bSize, bSamples: integer;
    inL, outL: double;
begin
    try
        bSamples := 0;
        bSize := 0;
        if SignalAsio.InputChannelCount > 0 then
        begin
            SignalAsio.MonitorInput(SignalList);
            SignalAsio.InputBufferStats(bSize, bSamples);
        end else
        if SignalAsio.OutputChannelCount > 0 then
        begin
            SignalAsio.MonitorOutput(SignalList);
            SignalAsio.OutputBufferStats(bSize, bSamples);
        end;

        if SignalAsio.DriverIndex >= 0 then
        begin
            SignalAsio.GetDriverLatencies(inL, outL);
            StatusLabel.Caption := Format('ASIO Version = %d, BufferSize = %d, BufferedSamples = %d, ' +
                              'InLatency = %g [ms], OutLatency = %g [ms], ActualLatency = %g [ms], Elapsed time [s] = %8.2g',
                              [SignalAsio.DriverVersion, bSize, bSamples,
                              inL, outL, SignalAsio.ActualLatency, SignalAsio.ElapsedTime]) + ',ProcessingTime = ' + FormatSample('0.000',SignalAsio.ProcessingTime) + ' [ms]';

            SignalList.UpdateNotify;
        end;
    except
        Timer.Enabled := false;
    end;
end;

procedure TAsioRecordForm.SignalAsioInputBufferReady(Sender: TObject);
begin
    SignalWrite1.Precision := SignalAsio.InputPrecision;
    SignalWrite1.Pull;
end;

procedure TAsioRecordForm.SignalAsioProcessRealTime(Sender: TObject);
begin
    if not Timer.Enabled then Timer.Enabled := True;
    //put real time processing code here
    // for playback take data from OutputBuffers, process and put and back in.
    // for real time recording/playback, take data from InputBuffers, process them and put them to OutputBuffers

    // THIS EVENT RUNS IN DRIVERS THREAD. DO NOT PERORM OPERATIONS ON THE SAME VARS
    // FROM MORE THAN ONE THREAD.
    // Only InputBuffers and OutputBuffers can be read/written with processing in between
end;

procedure TAsioRecordForm.SignalAsioStop(Sender: TObject);
begin
    SignalWrite1.CloseFile;
end;

procedure TAsioRecordForm.SignalRateConverterListBeforeUpdate(
  Sender: TObject);
begin
    TSignalRateConverter(Sender).Factor := SignalAsio.SamplingFrequency/SignalRead.SamplingFrequency;
end;

procedure TAsioRecordForm.StartButtonClick(Sender: TObject);
var i: integer;
begin
    if DriverNameListBox.ItemIndex < 0 then ERaise('Please select a valid ASIO driver first!');
    SignalAsio.Stop;

    for i := 0 to FSListBox.Count - 1 do  //samplingFrequency must be selected first
    begin
        if FSListBox.Selected[i] then
        begin
          SignalAsio.SamplingFrequency := StrToInt(FSListBox.Items[i]);
          Break
        end;
    end;

    for i := 0 to InputChBox.Count - 1 do
        SignalAsio.InputsSelected[i] := InputChBox.Selected[i];

    for i := 0 to OutputChBox.Count - 1 do
        SignalAsio.OutputsSelected[i] := OutputChBox.Selected[i];

    if SignalAsio.InputChannelCount > 0 then
    begin
        if SaveDialog.Execute then
        begin
            SignalWrite1.FileName := SaveDialog.Filename;
            Label5.Caption := 'Recording to: ' + SaveDialog.Filename;
        end;
    end;

    SignalRead.CloseFile;
    if OpenDialog.Execute then
    begin
        SignalRead.FileName := OpenDialog.FileName;
        SignalRead.OpenFile;
        SignalAsio.InputPrecision := prSingle;
        SignalAsio.OutputPrecision := SignalRead.Precision;

        SignalAsio.Start;

        TAxisScaleTool(TopChart.Tools[0]).Reset;
        TAxisScaleTool(BottomChart.Tools[0]).Reset;
    end;
end;

initialization
  RegisterClass(TAsioRecordForm);

end.
