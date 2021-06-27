//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroDesign.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroDesignForm *IntroDesignForm;
//---------------------------------------------------------------------------
__fastcall TIntroDesignForm::TIntroDesignForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->DefAttributes->Size = 12;
	RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->Lines->Add("Architecture of the library is organized in three layers: ");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Complete set of signal processing routines based on MtxVec.");
	RichEdit1->Lines->Add("With a set of components based on signal processing routines "
		" your application gets a jump start in user interface and processing power.");
	RichEdit1->Lines->Add("Connectivity layer gives you the capability to visually programm " 
		"DSP algorithm's by connecting components.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;

}
//---------------------------------------------------------------------------
