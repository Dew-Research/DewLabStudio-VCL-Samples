unit TS_ExpSmooth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Chart, StdCtrls, TeeProcs, TeEngine, Chart, ExtCtrls,
  ComCtrls, Series, MtxVec, TeeGDIPlus;

type
  TfrmExpSmooth = class(TfrmBasicChart)
    Series2: TLineSeries;
    Series3: TLineSeries;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    EditAlphaS: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditAlphaD: TEdit;
    EditGammaD: TEdit;
    Button3: TButton;
    Series4: TLineSeries;
    Series1: TLineSeries;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditAlphaT: TEdit;
    EditBetaT: TEdit;
    EditGammaT: TEdit;
    Label8: TLabel;
    EditPeriod: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Chart1AfterDraw(Sender: TObject);
  private
    { Private declarations }
    Data,YHat: TVec;
    T: Integer;
    singletext, doubletext,tripletext: String;
    procedure ResetForecast;
    procedure Smooth;
    procedure ResetChart;
  public
    { Public declarations }
  end;

var
  frmExpSmooth: TfrmExpSmooth;

implementation

Uses StatTimeSerAnalysis, MtxVecTee, MtxVecEdit, Math387;

{$R *.dfm}

procedure TfrmExpSmooth.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Exponential smoothing is a very popular scheme to produce a smoothed time series. Whereas in Single Moving Averages the past '
      + 'observations are weighted equally, exponential smoothing assigns exponentially decreasing weights as the observation get older. '
      + 'In other words, recent observations are given relatively more weight in forecasting than the older observations.');
    Add('');
    Add('This example demonstrates single, double and triple exponential smoothing. The following data set represents 24 observations. '
      + 'These are six years of quarterly data (each year = 4 quarters).');
    Add('');
    Add('Things to try');
    AdD('(1) Press the "Smooth" button to perform single, double and triple exponential smoothing.');
    Add('(2) Try changing initial values for alpha, beta and/or gamma parameters. Values must lie in the [0,1] interval.');
    Add('(3) Change the "Forecast period" value - the last forecast point.');
    Add('(4) Load different data set by pressing the "Edit data" button.');
  end;


  EditAlphaS.Text := FloatToStr(0.1);
  EditAlphaD.Text := FloatToStr(0.1);
  EditGammaD.Text := FloatToStr(0.1);
  EditAlphaT.Text := FloatToStr(0.1);
  EditBetaT.Text := FloatToStr(0.1);
  EditGammaT.Text := FloatToStr(0.1);
  EditPeriod.Text := IntToStr(4);

  Data := TVec.Create;
  YHat := TVec.Create;
  { populate with test data ... }
  Data.SetIt(false,[362,385,432,341,382,409,498,387,473,513,582,474,
                    544,582,681,557,628,707,773,592,627,725,854,661]);
  ResetForecast;
  DrawValues(Data,Series1);
end;

procedure TfrmExpSmooth.FormDestroy(Sender: TObject);
begin
  YHat.Destroy;
  Data.Destroy;
  inherited;
end;

procedure TfrmExpSmooth.Button2Click(Sender: TObject);
begin
  ViewValues(Data,'Raw data',True,False,True);
  ResetChart;
  ResetForecast;
  DrawValues(Data,Series1);
end;

procedure TfrmExpSmooth.ResetForecast;
begin
  UpDown1.Max := Data.Length * 2;
  UpDown1.Position := Data.Length;
end;

procedure TfrmExpSmooth.Button3Click(Sender: TObject);
begin
  Smooth;
end;

procedure TfrmExpSmooth.Smooth;
var AlphaS, AlphaD, GammaD: double;
    AlphaT,BetaT,GammaT: double;
    MSE: double;
    Period: Integer;
begin
  { read variables ... }
  try
    AlphaS := StrToFloat(EditAlphaS.Text);
  except
    AlphaS := 0.1;
  end;
  try
    AlphaD := StrToFloat(EditAlphaD.Text);
  except
    AlphaD := 0.1;
  end;
  try
    GammaD := StrToFloat(EditGammaD.Text);
  except
    GammaD := 0.1;
  end;
  try
    AlphaT := StrToFloat(EditAlphaT.Text);
  except
    AlphaT := 0.1;
  end;
  try
    BetaT := StrToFloat(EditBetaT.Text);
  except
    BetaT := 0.1;
  end;
  try
    GammaT := StrToFloat(EditGammaT.Text);
  except
    GammaT := 0.1;
  end;
  try
    Period := StrToInt(EditPeriod.Text);
  except
    Period := 4;
  end;
  T := UpDown1.Position;
  { step 1 => estimate parameters Alpha }
  { step 2 => forecast and store the results in YHat }
  SingleExpForecast(Data,YHat,AlphaS,T,MSE,0);
  SingleText := 'Single EXP: alpha='+FormatFloat('0.000',AlphaS);
  Series2.Title := 'Single EXP (MSE='+FormatFloat('0.000',MSE)+')';
  DrawValues(YHat,Series2,1,1); { offset by first point }

  { step 1 => estimate parameters Alpha,Gamma }
  { step 2 => forecast and store the results in YHat }
  DoubleExpForecast(Data,YHat,AlphaD,GammaD,T,MSE,1);
  DoubleText := 'Double EXP: alpha='+FormatFloat('0.000',AlphaD)+' gamma='+FormatFloat('0.000',GammaD);
  Series3.Title := 'Double EXP (MSE='+FormatFloat('0.000',MSE)+')';
  DrawValues(YHat,Series3,1,1); { offset by first point }

  { step 1 => estimate parameters Alpha,Beta, Gamma }
  { step 2 => forecast and store the results in YHat }
  TripleExpForecast(Data,YHat,AlphaT,BetaT,GammaT,T,MSE,Period);
  TripleText := 'Triple EXP: alpha='+FormatFloat('0.000',AlphaT)+' beta='+FormatFloat('0.000',BetaT)+ 'gamma='+FormatFloat('0.000',GammaT);
  Series4.Title := 'Triple EXP (MSE='+FormatFloat('0.000',MSE)+')';
  DrawValues(YHat,Series4,Period,1); { offset by first period }
end;

procedure TfrmExpSmooth.ResetChart;
begin
  SingleText := '';
  DoubleText := '';
  TripleText := '';
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
end;

procedure TfrmExpSmooth.Chart1AfterDraw(Sender: TObject);
var x,y: Integer;
begin
  inherited;
  With Chart1.Canvas, Chart1 do
  begin
    x := ChartRect.Left + 20;
    y := ChartRect.Top + 20;
    Font.Color := clGreen;
    Font.Style := [fsBold];
    TextOut(x,y,SingleText);
    Font.Color := clYellow;
    TextOut(x,y+TextHeight('W')*2,DoubleText);
    Font.Color := clBlue;
    TextOut(x,y+TextHeight('W')*4,TripleText);
  end;
end;

initialization
  RegisterClass(TfrmExpSmooth);

end.
