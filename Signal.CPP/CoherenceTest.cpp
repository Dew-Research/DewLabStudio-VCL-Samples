//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "CoherenceTest.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TCoherenceTestForm *CoherenceTestForm;
//---------------------------------------------------------------------------
__fastcall TCoherenceTestForm::TCoherenceTestForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::EditSpectrumButtonClick(TObject *Sender)
{
	CrossSpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::SignalRead1AfterUpdate(TObject *Sender)
{
	if (FilteredSignal != NULL) {
		FirFilter(SignalRead1->Data, FilteredSignal->Data, FirState);
		FilteredSignal->SamplingFrequency = SignalRead1->SamplingFrequency;
	}
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::FormCreate(TObject *Sender)
{
	Mtxexpr::sVector h;
	KaiserImpulse(h,OPENARRAY(double,(0.2,0.25)),0.001,ftLowPass,1);
	FirInit(h,FirState);
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	FilteredSignal->UsesInputs = false;
	SpectrumBox->ItemIndex = 4;
	SpectrumChart->Spectrums->Items[0]->Series = SpectrumChart->Series[0];
	ToolButton1Click();

	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The cross spectral analysis is usefull when trying to determine:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("What is the transfer function of the system.");
	RichEdit1->Lines->Add("Is the system linear or not. If it is not linear, at which frequencies "
												"is the system non-linear.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("Change the value of the spectrum box to see the frequency spectrum of the signal that was"
		"send in to the system (input spectrum), what came out (output spectrum), what is the "
		"frequency response of the system (transfer function) and the test for linearity (coherence). "
		"The system in this test case is a low pass FIR filter. With sufficient averaging, coherence "
		"would converge to 1. A coherence of 1 means that the system is linear at that frequency.");
}

void __fastcall TCoherenceTestForm::ToolButton1Click()
{
	SignalRead1->OpenFile();
	SignalRead1->RecordPosition = 0;
	SignalRead1->LastFrameCheck = lfcLastFullBlock;
	//SignalRead1.OverlappingPercent := 50;  we can not use this, because of the filter
	CrossAnalyzer->ResetAveraging();
	CrossAnalyzer->Logarithmic = true;
	CrossAnalyzer->Window = wtHanning;
	CrossAnalyzer->LogType = ltRelative;
	CrossAnalyzer->CrossAnalyzer->Recursive = false;
	while (CrossAnalyzer->Pull() != pipeEnd)
	{
		//fast enough so there is no need for a progress indicator here
	}
	CrossAnalyzer->CrossAnalyzer->Update();  //if recursive would be True, this would not be neccessary.
	SpectrumBoxChange(NULL);

}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::FormDestroy(TObject *Sender)
{
	FirFree(FirState);
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::SpectrumBoxChange(TObject *Sender)
{
	CrossAnalyzer->CrossAnalyzer->Transform = (TCrossTransform)SpectrumBox->ItemIndex;
	SpectrumChart->Title->Text->Clear();
	SpectrumChart->Title->Text->Add(CrossTransformToString(CrossAnalyzer->CrossAnalyzer->Transform));
	CrossAnalyzer->UpdateSpectrum();
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::PhaseBoxClick(TObject *Sender)
{
	SpectrumChart->SpectrumPart = PhaseBox->Checked?sppPhase:sppAmplt;
	switch (SpectrumChart->SpectrumPart) {
		case sppAmplt: SpectrumChart->LeftAxis->Title->Caption = "Amplitude";break;
		case sppPhase:
		{
			switch (CrossAnalyzer->PhaseMode) {
			case pmIgnore: SpectrumChart->LeftAxis->Title->Caption = "Phase [seconds]";break;
			case pm360: SpectrumChart->LeftAxis->Title->Caption = "Phase delay [degrees]";break;
			case pmPhaseDelay: SpectrumChart->LeftAxis->Title->Caption = "Phase delay [seconds]";break;
			case pmGroupDelay: SpectrumChart->LeftAxis->Title->Caption = "Group delay [samples]";break;
			}
			break;
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::CrossAnalyzerParameterUpdate(
      TObject *Sender)
{
		 SpectrumBox->ItemIndex = (byte)CrossAnalyzer->CrossAnalyzer->Transform;
		 SpectrumChart->SpectrumPart = PhaseBox->Checked?sppPhase:sppAmplt;
		 SpectrumChart->Title->Text->Clear();
		 SpectrumChart->Title->Text->Add(CrossTransformToString(CrossAnalyzer->CrossAnalyzer->Transform));
		 CrossAnalyzer->UpdateSpectrum();
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTestForm::UpdateButtonClick(TObject *Sender)
{
	 SignalRead1->RecordPosition = 0;
	 CrossAnalyzer->CrossAnalyzer->Recursive = false;
	 CrossAnalyzer->PullUntilEnd();
	 CrossAnalyzer->CrossAnalyzer->Update();  //if recursive would be True, this would not be neccessary->
	 SpectrumBoxChange(Sender);
}
//---------------------------------------------------------------------------
