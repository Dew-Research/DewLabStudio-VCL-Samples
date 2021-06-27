//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "TriggerDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TTriggerDemoForm *TriggerDemoForm;
//---------------------------------------------------------------------------
__fastcall TTriggerDemoForm::TTriggerDemoForm(TComponent* Owner)
	: TForm(Owner)
{
//    SignalIn1->MonitorAggressiveness = 50;
	Signal1->Data->Size(4096);  //defines how much data to copy
	Signal1->Data->SetZero();
	Signal1->UsesInputs = false;

	ChannelBox->ItemIndex = 0;
	PositionEdit->ItemIndex = 0;
	Signal1->SamplingFrequency = SignalIn1->SamplingFrequency;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The recording is setup for 11025 kHz stereo. The channel displayed is always " 
		"Left, but the channel on which the trigger condition is searched for can be altered. "
		"The best way to test this demo is to "
		"speak in to the microphone. You can select the trigger channel, trigger "
		"condition and which part of the signal to view relative to the trigger found. "
		"The trigger has to be reset manually by pressing the Reset button. "
		"The trigger can also be set to trigger automatically each time a trigger "
		"condition is found. The trigger condition can be searched for on a different channel "
		"from the one from which the data will be fetched. Catch-ups displayed in the title of the time signal "
		"show how many times the samples had to be skipped (see help for more info). "
		"There are many other options available.");

}
//---------------------------------------------------------------------------
void __fastcall TTriggerDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TTriggerDemoForm::ResetButtonClick(TObject *Sender)
{
	SignalIn1->ResetTriggers();	
}
//---------------------------------------------------------------------------
void __fastcall TTriggerDemoForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TTriggerDemoForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart->Height = Panel2->Height / 2;
}
//---------------------------------------------------------------------------
void __fastcall TTriggerDemoForm::SignalTimer1Timer(TObject *Sender)
{
	if (!SignalIn1->Active) SignalIn1->Start();
	SignalIn1->TriggerChannel = (TChannel)ChannelBox->ItemIndex;
	SignalIn1->TriggerAbove = AboveEdit->Position;
	SignalIn1->TriggerBelow = -INF;
	SignalIn1->TriggerDelay = 0;
	SignalIn1->TriggerPosition = (TTriggerPosition)PositionEdit->ItemIndex;
	SignalIn1->TriggerMode = trAboveBelow;
	SignalIn1->Triggering = trSingle;
	if (SignalIn1->Trigger(Signal1,NULL))
	{
		SpectrumAnalyzer->Pull();  //calls update on Signal1 and Self
		SignalChart1->Title->Text->Clear();
		SignalChart1->Title->Text->Add("Signal just after the sample, which triggered (Catch ups =" +
		IntToStr(SignalIn1->TriggerCatchUps[ChannelBox->ItemIndex]) + ")");
		CountLabel->Caption = "Count = " + IntToStr(SignalIn1->TriggerCount[ChannelBox->ItemIndex]);
	}
}
//---------------------------------------------------------------------------
