//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroPerformance.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroPerformanceForm *IntroPerformanceForm;
//---------------------------------------------------------------------------
__fastcall TIntroPerformanceForm::TIntroPerformanceForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->DefAttributes->Size = 12;
	RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->Lines->Add("Optimal signal processing performance is ensured with: ");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("CPU specific support and code optimization. Exceptional performance for AVX512 systems.");
	RichEdit1->Lines->Add("Data is processed in \"blocks\". This allows highly efficient optimization of tight loops.");
	RichEdit1->Lines->Add("Ultra fast decimation and interpolation algorithm with multi-rate, multi-stage, half-band filters.");
	RichEdit1->Lines->Add("Most of the routines are vectorized and can take advantage of AVX, AVX2  and AVX512 instruction sets.");

	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
}
//---------------------------------------------------------------------------
