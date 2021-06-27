//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "OnLineBicoherence.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"                            
TOnLineBicoherenceForm *OnLineBicoherenceForm;
//---------------------------------------------------------------------------
__fastcall TOnLineBicoherenceForm::TOnLineBicoherenceForm(TComponent* Owner)
	: TForm(Owner)
{
	// defines how much data to copy and
	// consequently also frequency resolution
	Signal1->Data->Size(1024);
	Signal1->Data->SetZero();
	Signal1->UsesInputs = false;
	Signal1->SamplingFrequency = SignalIn1->SamplingFrequency;
	BiSpectrumAnalyzer->Stats->Averaging = avExponentInf;
	BiSpectrumAnalyzer->Stats->ExpDecay = 20;
	BiSpectrumAnalyzer->Amplt->SetZero();
	BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly = true;
	BiSpectrumAnalyzer->BiAnalyzer->Lines->Size(100);
	BiSpectrumAnalyzer->BiAnalyzer->Lines->Ramp(20,10);  //becase resolution is about 10 Hz/line
	ChannelBox->ItemIndex = 0;
	FreqEditChange(this);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Bicoherence shows the frequencies related to the selected frequency. "
		"The bicoherence can also be run in real time, but before the "
		"spectrum is representative, sufficient number of running averages must be made."
		"A very limiting condition is that the frequency spectrum of the analyzed "
		"signal may not change significantly during the analysis."
		"Bicoherence can therefore be applied only in cases where it is possible "
		"to acquire sufficiently long signals whose frequency content does not change with time "
		"very quickly. For example, usually about 20 averages will be sufficient and with 90% "
		"overlapping. With a sampling frequency of 11kHz and frequency spectrum length of "
		"1024 frequency bins, that would mean that at least 6144/11025 = 0.4 seconds are needed "
		"during which the frequency content of the signal may not change significantly.");
}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::FreqEditChange(TObject *Sender)
{
	BiSpectrumAnalyzer->SamplingFrequency = SignalIn1->SamplingFrequency; //needed only for the first call
	//because the sampling frequency has not yet been set by the Update method,
	//simply because the timer has not yet triggered.
	BiSpectrumAnalyzer->BiAnalyzer->Frequency = FreqEdit->Position;

	((TColorLineTool*)(SpectrumChart->GetTool(2)))->Value = FreqEdit->Position;
	SpectrumChart1->Title->Text->Clear();
	SpectrumChart1->Title->Text->Add("Bicoherence of frequency: " + FormatSample("0",FreqEdit->Position) + "Hz");

}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart1->Height = Panel2->Height / 2;
}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::SignalTimer1Timer(TObject *Sender)
{
	if (!SignalIn1->Active) SignalIn1->Start();
	switch ((TChannel)ChannelBox->ItemIndex)
	{
		case chLeft:  SignalIn1->MonitorData(Signal1, NULL);break;
		case chRight: SignalIn1->MonitorData(NULL, Signal1);break;
	}
	SpectrumAnalyzer->Pull();
	BiSpectrumAnalyzer->Pull();
}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::ToolButton1Click(TObject *Sender)
{
	BiSpectrumAnalyzerDialog1->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TOnLineBicoherenceForm::ChannelBoxChange(TObject *Sender)
{
	BiSpectrumAnalyzer->ResetAveraging();	
}
//---------------------------------------------------------------------------
