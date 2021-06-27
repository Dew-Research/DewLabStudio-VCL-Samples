//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "DefaultArray.h"
#include "MtxExpr.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TDefArray *DefArray;
//---------------------------------------------------------------------------
__fastcall TDefArray::TDefArray(TComponent* Owner)
  : TBasicForm2(Owner)
{
    AnsiString str;

    RichEdit1->Lines->Clear();

	str = "There are three different ways on how to";
	str+= " access the elements of an array. ";
	str+= " (vector or matrix). All access methods ";
	str+= "  work on the same block of memory. Include MtxExpr.hpp to gain access to sVector, cVector, sMatrix and cMatrix types.";

	RichEdit1->Lines->Add("");
	str = "(*) Default arrays with ( , ) operators give you a clear syntax:";
	RichEdit1->Lines->Add(str);
	RichEdit1->SelAttributes->Name = "Courier New";
	RichEdit1->Lines->Add("a.Values(i , j) = 1; {where ""a"" is sMatrix object}");
	RichEdit1->Lines->Add("a.CValues(i , j) = Cplx(1,2)");
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("(*) Indexed pointers are fast as always:");
	RichEdit1->SelAttributes->Name = "Courier New";
	RichEdit1->Lines->Add("double *ap; ");
	RichEdit1->Lines->Add("ap = a.PValues1D(0)"); //obtain a pointer to 0th element
	RichEdit1->Lines->Add("ap = a.PValues(Row,Col)"); //obtain a pointer to (Row*a->Cols+Col) th element
	RichEdit1->Lines->Add("ap[i] = 3.5; {where ""a"" is TMtx object}");
	RichEdit1->Lines->Add("");
	str = "(*) One dimensional array (TMtx object only) allows ";
	str+= "you to work with the matrix as you would with one ";
	str+= "dimensional array:";
	RichEdit1->Lines->Add(str);
	RichEdit1->SelAttributes->Name = "Courier New";
	RichEdit1->Lines->Add("am[i*Cols+j] = 2.3; ");
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("For vectors");
	RichEdit1->Lines->Add("av[i] = 2.3; ");

	RadioGroup1Click(RadioGroup1);
	TrackBar1Change(TrackBar1);
}

//---------------------------------------------------------------------------
void __fastcall TDefArray::CumulativeSum(sVector &A)
{
  if (A.IsDouble) {

	  for (int i=0; i < A.Length ;i++)
		   A[i] = A[i] + A[i];
  }
  else
  {
	  for (int i=0; i < A.Length ;i++)
		   A.SValues(i) = A.SValues(i) + A.SValues(i);
  }

}

//---------------------------------------------------------------------------
void __fastcall TDefArray::CumulativeSumFast(sVector& A)
{
  if (A.IsDouble) {

	  double *ap;
	  ap = A.PValues1D(0);

	  for (int i=0; i < A.Length ;i++) {
			ap[i] = ap[i] + ap[i];
	  }
  }
  else
  {
	  float *ap;
	  ap = A.PSValues1D(0);

	  for (int i=0; i < A.Length ;i++) {
			ap[i] = ap[i] + ap[i];
	  }

  }
}
//---------------------------------------------------------------------------
void __fastcall TDefArray::CumulativeSum(sMatrix& A)
{                                    //Values 2D property
  if (A.IsDouble) {

	  for (int i=0; i < A.Rows ;i++)
		for (int j=0; j < A.Cols ;j++)
		  A.Values(i,j) = A.Values(i,j) + A.Values(i,j);
  }
  else
  {
	  for (int i=0; i < A.Rows ;i++)
		for (int j=0; j < A.Cols ;j++)
		  A.SValues(i,j) = A.SValues(i,j) + A.SValues(i,j);
  }
}
//---------------------------------------------------------------------------
void __fastcall TDefArray::CumulativeSumFast(sMatrix& A)
{                             // Indexed pointer
  int Cols = A.Cols;
  int k,i,j;

  if (A.IsDouble) {

	  double *ap;
	  ap = A.PValues1D(0);

	  for (i=0; i < A.Rows ;i++)
		for (j=0; j < A.Cols ;j++) {
		  k = i*Cols+j;
		  ap[k]= ap[k] + ap[k];
	  }

  } else {

	  float *ap;
	  ap = A.PSValues1D(0);

	  for (i=0; i < A.Rows ;i++)
		for (j=0; j < A.Cols ;j++) {
		  k = i*Cols+j;
		  ap[k]= ap[k] + ap[k];
	  }

  }

}
//---------------------------------------------------------------------------
void __fastcall TDefArray::CumulativeSumFast1(sMatrix& A)
{                                  // Indexed operator
  int Cols = A.Cols;
  int k,i,j;

  if (A.IsDouble) {

	  for (i=0; i < A.Rows ;i++)
		for (j=0; j < A.Cols ;j++) {

		  k = i*Cols+j;
		  A[k] = A[k] + A[k];
		}

  } else {

	  for (i=0; i < A.Rows ;i++)
		for (j=0; j < A.Cols ;j++) {

		  k = i*Cols+j;
		  A->SValues1D[k] = A->SValues1D[k] + A->SValues1D[k];
		}

  }

}
//---------------------------------------------------------------------------
void __fastcall TDefArray::TrackBar1Change(TObject *Sender)
{
  Len = TrackBar1->Position;
  Label1->Caption = IntToStr(Len);
}
//---------------------------------------------------------------------------

