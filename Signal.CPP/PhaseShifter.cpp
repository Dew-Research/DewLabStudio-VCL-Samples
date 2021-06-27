//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "PhaseShifter.h"
#include "OptimalFir.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPhaseShifterForm *PhaseShifterForm;
//---------------------------------------------------------------------------
__fastcall TPhaseShifterForm::TPhaseShifterForm(TComponent* Owner)
	: TForm(Owner)
{
	DiffBox->ItemIndex = 0;
	TransBWEditChange(this);
	SpectrumChart->Legend->Visible = true;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Hilbert transformers are used to obtain analytical representation of a real signal. "
		"Analytical signal is a complex signal. "
		"Hilbert transformers generate a 90 degree phase shifted version of the original signal. "
		"The original signal becomes the real part and hilbert transformer becomes the imaginary part of "
		"the new analytical signal. Hilbert transformes can be left out in many cases, if the signal is "
		"multiplied with a complex exponential (a complex sine function), which of course also results "
		"in a complex signal.");
}
//---------------------------------------------------------------------------
void __fastcall TPhaseShifterForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPhaseShifterForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPhaseShifterForm::SpectrumAnalyzerParameterUpdate(
			TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TPhaseShifterForm::TransBWEditChange(TObject *Sender)
{
	FillSeries(TransBWEdit->Position,0.02, DiffBox->ItemIndex);
}
//---------------------------------------------------------------------------
void __fastcall TPhaseShifterForm::FillSeries(TSample TransBW, TSample Ripple, int Pindex)
{
	Mtxexpr::sVector H, Err;

	AnsiString Title;
	switch (Pindex)
	{
		case 0: {
			Title = "Frequency response of a type III Hilbert filter (Kaiser)";
			KaiserImpulse( H,OPENARRAY(double,(1-TransBW,1)),Ripple, ftHilbertIII,1,2);
			SpectrumAnalyzer->Integration = inNone;
			H.Scale(H.Length/2);
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,Err);
		};break;
		case 1: {
			Title = "Frequency response of a type IV Hilbert filter (Kaiser)";
			KaiserImpulse( H,OPENARRAY(double,(1-TransBW,1)),Ripple, ftHilbertIV,1,2);
			SpectrumAnalyzer->Integration = inNone;
			H.Scale(H.Length/2);
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,Err);
		};break;
		case 2: {
			Title = "Frequency response of a type III Hilbert filter (remez)";
			RemezImpulse(H,OPENARRAY(double,(TransBW,1-TransBW)),Ripple, ftHilbertIII,1,2);
			SpectrumAnalyzer->Integration = inNone;
			H.Scale(H.Length/2);
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,Err);
		};break;
		case 3: {
			Title = "Frequency response of a type IV Hilbert filter (remez)";
			RemezImpulse( H,OPENARRAY(double,(TransBW,1)),Ripple, ftHilbertIV,1,2);
			SpectrumAnalyzer->Integration = inNone;
			H.Scale(H.Length/2);
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,Err);
		};break;
	}
	SpectrumChart->Title->Text->Clear();
	SpectrumChart->Title->Text->Add(Title);
	SpectrumAnalyzer->DCDump = false;
	SpectrumAnalyzer->Window = wtRectangular;
	SpectrumAnalyzer->ZeroPadding = 16;
	SpectrumAnalyzer->Process(H);
	DrawValues(Err,SpectrumChart->Series[1],0,SpectrumAnalyzer->HzRes);
}

void __fastcall TPhaseShifterForm::ComputeError(TVec *h, TVec *Err)
{
	Mtxexpr::sVector H1,A1,A2;
	H1.Length = h->Length;
	H1.SetZero();
	H1[0] = h->Length/2; //simple impulse for testing
	SpectrumAnalyzer->DCDump = false;
	SpectrumAnalyzer->Window = wtRectangular;
	SpectrumAnalyzer->ZeroPadding = 16;
	SpectrumAnalyzer->Process(H1);
	A1.Copy(SpectrumAnalyzer->Amplt);
	SpectrumAnalyzer->Process(h);
	A2.Copy(SpectrumAnalyzer->Amplt);
	Err->Sub(A1,A2);
}

