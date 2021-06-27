//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "Differentiator.h"
#include "OptimalFir.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TDifferentiatorForm *DifferentiatorForm;
//---------------------------------------------------------------------------
__fastcall TDifferentiatorForm::TDifferentiatorForm(TComponent* Owner)
	: TForm(Owner)
{
	DiffBox->ItemIndex = 0;
	TransBWEditChange(this);
	SpectrumChart->Legend->Visible = true;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Differentiation is often required to obtain velocity and acceleration "
		"from a sensor returning displacement. Likewise, integration "
		"is required to obtain velocity and displacement from acceleration as returned by "
		"the accelerometers. "
		"If the integrated/differentiated signal is not required, "
		"the integration/differentiation can be performed in frequency domain only "
		"while analyzing the frequency spectrum. The advantage of using a FIR filter "
		"over numerical differentiation/integration methods is the linear phase. "
		"The Integrator filter also filters the DC component.");

}
//---------------------------------------------------------------------------
void __fastcall TDifferentiatorForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TDifferentiatorForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TDifferentiatorForm::SpectrumAnalyzerParameterUpdate(
			TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TDifferentiatorForm::ComputeError(TVec *h, TIntegration Integration, TVec *Err, TSample FS)
{
	Mtxexpr::sVector H1,A1,A2;

	H1.Length = h->Length;
	H1.SetZero();
	H1[0] = 1; //simple impulse for testing
	TIntegration Int = SpectrumAnalyzer->Integration;
	SpectrumAnalyzer->Integration = Integration;
	SpectrumAnalyzer->DCDump = false;
	SpectrumAnalyzer->Window = wtRectangular;
	SpectrumAnalyzer->ZeroPadding = 8;
	SpectrumAnalyzer->Process(H1,NULL,NULL,NULL,FS);
	A1.Copy(SpectrumAnalyzer->Amplt);
	SpectrumAnalyzer->Integration = inNone;
	SpectrumAnalyzer->Process(h,NULL,NULL,NULL,FS);
	A2.Copy(SpectrumAnalyzer->Amplt);
	Err->Sub(A1,A2);
	SpectrumAnalyzer->Integration = Int;
}
void __fastcall TDifferentiatorForm::TransBWEditChange(TObject *Sender)
{
	FillSeries(TransBWEdit->Position,0.0001, DiffBox->ItemIndex);
}
//---------------------------------------------------------------------------
void __fastcall TDifferentiatorForm::FillSeries(TSample TransBW, TSample Ripple, int Pindex)
{
	AnsiString Title;
	Mtxexpr::sVector H,err;
	TSample FS = 2;
	switch (Pindex)
	{
		case 0: {  //differentiate in time
			Title = "Frequency response of a type III differentiator filter (Kaiser).";
			KaiserImpulse(H,OPENARRAY(double,(FS/2-TransBW,FS/2)),Ripple, ftDifferentiatorIII,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,diffOnce,err,FS);
		};break;
		case 1: {  //differentiate in time
			Title = "Frequency response of a type IV linear phase differentiator filter (Kaiser).";
			KaiserImpulse( H,OPENARRAY(double,(FS/2-TransBW,FS/2)),Ripple, ftDifferentiatorIV,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,diffOnce,err,FS);
		};break;
		case 2: {  //differentiate in time (certified)
			Title = "Frequency response of a type III differentiator filter (remez).";
			RemezImpulse(H,OPENARRAY(double,(0,FS/2-TransBW)),Ripple, ftDifferentiatorIII,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,diffOnce,err,FS);
		};break;
		case 3: {  //differentiate in time (certified)
			Title = "Frequency response of a type IV differentiator filter (remez).";
			RemezImpulse( H,OPENARRAY(double,(0,FS/2-TransBW)),Ripple, ftDifferentiatorIV,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,diffOnce,err,FS);
		};break;
		case 4: {
			Title = "Frequency response of a type III 2x differentiator filter (remez).";
			RemezImpulse(H,OPENARRAY(double,(TransBW,FS/2-TransBW)),Ripple, ftDoubleDifferentiatorIII,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,diffTwice,err,FS);
		};break;
		case 5: {
			Title = "Frequency response of a type IV 2x differentiator filter (remez).";
			RemezImpulse(H,OPENARRAY(double,(TransBW,FS/2-TransBW)),Ripple, ftDoubleDifferentiatorIV,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,diffTwice,err,FS);
		};break;
		case 6: {
			Title = "Frequency response of a type III integrator  filter (remez).";
			RemezImpulse(H,OPENARRAY(double,(TransBW,FS/2-TransBW)),Ripple, ftIntegratorIII,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,inOnce,err,FS);
		};break;
		case 7: {
			Title = "Frequency response of a type IV integrator  filter (remez).";
			RemezImpulse(H,OPENARRAY(double,(TransBW,FS/2)),Ripple, ftIntegratorIV,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,inOnce,err,FS);
		};break;
		case 8: {
			Title = "Frequency response of a type III 2x integrator  filter (remez).";
			RemezImpulse(H,OPENARRAY(double,(TransBW,FS/2-TransBW)),Ripple, ftDoubleIntegratorIII,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,inTwice,err,FS);
		};break;
		case 9: {
			Title = "Frequency response of a type IV 2x integrator  filter (remez).";
			RemezImpulse(H,OPENARRAY(double,(TransBW,FS/2)),Ripple, ftDoubleIntegratorIV,1,FS);
			SpectrumAnalyzer->Integration = inNone;
			FirLengthLabel->Caption = "Fir length = " + IntToStr(H.Length);
			ComputeError(H,inTwice,err,FS);
		};break;
		case 10:{ //differentiate in frequency
			Title = "Differentiator applied in frequency domain.";
			H.Length = 128;
			H.SetZero();
			H[0] = 1;  //simple impulse for testing->
			SpectrumAnalyzer->Integration = diffOnce;
			FirLengthLabel->Caption = "Fir length = 0";
		};break;
		case 11:{ //differentiate in frequency twice
			Title = "Differentiator applied twice in frequency domain.";
			H.Length = 128;
			H.SetZero();
			H[0] = 1;  //simple impulse for testing->
			SpectrumAnalyzer->Integration = diffTwice;
			FirLengthLabel->Caption = "Fir length = 0";
		};break;
		case 12:{  //integrate in frequency
			Title = "Integrator applied in frequency domain.";
			H.Length = 128;
			H.SetZero();
			H[0] = 1; //simple impulse for testing
			SpectrumAnalyzer->Integration = inOnce;
			FirLengthLabel->Caption = "Fir length = 0";
		};break;
		case 13:{  //integrate in frequency twice
			Title = "Integrator applied twice in frequency domain.";
			H.Length = 128;
			H.SetZero();
			H[0] = 1; //simple impulse for testing
			SpectrumAnalyzer->Integration = inTwice;
			FirLengthLabel->Caption = "Fir length = 0";
		};break;
	}
	SpectrumChart->Title->Text->Clear();
	SpectrumChart->Title->Text->Add(Title);
	SpectrumAnalyzer->DCDump = false;
	SpectrumAnalyzer->Window = wtRectangular;
	SpectrumAnalyzer->ZeroPadding = 8;
	SpectrumAnalyzer->Process(H,NULL,NULL,NULL,FS);
	DrawValues(err,SpectrumChart->Series[1],0,SpectrumAnalyzer->HzRes);
}
void __fastcall TDifferentiatorForm::PhaseBoxClick(TObject *Sender)
{
	SpectrumChart->SpectrumPart = (TSpectrumPart)PhaseBox->Checked;
	switch (SpectrumChart->SpectrumPart)
	{
		case sppAmplt:
		{
			SpectrumChart->LeftAxis->Title->Caption = "Amplitude";
			Series2->Active = true;
		};break;
		case sppPhase:
		{
			SpectrumChart->LeftAxis->Title->Caption = "Phase [degrees]";
			Series2->Active = False;
		};break;
	}
}
//---------------------------------------------------------------------------

