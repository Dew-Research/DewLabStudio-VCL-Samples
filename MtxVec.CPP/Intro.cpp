//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Intro.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroduction *Introduction;
//---------------------------------------------------------------------------
__fastcall TIntroduction::TIntroduction(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TIntroduction::FormCreate(TObject *Sender)
{
    
    AnsiString str;

    RichEdit1->Lines->Clear();
    RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
    RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
    RichEdit1->SelAttributes->Size = 11;
    str = "Welcome to MtxVec, an object oriented vectorized numerical library ";
    str+= "for Delphi and C++";
    RichEdit1->Lines->Add(str);
    RichEdit1->Lines->Add("");
    RichEdit1->Lines->Add("MtxVec adds the following capabilities to your development environment:");
    RichEdit1->Lines->Add("");
    RichEdit1->Paragraph->Numbering = nsBullet;
    RichEdit1->Paragraph->FirstIndent = 10;
    RichEdit1->Lines->Add("Comprehensive set of mathematical and statistical functions");
	RichEdit1->Lines->Add("Substantial performance improvements of floating point math by exploiting the SSE2, SSE3, SSE4.x and AVX instruction sets.");
	RichEdit1->Lines->Add("Certified support for 4GB address range on 64bit OS for 32bit applications.");
	RichEdit1->Lines->Add("Open CL support allows high performance cross platform portable code and gives you access to the power of GPUs.");
	RichEdit1->Lines->Add("Improved compactness and readability of code.");
	RichEdit1->Lines->Add("Significantly shorter development times by protecting the developer from a wide range of possible errors.");
	RichEdit1->Lines->Add("Same API interface in Delphi for W32, C++ and .NET");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");
	str = "Typical performance improvements observed by most users are 4-6 times for ";
	str+= "vector functions, but speed ups up to 20 times are not rare. The matrix ";
	str+="multiplication for example is faster up to 50 times. ";
	RichEdit1->Lines->Add(str);
	RichEdit1->Lines->Add("");
	str = "Navigate through the demo application, to learn ";
	str+= "more about MtxVec and experience it""s unmatched ";
	str+= "performance and ease of use.";
	RichEdit1->Lines->Add(str);


}
//---------------------------------------------------------------------------



