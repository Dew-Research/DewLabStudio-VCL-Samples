//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroFunctionList.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroFunList *IntroFunList;
//---------------------------------------------------------------------------
__fastcall TIntroFunList::TIntroFunList(TComponent* Owner)
  : TBasicForm3(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style  = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Basic MtxVec package gives you:");
  RichEdit1->Lines-> Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Over 1200 well documented routines");
  RichEdit1->Lines->Add("Full support (where appropriate) for complex numbers");
  RichEdit1->Lines->Add("TMtx and TVec objects provide you with full matrix, vector and matrix-vector arithmetics");
  RichEdit1->Lines->Add("16 different probability functions (PDF,CDF and inverse CDF)");
  RichEdit1->Lines->Add("4 minimization algorithms (BGFS, Marquard, Simplex and Brent)");
  RichEdit1->Lines->Add("9 special functions (Bessel functions, elliptic integrals, …)");
  RichEdit1->Lines->Add("Math387 unit - it fully replaces and extends Delphi Math unit ");
  RichEdit1->Lines->Add("Polynomial handling routines (splines, piece-wise polynomials, polynomial root finding,..)");
  RichEdit1->Lines->Add("Symmetric multiprocessing support for up to 8 CPUs");
  RichEdit1->Lines->Add("Processor specific optimization");
  RichEdit1->Lines->Add("Multi-threading safe");
  RichEdit1->Lines->Add("Built-in dynamic memory allocation");
  RichEdit1->Lines->Add("Fee free tech support with 24h response");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------
