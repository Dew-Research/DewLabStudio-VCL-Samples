//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Intro.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroduction *Introduction;
//---------------------------------------------------------------------------
__fastcall TIntroduction::TIntroduction(TComponent* Owner)
	: TForm(Owner)
{
		RichEdit1->Lines->Clear();
		RichEdit1->SelAttributes->Color = (TColor) RGB(226,226,226);
		RichEdit1->SelAttributes->Size = 14;
		RichEdit1->Lines->Add("Welcome to DSP Master");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Written entirely with MtxVec and taking advantage of full vector/matrix design.");
		RichEdit1->Lines->Add("Supports signal processing algorithms in streaming or single block mode.");
		RichEdit1->Lines->Add("Features a large set of ready to use components covering digital filter design and frequency analysis.");
		RichEdit1->Lines->Add("Visually connect signal processing components to form signal processing pipes capable of streaming.");
		RichEdit1->Lines->Add("Supports multichannel, aribtrary sampling frequency, complex or real, double or single precision, signal processing.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsItalic;
		RichEdit1->Lines->Add("\"MtxVec was created to help shorten the development time of commercial scientific applications.\"");
		RichEdit1->Lines->Add("");
		RichEdit1->Lines->Add("Navigate through the demo application, to learn more about DSP for MtxVec.");
}

//---------------------------------------------------------------------------
