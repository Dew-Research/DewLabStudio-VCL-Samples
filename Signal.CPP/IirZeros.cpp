//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "IirZeros.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIirZerosForm *IirZerosForm;
//------------------------------------------------------ ---------------------
__fastcall TIirZerosForm::TIirZerosForm(TComponent* Owner)
	: TForm(Owner)
{
	FilterBox->ItemIndex = 0;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("DSP for MtxVec features 4 different filter design methods for infinite impulse response filters: " 
		"Butterworth, Chebyshev type I and type II and elliptic filters. Change the order and attenuation "
		"in the stop band of a low-pass IIR filter designed with all 4 methods.");
	FillSeries(5,40);
}
//---------------------------------------------------------------------------
void __fastcall TIirZerosForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TIirZerosForm::FilterBoxChange(TObject *Sender)
{
	FillSeries(OrderEdit->IntPosition,AttEdit->IntPosition);
}
//---------------------------------------------------------------------------
void __fastcall TIirZerosForm::FillSeries(int Order, int Att)
{
	int  i;
	Mtxexpr::sVector z,p;
	TSample k;
	switch ((TIirFilterMethod)FilterBox->ItemIndex)
	{
		case fimButter:      ButterFilter(Order,OPENARRAY(double,(0.2)),ftLowpass,false,z,p,k);break;
		case fimChebyshevI:  ChebyshevIFilter(Order,0.1,OPENARRAY(double,(0.2)),ftLowpass,false,z,p,k);break;
		case fimChebyshevII: ChebyshevIIFilter(Order,Att,OPENARRAY(double,(0.2)),ftLowpass,false,z,p,k);break;
		case fimElliptic:    EllipticFilter(Order,0.1,Att,OPENARRAY(double,(0.2)),ftLowpass,false,z,p,k);break;
	}
	if (!z.Complex) z.ExtendToComplex(true);
	z.CartToPolar(r,phi);
	phi.Scale(180/M_PI);
	for (i = 0; i < z.Length; i++)
	{
		 Series1->AddPolar(phi[i], r[i]);
	}
	if (!p->Complex) p.ExtendToComplex(true);
	p.CartToPolar(r,phi);
	phi.Scale(180/M_PI);
	for (i = 0; i < z.Length; i++)
	{
		 Series2->AddPolar(phi[i], r[i]);
	}
}
