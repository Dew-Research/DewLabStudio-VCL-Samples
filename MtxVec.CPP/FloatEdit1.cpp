//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FloatEdit1.h"
#include "MtxExpr.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma link "MtxComCtrls"
#pragma resource "*.dfm"
TfrmFloatEdit1 *frmFloatEdit1;
//---------------------------------------------------------------------------
__fastcall TfrmFloatEdit1::TfrmFloatEdit1(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  str = "The TMtxFloatEdit component can be used to edit/view/change ";
  str+= "real or complex number. The control also includes runtime complex ";
  str+= "number format editor. You can invoke it with :";
  RichEdit1->Lines->Add(str);
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("holding the CTRL key and double clicking on TMtxFloatEdit control");
  RichEdit1->Lines->Add("in code by calling TMtxFloatEdit Execute method");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;

  MtxFloatEdit1->Value = "2+2i";
  MtxFloatEdit2->Value = "2+5i";
}
//---------------------------------------------------------------------------

void __fastcall TfrmFloatEdit1::Button1Click(TObject *Sender)
{
  Z1 = MtxFloatEdit1->CplxPosition;
  Z2 = MtxFloatEdit2->CplxPosition;
  if (Sender == Button1)
  {
	 Res = CMul(Z1, Z2);
  }
  else if (Sender == Button2) Res = CDiv(Z1,Z2);
  else if (Sender == Button3) Res = CAdd(Z1,Z2);
  else if (Sender == Button4) Res = CSub(Z1,Z2);
  Edit1->Text = CplxToStr(Res,2);
}
//---------------------------------------------------------------------------

void __fastcall TfrmFloatEdit1::Button5Click(TObject *Sender)
{
  MtxFloatEdit1->Execute(true);
}
//---------------------------------------------------------------------------

void __fastcall TfrmFloatEdit1::Button6Click(TObject *Sender)
{
  MtxFloatEdit2->Execute(true);
}
//---------------------------------------------------------------------------


