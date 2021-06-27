//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "WindowFilters.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TWindowFiltersForm *WindowFiltersForm;
//---------------------------------------------------------------------------
__fastcall TWindowFiltersForm::TWindowFiltersForm(TComponent* Owner)
	: TForm(Owner)
{
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Change the length of the filter to see how the width the transition bandwidth changes. "
		"The attenuation in dB applies only to Kaiser in Chebyshev windows. Cutoff frequency "
		"defines the start of the attenuation.");
	FillSeries(0.2,40,128);
}
//---------------------------------------------------------------------------
void __fastcall TWindowFiltersForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TWindowFiltersForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TWindowFiltersForm::SpectrumAnalyzerParameterUpdate(TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TWindowFiltersForm::FillSeries(TSample Freq, TSample Att,int Length)
{
	Mtxexpr::sVector h;
	SpectrumAnalyzer->Window = wtRectangular;
	SpectrumAnalyzer->Logarithmic = true;
	SpectrumAnalyzer->ZeroPadding = 16;
	SpectrumAnalyzer->LogSpan = ls200;
	if (Length % 2 != 0) Length++;
	h->Length = Length;
	for (int i = 0;i<SpectrumChart->SeriesList->Count;i++)
		SpectrumChart->Series[0]->Free();

	for (int i=0;i<11;i++)
	{
		SpectrumChart->AddSeries(new TFastLineSeries(SpectrumChart));
		(*SpectrumChart->Spectrums)[0]->Series = SpectrumChart->Series[i];
		SpectrumChart->Series[i]->Title = SignalWindowToString(TSignalWindowType(i));

		switch ((TSignalWindowType)i)
		{
			case wtBlackman: FirImpulse(h,OPENARRAY(double,(Freq,Freq+0.05)),0.3,ftLowPass, (TSignalWindowType)i,2);break;
			case wtKaiser: FirImpulse(h,OPENARRAY(double,(Freq,Freq+0.05)),KaiserBetaFir(Math387::Power(10,-Att/20)),ftLowPass, (TSignalWindowType)i,2);break;
			default: FirImpulse(h,OPENARRAY(double,(Freq,Freq+0.05)),Att,ftLowPass, (TSignalWindowType)i,2);
		}
		SpectrumAnalyzer->Process(h); //no denominator and place result in self
	}
	SpectrumChart->Legend->Visible = True;


}

void __fastcall TWindowFiltersForm::FreqEditChange(TObject *Sender)
{
	FillSeries(FreqEdit->Position,TransEdit->Position,FilterLengthEdit->IntPosition);
}
//---------------------------------------------------------------------------
