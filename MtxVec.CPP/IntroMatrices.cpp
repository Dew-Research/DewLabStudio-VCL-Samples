//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroMatrices.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroMtx *IntroMtx;
//---------------------------------------------------------------------------
__fastcall TIntroMtx::TIntroMtx(TComponent* Owner)
  : TBasicForm3(Owner)
{

	RichEdit1->Lines->Clear();
	RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style  << TFontStyle::fsBold;
	RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
	RichEdit1->SelAttributes->Size = 11;
	RichEdit1->Lines->Add("Matrix operations:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Lines->Add("Least squares solution to a system of linear equations");
	RichEdit1->Lines->Add("Refining solution of linear systems and error estimate");
	RichEdit1->Lines->Add("Singular value decomposition and solution of a system of equations");
	RichEdit1->Lines->Add("Eigenvalues and eigenvectors");
	RichEdit1->Lines->Add("Toeplitz systems of linear equations");
	RichEdit1->Lines->Add("Complete support for complex numbers");
	RichEdit1->Lines->Add("2D FFT");
	RichEdit1->Lines->Add("Complete matrix arithmetics");
	RichEdit1->Lines->Add("Support for sparse matrices");
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------

 