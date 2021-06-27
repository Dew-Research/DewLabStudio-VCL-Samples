//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MonitorDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TMonitorDemoForm *MonitorDemoForm;
//---------------------------------------------------------------------------
__fastcall TMonitorDemoForm::TMonitorDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	Signal1->Data->Size(4096);  //defines how much data to copy and consequently also frequency resolution
	Signal1->Data->SetZero();
	Signal1->UsesInputs = false;
	SignalWrite1->Precision = prSmallInt; //or prInteger or prByte (others will not work)->
	ChannelBox->ItemIndex = 0;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The recording is set up for 44kHz stereo. The best way to test this demo is to "
		"speak in to the microphone. You can select the channel you wish to monitor."
		"If Record to file checkbox is checked, the signal will be recorded to C:\\test.wav."
		"Note the responsivnes of the charts (a very short delay from the time you speak  "
		"to when the display shows the change) while recording to file.");

}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart->Height = Panel2->Height / 2;
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::RecordToFileBoxClick(TObject *Sender)
{
	switch (SignalIn1->Quantization)
	{
		case 8:  SignalWrite1->Precision = prByte;break;
		case 16: SignalWrite1->Precision = prSmallInt;break;
		case 24: SignalWrite1->Precision = prInt24;break;
	}
	SignalWrite1->Active = RecordToFileBox->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::Spectrum1Click(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::imechart1Click(TObject *Sender)
{
	ChartEditor1->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::Recording1Click(TObject *Sender)
{
	SignalInDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::Spectrumchart1Click(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::StartButtonClick(TObject *Sender)
{
	SignalIn1->Start();	
}
//---------------------------------------------------------------------------
void __fastcall TMonitorDemoForm::SignalTimer1Timer(TObject *Sender)
{
	if (!SignalIn1->Active) return;
	SignalIn1->TriggerChannel = (TChannel)ChannelBox->ItemIndex;
	switch (SignalIn1->TriggerChannel)
	{
		case chLeft:  SignalIn1->Trigger(Signal1, NULL );break;
		case chRight: SignalIn1->Trigger(NULL, Signal1);break;
	}
	SpectrumAnalyzer->Pull();  //calls update on Signal1 and Self
}
//---------------------------------------------------------------------------
