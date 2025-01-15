unit SpectralDecompositionForecast;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SignalToolsTee, TeEngine, TeeProcs, Chart,
  Series, MtxVecTee, TeeEdit, SignalTools, FileSignal, MtxBaseComp,
  SignalAnalysis, MtxDialogs, SignalToolsDialogs, MtxComCtrls, ComCtrls,
  MtxFastLineEdit, TeeGDIPlus;

type
  TSpectralDecomposition = class(TForm)
    SpectrumChart1: TSpectrumChart;
    SignalChart1: TSignalChart;
    Splitter1: TSplitter;
    Panel1: TPanel;
    SignalRead1: TSignalRead;
    ChartEditor1: TChartEditor;
    Series1: TMtxFastLineSeries;
    Series2: TFastLineSeries;
    ChartTool1: TSpectrumMarkTool;
    Series3: TPointSeries;
    Series4: TMtxFastLineSeries;
    ChartTool2: TAxisScaleTool;
    SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog;
    Button3: TButton;
    FilePositionEdit: TMtxFloatEdit;
    Label1: TLabel;
    SpectrumAnalyzer1: TSpectrumAnalyzer;
    ChartTool3: TAxisScaleTool;
    UpperLimit: TLineSeries;
    LowerLimit: TLineSeries;
    RichEdit1: TRichEdit;
    TeeGDIPlus1: TTeeGDIPlus;
    TeeGDIPlus2: TTeeGDIPlus;
    procedure Button1Click(Sender: TObject);
    procedure SpectrumAnalyzer1PeaksUpdate(Sender: TObject);
    procedure SpectrumChart1AfterMarkPeak(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FilePositionEditChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SpectralDecomposition: TSpectralDecomposition;

implementation

uses SignalUtils, Math387, MtxExpr, MtxVec, AbstractMtxVec;

{$R *.dfm}

procedure TSpectralDecomposition.Button1Click(Sender: TObject);
begin
    FilePositionEditChange(Sender);
end;

procedure TSpectralDecomposition.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TSpectralDecomposition.Button3Click(Sender: TObject);
begin
    SpectrumAnalyzerDialog1.Execute;
end;

procedure TSpectralDecomposition.FilePositionEditChange(Sender: TObject);
begin
    SignalRead1.FileName := ExtractFilePath(ParamStr(0)) + 'bz.sfs';
    SignalRead1.RecordPosition := FilePositionEdit.IntPosition;
    SpectrumAnalyzer1.Pull;
    SpectrumChart1AfterMarkPeak(Sender);
end;

procedure TSpectralDecomposition.FormCreate(Sender: TObject);
begin
    SignalRead1.IsDouble := DefaultIsDouble;
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('Spectral decomposition uses frequency analysis to predict the future of the time series. ' +
          'By marking the peaks, individual or multiple. one can see the effect of each component. ' +
          'This approach uses only those components of the signal for forecasting for ' +
          'which there is evidently periodicity present thus guarding the user from  ' +
          'making things up without knowing it.');
      Add('');
      Paragraph.FirstIndent := 0;
      Paragraph.Numbering := nsNone;
    end;

    FilePositionEditChange(Sender);
end;

procedure TSpectralDecomposition.SpectrumAnalyzer1PeaksUpdate(Sender: TObject);
begin
    //
end;

procedure TSpectralDecomposition.SpectrumChart1AfterMarkPeak(Sender: TObject);
var ToneState: TToneState;
    i: integer;
    Work, Forecast: Vector;
    ConfInt: double;
begin
    Forecast.Size(Round(SignalRead1.Length*1.5));
    Forecast.SetZero;
    Work.Size(Forecast);
    for i := 0 to SpectrumAnalyzer1.Peaks.List.Count - 1 do
    begin
        ToneInit(SpectrumAnalyzer1.Peaks[i].Freq/SpectrumAnalyzer1.SamplingFrequency,SpectrumAnalyzer1.Peaks[i].Phase*Pi/180,
                 SpectrumAnalyzer1.Peaks[i].Amplt, ToneState);
        Tone(Work, ToneState);
        Forecast.Add(Work);
    end;
    Forecast := Forecast  + SignalRead1.Data.Mean;
    ConfInt := StdDev(SignalRead1.Data - Select(Forecast, 0, SignalRead1.Data.Length-1));
    DrawValues(Forecast, Series4, 0, SignalRead1.Dt);
    DrawValues(Forecast + 3*ConfInt, UpperLimit, 0, SignalRead1.Dt);
    DrawValues(Forecast - 3*ConfInt, LowerLimit, 0, SignalRead1.Dt);
end;

initialization
RegisterClass(TSpectralDecomposition);

end.
