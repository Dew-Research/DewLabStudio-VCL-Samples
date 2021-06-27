//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "CopyCompare.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"               
#pragma resource "*.dfm"
TCopyComp *CopyComp;
//---------------------------------------------------------------------------
__fastcall TCopyComp::TCopyComp(TComponent* Owner): TBasicForm2(Owner)
{
    AnsiString str;                                                

    RichEdit1->Lines->Clear();
    str = "This example compares ""regular"" Delphi code with highly optimized MtxVec code.";
    str+= " The example compares Mtxvec::TMatrix.Copy and Mtxvec::TMatrix.Transp method with Delphi equivalent";
    str+= " code. Here is the code used : ";
    RichEdit1->Lines->Add(str);
    RichEdit1->Lines->Add("");
    RichEdit1->SelAttributes->Name = "Courier New";
    RichEdit1->Lines->Add("procedure CopyMtxVec(A,B: Mtxvec::TMatrix);");
    RichEdit1->Lines->Add("begin");
    RichEdit1->Lines->Add("  B.Copy(A);");
    RichEdit1->Lines->Add("end;");
    RichEdit1->Lines->Add("");
    RichEdit1->Lines->Add("procedure CopyDelphi(var A,B: T2DSampleArray);");
    RichEdit1->Lines->Add("var i,j : Integer;");
    RichEdit1->Lines->Add("begin");
    RichEdit1->Lines->Add("  for i := 0 to Length(A) -1 do");
    RichEdit1->Lines->Add("    for j := 0 to Length(A[i]) -1 do b[i,j] := a[i,j];");
    RichEdit1->Lines->Add( "end;");
    RichEdit1->SelAttributes->Name = "Courier New";
    RichEdit1->Lines->Add("");
    RichEdit1->Lines->Add("procedure TranspDelphi(var A,B: T2DSampleArray);");
    RichEdit1->Lines->Add("var i,j: Integer;");
    RichEdit1->Lines->Add("begin");
    RichEdit1->Lines->Add("  for i := 0 to Length(A) -1 do //cols");
	RichEdit1->Lines->Add("    for j := 0 to Length(A[i])-1 do b[j,i] := a[i,j];");
    RichEdit1->Lines->Add("end;");
	RichEdit1->SelAttributes->Name = "Courier New";
    RichEdit1->Lines->Add("");
    RichEdit1->SelAttributes->Name = "Courier New";
    RichEdit1->Lines->Add("procedure TranspMtxVec(A,B: Mtxvec::TMatrix);");
    RichEdit1->Lines->Add("begin");
    RichEdit1->Lines->Add("  B.Transp(A);");
    RichEdit1->Lines->Add("end;");
    RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("Try changing dimension of test matrix.");

	TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------
void __fastcall TCopyComp::CopyMtxVec(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B)
{
  B->Copy(A);
}

//---------------------------------------------------------------------------
void __fastcall TCopyComp::CopyBCB(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B)
{
  B->Size(A->Rows, A->Cols);

  if (B->IsDouble) {

	  for (int i=0; i < A->Length ;i++)
		  B->Values1D[i] = A->Values1D[i];
  } else {

	  for (int i=0; i < A->Length ;i++)
		  B->SValues1D[i] = A->SValues1D[i];
  }
}
//---------------------------------------------------------------------------
void __fastcall TCopyComp::TranspMtxVec(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B)
{
  B->Transp(A);
}
//---------------------------------------------------------------------------
void __fastcall TCopyComp::TranspBCB(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B)
{
  B->Size(A);

  if (B->IsDouble) {

	  for (int i=0; i < A->Rows ;i++)
		for (int j=0; j < A->Cols ;j++)
		  B->Values[j][i]= A->Values[i][j];

  } else {

	  for (int i=0; i < A->Rows ;i++)
		for (int j=0; j < A->Cols ;j++)
		  B->SValues[j][i]= A->SValues[i][j];
  }
}
//---------------------------------------------------------------------------
void __fastcall TCopyComp::TrackBar1Change(TObject *Sender)
{
  Dim = TrackBar1->Position;
  Label2->Caption = IntToStr(Dim);
}
//---------------------------------------------------------------------------

void __fastcall TCopyComp::Button1Click(TObject *Sender)
{
  int MaxIter;
  double TimeElapsed2;
  // Setup chart
  Series1->Clear();
  Series2->Clear();
  A.Size(Dim,Dim);
  if (Dim < 15) MaxIter = 5000000;
  else if (Dim < 30) MaxIter = 500000;
  else if (Dim < 50) MaxIter = 200000;
  else if (Dim < 80) MaxIter = 10000;
  else if (Dim < 200) MaxIter = 5000;
  else if (Dim < 500) MaxIter = 1000;
  else MaxIter = 100;

  Chart1->LeftAxis->Title->Caption = "time [ms] ("+IntToStr(MaxIter)+" executions)";
  Screen->Cursor = crHourGlass;
  // BCB Copy
  StartTimer();
  for (int i =1; i<=MaxIter; i++)
    CopyBCB(A,B);
  TimeElapsed = StopTimer()*1000;
  Series1->AddXY(0,1,"Copy operation",clTeeColor);

  // MtxVec Copy
  StartTimer();
  for (int i=1; i<=MaxIter; i++)
	CopyMtxVec(A,B);
  TimeElapsed2 = StopTimer()*1000;
  Series2->AddXY(0,TimeElapsed2/TimeElapsed,"",clTeeColor);

  // BCB Transp
  StartTimer();
  for (int i=1; i<=MaxIter; i++)
	TranspBCB(A,B);
  TimeElapsed2 = StopTimer()*1000;
  Series1->AddXY(1,TimeElapsed2/TimeElapsed,"Transp operation",clTeeColor);

  // MtxVec Transp
  StartTimer();
  for (int i=1; i<=MaxIter; i++)
	TranspMtxVec(A,B);
  TimeElapsed2 = StopTimer()*1000;
  Series2->AddXY(1,TimeElapsed2/TimeElapsed,"",clTeeColor);

  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

