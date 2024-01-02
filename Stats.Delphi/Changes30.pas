unit Changes30;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic_REdit, StdCtrls, ComCtrls;

type
  TfrmChanges30 = class(TfrmBaseRichEdit)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChanges30: TfrmChanges30;

implementation

{$R *.dfm}

procedure TfrmChanges30.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1, RichEdit1.Lines do
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
    Add('Release 6.0.5 List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Delphi Alexandria 11.0');
    Add('Support for combined (either double or single) precision where meaningfull.');
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

    SelAttributes.Size := 14;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 4.1 (September 2011): List of changes');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Support for Delphi XE2, 32bit and 64bit compiler');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 14;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 4.0 (June 2010): List of changes');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Statistics.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Fixed GrubbsTest');
    Add('Fixed bug with RegressTest and Constant param');
    Add('Fixed bug with TBiPlot demo');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');

    SelAttributes.Size := 14;
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

    SelAttributes.Size := 14;
    SelAttributes.Color := RGB(72,123,180);
    SelAttributes.Style := [fsBold];
    Add('Release 3.0 (June 2007): List of changes');
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Statistics.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Expanded and moved all MV*** routines to Probabilities.pas.');
    Add('Moved ACF,PACF,AutoCov routines to StatTimeSerAnalysis.pas unit.');
    Add('Added Chi-Squared distribution parameter estimate (ChiSquareFit).');
    Add('Added Cauchy distribution MLE parameter estimates (CauchyFit).');
    Add('Added Erlang distribution parameter estimates (ErlangFit).');
    Add('Added Laplace distribution MLE parameter estimates (LaplaceFit).');
    Add('Added Negative Binomial distribution parameter estimates (NegBinomFit).');
    Add('Anderson-Darling normal distribution p value now calculated correctly by using saddlepoint approximation.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('Regress.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added PRESS and R2 functions.');
    Add('Added optimal Ridge Regress k calculation (using minimal MSE).');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('StatRandom.pas');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('Added Gumbel, Triangular, Erlang distribution random number generators.');
    Add('Changed implementation for all random generators to allow either use of '
      + 'MtxVec.Random.dll or "inhouse" simplified random generators.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
    Add('Help files and examples');
    Add('');
    Paragraph.Numbering := nsBullet;
    Paragraph.FirstIndent := 10;
    Add('All examples now include Delphi, C++ and C# personalities.');
    Paragraph.Numbering := nsNone;
    Paragraph.FirstIndent := 0;
    Add('');
  end;
end;

initialization
  RegisterClass(TfrmChanges30);

end.
