//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "SparseTest.h"
#include "MtxVecEdit.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmSparseTest *frmSparseTest;
//---------------------------------------------------------------------------
__fastcall TfrmSparseTest::TfrmSparseTest(TComponent* Owner): TBasicForm2(Owner)
{
	  AnsiString str;
		 //
	  RichEdit1->Paragraph->FirstIndent = 0;
	  RichEdit1->Paragraph->Numbering = nsNone;
	  RichEdit1->Lines->Add("The system of 256 linear equations (sparse) sytstem is solved with four methods:");
	  RichEdit1->Lines->Add("");
	  RichEdit1->Lines->Add("1) TMtx.LUSolve method is used to solve the system of equations");
	  RichEdit1->Lines->Add("2) TSparseMtx.Solve direct method (umfpack) is used to solve the system of equations");
	  RichEdit1->Lines->Add("3) TSparseMtx.Solve direct method (pardiso) is used to solve the system of equations");
	  RichEdit1->Lines->Add("4) TSparseMtx iterative method is used to solve the system of equations");
	  RichEdit1->Lines->Add("");
	  str = "The test's should be ran at least twice because the pardiso solver ";
	  str+= "has a long initialization period! Umfpack can optionally report also ";
	  str+= "statistics about the solver!";
	  RichEdit1->Lines->Add(str);

	  SparseA = new TSparseMatrix();
	  SparseA->ReportLevel = prlNone; // no report - fastest
	  SparseA->AutoClearReport = true; // force clear
		 //
	  SparseA->LoadFromMatrixMarketFile("pde225.mtx");

}
//---------------------------------------------------------------------------

void __fastcall TfrmSparseTest::FormDestroy(TObject *Sender)
{
   delete SparseA;
   SparseA = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSparseTest::Button1Click(TObject *Sender)
{
  sMatrix A;
  sVector x1, x2, x3, x4, B;
  int i;
  AnsiString tmpStr;

  // random data for Ax=b i.e. b constants
  B.Size(SparseA->Rows);
  B.RandGauss();

  Screen->Cursor = crHourGlass;
  Series1->Clear();
  // Ordinary Mtx.LuSolve

  SparseA->SparseToDense(A,100000);
  StartTimer();
  for (i = 1;i<100;i++) A.LUSolve(B,x1); //x1 = Div(B,A);
  double tmpTime = StopTimer()*1000;
  Series1->Add(tmpTime,"LUSolve",clRed);

  // "regular" sparse solve

  SparseA->SparseSolver = ssUmfPack;
  StartTimer();
  for (i = 1;i<100;i++) SparseA->Solve(B,x2);
  // load report from MtxVec Report global variable
  Memo1->Lines->Clear();
  Mtxvec::Report->Position = 0;
  Memo1->Lines->LoadFromStream(Mtxvec::Report);
  tmpTime = StopTimer()*1000;
  Series1->Add(tmpTime,"Umfpack \r Solve",clBlue);

// "Pardiso" sparse solve
  #ifndef TTSINGLE

  SparseA->SparseSolver = ssUmfPack;
  StartTimer();
  for (i = 1;i<100;i++) SparseA->Solve(B,x3);
  // load report from MtxVec Report global variable
  Memo1->Lines->Clear();
  Mtxvec::Report->Position = 0;
  Memo1->Lines->LoadFromStream(Mtxvec::Report);
  tmpTime = StopTimer()*1000;
  Series1->Add(tmpTime,"Pardiso \r Solve",clGreen);

  #endif

  // iterative sparse solve

  x4.Size(B);
  StartTimer();
  SparseA->IterativeMethod = itmLUGMRES;
  SparseA->SparseSolver = ssIterative;
  for (i = 1; i < 100 ; i++)  {

	x4.Ramp(); // Approximate solution
	SparseA->SolveIterative(B,x4,false);
//    x4 = Div(B, SparseA);  //this wont work becaues there is no access to the left side
  }
  tmpTime = StopTimer()*1000;
  Series1->Add(tmpTime,"Sparse \r IterativeSolve",clYellow);




  Screen->Cursor = crDefault;
  if (x1.Equal(x2,1.0e-3)) tmpStr = "LU Solve solution equal to UmfPack solution";
  else tmpStr = "LU Solve solution NOT equal to Umfpack solve solution";

  #ifndef TTSINGLE
  if (x1.Equal(x3,1.0e-3)) tmpStr += "\n\r LU Solve solution equal to Pardiso solution";
  else tmpStr += "\n\r LU Solve solution NOT equal to Pardiso solve solution";
  #endif

  if (x1.Equal(x4,1.0e-3)) tmpStr += "\n\r LU Solve solution equal to iterative solve solution";
  else tmpStr += "\n\r LU Solve solution NOT equal to iterative solve solution";


  ShowMessage(tmpStr);
}
//---------------------------------------------------------------------------
void __fastcall TfrmSparseTest::ComboBox1Change(TObject *Sender)
{
  if (SparseA != NULL) {
	  SparseA->ReportLevel = TReportLevel(ComboBox1->ItemIndex);
  }
}
//---------------------------------------------------------------------------



