//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroVectors.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroVec *IntroVec;
//---------------------------------------------------------------------------
__fastcall TIntroVec::TIntroVec(TComponent* Owner)
  : TBasicForm3(Owner)
{
//  TBasicForm3::FormCreate(Sender);

  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Vector operations:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Real and complex FFT");
  RichEdit1->Lines->Add("Auto and cross correlations");
  RichEdit1->Lines->Add("Convolution and filtering");
  RichEdit1->Lines->Add("Complete vector arithmetic");
  RichEdit1->Lines->Add("Sorting real and complex numbers");
  RichEdit1->Lines->Add("Random generators");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------

