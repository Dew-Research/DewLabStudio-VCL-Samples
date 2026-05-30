//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "IntroParser.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroParserForm *IntroParserForm;
//---------------------------------------------------------------------------
__fastcall TIntroParserForm::TIntroParserForm(TComponent* Owner)
  : TBasicForm3(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TIntroParserForm::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Math expression evaluator features:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Support for real and complex numbers");
  RichEdit1->Lines->Add("Support for vectors and matrices");
  RichEdit1->Lines->Add("Many matrix operations are multithreaded");
  RichEdit1->Lines->Add("Most built-in vectorized functions are optimized for SSE2/SSE3");
  RichEdit1->Lines->Add("Performance of vectorized expression evaluation is 10 to 20x higher than classical expression parsers.");
  RichEdit1->Lines->Add("It can solve systems of linear equations, do QR or LQ compositions.");
  RichEdit1->Lines->Add("Operator support for per element and matrix/vector operations");
  RichEdit1->Lines->Add("Complete set of standard math routines (Log, Power, Sin,...)");
  RichEdit1->Lines->Add("Very fast also when evaluating not vectorized expressions");
  RichEdit1->Lines->Add("Constant expressions evaluated during the parsing stage");
  RichEdit1->Lines->Add("You can add user defined variables, constants, functions and operators");
  RichEdit1->Lines->Add("Custom functions can be object methods.");
  RichEdit1->Lines->Add("Functions can be overloaded allowing same name but different param count.");
  RichEdit1->Lines->Add("Vectors and matrices can be accessed by elements a(i) or m(r,c).");
  RichEdit1->Lines->Add("Function parameters and results can be string types.");
  RichEdit1->Lines->Add("Colon operator allows selection of ranges of rows and colums m(:), m(1,:), v(2:3)");
  RichEdit1->Lines->Add("Assign operator supports colon operator: m(2:3) = 4");
  RichEdit1->Lines->Add("Colon operator supports step <> 1 and allows: m(10:-1:3) = 4");
  RichEdit1->Lines->Add("Vectors and matrices can return elements from conditions: a = m(m > 4)");
  RichEdit1->Lines->Add("Evaluation of a list of expressions.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------
