//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroSparse.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroSparseForm *IntroSparseForm;
//---------------------------------------------------------------------------
__fastcall TIntroSparseForm::TIntroSparseForm(TComponent* Owner): TBasicForm3(Owner)
{
	  AnsiString str;

	  RichEdit1->Lines->Clear();
	  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
	  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
	  RichEdit1->SelAttributes->Size = 11;

	  RichEdit1->Lines->Add("Sparse matrix class features:");
	  RichEdit1->Lines->Add("");
	  RichEdit1->Paragraph->FirstIndent = 10;
	  RichEdit1->Paragraph->Numbering = nsBullet;
	  RichEdit1->Lines->Add("Support for real and complex sparse matrices");
	  RichEdit1->Lines->Add("UMFPack v4.3 direct sparse sparse solver");
	  RichEdit1->Lines->Add("Pardiso multithreaded sparse solver");
	  RichEdit1->Lines->Add("Iterative sparse solvers (cg, bcg, gmres,..)");
	  str = "Many conversion routines to convert to and from different matrix formats "+
	  str+= "(triplet, banded, dense, Harwell Boeing)";
	  RichEdit1->Lines->Add(str);

	  RichEdit1->Lines->Add("Support for MatrixMarket file format.");
	  RichEdit1->Lines->Add("Very fast banded matrix solvers already available in TMtx");
	  RichEdit1->Lines->Add("Add, subtract, multiply routines for sparse/sparse and dense/sparse matrices/vectors");
	  str = "PixelDownSample routine to allow fast display of the non-zero ";
	  str+= "pattern of the matrices of large sizes.  (1000 000 x 1000 000 elements)";
	  RichEdit1->Lines->Add(str);
	  RichEdit1->Lines->Add("Complete set of standard math routines (Log, Power, Sin,...)");

	  RichEdit1->Paragraph->FirstIndent = 0;
	  RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------

