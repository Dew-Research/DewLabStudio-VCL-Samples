//---------------------------------------------------------------------------

#include <vcl.h>

#pragma hdrstop
#include "ClipboardMSOffice.h"

#include "MtxVecEdit.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TMSOffice *MSOffice;
//---------------------------------------------------------------------------
__fastcall TMSOffice::TMSOffice(TComponent* Owner)
  : TBasicForm2(Owner)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add("MtxVecEdit form allows you to export/import TVec or TMtx values to MSOffice (Excel, Word) programs.");
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->Lines->Add("Copying values to Excel (Word):");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Lines->Add("1)	Click on the 'MtxVec->Excel' button");
  RichEdit1->Lines->Add("2)	Select 'Copy' from the 'Edit' menu");
  RichEdit1->Lines->Add("3)	Go to Excel and select 'Edit->Paste' menu item.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->Lines->Add("Pasting values from Word:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Lines->Add("1)	Go to Word and create 2x2 table,");
  RichEdit1->Lines->Add("2)	Enter values: '+1+2i, 0+2i, 3+1i, 2+0i'");
  RichEdit1->Lines->Add("3)	Select table and copy it to clipboard");
  RichEdit1->Lines->Add("4)	Click on the ""Word->MtxVec"" button");
  RichEdit1->Lines->Add("5)	Select 'Edit->Paste' menu. As you can see, complex values are copied to TMtx.");
}
//---------------------------------------------------------------------------

void __fastcall TMSOffice::Button1Click(TObject *Sender)
{
  AMtx.Size(5,4,false);
  AMtx.RandGauss(3,1);
  ViewValues(AMtx,"Exporting to Excel",true,false,false);
}
//---------------------------------------------------------------------------

void __fastcall TMSOffice::Button2Click(TObject *Sender)
{
  // initialize to zero
  AMtx.SetZero();
  ViewValues(AMtx,"Importing from Word",true,false,false);
}
//---------------------------------------------------------------------------

