//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroApplication.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroApplicationForm *IntroApplicationForm;
//---------------------------------------------------------------------------
__fastcall TIntroApplicationForm::TIntroApplicationForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->DefAttributes->Size = 12;
	RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
	RichEdit1->SelAttributes->Size = 14;
	RichEdit1->Lines->Add("Building applications:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("All key components have ready to use user dialogs.");
	RichEdit1->Lines->Add("All components support streaming of their states and/or data "
		"to and from TStream. Partial or complete application configuration "
		"can be saved or restored instantly.");
	RichEdit1->Lines->Add("With only a few drop-in components a signal analysis "
		"application with complete user interface can be built!");
	RichEdit1->Lines->Add("Real-time and off-line processing.");
	RichEdit1->Lines->Add("By changing a DEFINE statement the application can be recompiled "
		"in double or single precision!");
	RichEdit1->Lines->Add("Instant support for latest CPU architectures via dll update!");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;

}
//---------------------------------------------------------------------------
