//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBasicForm1 *BasicForm1;
//---------------------------------------------------------------------------
__fastcall TBasicForm1::TBasicForm1(TComponent* Owner)
	: TForm(Owner)
{
	RichEdit1->Lines->Clear();
}
void __fastcall TBasicForm1::SetDownSize(bool Value)
{
	FDownSize = Value;
}

//---------------------------------------------------------------------------
void __fastcall TBasicForm1::CheckDownSampleClick(TObject *Sender)
{
	FDownSize = CheckDownSample->Checked;
	Chart1->AllowZoom = !CheckDownSample->Checked;
}
//---------------------------------------------------------------------------
