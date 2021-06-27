//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "BicoherenceTest.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBicoherenceTestForm *BicoherenceTestForm;
//---------------------------------------------------------------------------
__fastcall TBicoherenceTestForm::TBicoherenceTestForm(TComponent* Owner)
	: TForm(Owner)
{
	Signal1->UsesInputs = false;
	BiSpectrumAnalyzer->Amplt->SetZero();
	Freq1EditChange(this);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("This test feeds the bispectrum analyzer with the "
		"following test signal: Sin(w1)+Sin(w2)+Sin(w1)*Sin(w1)+Some_Gaussian_Noise. "
		"The result should be two dots. Sum and difference frequencies in the bicoherence spectrum "
		"located at (w1,w2-w1) and (w2,w1)");

}
//---------------------------------------------------------------------------
void __fastcall TBicoherenceTestForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TBicoherenceTestForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TBicoherenceTestForm::Freq1EditChange(TObject *Sender)
{
	Button1Click(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TBicoherenceTestForm::Button1Click(TObject *Sender)
{
	ToneInit(Freq1Edit->Position/Signal1->SamplingFrequency,0,1,ToneState1);
	ToneInit(Freq2Edit->Position/Signal1->SamplingFrequency,0,1,ToneState2);
	BiSpectrumAnalyzer->ResetAveraging();
	BiSpectrumAnalyzer->Window = SpectrumAnalyzer->Window;
	for (int i=0;i<=25;i++) BiSpectrumAnalyzer->Pull();
	BiSpectrumAnalyzer->BiAnalyzer->Update(); //compute bicoherence
	BiSpectrumAnalyzer->BiAnalyzer->GetFullSpectrum(BMtx,true);  //get result

	Series1->Clear();
	Series1->ColorPalette->TopColor = clBlue;
	Series1->ColorPalette->BottomColor = clWhite;
	Series1->Matrix = BMtx; //must be set->->-> to copy the data;
//         CreateDefaultPalette;
	Series1->Repaint();
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TBicoherenceTestForm::Signal1AfterUpdate(TObject *Sender)
{
	Mtxexpr::sVector Tone1, Tone2;

	Tone1.Size(Signal1->Data);
	Tone2.Size(Signal1->Data);

	Tone(Tone1,ToneState1);
	Tone(Tone2,ToneState2);
	Signal1->Data->Copy(Tone1);
	Signal1->Data->Add(Tone2);

	Tone2.Mul(Tone1);
	Tone1.RandGauss(0,0.1);
	Signal1->Data->Add(Tone2);                         
	Signal1->Data->Add(Tone1);
}
//---------------------------------------------------------------------------
void __fastcall TBicoherenceTestForm::Panel2Resize(TObject *Sender)
{
	Chart1->Height = (int) (Panel2->Height*0.66);
}
//---------------------------------------------------------------------------
