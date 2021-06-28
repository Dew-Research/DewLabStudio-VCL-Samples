//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "MtxExpr.hpp"
#include "IirGroupDelay.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIirGroupDelayForm *IirGroupDelayForm;
//---------------------------------------------------------------------------
__fastcall TIirGroupDelayForm::TIirGroupDelayForm(TComponent* Owner)
	: TForm(Owner)
{
	for (int i=0;i<4;i++)
		SpectrumChart->AddSeries(new TFastLineSeries(SpectrumChart));
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Group delay of IIR filters. Group delay is the first "
						"derivate of the continuous phase. Change the filter parameters "
						"and observer what happens to the group delay!");
	FillSeries(5,40);
}
//---------------------------------------------------------------------------
void __fastcall TIirGroupDelayForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TIirGroupDelayForm::FillSeries(int Order, int Att)
{
	Mtxexpr::sVector num,den,h;
	for (int i=0;i<4;i++)
	{
		SpectrumChart->SeriesList->Move(0,3);
		SpectrumChart->Series[0]->Title = IirFilterMethodToString((TIirFilterMethod)i);
		switch ((TIirFilterMethod)i)
		{
			case fimButter:      ButterFilter(Order,OPENARRAY(double,(0.2)),ftLowpass,false,num,den);break;
			case fimChebyshevI:  ChebyshevIFilter(Order,0.1,OPENARRAY(double,(0.2)),ftLowpass,false,num,den);break;
			case fimChebyshevII: ChebyshevIIFilter(Order,Att,OPENARRAY(double,(0.2)),ftLowpass,false,num,den);break;
			case fimElliptic:    EllipticFilter(Order,0.1,Att,OPENARRAY(double,(0.2)),ftLowpass,false,num,den);break;
		}
		GroupDelay(h,num,den,128);
		h.SetSubRange(0,(int) (0.95*h.Length)); //problems on the right edge
		DrawValues(h,SpectrumChart->Series[0],0,0.95*0.5/h.Length);
		h.SetFullRange();
	}
}
void __fastcall TIirGroupDelayForm::OrderEditChange(TObject *Sender)
{
	FillSeries(OrderEdit->IntPosition,AttEdit->IntPosition);
}
//---------------------------------------------------------------------------

