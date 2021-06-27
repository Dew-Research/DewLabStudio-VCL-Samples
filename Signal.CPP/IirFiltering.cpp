//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "IirFiltering.h"
#include "IirFilters.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIirFilteringForm *IirFilteringForm;
//---------------------------------------------------------------------------
__fastcall TIirFilteringForm::TIirFilteringForm(TComponent* Owner)
	: TForm(Owner)
{
	for (int i=0;i<4;i++)
		SpectrumChart->AddSeries(new TFastLineSeries(SpectrumChart));
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("DSP for MtxVec features 4 different filter design methods for infinite impulse response filters: " 
						"Butterworth, Chebyshev type I and type II and elliptic filters. Change the order and attenuation "
						"in the stop band of a low-pass IIR filter designed with all 4 methods.");
	FillSeries(5,40,0.1);
}
//---------------------------------------------------------------------------
void __fastcall TIirFilteringForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TIirFilteringForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TIirFilteringForm::SpectrumAnalyzerParameterUpdate(
			TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TIirFilteringForm::FillSeries(int Order, int Att, TSample Freq)
{
	SpectrumAnalyzer->Window = wtRectangular;
	SpectrumAnalyzer->Logarithmic = true;
	SpectrumAnalyzer->LogSpan = ls200;
	SpectrumAnalyzer->ZeroPadding = 128;
	Mtxexpr::sVector num,den,h;
	for (int i=0;i<4;i++)
	{
		(*SpectrumChart->Spectrums)[0]->Series = SpectrumChart->Series[i];
		SpectrumChart->Series[i]->Title = IirFilterMethodToString((TIirFilterMethod)i);
		switch ((TIirFilterMethod)i)
		{
			case fimButter:      ButterFilter(Order,OPENARRAY(double,(Freq)),ftLowPass,false,num,den);break;
			case fimChebyshevI:  ChebyshevIFilter(Order,0.1,OPENARRAY(double,(Freq)),ftLowPass,false,num,den);break;
			case fimChebyshevII: ChebyshevIIFilter(Order,Att,OPENARRAY(double,(Freq)),ftLowPass,false,num,den);break;
			case fimElliptic:    EllipticFilter(Order,0.1,Att,OPENARRAY(double,(Freq)),ftLowPass,false,num,den);break;
		}
/*            Alternative:

						 FrequencyResponse(num,den,h,64);
						 h->Abs;
						 h->Log10;
						 h->Scale(-20);
						 DrawIt(h);*/
		SpectrumAnalyzer->Process(num,den,NULL,NULL); //place result in self
	}
	SpectrumChart->Legend->Visible = true;
}
void __fastcall TIirFilteringForm::OrderEditChange(TObject *Sender)
{
	FillSeries(OrderEdit->IntPosition,AttEdit->IntPosition, FreqEdit->Position);	
}
//---------------------------------------------------------------------------