void __fastcall TDefArray::Button1Click(TObject *Sender)
{
  int i, j, MaxIter;

//  { setup TestVec }
  Series1->Clear();
  Series2->Clear();
  Series3->Clear();
  Screen->Cursor = crHourGlass;
  if (RadioGroup1->ItemIndex == 0) // { test vector }
  {
	j = 1;
	MaxIter = 10;
	if (Len < 5000) { MaxIter = 5000; }
	if (Len < 2000) { MaxIter = 10000; }
	if (Len < 500) { MaxIter = 60000; }
	if (Len < 100) { MaxIter = 300000; }

	while (j < Len) {

	  TestVec.Size(j);
	  TestVec.SetZero();
	  StartTimer();
//      { arrays property}
	  for (i = 1; i < MaxIter; i++) CumulativeSum(TestVec);
	  TimeElapsed = StopTimer()*1000;;
	  Series1->AddXY(j,TimeElapsed,"",clTeeColor);
	  Series1->Title = "Values property";
	  TestVec.SetZero();
	  StartTimer();
//      { indexed pointer }
	  for (i = 1; i < MaxIter; i++) CumulativeSumFast(TestVec);
	  TimeElapsed = StopTimer()*1000;;
	  Series2->AddXY(j,TimeElapsed,"",clTeeColor);
	  Series2->Title = "Indexed pointer";
	  if (j < 10) { j+=  2; }
	  else if (j < 100) { j+= 10; }
	  else if (j < 500) { j+= 50; }
	  else if (j < 1000) { j+= 100; }
	  else if (j < 3000) { j+= 250; }
	  else { j+=  500; }
	}
  } else {

	j = 5;
	MaxIter = 100;
	if (Len < 70) { MaxIter = 1500; }
	if (Len < 30) { MaxIter = 5500; }
	while (j < Len) {

		  TestMtx.Size(j,j);
		  TestMtx.SetVal(0); //SetZero
	//      { indexed pointer}
		  StartTimer();
		  for (i = 1; i < MaxIter; i++) CumulativeSumFast1(TestMtx);
		  TimeElapsed = StopTimer()*1000;;
		  Series2->AddXY(j,TimeElapsed,"",clTeeColor);
		  Series2->Title = "Values1D property";
	//      { 2D array property }
		  StartTimer();
		  for (i = 1; i < MaxIter; i++) CumulativeSum(TestMtx);
		  TimeElapsed = StopTimer()*1000;;
		  Series1->AddXY(j,TimeElapsed,"",clTeeColor);
		  Series1->Title = "Values 2D property";
	///      { 1D property}
		  StartTimer();
		  for (i = 1; i < MaxIter; i++) CumulativeSumFast(TestMtx);
		  TimeElapsed = StopTimer()*1000;;
		  Series3->AddXY(j,TimeElapsed,"",clTeeColor);
		  Series3->Title = "Indexed pointer";
		  if (j < 10) {j+= 2;}
		  else if (j < 50) {j+= 5;}
		  else if (j < 100) {j+= 10;}
		  else if (j < 200) {j+= 15;}
		  else {j+= 20;}
	}
  }
  Chart1->LeftAxis->Title->Caption = "time [ms] ("+IntToStr(MaxIter)+" iterations)";
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TDefArray::RadioGroup1Click(TObject *Sender)
{
  switch (((TRadioGroup*) Sender)->ItemIndex) {
  case 0:   Label2->Caption = "Vector length";
            TrackBar1->Max = 10000;
            TrackBar1->Frequency = 500;
            break;
  case 1:   Label2->Caption = "Sqared matrix rows";
            TrackBar1->Max = 300;
            TrackBar1->Frequency = 10;
            TrackBar1->Position = 150;
            break;
  }

  Series3->Active = (((TRadioGroup*) Sender)->ItemIndex != 0);
  TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------

