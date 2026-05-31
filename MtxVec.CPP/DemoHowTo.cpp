//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "DemoHowTo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TfrmDemoHowTo *frmDemoHowTo;
//---------------------------------------------------------------------------
__fastcall TfrmDemoHowTo::TfrmDemoHowTo(TComponent* Owner)
  : TBasicForm3(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmDemoHowTo::FormCreate(TObject *Sender)
{
  TBasicForm3::FormCreate(Sender);

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Usage instructions for the demo app:");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("You can see the source code of each form by pressing the \"Source Code\" tab at the bottom of the form.");
  RichEdit1->Lines->Add("Each form can be recompiled as a standalone application. All you have to do is add the form to a newly created project and press F9.");
  RichEdit1->Lines->Add("There are no code dependancies between individual forms. Each form is a standalone working application and entire source required to implement the behaviour is implemented in that one unit.");
  RichEdit1->Lines->Add("Many forms have usage instructions at the top of the window.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
}
//---------------------------------------------------------------------------
