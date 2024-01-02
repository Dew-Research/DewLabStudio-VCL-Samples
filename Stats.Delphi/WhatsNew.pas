unit WhatsNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_REdit, StdCtrls, ComCtrls;

type
  TfrmWhatsNew = class(TfrmBaseRichEdit)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWhatsNew: TfrmWhatsNew;

implementation

{$R *.dfm}

procedure TfrmWhatsNew.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;


    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 6.2.0 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Delphi Athens 12.0');
    Add('Added ARIMA Trend decomposition example');
    Add('Bug fix for MannWhitneyTest');
    Add('Updated for MtxVec v6.2.0');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 6.1.0 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Rewritten the ARMA MLE fitting and the forecasting function used by ARIMA.');
    Add('Added an example for ARIMA fitting with trend decomposition.');
    Add('Updated for MtxVec v6.1 and Alexandria 11.1');

    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 6.0.5 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Delphi Alexandria 11.0');
    Add('Bug fix for Stepwise multiple regression when running with enabled assertions (debug mode).');
    Add('Fixed a bug when fitting parameters of the Fisher random distribution.');
    Add('Added vectorized version of the Fisher PDF.');
    Add('Running on Linux with hardware acceleration via MtxVec v6.0.5 and Intel OneAPI.');
    Add('Updated for MtxVec v6.0.5');

    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 6.0 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Linux with Rad Studio 10.4.');
    Add('Support for combined (either double or single) precision where meaningfull with MtxVec v6.');
    Add('Added new CDF and Inverse CDF for Studentized Range distribution.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 5.3 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Linux with Rad Studio 10.2 Tokyo.');
    Add('New multiple stepwise regression component.');
    Add('New vectorized multiple non-linear regression component.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 5.1 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Rad Studio 10.1 Berlin.');
    Add('Cross platform support for FireMonkey on iOS, OS X and Android.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 5.02 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Updated for MtxVec v5.02 (Performance Enhancements, Android support).');
    Add('Update to Stats demo for FireMonkey to run also on Android tablets.');
    Add('Support for Delphi XE8 and related TeeChart updates');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 4.5 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Delphi XE7');
    Add('Updated for MtxVec v4.5');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 4.4 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added support for FireMonkey including all UI controls, Demo and TeeChart support from including XE5 forward.');
    Add('Fixed double and tripple exponential smoothing.');
    Add('Fixed a potential round off error with two-level full factorial design.');
    Add('Added new faster overload for histogram computation.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 4.1 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Delphi XE2 32 and 64bit');
    Add('Updated for MtxVec v4.1');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 4.0 List of changes');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Statistics.pas, Regress.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Fixed GrubbsTest');
    Add('Fixed bug with RegressTest and Constant param');
    Add('Fixed bug with TBiPlot demo');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 3.5 (September 2008): List of changes');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Statistics.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Several changes in Covatiance and CorrCoef implementation (vectorized)');
    Add('Vectorization: Several routines have been vectorized.');
    Add('Added: Percentile - overload when multiple percentiles were needed from the same dataset.');
    Add('Added: MaxwellFit, LogisticFit routines.');
    Add('Fixed: several bugs in A-D test.');
    Add('Fixes: GOF Kolmogorov - fixed bug when two samples with different sizes were compared.');
    Add('Fixed: Hypothesis tests - hypothesis result when test statistics was Inf or Nan.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatRandom.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added: Maxwell and Logistic distribution  random number generators. Stat Master now supports 25 different random number generators.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Regress.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Fixed: Several bugs in RegressTest procedure.');
    Add('Added: Added Constant=true parameter to LinRegress routine.');
    Add('Added: More statistical parameters for TRegStats record.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatProbPlots.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Fixed: Q-Q plot when plotting only one dataset.');
    Add('Streamlined all probability plot rutines for simplified use.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('What''s new in Stats Master 3.0');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Improved random generators.');
    Add('Added Gumbel, Triangular, Erlang distribution random number generators.');
    Add('Changed implementation for all random generators to allow either use of '
      + 'MtxVec.Random.dll or "inhouse" simplified random generators.');
    Add('More examples, including C# an C++ examples.');
    Add('Added Chi-Squared distribution parameter estimate (ChiSquareFit).');
    Add('Added Cauchy distribution MLE parameter estimates (CauchyFit).');
    Add('Added Erlang distribution parameter estimates (ErlangFit).');
    Add('Added Laplace distribution MLE parameter estimates (LaplaceFit).');
    Add('Added Negative Binomial distribution parameter estimates (NegBinomFit).');
    Add('Expanded regression routines.');
    Add('Added PRESS and R2 functions.');
    Add('Several bug fixes.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('What''s new in Stats Master 2.1');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Several new routines for handling/manipulating time series.');
    Add('New tests for normal distribution, detecting outliers, etc.');
    Add('Improved examples and help files.');
    Add('Several bug fixes.');
    Add('Added Kolmogorov-Smirnov goodnes of fit test (one and two sample).');
    Add('Added empirical cumulative distribution function.');
    Add('Chi2 GOF test: added support for log-normal and uniform distribution.');
    Add('Added ZScores for vector.');
    Add('Added Bera-Jarque test of composite normality.');
    Add('Added Grubbs''s test for outliers.');
    Add('Several bugs in routine Histogram fixed.');
    Add('Added single moving average function.');
    Add('Added sigle, double and triple exponential smoothing routines.');
    Add('Added sigle, double and triple exponential forecasting routines.');
    Add('Added ARMA/ARIMA simulation routines.');
    Add('Added ARMA/ARIMA estimation (MLE) routines.');
    Add('Added ARMA/ARIMA forecasting routines.');
    Add('Added Yule-Walker AR coefficients estimation.');
    Add('Added Burg AR coefficients estimation.');
    Add('Added Innovations ARMA and MA coefficients estimation.');
    Add('Added innovations and Durbin-Levinson algorithms.');
    Add('Added ARAR model fitting and forecasting routines.');
    Add('Added Box-Cox and inverse Box-Cox transformation.');
    Add('Added rational model fit.');
    Add('Added logistic model fit.');
    Add('Added Poisson regression.');
    Add('Added tMtxBinaryTest component for performing one and two test(s) binary diagnostic test.');
    Add('Added several new examples demonstrating time series analysis routines.');

    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Size := 13;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('What''s new in Stats Master 2.0');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Compatible with MtxVec v2.');
    Add('Support for .NET.');
    Add('Support for SSE3 instruction set.');
    Add('Substantial increase in number of optimized primitive functions and methods via MtxVec v2.');
    Add('Improved range checking and programmer safety.');
    Add('Several bug fixes.');
    Add('Enhanced and more customizable routines.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
  end;
end;

procedure TfrmWhatsNew.FormDestroy(Sender: TObject);
begin
  RichEdit1.Lines.Clear;
  inherited;
end;

initialization
  RegisterClass(TfrmWhatsNew);

end.
