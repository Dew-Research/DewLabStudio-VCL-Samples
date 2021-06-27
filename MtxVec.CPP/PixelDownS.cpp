//---------------------------------------------------------------------------

#include <vcl.h>
#include <stdlib.h>
#pragma hdrstop

#include "PixelDownS.h"
#include <MtxVecTee.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TDownS *DownS;
//---------------------------------------------------------------------------
__fastcall TDownS::TDownS(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  str = "The PixelDownSample method can be used to speed ";
  str+= "up the drawing of huge amounts of data (>> 1 milion points) ";
  str+= "samples). The routine will reduce the number of ";
  str+= "points in vectors Y and X in such a way that there ";
  str+= "will be virtualy no visual difference between the original ";
  str+= "and downsampled data. That however will no longer be ";
  str+= "true, if you will zoom-in on the data.";
  RichEdit1->Lines->Add(str);
  str = "The performance gain can be as big as 500x depending ";
  str+= "on the charting tool that you use, CPU and number ";
  str+= "of points that will be drawn. You can easily ";
  str+= "draw data series from vectors with length of over 10 milion ";
  str+= "points in real time taking only a percent or so of your ";
  str+= "CPU. Try changing the ""Number of points"" ";
  str+= "and compare the visual appearance of both charts.";

  RichEdit1->Lines->Add(str);
  TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------
void __fastcall TDownS::FillRandomPoints(void)
{
	if (NumPoints == TestVec.Length) {

         TestVec+= 10000;

    } else {

		TestVec.Size(NumPoints);
		TestVec.RandUniform(-500,500);
		TestVec.CumSum();
    }
}
//---------------------------------------------------------------------------

void __fastcall TDownS::FormResize(TObject *Sender)
{
  Chart1->Height = Panel3->Height / 2;
}
//---------------------------------------------------------------------------


void __fastcall TDownS::Button1Click(TObject *Sender)
{
  double Step;
  TestVec.Length = 0;
  FillRandomPoints();
  // "regular" plotting
  Screen->Cursor = crHourGlass;
  StartTimer();
  Chart1->BottomAxis->Automatic = false;
  Chart1->BottomAxis->SetMinMax(0,TestVec.Length-1);
  Series1->Clear();
  DrawValues(TestVec,Series1,0.0, 1.0,false);
  TimeElapsed = StopTimer()*1000;
  Label3->Caption = IntToStr((int) TimeElapsed)+" ms";

  // "optimized" plotting
  StartTimer();
  Chart1->BottomAxis->Automatic = false;
  Chart1->BottomAxis->SetMinMax(0,TestVec.Length-1);
  Series2->Clear();

  DrawValues(TestVec,Series2,0.0,1.0,true);
  TimeElapsed = StopTimer()*1000;
  Label4->Caption = IntToStr((int) TimeElapsed)+" ms";
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TDownS::TrackBar1Change(TObject *Sender)
{
  NumPoints = TrackBar1->Position;
  Label6->Caption = IntToStr(NumPoints);
}
//---------------------------------------------------------------------------

void __fastcall TDownS::SpeedButton1Click(TObject *Sender)
{
  FillRandomPoints();
  Screen->Cursor = crHourGlass;

  StartTimer();
  Chart1->BottomAxis->Automatic = false;
  Chart1->BottomAxis->SetMinMax(0,TestVec.Length);
  Series1->Clear();
  DrawValues(TestVec,Series1,0,1.0,False);
  TimeElapsed = StopTimer()*1000;
  Label3->Caption = IntToStr((int) TimeElapsed)+" ms";

  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TDownS::SpeedButton2Click(TObject *Sender)
{
  FillRandomPoints();
  Screen->Cursor = crHourGlass;

  StartTimer();
  Chart1->BottomAxis->Automatic = false;
  Chart1->BottomAxis->SetMinMax(0,TestVec.Length);
  Series2->Clear();
  DrawValues(TestVec,Series2,0,1.0,True);
  TimeElapsed = StopTimer()*1000;
  Label4->Caption = IntToStr((int) TimeElapsed)+" ms";

  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

