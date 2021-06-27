//---------------------------------------------------------------------------

#include <vcl.h>
#include <stdlib.h>
#pragma hdrstop

#include "QRPoly1.h"
#include "MtxVecTee.hpp"
#include "MtxVecEdit.hpp"
#include "Polynoms.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic1"
#pragma resource "*.dfm"
TLQRPoly *LQRPoly;
//---------------------------------------------------------------------------
__fastcall TLQRPoly::TLQRPoly(TComponent* Owner)
  : TBasicForm1(Owner)
{
  AnsiString str;

  str = "Fitting a polynomial of high degree is easy. ";
  str+= "MtxVec offers you the ability to create ";
  str+= "Vandermonde matrix and then use it to find the desired ";
  str+= "polynomial coefficients via the LQR decomposition. ";
  str+= "Here is the code used to find the polynomial coefficients:";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("void PolyFit(TVec *XData, TVec* YData; int Degree, TVec* Coeff)");
  RichEdit1->Lines->Add("{");
  RichEdit1->Lines->Add("  Matrix V;");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit1->Lines->Add("  // num coeff = Degree +1");
  RichEdit1->Lines->Add("  V->VanderMonde(Degree+1,XData);");
  RichEdit1->Lines->Add("  V->LQRSolve(YData,Coeff);");
  RichEdit1->Lines->Add("}");

  if (!X.IsDouble) {
      TrackBar1->Position = 7;
  }

  TrackBar1Change(TrackBar1);
  TrackBar2Change(TrackBar2);

  X.Size(1000,false);
  Y.Size(X);
  randomize();
  double tmp = random(1000);
  X.Ramp();

  if (Y.IsDouble) {

	for (int i=0; i < Y.Length; i++)
	 {
		tmp = tmp + random(1000) - 500;
		Y[i] = tmp;
	 }
  } else {

	 for (int i=0; i < Y.Length; i++)
	 {
		tmp = tmp + random(1000) - 500;
		Y.SValues(i) = tmp;
	 }
  }

  DrawValues(Y,Series1,0.0,1.0,false);
}
//---------------------------------------------------------------------------
void __fastcall TLQRPoly::TrackBar1Change(TObject *Sender)
{
  PolyOrder = TrackBar1->Position;
  Label2->Caption = IntToStr(PolyOrder);
  Button2->Enabled = false;
  Button3->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TLQRPoly::Button1Click(TObject *Sender)
{
  StartTimer();
  Screen->Cursor = crHourGlass;

  PolyFit(X,Y,PolyOrder,Coeff, R, DegF,L2R,NULL);
  intX.Size(X.Length*Factor);
  intX.Ramp(0,1.0/Factor);
  PolyEval(intX,Coeff,R,DegF,L2R,intY,Delta);
  TimeElapsed = StopTimer()*1000;
  Label5->Caption = IntToStr((int) TimeElapsed)+ " ms";
  DrawValues(intY,Series2,0,1.0/Factor,DownSize);
  intY.Sub(Delta);
  DrawValues(intY,Series4,0,1.0/Factor,DownSize);
  intY.AddScaled(Delta,2.0);
  DrawValues(intY,Series3,0,1.0/Factor,DownSize);
  Screen->Cursor = crDefault;
  Button2->Enabled = true;
  Button3->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TLQRPoly::TrackBar2Change(TObject *Sender)
{
  Factor = TrackBar2->Position;
  Label3->Caption = IntToStr(Factor);
  Button2->Enabled = false;
  Button3->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TLQRPoly::Button2Click(TObject *Sender)
{
  ViewValues(Coeff,"Coefficients",true,false,false);
}
//---------------------------------------------------------------------------

void __fastcall TLQRPoly::CheckDownSampleClick(TObject *Sender)
{
  Button2->Enabled = false;
  Button3->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TLQRPoly::Button3Click(TObject *Sender)
{
  ViewValues(Delta,"Delta",true,false, false);
}
//---------------------------------------------------------------------------

