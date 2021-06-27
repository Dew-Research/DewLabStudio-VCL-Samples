//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroSignal.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroSignalForm *IntroSignalForm;
//---------------------------------------------------------------------------
__fastcall TIntroSignalForm::TIntroSignalForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->DefAttributes->Size = 12;
	RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->Lines->Add("A wide range of signal filtering routines includes:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Elliptic,Butterworth and Chebyshev filter designers");
	RichEdit1->Lines->Add("Parks-McClellan optimal FIR filter design routine");
	RichEdit1->Lines->Add("Savitzky-Golay polynomial FIR filter");
	RichEdit1->Lines->Add("Multi-rate, multi-stage decimation and interpolation filters");
	RichEdit1->Lines->Add("Envelope detection/amplitude demodulation");
	RichEdit1->Lines->Add("Zoom-spectrum filter");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
}
//---------------------------------------------------------------------------
