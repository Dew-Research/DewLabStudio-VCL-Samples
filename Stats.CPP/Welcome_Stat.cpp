//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Welcome_Stat.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_REdit"
#pragma resource "*.dfm"
TfrmWelcome *frmWelcome;
//---------------------------------------------------------------------------
__fastcall TfrmWelcome::TfrmWelcome(TComponent* Owner)
	: TfrmBaseRichEdit(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->DefAttributes->Size = 10;
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->SelAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(72,123,180);
	RichEdit1->Lines->Add("Welcome to Stats Master");
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("Stats Master is a (c) MtxVec Add-On library with many statistical and mathematical routines."
		"It comes with:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("25 different distributions random generators");
	RichEdit1->Lines->Add("Hypothesis testing");
	RichEdit1->Lines->Add("Analysis of variance");
	RichEdit1->Lines->Add("Principal component analysis");
	RichEdit1->Lines->Add("Linear and multiple linear regression");
	RichEdit1->Lines->Add("Non-linear regression");
	RichEdit1->Lines->Add("Special statistical plots");
	RichEdit1->Lines->Add("Quality control charts");
	RichEdit1->Lines->Add("Time series analysis and prediction");
	RichEdit1->Lines->Add("Easy-to-use set of components");
	RichEdit1->Lines->Add("and more...");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("Stats Master demonstrates how easy, fast and performance efficient it"
		" is to build advanced numerical algorithms with MtxVec. Many of the essential"
		" statistical routines presented in this package were not available to"
		" Delphi developers at all - until now.");
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("Navigate through the demo application, to learn more "
		"about Stats Master and experience it's unmatched "
		" performance and ease of use.");
}
//---------------------------------------------------------------------------
