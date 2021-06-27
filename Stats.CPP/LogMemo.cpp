//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "LogMemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmLogForm *frmLogForm;
//---------------------------------------------------------------------------
__fastcall TfrmLogForm::TfrmLogForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmLogForm::Button1Click(TObject *Sender)
{
	Memo1->Lines->Clear();	
}
//---------------------------------------------------------------------------

