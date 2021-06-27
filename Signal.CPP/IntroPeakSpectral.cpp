//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroPeakSpectral.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroPeakSpectralForm *IntroPeakSpectralForm;
//---------------------------------------------------------------------------
__fastcall TIntroPeakSpectralForm::TIntroPeakSpectralForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->DefAttributes->Size = 12;
	RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->Lines->Add("Frequency spectrum peak analysis:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("6 methods for frequency and amplitude interpolation: "
		"Numeric, Quadratic, Barycentric, Quinn's First, Quinn's second, Jain's");
	RichEdit1->Lines->Add("Auto find peaks in the frequency spectrum: largest, harmonics or retrace existing");
	RichEdit1->Lines->Add("Add and delete peak marks on the fly with a dedicated TeeTool");
	RichEdit1->Lines->Add("Peak order tracking");
	RichEdit1->Lines->Add("Limit search for peaks within a frequency band");
	RichEdit1->Lines->Add("Link RMS calculation of frequency bands to peak position");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
}
//---------------------------------------------------------------------------
