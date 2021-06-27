//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Changes11.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_REdit"
#pragma resource "*.dfm"
TfrmChanges11 *frmChanges11;
//---------------------------------------------------------------------------
__fastcall TfrmChanges11::TfrmChanges11(TComponent* Owner)
	: TfrmBaseRichEdit(Owner)
{
		RichEdit1->SelAttributes->Size = 14;
//		RichEdit1->SelAttributes->Color = RGB(72,123,180);
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
		RichEdit1->Lines->Add("Release 1.1: List of changes");
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("Statistics.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Added Chi-Squared and F tests for comparing variance(s).");
		RichEdit1->Lines->Add("Added Spearman rank correlation test.");
		RichEdit1->Lines->Add("Added LogNormalFit routine for fitting log-normally distributed values.");
		RichEdit1->Lines->Add("Fixed the internal TiedRank routine (in some special cases ranks were not calculated correctly) "
			"and moved it to public section.");
		RichEdit1->Lines->Add("Added autocovariance, autocorrelation and partial autocorellation functions.");
		RichEdit1->Lines->Add("Added Chi2 Goodness of fit test routines.");
		RichEdit1->Lines->Add("Added Shapiro-Wilks and Shapiro-Francia Goodness of fit test routines.");
		RichEdit1->Lines->Add("Minor bug fixes.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("StatSeries.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Added control limits calculation for R-Chart.");
		RichEdit1->Lines->Add("Added EWMA chart calculation.");
		RichEdit1->Lines->Add("Removed the probability axis tool. Now the relevant code is included "
			"in probability series (simplified code - see updated example in Statistics demo).");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("Regress.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Fixed R2 calculation for Constant = false case.");
		RichEdit1->Lines->Add("Added logistic (simple and ordinal) regression routines.");
		RichEdit1->Lines->Add("Minor bug fixes");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("StatTools.pas");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("New TMtxLogistReg component which encapsulates "
			 "logistic regression routines.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit1->Lines->Add("StatARIMA.pas (ALPHA VERSION, NOT YET OFFICIALLY SUPPORTED)");
		RichEdit1->Lines->Add("");
		RichEdit1->Lines->Add("New unit which introduces several routines for ARMA and ARIMA processes. "
			 "These routines are still in testing and not yet fully developed. This goes for "
			 "EstimateArima and PredictArima routines.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");

}
//---------------------------------------------------------------------------
