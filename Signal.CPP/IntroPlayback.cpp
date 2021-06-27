//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroPlayback.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroPlaybackForm *IntroPlaybackForm;
//---------------------------------------------------------------------------
__fastcall TIntroPlaybackForm::TIntroPlaybackForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->DefAttributes->Size = 12;
	RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->Lines->Add("Playback and record:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("96kHz/24 bit extensible audio format support.");
	RichEdit1->Lines->Add("8,16,24 and 32 bit support for reading/writing, playback/recording");
	RichEdit1->Lines->Add("Arbitrary sampling frequency.");
	RichEdit1->Lines->Add("Multichannel audio card support.");
	RichEdit1->Lines->Add("Audio compression manager support when reading wav files.");
	RichEdit1->Lines->Add("Real time signal monitor during playback and recording.");
	RichEdit1->Lines->Add("Triggering support with pre-trigger, post-trigger,..");
	RichEdit1->Lines->Add("Configurable display delay and skip protection for trigger and monitoring.");
	RichEdit1->Lines->Add("Full access to audio buffers.");
	RichEdit1->Lines->Add("Additional binary/text file format support.");
	RichEdit1->Lines->Add("Ready to use user interface instantly adds playback/recording capabilities to any application.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;

}
//---------------------------------------------------------------------------
