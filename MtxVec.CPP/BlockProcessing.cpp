//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "BlockProcessing.h"
#include <Probabilities.hpp>
#include <math.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic1"
#pragma resource "*.dfm"
TfrmBlockProc *frmBlockProc;
//---------------------------------------------------------------------------
__fastcall TfrmBlockProc::TfrmBlockProc(TComponent* Owner)
  : TBasicForm1(Owner)
{
 AnsiString str;

  str = "Block processing enables you to adapt the length ";
  str+= "of the memory being accessed by your algorithm to ";
  str+= "approximately match the size of the CPU cache. If ";
  str+= "the memory at the same memory location is accessed ";
  str+= "more than once, the second access will about 3-6 ";
  str+= "times faster. The trick is to break long vectors ";
  str+= "down in to a series of short ones and process each ";
  str+= "block separately, thus always holding the entire memory ";
  str+= "block in the CPU cache and radically reducing the number" ;
  str+= "of CPU cache misses. Block processing is demonstrated by ";
  str+= "timing three versions of the same function. The function ";
  str+= "being benchmarked is Maxwell PDF.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  str = "Block length (size of the sub vector) is automatically set ";
  str+= "by MtxVec to match the CPU cache size and so is the number ";
  str+= "iterations required to process the entire vector length.";
  RichEdit1->Lines->Add(str);

  X.Size(Len);
  Res.Size(X);

}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellBlock(int Iter, double &Result)
{
  sVector xx;

  StartTimer();
  double a = 1;
  for (int i=1; i<Iter; i++)
  {
	Res.BlockInit();
	X.BlockInit();
	while (!X.BlockEnd)
	{
	  xx.Sqr(X);
	  Res.Copy(xx);
	  Res *= -0.5*a;
	  Res.Exp();
	  Res *= xx;
	  Res *= pow(4*INVTWOPI,0.5)*a;

	  Res.BlockNext();
	  X.BlockNext();
	}
  }
  Result = StopTimer()*1000;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellNoBlock(int Iter, double &Result)
{
  // Maxwell distribution, a = 1.0
  sVector xx;

  double a = 1;
  StartTimer();
  for (int i=1; i<Iter; i++)
  {
	xx.Sqr(X);
	Res = xx();
	Res *= -0.5*a;
	Res.Exp();
	Res *= xx;
	Res *= pow(4*INVTWOPI,0.5)*a;
  }
  Result = StopTimer()*1000;

}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellFunction(int Iter, double &Result)
{
  // Maxwell distribution, a = 1.0
  double a = 1;

  StartTimer();

  if (X.IsDouble) {
	  for (int i=1; i<Iter; i++)
		for (int j=0; j< X.Length; j++)
		{
			Res[j] = MaxwellPDF(X[j],a);
		}
  } else {
	  for (int i=1; i<Iter; i++)
		for (int j=0; j< X.Length; j++)
		{
			Res.SValues(j) = MaxwellPDF(X.SValues(j),a);
		}

  }
  Result = StopTimer()*1000;
}
//---------------------------------------------------------------------------double FindMax(double *a, int Len) {

double FindMax(double *a, int Len)
{
	 double Result = MINNUM;
	 int i;
	 for (i = 0; i < Len; i++) {

		  if (a[i] > Result) Result = a[i];
	 }
	 return Result;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::Button1Click(TObject *Sender)
{
  int i, Len;
  double *a1 = new double[6];
  double *a2 = new double[6];
  double *a3 = new double[6];
  Screen->Cursor = crHourGlass;
  X.Size(10);
  X.SetVal(2.0);
  Res.Size(X);
  int Iters = 1000000;
  Len = 5;
  for (i=0; i<Len; i++)
  {
	MaxwellFunction(Iters,a1[i]);
	Label1->Caption = "Progress: " + FormatFloat("0",(i+0.33)/6.0*100) + "%";
	Update();
	MaxwellNoBlock(Iters,a2[i]);
	Label1->Caption = "Progress: " + FormatFloat("0",(i+0.66)/6.0*100) + "%";
	Update();
	MaxwellBlock(Iters,a3[i]);
	Label1->Caption = "Progress: " + FormatFloat("0",(i+0.99)/6.0*100) + "%";
	Update();
	Iters = Iters/10;
	X.Length = X.Length*10;
	Res.Size(X);
	X.SetVal(2.0);
  }
  Label1->Caption = "Progress: 100%";
  for (i=0; i<Chart1->SeriesCount(); i++) Chart1->Series[i]->Clear();
  for (i=0; i<Len; i++) Chart1->Series[0]->AddY(a1[i],FormatFloat("0",Math387::Power(10,i+1)),clTeeColor);
  for (i=0; i<Len; i++) Chart1->Series[1]->AddY(a2[i],"",clTeeColor);
  for (i=0; i<Len; i++) Chart1->Series[2]->AddY(a3[i],"",clTeeColor);

  Chart1->LeftAxis->Automatic = False;
  Chart1->LeftAxis->SetMinMax(0,1.1*Math387::Max(Math387::Max(FindMax(a1,Len),FindMax(a2,Len)),FindMax(a3,Len)));
  Screen->Cursor = crDefault;

  delete[] a1;
  delete[] a2;
  delete[] a3;
}
//---------------------------------------------------------------------------

