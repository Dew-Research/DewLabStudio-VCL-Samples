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
    RichEdit1->Lines->Clear();
}
//---------------------------------------------------------------------------

