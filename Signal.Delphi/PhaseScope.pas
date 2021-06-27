unit PhaseScope;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, SignalProcessing, AudioSignal, MtxComCtrls, SignalUtils,
  TeePolar, MtxExpr, SignalSeriesTee, TeeGDIPlus;

type
  TPhaseScopeForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartButton: TToolButton;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;
    Splitter1: TSplitter;
    SignalChart1: TSignalChart;
    Series3: TFastLineSeries;
    SignalTimer1: TSignalTimer;
    SignalIn1: TSignalIn;
    Signal1: TSignal;
    ChannelBox: TComboBox;
    Label1: TLabel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Signal2: TSignal;
    ChartTool3: TAxisScaleTool;
    RightPhaseChart: TChart;
    Series2: TSignalPolarSeries;
    LeftPhaseChart: TChart;
    SignalPolarSeries1: TSignalPolarSeries;
    TeeGDIPlus1: TTeeGDIPlus;
    TeeGDIPlus2: TTeeGDIPlus;
    TeeGDIPlus3: TTeeGDIPlus;
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure SignalTimer1Timer(Sender: TObject);
    procedure ChartButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
//    DelayState: TDelayFilterState; // for delay filter
//    HilbertState: TFirState;
  public
    { Public declarations }
  end;

var
  PhaseScopeForm: TPhaseScopeForm;

implementation

uses Math387, MtxVec, OptimalFir, MtxVecTee;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TPhaseScopeForm.FormCreate(Sender: TObject);
//var H: Vector;
begin //just an example how to setup filters
//    H.Length := 256;
//    RemezImpulse(H,[0.05,0.495],ftHilbertIV,1); //type four hilbert
//    FirInit(H,HilbertState);
//    RemezImpulse(H,[0,0.05],ftHighpass,1);  // need a DC filter on original
//    Delayinit((H.Length-1) div 2,DelayState);

    SignalIn1.IsDouble := DefaultIsDouble;

    Signal1.IsDouble := DefaultIsDouble;
    Signal1.Data.Size(1024);  //defines how much data to copy and consequently also frequency resolution
    Signal1.Data.SetZero;
    Signal1.UsesInputs := false;

    Signal2.IsDouble := DefaultIsDouble;
    Signal2.Data.Size(1024);  //defines how much data to copy and consequently also frequency resolution
    Signal2.Data.SetZero;
    Signal2.UsesInputs := false;

    ChannelBox.ItemIndex := 0;

    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('The recording is setup for 11025 kHz stereo. You can select ' +
          'the channel you wish to monitor.' +
          'This example shows, the relative phases of each channel separately.' +
          'This example demonstrates the use of a hilbert transformer and ' +
          'the faster (50x) TSignalPolarSeries');
    end;
end;


procedure TPhaseScopeForm.Panel2Resize(Sender: TObject);
begin
    Panel3.Height := Panel2.Height div 2;
    LeftPhaseChart.Width := Panel3.Width div 2;
end;

procedure TPhaseScopeForm.SignalTimer1Timer(Sender: TObject);
var a,Re,Im: Vector;
begin                                  
    Re.Size(0);
    Im.Size(0);
    
    if not SignalIn1.Active then SignalIn1.Start;
    SignalIn1.MonitorData(Signal1,Signal2);

    RemoveDC(Signal1.Data); //should be FIR filter, but this will work also
    RemoveDC(Signal2.Data); //should be FIR filter, but this will work also
    a.Hilbert(Signal1.Data);
    a.SetSubRange(Trunc(a.Length*0.01),Trunc(a.Length*0.8)); //leave out the edges, because they are bad... (rectangular window ripple effect)

    a.CplxToReal(Re,Im);
//    a.CartToPolar(Re,Im);
//    Im := Im*(180/Pi); //from radians to degrees
//    Re := Re/re.Max;  //normalize
    DrawValues(Re,Im,LeftPhaseChart.Series[0]); //angle is x
    a.SetFullRange;
    a.Hilbert(Signal2.Data);
    a.SetSubRange(Trunc(a.Length*0.01),Trunc(a.Length*0.8)); //leave out the edges, because they are bad... (rectangular window ripple effect)
    a.CplxToReal(Re, Im);
//    a.CartToPolar(Re,Im);
//    Im := Im*(180/Pi); //from radians to degrees
//    Re := Re/re.Max;  //normalize
    DrawValues(Re,Im,RightPhaseChart.Series[0]); //angle is x
    SignalChart1.Title.Text.Clear;
    case ChannelBox.ItemIndex of
    0: begin
       SignalChart1.Signals[0].Input := Signal1;
       SignalChart1.Title.Text.Add('Time signal - Left channel');
       end;
    1: begin
       SignalChart1.Signals[0].Input := Signal2;
       SignalChart1.Title.Text.Add('Time signal - Right channel');
       end;
    end;
    SignalChart1.Signals[0].Input.UpdateNotify;
end;

procedure TPhaseScopeForm.ChartButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TPhaseScopeForm.FormDestroy(Sender: TObject);
begin
     SignalTimer1.Enabled := false;
//     FirFree(HilbertState);
//     DelayFree(DelayState);
end;

initialization
RegisterClass(TPhaseScopeForm);

end.
