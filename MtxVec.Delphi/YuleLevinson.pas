unit YuleLevinson;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Basic1, TeeProcs, TeEngine, Chart, StdCtrls, ExtCtrls, MtxVec,            
  Toeplitz, Series, ComCtrls,Math387,MtxVecEdit, Buttons, MtxExpr,         
  AbstractMtxVec;

type
  TYuleLev = class(TBasicForm1)
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Panel3: TPanel;
    RadioGroup1: TRadioGroup;
    TrackBar1: TTrackBar;
    Label1: TLabel;                           
    Label2: TLabel;
    Label3: TLabel;                                                             
    Label4: TLabel;
    TrackBar2: TTrackBar;                                  
    Label5: TLabel;
    Label6: TLabel;
    Button1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    y,spec,corr: Vector;
    CorrLen : Integer;
    ZeroPadding : Integer;
    LPCCoef : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  YuleLev: TYuleLev;

implementation

Uses MtxVecTee, MtxVecInt;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure TYuleLev.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('YuleWalker autoregressive spectra uses Levinson '
      + 'Durbin recursion to solve a toeplitz systems of '
      + 'linear equations taking only O(n2) operations '
      + 'instead of O(n3) as required by LUSolve. The chart '
      + 'compares FFT and YuleWalker AR. The corrLen defines '
      + 'the number of samples on which the Autocorrelation '
      + 'is performed and LPCCoef defines the number of '
      + 'computed autocorrelation coefficients. The method '
      + 'uses biased autocorrelation. FFT uses only LPCoef '
      + 'parameter to determine the number of sample to '
      + 'include. It then rounds LPCCoef to the nearest '
      + 'power of two. FFT uses no windowing.');
    Add('Zoom in on a chart (left-click and drag mouse '
      + 'over the chart) to see differences. Please note '
      + 'that it takes less then 10ms to compute a 32000 '
      + 'point FFT on P366.');
  end;
  RadioGroup1Click(RadioGroup1);
  TrackBar1Change(TrackBar1);
  TrackBar2Change(TrackBar2);
end;

procedure TYuleLev.Button1Click(Sender: TObject);
begin
  Series1.Clear;
  Series2.Clear;
  Screen.Cursor := crHourGlass;
  StartTimer;
  { Levinson Yule Walker }
  y.LoadFromFile('FFTData.vec'); {Load signal}
  y.Resize(CorrLen);
  corr := AutoCorrBiased(y,LPCCoef);  {auto correlation}
  Levinson(corr, y);            {Levinson recursion}
  y.Resize(LargestExp2(y.Length*ZeroPadding),True); {zero padder}
  spec := Log10(1/Mag(FFT(y)));
  Label5.Caption := 'Time needed for Levinson YW : '+ FormatSample(StopTimer*1000,'0.000') +' ms';

  DrawValues(spec,Series1,0,1,DownSize);

  StartTimer;
  { "Regular" FFT }
  y.LoadFromFile('FFTData.vec'); {Load signal}
  y.Resize(LPCCoef);
  y.Resize(LargestExp2(LPCCoef)*ZeroPadding,True);
  spec := Mag(FFT(y));
  spec := Log10(ThreshBottom(spec,1E-5));
  TimeElapsed := GetTickCount - TimeCheck;
  Label6.Caption := 'Time needed for FFT : '+ FormatSample(StopTimer*1000,'0.000')+' ms';
  DrawValues(spec,Series2,0,1,DownSize);

  Chart1.Repaint;
  Screen.Cursor := crDefault;
end;

procedure TYuleLev.TrackBar1Change(Sender: TObject);
begin
  CorrLen := TTrackBar(Sender).Position;
  Label2.Caption := IntToStr(CorrLen);
  TrackBar2.Max := CorrLen;
  TrackBar2.Frequency := CorrLen div 20;
  TrackBar2.Position := CorrLen div 2;
  TrackBar2Change(TrackBar2);
end;

procedure TYuleLev.TrackBar2Change(Sender: TObject);
begin
  LPCCoef := TTrackBar(Sender).Position;
  Label4.Caption := IntToStr(LPCCoef);
end;

procedure TYuleLev.RadioGroup1Click(Sender: TObject);
begin
  case TRadioGroup(Sender).ItemIndex of
  0    : ZeroPadding := 1;
  1    : ZeroPadding := 2;
  2    : ZeroPadding := 4;
  3    : ZeroPadding := 8;
  4    : ZeroPadding := 16;
  end;
end;      

initialization
   RegisterClass(TYuleLev);

end.
  