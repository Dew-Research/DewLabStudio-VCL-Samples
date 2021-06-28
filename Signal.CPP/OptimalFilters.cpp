//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "OptimalFilters.h"
#include "OptimalFir.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TOptimalFiltersForm *OptimalFiltersForm;
//---------------------------------------------------------------------------
__fastcall TOptimalFiltersForm::TOptimalFiltersForm(TComponent* Owner)
	: TForm(Owner)
{
	SpectrumAnalyzer->LogSpan = ls350;
	SpectrumAnalyzer->Logarithmic = true;
	SpectrumAnalyzer->DCDump = false;
	SpectrumAnalyzer->Window = wtRectangular;
	SpectrumAnalyzer->ZeroPadding = 8;
	FillSeries(0.04,0.000000001);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Optimal FIR filters can be designed by using Parks-McClellan algorithm. " 
					"On the chart below you can see an example of \"auto-length\" band-pass filter design." 
					"Change the required stop band attenuation and the width of the transition regions. " 
					"Not all combinations will result in a valid filter. You can design FIR filters " 
					"with stop band attenuation down to -180 dB and filter length of up to 5000." 
					"For typical aplications FIR filters of length not more then 500 are used.");
}
//---------------------------------------------------------------------------
void __fastcall TOptimalFiltersForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TOptimalFiltersForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TOptimalFiltersForm::ImpulseButtonClick(TObject *Sender)
{
	ViewValues(h);
}
//---------------------------------------------------------------------------
void __fastcall TOptimalFiltersForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TOptimalFiltersForm::FillSeries(TSample TransBW,TSample Ripple)
{
	RemezImpulse(h,OPENARRAY(double,(0.1,0.1+TransBW,0.22-TransBW,0.22)),Ripple,ftBandpass);
	FirLengthLabel->Caption = "Fir length = " + IntToStr(h.Length);
	SpectrumAnalyzer->Process(h);
}
void __fastcall TOptimalFiltersForm::TransBWEditChange(TObject *Sender)
{
	FillSeries(TransBWEdit->Position,Math387::Power(10,-AttEdit->Position/20));
}
//---------------------------------------------------------------------------
