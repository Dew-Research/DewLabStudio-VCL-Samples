//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroWhyMtxVec.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroWhyMtxVecForm *IntroWhyMtxVecForm;
//---------------------------------------------------------------------------
__fastcall TIntroWhyMtxVecForm::TIntroWhyMtxVecForm(TComponent* Owner)
  : TBasicForm3(Owner)
{
//  TBasicForm3::FormCreate(Sender);

  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->SelAttributes->Style  = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->Lines->Add("Why MtxVec:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  AnsiString str;

  RichEdit1->Lines->Add("Features a comprehensive set of math functions for science and engineering.");
  RichEdit1->Lines->Add("Provides a platform which delivers linear scaling across multiple CPU cores when multithreaded.");
  RichEdit1->Lines->Add("Based on vectorized code which scales excellent with releases of new CPU architectures.");
  RichEdit1->Lines->Add("Powerfull debugger visualizers provided can be used with any project, including those not using MtxVec.");
  str = "All routines have internal and automatic memory management. This frees the user from a wide range of possible errors like, allocating insufficient memory, forgetting to free ";
  str+= "the memory, keeping too much memory allocated at the same time and similar.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("Parameters are explicitly range checked, before they are passed to the dll routines. This ensures that all dll calls are safe to use.");
  RichEdit1->Lines->Add("Organized in to a set of “primitive” highly optimized functions covering all the basic math operations, which are used by all higher level algorithms, in a similar way as the BLAS is used by LAPACK.");
  RichEdit1->Lines->Add("When calling Lapack routines MtxVec automatically compensates for the fact that in FORTRAN the matrices are stored by columns and in other languages by rows.");
  RichEdit1->Lines->Add("Many LAPACK functions take many parameters. Most of them can be filled-in automatically by MtxVec, thus reducing the time to study each function extensively, before it can be used.");
  RichEdit1->Lines->Add("Although some compilers support native SSE2/SSE3/SSE4 instruction set, the resulting code can never be as optimal as a hand optimized version.");
  RichEdit1->Lines->Add("Many linear algebra routines are multithreaded, including FFT’s and sparse matrix solvers.");
  RichEdit1->Lines->Add("By writing MtxVec code, your application is instantly ready for future CPU instructions, with release of new dlls.");
  RichEdit1->Lines->Add("All MtxVec functions must pass very strict automated tests. It is these tests, which give the library the highest possible level of reliability, accuracy and error protection.");
  RichEdit1->Lines->Add("All low level code is abstracted away from the user. This allows a very easy transition to any future platform supported by MtxVec.");
  RichEdit1->Lines->Add("C/C++ and FORTRAN based functions were compiled with the latest version’s Intel C/C++ and FORTRAN compilers and with support for SSE2 and SSE3.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->SelAttributes->Style  = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->Lines->Add("Why MtxVec for .NET");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Optimizing the performance of .NET code can be a real challenge. MtxVec delivers patterns which allow fast executing floating point code to be also written fast.");
  RichEdit1->Lines->Add("The advantage of P4 SSE2 and SSE3 instruction sets can be exploited only with unmanaged code. And only hand optimized code can be truly optimal.");
  RichEdit1->Lines->Add("Provides an interface to LAPACK to be used from any .NET language.");
  str = "Unmanaged code is encapsulated in to efficient and thin wrappers making the code “safe” for the end user, with little or no overhead ";
  str+= "associated with transitions from managed to unmanaged code. Many difficult to trace bugs and performance issues are avoided in this way.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("Especially for complex numbers, the performance gain against native .NET code can be very large.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------
