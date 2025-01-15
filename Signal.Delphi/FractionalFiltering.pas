unit FractionalFiltering;

interface

uses
  System.Types,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, MtxBaseComp, SignalTools, SignalAnalysis, SignalToolsDialogs,
  SpectrumAna, TeeProcs, TeEngine, Chart, SignalToolsTee, StdCtrls,
  ExtCtrls, FileSignal, Series, SignalSeriesTee, TeeTools, TeeEdit,
  SignalProcessing, MtxVec, MtxComCtrls, MtxDialogs, ComCtrls, ToolWin,
  TeeGDIPlus;

type
  TFractionalFilteringForm = class(TForm)
    ChartEditor1: TChartEditor;
    RichEdit1: TRichEdit;
    Panel2: TPanel;                                  
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;                           
    Label2: TLabel;
    FractionalEdit: TMtxFloatEdit;
    Panel1: TPanel;
    SpectrumChart: TSpectrumChart;
    FastLineSeries1: TFastLineSeries;
    SignalDiscreteSeries1: TSignalDiscreteSeries;
    AxisScaleTool1: TAxisScaleTool;
    Splitter2: TSplitter;
    GroupDelayChart: TSpectrumChart;
    FastLineSeries2: TFastLineSeries;
    SignalDiscreteSeries2: TSignalDiscreteSeries;
    AxisScaleTool2: TAxisScaleTool;
    ChartTool1: TSpectrumMarkTool;
    FilterDelayLabel: TLabel;
    FractionalFilterBox: TComboBox;
    Label1: TLabel;
    Signal: TSignal;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    LogBox: TCheckBox;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    procedure FormCreate(Sender: TObject);
    procedure SpectrumAnalyzer1ParameterUpdate(Sender: TObject);
    procedure MtxFloatEdit1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure SignalAfterUpdate(Sender: TObject);
    procedure FractionalFilterBoxChange(Sender: TObject);
    procedure LogBoxClick(Sender: TObject);
    procedure FractionalEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FractionalFilteringForm: TFractionalFilteringForm;

implementation

uses SignalUtils, Math387, MtxVecTee, MtxExpr, AbstractMtxVec, MtxVecBase;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TFractionalFilteringForm.FormCreate(Sender: TObject);
begin
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Fractional filters are linear phase filters which delay the signal by ' +
            'a user specified fraction of a sample. Their delay is composed from ' +
            'integer sample count plus the fractional part. Demonstrated are filters ' +
            'with relaxed stopband specification. Stopband is allowed to vary between 0 and 1. ' +
            'Observe the group delay and compare the actual delay as a function of frequency to the Total delay label. ' +
            'Various predefined designs are available which compromise between different filter properties.' +
            'When there is a need for other filter, any lowpass/bandpass filter can be designed to have ' +
            'a fractional delay (less than one sample) part also by using FractionalKaiserImpulse function.' );

        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
    end;
    FractionalFilterBox.ItemIndex := integer(falp_60dB);
    FractionalFilterBoxChange(Sender);
end;

procedure TFractionalFilteringForm.SignalAfterUpdate(Sender: TObject);
begin
    //
end;

procedure TFractionalFilteringForm.SpectrumAnalyzer1ParameterUpdate(Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TFractionalFilteringForm.MtxFloatEdit1Change(Sender: TObject);
begin
    //
end;

procedure TFractionalFilteringForm.FormResize(Sender: TObject);
begin
    GroupDelayChart.Height := Panel1.Height div 2;
end;

procedure TFractionalFilteringForm.FractionalEditChange(Sender: TObject);
begin
    FractionalFilterBoxChange(Sender);
end;

procedure TFractionalFilteringForm.LogBoxClick(Sender: TObject);
begin
    SpectrumAnalyzer.Logarithmic := LogBox.Checked;
    if LogBox.Checked then
        SpectrumChart.LeftAxis.Title.Caption := 'Magnitude [dB]'
    else
        SpectrumChart.LeftAxis.Title.Caption := 'Amplitude';

    SpectrumAnalyzer.Update;
end;

procedure TFractionalFilteringForm.FractionalFilterBoxChange(Sender: TObject);
var H, DeltaImpulse: Vector;
    GrpDelay: Vector;
    FirState: TFirState;
    Delay: TSample;
begin
    H.IsDouble := DefaultIsDouble;
    Delay := FractionalImpulse(H, FractionalEdit.Position, TFractionalImpulse(FractionalFilterbox.ItemIndex));
    DeltaImpulse.Size(4096, H);
    DeltaImpulse.SetZero;
    DeltaImpulse[0] := DeltaImpulse.Length div 2;

    FirInit(H, FirState);
    FirFilter(DeltaImpulse, Signal.Data, FirState);
    FirFree(FirState);

    SpectrumAnalyzer.Update;
    GroupDelay(grpDelay, H, nil, 32);
    DrawValues(grpDelay, GroupDelayChart.Series[0],0, Signal.SamplingFrequency/(grpDelay.Length*2));

    FilterDelayLabel.Caption := 'Total delay = ' + FormatSample('0.000',Delay) + ' [Samples]';
end;

procedure TFractionalFilteringForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor1.Execute;
end;

procedure TFractionalFilteringForm.SpectrumEditButtonClick(Sender: TObject);
begin
   SpectrumAnalyzerDialog.Execute();
end;

initialization
RegisterClass(TFractionalFilteringForm);

end.
