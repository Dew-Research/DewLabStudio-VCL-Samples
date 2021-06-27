//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroPolynoms.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroPoly *IntroPoly;
//---------------------------------------------------------------------------
__fastcall TIntroPoly::TIntroPoly(TComponent* Owner)
  : TBasicForm3(Owner)
{

//  TBasicForm3::FormCreate(Sender); // inherited

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Robust polynomials handling methods:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Polynomial evaluation, root finding");
  RichEdit1->Lines->Add("Piece-wise polynomials");
  RichEdit1->Lines->Add("Fast cubic spline algorithm");
  RichEdit1->Lines->Add("Linear or cubic interpolation");
  RichEdit1->Lines->Add("Fit high order polynomials to data");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------

 