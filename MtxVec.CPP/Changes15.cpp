//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Changes15.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TfrmChanges15 *frmChanges15;
//---------------------------------------------------------------------------
__fastcall TfrmChanges15::TfrmChanges15(TComponent* Owner)
  : TBasicForm3(Owner)
{

  RichEdit1->Lines->Clear();

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v2.0:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  AnsiString str;

  RichEdit1->Lines->Add("Support for .NET platform. Single source code compiles on .NET and W32.");
  RichEdit1->Lines->Add("Sparse matrices: Umfpack v4.3 and Pardiso solver.");
  RichEdit1->Lines->Add("All C/C++ (umfpack) code compiled with Intel C/C++ compiler with support for SSE2/SSE3.");
  RichEdit1->Lines->Add("All Fortran code compiled with Intel Fortran compiler with support for SSE2/SSE3.");
  RichEdit1->Lines->Add("Sparse solvers for complex sparse matrices.");
  RichEdit1->Lines->Add("New random generators via MKL 7.0");
  RichEdit1->Lines->Add("New FFT engine with support for arbitrary length FFTs including arbitrary 2D FFT sizes) and symmetric multiprocessing.");
  str = "Extensive tests written to interface DUnit test framework. ";
  str+= "Tests execute under .NET and W32 and ensure that code gives the same result.";
  RichEdit1->Lines->Add(str);

  str = "New memory allocation bypassing Delphi memory manager and allowing ";
  str+= "to better exploit available system memory";
  RichEdit1->Lines->Add(str);

  RichEdit1->Lines->Add("Intel SPL calls replaced with Intel IPP 4.0.");
  RichEdit1->Lines->Add("New dll interfaces allow support of C++Builder and Kylix.");
  str = "Common abstract class between for TVec, TMtx ";
  str+= "and TSparseMtx shares common functions. New syntax options allowing much more flexibility ";
  str+= "when exchanging data between TVec, TMtx and TSparseMtx. Only the ""view"" of memory is changed. ";
  str+= "It is possible to write single source code which can take vector ";
  str+= ",matrix and sparse matrix objects as parameters.";
  RichEdit1->Lines->Add(str);

  RichEdit1->Lines->Add("Vastly improved error checking, mostly due to in-depth tests. ");
  RichEdit1->Lines->Add("Prescot CPU support exploiting the features of the new (SSE3) instruction set. ");
  RichEdit1->Lines->Add("Extensive performance optimizations across the entire library.");
  RichEdit1->Lines->Add("Operator overloading under .NET for complex numbers. ");
  str = "It should be possible to write single source code ";
  str+= "that would execute on W32 and .NET with the same ";
  str+= "or very similar performance even for short vectors and small matrices. ";
  RichEdit1->Lines->Add(str);
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v2.1:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Operator overloading for Delphi 2006 with support for Vectors, Matrices and complex numbers!");
  RichEdit1->Lines->Add("Enhanced support for .NET platform.");
  RichEdit1->Lines->Add("Updated Intel MKL 8.0.1 and IPP 5.0");
  RichEdit1->Lines->Add("New Vectorized expression parser gives you the fastest expression evaluation.");
  RichEdit1->Lines->Add("Fixed a bug for object cache resize.");
  RichEdit1->Lines->Add("Fixed a bug in TPiecePoly when assigning Breaks before Coefficients.");
  RichEdit1->Lines->Add("TMtxComponent has been upgraded with VCL independent FreeNotification system.");
  RichEdit1->Lines->Add("ViewValues editor now comes with MS Office style menus.");
  RichEdit1->Lines->Add("ViewValues editor now correctly copies columns to clipboard.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");



}
//---------------------------------------------------------------------------
