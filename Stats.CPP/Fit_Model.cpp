//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Mtxexpr.hpp"
#include "Fit_Model.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Chart"
#pragma resource "*.dfm"
TfrmModels *frmModels;
//---------------------------------------------------------------------------
__fastcall TfrmModels::TfrmModels(TComponent* Owner)
	: TfrmBasicChart(Owner)
{
	X->LoadFromFile(CodePath() + "FIT_X.VEC");
	Y->LoadFromFile(CodePath() + "FIT_Y.VEC");

	DrawValues(X,Y,Series1);
}
//---------------------------------------------------------------------------
void __fastcall TfrmModels::FormShow(TObject *Sender)
{
	ComboBox1->ItemIndex = 0;
	ComboBox1Change(this);
}
//---------------------------------------------------------------------------

void __fastcall TfrmModels::Button2Click(TObject *Sender)
{
	ViewValues(X,"Editing X...",true,false,true);
	ComboBox1Change(this);
}
//---------------------------------------------------------------------------

void __fastcall TfrmModels::Button3Click(TObject *Sender)
{
	ViewValues(Y,"Editing Y...",true,false,true);
	ComboBox1Change(this);
}
//---------------------------------------------------------------------------


void __fastcall TfrmModels::ComboBox1Change(TObject *Sender)
{
	int PolyDeg;
	AnsiString PolyStr;
	int DegNom, DegDenom;
	int i;
	double *bvals;

	switch(ComboBox1->ItemIndex)
	{
		case 0:  { // Y=B*Exp[A*X]
			ExpFit(B,X,Y,NULL);
			MsgText = "Y="+FormatFloat("(0.00)",B->Values[0])+"*"+
			"Exp["+FormatFloat("(0.00)",B->Values[1])+"*X]";
			bvals = new double[B->Length];
			for (int i=0; i < B->Length; i++) {
				bvals[i] = B[i];
			}
			ExpEval(bvals,B->Length,X,YCalc);
			delete bvals;
		};break;
		case 1:  { // Y=k*X+n
			LineFit(B,X,Y,NULL);
			MsgText = "Y="+FormatFloat("(0.00)",B->Values[1])+"*"+
				"X +"+FormatFloat("(0.00)",B->Values[0]);
			bvals = new double[B->Length];
			for (int i=0; i < B->Length; i++) {
				bvals[i] = B[i];
			}
			LineEval(bvals,B->Length,X,YCalc);
			delete bvals;
		};break;
		case 2:  { // Y=a*X^B
			PowerFit(B,X,Y,NULL);
			MsgText = "Y="+FormatFloat("(0.00)",B->Values[0])+"*"+
				   "X^["+FormatFloat("+0.00;-0.00",B->Values[1])+"]";
			bvals = new double[B->Length];
			for (int i=0; i < B->Length; i++) {
				bvals[i] = B[i];
			}
			PowerEval(bvals,B->Length,X,YCalc);
			delete bvals;
		};break;
		case 3:  { // Poly fit
			PolyStr = InputBox("Polynomial degree","Enter poly degree : ","5");
			PolyDeg = StrToIntDef(PolyStr,5);
			PolyFit(X,Y,PolyDeg,B);
			MsgText = "Y=";
			for (i = 0;i<PolyDeg;i++)
			{
				MsgText = MsgText + FormatFloat("(0.00)",B->Values[i])+"X^"+IntToStr(PolyDeg-i)+"+";
			}
			MsgText = MsgText + FormatFloat("(0.00)",B->Values[PolyDeg]);
			PolyEval(X,B,YCalc);
		};break;
		case 4:  { // Rational function with constant term
			PolyStr = InputBox("Nominator degree","Enter nominator degree : ","2");
			DegNom = StrToIntDef(PolyStr,2);
			PolyStr = InputBox("Denominator degree","Enter denominator degree : ","4");
			DegDenom = StrToIntDef(PolyStr,4);
			FracFit(B,X,Y,DegNom,DegDenom,True,NULL);
			FracEval(B,X,YCalc,DegNom,True);
			MsgText = "Y=(";
			for (i = DegNom;i>0;i--)
			{
				MsgText = MsgText + FormatFloat("(0.00)",B->Values[i])+"X^"+IntToStr(i)+"+";
			}
			MsgText = MsgText + FormatFloat("(0.00)",B->Values[0])+")/(";
			if (DegDenom > 0)
			{
				for (int i = DegNom+DegDenom;i>DegNom;i--)
				{
					MsgText = MsgText + FormatFloat("(0.00)",B->Values[i])+"X^"+IntToStr(i-DegNom)+"+";
				}
			} else MsgText = MsgText+"+";
			MsgText = MsgText + "1.0)";
		};break;
		case 5:  { // Logistic fit with constant term
			LogisticFit(B,X,Y,True);
			LogisticEval(B,X,YCalc,True);
			MsgText = "Y="+FormatFloat("0.00",B->Values[0]);
			MsgText += "+["+FormatFloat("0.00",B->Values[1])+FormatFloat("-0.00;+0.00",B->Values[0])+"]/";
			MsgText += "[1+Exp("+FormatFloat("-0.00;+0.00",B->Values[2])+"x "+FormatFloat("+0.00;-0.00",B->Values[3])+"]";
		};break;
		case 6: { // Logarithm
			LnFit(B,X,Y,NULL);
			LnEval(B,X,YCalc);
			MsgText = "Y="+FormatSample("+0.00;-0.00",B->Values[0])+
				FormatSample("+0.00;-0.00",B->Values[1])+"*Ln[X]";
		};break;
	}
	// calculate RSS
	Residuals->Sub(Y,YCalc);
	Label2->Caption = "Model RSS : " + FormatSample("0.0000",Residuals->SumOfSquares());
	// update chart
	DrawValues(X,Y,Series1,false);
	DrawValues(X,YCalc,Series2,false);
	Chart1->SubTitle->Text->Clear();
	Chart1->SubTitle->Text->Add(MsgText);
}
//---------------------------------------------------------------------------

