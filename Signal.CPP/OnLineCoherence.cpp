//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "OnLineCoherence.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"                             
TOnLineCoherenceForm *OnLineCoherenceForm;       
//---------------------------------------------------------------------------
__fastcall TOnLineCoherenceForm::TOnLineCoherenceForm(TComponent* Owner)
	: TForm(Owner)
{
	// defines how much data to copy and
	// consequently also frequency resolution
	Signal1->Data->Size(2048);
	Signal1->Data->SetZero();
	Signal1->UsesInputs = false;
	Signal1->SamplingFrequency = SignalIn1->SamplingFrequency;

	Signal2->Data->Size(2048);  
	Signal2->UsesInputs = false;
	Signal2->SamplingFrequency = SignalIn1->SamplingFrequency;

	SpectrumBox->ItemIndex = 0;
	CrossAnalyzer->Stats->Averaging = avExponentInf;
	CrossAnalyzer->Stats->ExpDecay = 20;
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
	RichEdit1->Lines->Add("This example shows how you can run this tests in real time. You could "
		"connect your test signal to the left channel and microphone input to the "
		"right channel. If your test signal would be going to the speakers, the microphone "
		"will be recording the sound comming from them and the transfer function "
		"would show you what is the frequency response of your audio system: "
		"amplifier + cables + speakers + room + microphone. ");


}
//---------------------------------------------------------------------------
void __fastcall TOnLineCoherenceForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TOnLineCoherenceForm::CrossAnalyzerParameterUpdate(
      TObject *Sender)
{
	 SpectrumBox->ItemIndex = Byte(CrossAnalyzer->CrossAnalyzer->Transform);
	 SpectrumChart->Title->Text->Clear();
	 SpectrumChart->Title->Text->Add(CrossTransformToString(CrossAnalyzer->CrossAnalyzer->Transform));
	 CrossAnalyzer->UpdateSpectrum(); //copy the correct TCrossTransfrom to CrossAnalyzer.Amplt
																 //update bands, peaks and chart, but do not perform average
}
//---------------------------------------------------------------------------
void __fastcall TOnLineCoherenceForm::SpectrumBoxChange(TObject *Sender)
{
	CrossAnalyzer->CrossAnalyzer->Transform = (TCrossTransform)SpectrumBox->ItemIndex;
	SpectrumChart->Title->Text->Clear();
	SpectrumChart->Title->Text->Add(CrossTransformToString(CrossAnalyzer->CrossAnalyzer->Transform));
	//copy the correct TCrossTransfrom to CrossAnalyzer->Amplt
	//update bands, peaks and chart, but do not perform average
	CrossAnalyzer->UpdateSpectrum();
}
//---------------------------------------------------------------------------
void __fastcall TOnLineCoherenceForm::SignalTimer1Timer(TObject *Sender)
{
	 if (!SignalIn1->Active) SignalIn1->Start();
	 SignalIn1->MonitorData(Signal1,Signal2);
	 CrossAnalyzer->Pull();
}
//---------------------------------------------------------------------------
void __fastcall TOnLineCoherenceForm::ToolButton1Click(TObject *Sender)
{
	CrossSpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
