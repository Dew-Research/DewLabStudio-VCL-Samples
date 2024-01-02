unit ARMATrend;

interface

uses
  System.Types,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ImgList, Vcl.StdCtrls, VCLTee.TeEngine,
  AbstractMtxVec, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, MtxVecTee;

type
  TARMATrendForm = class(TForm)
    SignalChart1: TChart;
    Series1: TMtxFastLineSeries;
    Series2: TMtxFastLineSeries;
    Series3: TMtxFastLineSeries;
    ARMAModelBox: TComboBox;
    Label1: TLabel;
    ModelLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ARMAModelBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ARMATrendForm: TARMATrendForm;

implementation

uses MtxVec, MtxExpr, StatTimeSerAnalysis, Optimization, Math387, MtxVecInt, Polynoms, MtxIntDiff,
     Regress, StringVar, MtxVecBase;

{$R *.dfm}

procedure TARMATrendForm.ARMAModelBoxChange(Sender: TObject);
var p, t, x, x1,x2, residuals, y, Trend, b, Forecasts, data, fStdDev: Vector;
    aMLE, mu, aSigma: double;
    Iters: integer;
    nForecast: integer;
    aStrings: StringList;
begin
    series1.Title := 'Data';
    series2.Title := 'Forecast';
    Series3.Title := 'Trend';

    data.LoadFromFile('dowjones.vec');

    case ARMAModelBox.ItemIndex of
    0: begin
       p.Size(2, Data);  //We will be fitting ARIMA (AR = 2, MA = 1)
       t.Size(1, Data);
       end;
    1: begin
       p.Size(3, Data);
       t.Size(2, Data);
       end;
    2: begin
       p.Size(5, Data);
       t.Size(4, Data);
       end;
    end;

    nForecast := 160;

    x.Size(data);
    x.Ramp;

    LinRegress(x, Data, b, true, nil, Trend, nil);

    y := Data - Trend;
    ARYuleWalkerFit(y, p, aSigma);  //fit the AR part

    t.SetZero; //initialize the MA part to 0

    Trend.Size(0);
    Iters := ARMAMLE(y, p, t, Residuals, aMLE, mu); //refine AR stored in P and MA stored in T

    Forecasts.Size(nForecast, x);
    x1.Size(nForecast, x);
    x1.Ramp(x.Last + 1, 1);

    Trend.Size(0);
    ARMAForecast(y, p, t, Residuals, nForecast, mu, Forecasts, fStdDev);

    DrawValues(x, Data, Series1);

    x1.Ramp(x.Last + 1, 1);
    Trend := b[1]*x1 + b[0];
    Forecasts := Forecasts + Trend;
    DrawValues(x1, Forecasts, Series2);

    x2.Size(x.Length + nForecast, x);
    x2.Ramp;

    Trend := b[1]*x2 + b[0];
    DrawValues(x2, Trend, Series3);

    aStrings.Add('Model: AR = [');
    P.ValuesToStrings(aStrings);
    aStrings.Add('], MA = [');
    T.ValuesToStrings(aStrings);
    aStrings.Add(']');
    aStrings.Add(', Y = ' + FormatSample('0.00', b[1]) + ' * x + ' + FormatSample('0.00', b[0]));

    aStrings.QuoteChar := ' ';
    aStrings.LineBreak := ' ';
    aStrings.Delimiter := ' ';

    ModelLabel.Caption := aStrings.DelimitedText;
end;

procedure TARMATrendForm.FormCreate(Sender: TObject);
begin
    ArmaModelBoxChange(nil);
end;

initialization
  RegisterClass(TARMATrendForm);

end.
