//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "RegisterSignal.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TRegisterSignalForm *RegisterSignalForm;
//---------------------------------------------------------------------------
__fastcall TRegisterSignalForm::TRegisterSignalForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
	RichEdit1->Lines->LoadFromFile(ExtractFilePath(Application->ExeName)+"\\RegisterSignal.rtf");
}
//---------------------------------------------------------------------------
