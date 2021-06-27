unit PlaybackDemo;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalProcessing, AudioSignal, MtxComCtrls, SignalUtils,
  Menus, TeCanvas, TeeGdiPlusEditor, TeeGDIPlus;

type
  TPlaybackDemoForm = class(TForm)
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
    SignalChart1: TSignalChart;
    Series3: TFastLineSeries;
    SignalTimer1: TSignalTimer;
    Signal1: TSignal;
    ChannelBox: TComboBox;
    Label1: TLabel;
    SignalOut1: TSignalOut;
    SignalRead1: TSignalRead;
    ToolButton1: TToolButton;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Spectrum1: TMenuItem;
    Chart1: TMenuItem;
    Playback1: TMenuItem;
    SignalOutDialog: TSignalOutDialog;
    N1: TMenuItem;
    imechart1: TMenuItem;
    ChartEditor2: TChartEditor;
    TeeGDIPlus1: TTeeGDIPlus;
    TeeGDIPlus2: TTeeGDIPlus;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure SignalTimer1Timer(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Spectrum1Click(Sender: TObject);
    procedure Chart1Click(Sender: TObject);
    procedure Playback1Click(Sender: TObject);
    procedure imechart1Click(Sender: TObject);
    procedure SignalOut1ParameterUpdate(Sender: TObject);
  private
    procedure WaitForPlayback;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlaybackDemoForm: TPlaybackDemoForm;

implementation

uses Math387, MtxVec;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TPlaybackDemoForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TPlaybackDemoForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TPlaybackDemoForm.FormCreate(Sender: TObject);
begin
    SignalRead1.IsDouble:= DefaultIsDouble;
    Signal1.IsDouble := DefaultIsDouble;

    Signal1.Data.Size(2048);  //defines how much data to copy
    Signal1.UsesInputs := false;
//    SignalRead1.Length := 16384;  //this will automatically set the size of the SignalOut buffer!!

    ChannelBox.ItemIndex := 0;

    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('Open an uncompressed PCM wav file. The signal display and spectrum analyzer will be ' +
          'updated with a frequency independent of the audio stream being played back. ' +
          'Note the smooth and very responsive display next to the clean playback. '+
          'The screen update frequency is 20Hz, frequency spectrum is based on 2048 samples ' +
          'and this requires only 20% of 1GHz CPU.');
    end;
end;


procedure TPlaybackDemoForm.Panel2Resize(Sender: TObject);
begin
    SpectrumChart.Height := Panel2.Height div 2;
end;

procedure TPlaybackDemoForm.SignalTimer1Timer(Sender: TObject);
begin
    if not SignalOut1.Active then Exit;
    case TChannel(ChannelBox.ItemIndex) of
    chLeft:  SignalOut1.MonitorData(Signal1, nil    );
    chRight: SignalOut1.MonitorData(nil    , Signal1);
    end;
    SpectrumAnalyzer.Pull;  //calls update on Signal1 and Self
end;

procedure TPlaybackDemoForm.WaitForPlayback;
var i: integer;
begin
    SignalOut1.StopAtOnce;
    i := 0;
    while i < 10 do
    begin
         Inc(i);
         Application.ProcessMessages;
         Sleep(20);
    end;
end;

procedure TPlaybackDemoForm.ToolButton1Click(Sender: TObject);
var Len: integer;
begin
     if OpenDialog1.Execute then
     begin
          WaitForPlayback;   //because you can not start right after being stopped
          SignalRead1.FileName := OpenDialog1.FileName;
          SignalRead1.OpenFile; //not needed otherwise, but we need Precision and SamplingFrequency fields
          Len := Trunc(0.3*SignalRead1.SamplingFrequency*SignalRead1.ChannelCount); //this is important
          if Odd(len) then Inc(Len);
          SignalRead1.Length := Len;
//        because SignalOut buffer size will use this to set its own BufferSize
//        If BufferSize is too small, the sound will be distorted.
          SignalOut1.Quantization := Min(24,SizeOfPrecision(SignalRead1.Precision,false)*8);
          SignalOut1.Start;
     end;
end;


procedure TPlaybackDemoForm.Spectrum1Click(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TPlaybackDemoForm.Chart1Click(Sender: TObject);
begin
     ChartEditor.Execute;
end;

procedure TPlaybackDemoForm.Playback1Click(Sender: TObject);
begin
     SignalOutDialog.Execute;     
end;

procedure TPlaybackDemoForm.imechart1Click(Sender: TObject);
begin
     ChartEditor2.Execute;
end;

procedure TPlaybackDemoForm.SignalOut1ParameterUpdate(Sender: TObject);
begin
     //
//     SignalREad1.Length := Signalout1.
end;

initialization
RegisterClass(TPlaybackDemoForm);

end.
