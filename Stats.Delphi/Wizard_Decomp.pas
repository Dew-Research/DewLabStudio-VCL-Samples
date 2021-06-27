unit Wizard_Decomp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_Form, StdCtrls, ExtCtrls;

type
  TfrmDecompDemo = class(TfrmBasic)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDecompDemo: TfrmDecompDemo;

implementation

Uses DecompWizard;

{$R *.dfm}

procedure TfrmDecompDemo.FormCreate(Sender: TObject);
begin
  inherited;
  With Memo1.Lines do
  begin
    Clear;
    Add('Decomposition forecasting');
    Add(chr(13));
    Add('Classical time series decomposition separates a time series into five components: mean, long-range trend, seasonality, cycle, and randomness. ' +
      'The decomposition model is:');
    Add('Value = (Mean) x (Trend) x (Seasonality) x (Cycle) x (Random).');
    Add('Note that this model is multiplicative rather than additive. Although additive models are more popular in other areas of statistics, forecasters '+
      'have found that the multiplicative model fits a wider range of forecasting situations.');
    Add('Decomposition is popular among forecasters because it is easy to understand (and explain to others). While complex ARIMA models are often ' +
      'popular among statisticians, they are not as well accepted among forecasting practitioners. For seasonal (monthly, weekly, or quarterly) data, ' +
      'decomposition methods are often as accurate as the ARIMA methods and they provide additional information about the trend and cycle which may ' +
      'not be available in ARIMA methods.');
    Add('Decomposition has one disadvantage: the cycle component must be input by the forecaster since it is not estimated by the algorithm. You can ' +
      'get around this by ignoring the cycle, or by assuming a constant value. Some forecasters consider this a strength because it allows the forecaster '+
      'to enter information about the current business cycle into the forecast.');
  end;

  With TfrmDecompositionWizard.Create(Self) do
  begin
    Align := alClient;
    Parent := Self;
    BorderStyle := bsNone;
    BtnCancel.Visible := false; { in this case hide Cancel button }
    { load prepared data }
    TimeSeries.LoadFromFile('airpass.vec');
    Show();
  end;
end;

initialization
  RegisterClass(TfrmDecompDemo);

end.
