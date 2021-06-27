//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroHigherSpectral.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroHigherSpectralForm *IntroHigherSpectralForm;
//---------------------------------------------------------------------------
__fastcall TIntroHigherSpectralForm::TIntroHigherSpectralForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
		RichEdit1->Lines->Clear();
		RichEdit1->DefAttributes->Size = 12;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 14;
		RichEdit1->Lines->Add("Make use of higher order spectral analysis:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Compute bispectrum and/or bicoherence of real and complex signals");
		RichEdit1->Lines->Add("Compute bicoherence for only preselected frequency pairs");
		RichEdit1->Lines->Add("View bicoherence in real time with running average");
		RichEdit1->Lines->Add("Supports spectrum sizes with more then 16384 lines for preselected frequency pairs");
		RichEdit1->Lines->Add("Full set of peak marking/tracking features");
		RichEdit1->Lines->Add("Frequency band statistics");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;

}
//---------------------------------------------------------------------------
