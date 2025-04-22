//---------------------------------------------------------------------------

#include <vcl.h>
#include <stdlib.h>
#pragma hdrstop

#include "Interp1.h"
#include "MtxVecTee.hpp"
#include "MtxExpr.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic1"
#pragma resource "*.dfm"
TInterpolating1 *Interpolating1;
//---------------------------------------------------------------------------
__fastcall TInterpolating1::TInterpolating1(TComponent* Owner)
  : TBasicForm1(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "Polynoms unit introduces a very powerful method for ";
  str+= "interpolation. You can perform linear or cubic interpolation ";
  str+= "(using cubic splines). Everyhting gets done by calling just ";
  str+= "one  procedure:";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Name = "Courier New";
  RichEdit1->Lines->Add("Interpolate(FunValues,intX,intY,interpolationMethod);");
  RichEdit1->Lines->Add("");
  str = "Try changing the number of data points, number of ";
  str+= "interpolated points and interpolation method. The ";
  str+= "'DownSample' checkbox will use the PixelDownSample ";
  str+= "method to reduce the number of points to be displayed ";
  str+= "(BIG speed-up if you are charting interpolated values).";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Parameters in this demo :");
  RichEdit1->Lines->Add("Interpolation: \t interpolation method used (linear, cubic)");
  RichEdit1->Lines->Add("DataPoints:\t number of data points");
  RichEdit1->Lines->Add("Factor:\t\t number of interpolated points between two data points");
  RichEdit1->Lines->Add("Time needed:\t time in miliseconds, needed to construct and evaluate (but not draw) piece-wise polynomial");

  ComboBox1->ItemIndex = 1;
  ComboBox1Change(ComboBox1);
  TrackBar1Change(TrackBar1);
  TrackBar2Change(TrackBar2);
  CheckDownSampleClick(CheckDownSample);
}
//---------------------------------------------------------------------------

void __fastcall TInterpolating1::ComboBox1Change(TObject *Sender)
{
  switch (ComboBox1->ItemIndex)
  {
    case 0: intMethod = IntLinear; break;
    case 1: intMethod = IntCubic; break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TInterpolating1::TrackBar1Change(TObject *Sender)
{
  NumPoints = TrackBar1->Position;
  StaticText2->Caption = IntToStr(NumPoints);
}
//---------------------------------------------------------------------------

void __fastcall TInterpolating1::TrackBar2Change(TObject *Sender)
{
  Factor = TrackBar2->Position;
  StaticText3->Caption = IntToStr(Factor);
}
//---------------------------------------------------------------------------

void __fastcall TInterpolating1::Button1Click(TObject *Sender)
{
  sVector X, Y, pX, pY;

  Chart1->LeftAxis->Automatic = true;
  Chart1->BottomAxis->Automatic = true;
  X.Size(NumPoints,false);
  Y.Size(NumPoints,false);
  Screen->Cursor = crHourGlass;
  Randomize();
  X.Ramp();

  if (Y.IsDouble) {

	  Y[0] = 1000;
	  for (int i=1; i < X.Length; i++) Y[i] = Y[i-1] + 250 - Random(500);

  } else {

	  Y.SValues(0) = 1000;
	  for (int i=1; i < X.Length; i++) Y.SValues(i) = Y.SValues(i-1) + 250 - Random(500);
  }

  DrawValues(Y,Series1,0,1.0,DownSize);
  StartTimer();
  pX.Size(NumPoints*Factor,false);
  pX.Ramp(0,1.0/double(Factor));
  Interpolate(Y,pX,pY,intMethod,true);
  TimeElapsed = StopTimer()*1000;;
  Label5->Caption = "Solved in "+IntToStr((int) TimeElapsed)+" ms";
  DrawValues(pY,Series2,0,1.0/Factor, DownSize);

  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

