//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "WhatsNew.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_REdit"
#pragma resource "*.dfm"
TfrmWhatsNew *frmWhatsNew;
//---------------------------------------------------------------------------
__fastcall TfrmWhatsNew::TfrmWhatsNew(TComponent* Owner): TfrmBaseRichEdit(Owner)
{
	RichEdit1->Lines->Clear();

	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("What's new in Stats Master v6");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Support for Rad Studio 10.4.");
	RichEdit1->Lines->Add("Support for combined (either double or single) precision where meaningfull with MtxVec v6.");
	RichEdit1->Lines->Add("New multiple stepwise regression component.");
	RichEdit1->Lines->Add("New vectorized multiple non-linear regression component.");
	RichEdit1->Lines->Add("Support for Linux");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");

	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("What's new in Stats Master v5");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Updated for MtxVec v5");
	RichEdit1->Lines->Add("Cross platform support with FireMonkey for OS X, iOS and Android.");
	RichEdit1->Lines->Add("Support for Rad Studio 10.1 Berlin");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");


	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("New features and changes for v4.5 (September 2014)");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;

	RichEdit1->Lines->Add("Added support for XE7.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");

	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("New features and changes for v4.4 (February 2014)");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;

	RichEdit1->Lines->Add("Added support for FireMonkey including all UI controls, Demo and TeeChart support from including XE5 forward.");
	RichEdit1->Lines->Add("Fixed double and tripple exponential smoothing.");
	RichEdit1->Lines->Add("Fixed a potential round off error with two-level full factorial design.");
	RichEdit1->Lines->Add("Added new faster overload for histogram computation.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");


	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("What's new in Stats Master 4.1");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;

	RichEdit1->Lines->Add("Support for Delphi XE2 32 and 64bit");
	RichEdit1->Lines->Add("Updated for MtxVec v4.1");
	RichEdit1->Lines->Add("Fixed GrubbsTest");
	RichEdit1->Lines->Add("Fixed bug with RegressTest and Constant param");
	RichEdit1->Lines->Add("Fixed bug with TBiPlot demo");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");

	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);

	RichEdit1->Lines->Add("What's new in Stats Master 3.5");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Percentile: Added overload when multiple percentiles were needed from the same dataset.");
	RichEdit1->Lines->Add("Vectorization: Several routines have been vectorized.");
	RichEdit1->Lines->Add("Added: MaxwellFit, LogisticFit. FFit, StudentFit routines.");
	RichEdit1->Lines->Add("Several changes in Covatiance and CorrCoef implementation (vectorized).");
	RichEdit1->Lines->Add("Fixed: several bugs in A-D test.");
	RichEdit1->Lines->Add("Fixed: GOF Kolmogorov - fixed bug when two samples with different sizes were compared.");
	RichEdit1->Lines->Add("Fixed: Hypothesis tests - hypothesis result when test statistics was Inf or Nan.");
	RichEdit1->Lines->Add("Added: Maxwell and Logistic distribution  random number generators. Stat Master now supports 25 different random number generators.");
	RichEdit1->Lines->Add("Fixed: Q-Q plot when plotting only one dataset.");
	RichEdit1->Lines->Add("Streamlined all probability plot rutines for simplified use.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");

	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("What's new in Stats Master 3.0");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Improved random generators.");
	RichEdit1->Lines->Add("Added Gumbel, Triangular, Erlang distribution random number generators.");
	RichEdit1->Lines->Add("Changed implementation for all random generators to allow either use of MtxVec.Random.dll or ""inhouse"" simplified random generators.");
	RichEdit1->Lines->Add("More examples, including C# an C++ examples.");
	RichEdit1->Lines->Add("Added Chi-Squared distribution parameter estimate (ChiSquareFit).");
	RichEdit1->Lines->Add("Added Cauchy distribution MLE parameter estimates (CauchyFit).");
	RichEdit1->Lines->Add("Added Erlang distribution parameter estimates (ErlangFit).");
	RichEdit1->Lines->Add("Added Laplace distribution MLE parameter estimates (LaplaceFit).");
	RichEdit1->Lines->Add("Added Negative Binomial distribution parameter estimates (NegBinomFit).");
	RichEdit1->Lines->Add("Expanded regression routines.");
	RichEdit1->Lines->Add("Added PRESS and R2 functions.");
	RichEdit1->Lines->Add("ML regresion now support LQR, SVD or LU solving method.");
	RichEdit1->Lines->Add("Several bug fixes.");
	RichEdit1->Lines->Add("Anderson-Darling normality test now returns correct P values.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");

	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("What's new in Stats Master 2.1");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Several new routines for handling/manipulating time series.");
	RichEdit1->Lines->Add("New tests for normal distribution, detecting outliers, etc.");
	RichEdit1->Lines->Add("Improved examples and help files.");
	RichEdit1->Lines->Add("Several bug fixes.");
	RichEdit1->Lines->Add("Added Kolmogorov-Smirnov goodnes of fit test (one and two sample).");
	RichEdit1->Lines->Add("Added empirical cumulative distribution function.");
	RichEdit1->Lines->Add("Chi2 GOF test: added support for log-normal and uniform distribution.");
	RichEdit1->Lines->Add("Added ZScores for vector.");
	RichEdit1->Lines->Add("Added Bera-Jarque test of composite normality.");
	RichEdit1->Lines->Add("Added Grubbs""s test for outliers.");
	RichEdit1->Lines->Add("Several bugs in routine Histogram fixed.");
	RichEdit1->Lines->Add("Added single moving average function.");
	RichEdit1->Lines->Add("Added sigle, double and triple exponential smoothing routines.");
	RichEdit1->Lines->Add("Added sigle, double and triple exponential forecasting routines.");
	RichEdit1->Lines->Add("Added ARMA/ARIMA simulation routines.");
	RichEdit1->Lines->Add("Added ARMA/ARIMA estimation (MLE) routines.");
	RichEdit1->Lines->Add("Added ARMA/ARIMA forecasting routines.");
	RichEdit1->Lines->Add("Added Yule-Walker AR coefficients estimation.");
	RichEdit1->Lines->Add("Added Burg AR coefficients estimation.");
	RichEdit1->Lines->Add("Added Innovations ARMA and MA coefficients estimation.");
	RichEdit1->Lines->Add("Added innovations and Durbin-Levinson algorithms.");
	RichEdit1->Lines->Add("Added ARAR model fitting and forecasting routines.");
	RichEdit1->Lines->Add("Added Box-Cox and inverse Box-Cox transformation.");
	RichEdit1->Lines->Add("Added rational model fit.");
	RichEdit1->Lines->Add("Added logistic model fit.");
	RichEdit1->Lines->Add("Added Poisson regression.");
	RichEdit1->Lines->Add("Added tMtxBinaryTest component for performing one and two test(s) binary diagnostic test.");
	RichEdit1->Lines->Add("Added several new examples demonstrating time series analysis routines.");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");

	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("What's new in Stats Master 2.0");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Compatible with MtxVec v2.");
	RichEdit1->Lines->Add("Support for .NET.");
	RichEdit1->Lines->Add("Support for SSE3 instruction set.");
	RichEdit1->Lines->Add("Substantial increase in number of optimized primitive functions and methods via MtxVec v2.");
	RichEdit1->Lines->Add("Improved range checking and programmer safety.");
	RichEdit1->Lines->Add("Several bug fixes.");
	RichEdit1->Lines->Add("Enhanced and more customizable routines.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");
	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;

}
//---------------------------------------------------------------------------
