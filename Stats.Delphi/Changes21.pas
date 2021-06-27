unit Changes21;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_REdit, StdCtrls, ComCtrls;

type
  TfrmChanges21 = class(TfrmBaseRichEdit)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var                                                         
  frmChanges21: TfrmChanges21;

implementation

{$R *.dfm}

procedure TfrmChanges21.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1, RichEdit1.Lines do
  begin
    Clear;
    SelAttributes.Size := 14;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 2.1 (June 2006): List of changes');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Statistics.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added Hotelling T2 one or two sample test.');
    Add('Added M-Box test for equal covariance matrices.');
    Add('Added Mann--Whitney U test.');
    Add('Added Metric (classical) Multidimensional Scaling routine.');
    Add('Added Cronbach Alpha coefficient routine (Item Analysis).');
    Add('Added Latin Hypercube DOE.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Regress.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added Principal Component Regression (PCR).');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatSeries.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added TBiPlotSeries.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Size := 14;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 2.1 (March 2006): List of changes');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Statistics.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added Kolmogorov-Smirnov goodnes of fit test (one and two sample).');
    Add('Added empirical cumulative distribution function.');
    Add('Chi2 GOF test: added support for log-normal and uniform distribution.');
    Add('Added ZScores for vector.');
    Add('Added Bera-Jarque test to normal distribution.');
    Add('Added Lilliefors test to normal distribution.');
    Add('Added Grubb''s test for outliers.');
    Add('Fixed several bugs in Histogram routine.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatTimeSerAnalysis.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added sigle, double and triple exponential smoothing routines.');
    Add('Added single, double and triple exponential forecasting routines.');
    Add('Added single moving average function.');
    Add('Added ARMA/ARIMA simulation routines.');
    Add('Added ARMA/ARIMA forecasting routines.');
    Add('Added ARMA/ARIMA predicting (MLE) routines.');
    Add('Added Yule-Walker and Burg AR coefficients estimation.');
    Add('Added innovations ARMA and MA coefficients estimation.');
    Add('Added innovations and Durbin-Levinson algorithms.');
    Add('Added ARAR model fitting and forecasting routines.');
    Add('Added Box-Cox and inverse Box-Cox transformation.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('RegModels.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added rational fit model.');
    Add('Added logistic fit model.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Regress.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added Poisson regression.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatTools.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added TMtxBinaryTest component for performing one and two test(s) binary diagonstic test.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatControlCharts.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added Levey-Jennings Westgard rules check.');
    Add('Added CumSum QC chart.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
  end;

end;

initialization
  RegisterClass(TfrmChanges21);

end.
