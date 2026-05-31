//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic3.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "MtxBaseComp"
//#pragma link "MtxVecTools"
//#pragma link "MtxComCtrls"
//#pragma link "MtxVecDBTools"
#pragma resource "*.dfm"
TBasicForm3 *BasicForm3;
//---------------------------------------------------------------------------
__fastcall TBasicForm3::TBasicForm3(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TBasicForm3::FormCreate(TObject *Sender)
{
    RichEdit1->Lines->Clear();
    RichEdit1->DefAttributes->Size = 10;
    RichEdit1->DefAttributes->Style = TFontStyles();
}
//---------------------------------------------------------------------------

