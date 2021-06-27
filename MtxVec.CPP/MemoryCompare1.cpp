//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MemoryCompare1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"                                                  
TMemComp1 *MemComp1;
//---------------------------------------------------------------------------
__fastcall TMemComp1::TMemComp1(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  str = "Frequent memory allocation can cost a lot of CPU. ";
  str+= "Frequent object create and destroy costs even more. ";
  str+= "One object create and destroy can take about the ";
  str+= "same as scalling an array of 200 elements. One ";
  str+= "GetMem/FreeMem pair is equal to scalling an array ";
  str+= "of 40 elements. CreateIt/FreeIt pair equals only ";
  str+= "'15 scale elements' while creating an object and ";
  str+= "allocating memory for you at the same time.";
  RichEdit1->Lines->Add(str);
  str ="Try many different vectors sizes and rerun the test ";
  str+= "several times. Results with memory allocation may vary greatly.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("Zoom in on the chart (left-click and drag mouse over the chart) to see more details.");

  // Setup chart
  for (int i=0; i<=3; i++)
    Series1->Add(0,"",clTeeColor);

  Series1->XLabel[0] = "(32,1024)";
  Series1->XLabel[1] = "(32,0)";
  Series1->XLabel[2] = "(0,0)";
  Series1->XLabel[3] = "(Create/Destroy)";
  TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------
void __fastcall TMemComp1::DoWithCreate(AnsiString ALabel)
{
  Mtxvec::TVector *vec1, *vec2, *vec3, *vec4;
  Mtxvec::TVector *vec5, *vec6, *vec7, *vec8;
  Mtxvec::TVector *vec9, *vec10, *vec11, *vec12;

  StartTimer();
  for (int i=1; i<=28000; i++)
  {
	// use Create to create 12 vectors }
	vec1 = new Mtxvec::TVector;
	vec2 = new Mtxvec::TVector;
	vec3 = new Mtxvec::TVector;
	vec4 = new Mtxvec::TVector;
	vec5 = new Mtxvec::TVector;
	vec6 = new Mtxvec::TVector;
	vec7 = new Mtxvec::TVector;
	vec8 = new Mtxvec::TVector;
	vec9 = new Mtxvec::TVector;
	vec10 = new Mtxvec::TVector;
	vec11 = new Mtxvec::TVector;
	vec12 = new Mtxvec::TVector;
	try
	{
	  vec1->Size(Len,false);
	  vec2->Size(Len,false);
	  vec3->Size(Len,false);
	  vec4->Size(Len,false);
	  vec5->Size(Len,false);
	  vec6->Size(Len,false);
	  vec7->Size(Len,false);
	  vec8->Size(Len,false);
	  vec9->Size(Len,false);
	  vec10->Size(Len,false);
	  vec11->Size(Len,false);
	  vec12->Size(Len,false);
	}
	__finally
	{
	   // use delete to destroy 12 vectors }
	   delete vec1;
	   delete vec2;
	   delete vec3;
	   delete vec4;
	   delete vec5;
       delete vec6;
       delete vec7;
       delete vec8;
       delete vec9;
       delete vec10;
       delete vec11;
       delete vec12;
    }
  }
  TimeElapsed = StopTimer()*1000.0;
  Screen->Cursor = crDefault;
  // store the time elapsed to series
  Series1->Add(TimeElapsed, ALabel, clRed);
}
//---------------------------------------------------------------------------
void DoWithCreateIt1(int Len)
{
  sVector vec1, vec2, vec3, vec4, vec5, vec6, vec7, vec8, vec9, vec10, vec11, vec12;

  vec1.Size(Len,false);
  vec2.Size(Len,false);
  vec3.Size(Len,false);
  vec4.Size(Len,false);
  vec5.Size(Len,false);
  vec6.Size(Len,false);
  vec7.Size(Len,false);
  vec8.Size(Len,false);
  vec9.Size(Len,false);
  vec10.Size(Len,false);
  vec11.Size(Len,false);
  vec12.Size(Len,false);
}
//---------------------------------------------------------------------------
void __fastcall TMemComp1::DoWithCreateIt(AnsiString ALabel, int Index, TColor AColor)
{ //allocate pointers to objects from cache on the stack

  StartTimer();
  for (int i=1; i<=28000; i++) DoWithCreateIt1(Len);
  TimeElapsed = StopTimer()*1000;
  // store the time elapsed to series
  Series1->Add(TimeElapsed, ALabel, AColor);
}
//---------------------------------------------------------------------------

void __fastcall TMemComp1::TrackBar1Change(TObject *Sender)
{
  Len = TrackBar1->Position;
  Label2->Caption = IntToStr(Len);
}
//---------------------------------------------------------------------------

void __fastcall TMemComp1::Button3Click(TObject *Sender)
{
  Screen->Cursor = crHourGlass;
  Series1->Clear();
  // do full comparison
  Controller->SetVecCacheSize(32,1024);
  DoWithCreateIt("(32,1024)",0,clYellow);
  Controller->SetVecCacheSize(32,0);
  DoWithCreateIt("(32,0)", 1,clGreen);
  Controller->SetVecCacheSize(0,0);
  DoWithCreateIt("(0,0)", 2,clBlue);
  Controller->SetVecCacheSize(0,0);
  DoWithCreate("Create/Destroy");
  Chart1->Repaint();
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

