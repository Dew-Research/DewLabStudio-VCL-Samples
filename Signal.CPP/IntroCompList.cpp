//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroCompList.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroCompListForm *IntroCompListForm;
//---------------------------------------------------------------------------
__fastcall TIntroCompListForm::TIntroCompListForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->LoadFromFile(ExtractFilePath(Application->ExeName)+"\\Components.rtf");
}
//---------------------------------------------------------------------------
