//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBasicForm2 *BasicForm2;
//---------------------------------------------------------------------------
__fastcall TBasicForm2::TBasicForm2(TComponent* Owner)
  : TForm(Owner)
{
  RichEdit1->Lines->Clear();
}
//---------------------------------------------------------------------------

