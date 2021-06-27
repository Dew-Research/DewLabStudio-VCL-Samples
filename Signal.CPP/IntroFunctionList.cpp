//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroFunctionList.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroFunList *IntroFunList;
//---------------------------------------------------------------------------
__fastcall TIntroFunList::TIntroFunList(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->LoadFromFile(ExtractFilePath(Application->ExeName)+"\\Routines.rtf");
}
//---------------------------------------------------------------------------
