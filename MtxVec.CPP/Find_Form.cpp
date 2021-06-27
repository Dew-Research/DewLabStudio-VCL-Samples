//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Find_Form.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmFind *frmFind;
//---------------------------------------------------------------------------
__fastcall TfrmFind::TfrmFind(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmFind::FormClose(TObject *Sender, TCloseAction &Action)
{
  FindText = Edit1->Text;
  FindAll = CheckBox1->Checked;
}
//---------------------------------------------------------------------------
