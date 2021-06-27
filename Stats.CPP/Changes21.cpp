//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Changes21.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_REdit"
#pragma link "MtxBaseComp"
#pragma link "MtxVecTools"
#pragma link "StatTools"
#pragma resource "*.dfm"
TfrmChanges21 *frmChanges21;
//---------------------------------------------------------------------------
__fastcall TfrmChanges21::TfrmChanges21(TComponent* Owner)
	: TfrmBaseRichEdit(Owner)
{
		RichEdit1->SelAttributes->Size = 14;
//		RichEdit1->SelAttributes->Color = RGB(72,123,180);
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
		RichEdit1->Lines->Add("Release 2.1 (March 2006): List of changes");
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("Statistics.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Added Kolmogorov-Smirnov goodnes of fit test (one and two sample).");
		RichEdit1->Lines->Add("Added empirical cumulative distribution function.");
		RichEdit1->Lines->Add("Chi2 GOF test: added support for log-normal and uniform distribution.");
		RichEdit1->Lines->Add("Added ZScores for vector.");
		RichEdit1->Lines->Add("Added Bera-Jarque test to normal distribution.");
		RichEdit1->Lines->Add("Added Lilliefors test to normal distribution.");
		RichEdit1->Lines->Add("Added Grubb""s test for outliers.");
		RichEdit1->Lines->Add("Fixed several bugs in Histogram routine.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("StatTimeSerAnalysis.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Added sigle, double and triple exponential smoothing routines.");
		RichEdit1->Lines->Add("Added single, double and triple exponential forecasting routines.");
		RichEdit1->Lines->Add("Added single moving average function.");
		RichEdit1->Lines->Add("Added ARMA/ARIMA simulation routines.");
		RichEdit1->Lines->Add("Added ARMA/ARIMA forecasting routines.");
		RichEdit1->Lines->Add("Added ARMA/ARIMA predicting (MLE) routines.");
		RichEdit1->Lines->Add("Added Yule-Walker and Burg AR coefficients estimation.");
		RichEdit1->Lines->Add("Added innovations ARMA and MA coefficients estimation.");
		RichEdit1->Lines->Add("Added innovations and Durbin-Levinson algorithms.");
		RichEdit1->Lines->Add("Added ARAR model fitting and forecasting routines.");
		RichEdit1->Lines->Add("Added Box-Cox and inverse Box-Cox transformation.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("RegModels.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Added rational fit model.");
		RichEdit1->Lines->Add("Added logistic fit model.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("Regress.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Added Poisson regression->");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("StatTools.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Added TMtxBinaryTest component for performing one and two test(s) binary diagonstic test.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
}
//---------------------------------------------------------------------------
