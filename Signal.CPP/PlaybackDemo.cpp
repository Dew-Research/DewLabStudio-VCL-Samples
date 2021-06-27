//---------------------------------------------------------------------------

#include <vcl.h>
#include <Avrt.h>
#pragma hdrstop

#include "PlaybackDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPlaybackDemoForm *PlaybackDemoForm;
//---------------------------------------------------------------------------
__fastcall TPlaybackDemoForm::TPlaybackDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	Signal1->Data->Size(2048);  //defines how much data to copy
	Signal1->UsesInputs = false;
	//    SignalRead1->Length = 16384;  //this will automatically set the size of the SignalOut buffer!!
	ChannelBox->ItemIndex = 0;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Open an uncompressed PCM wav file. The signal display and spectrum analyzer will be "
		"updated with a frequency independent of the audio stream being played back. "
		"Note the smooth and very responsive display next to the clean playback. "
		"The screen update frequency is 20Hz, frequency spectrum is based on 2048 samples "
		"and this requires only 20% of 1GHz CPU.");
}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::Spectrum1Click(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::Chart1Click(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::Playback1Click(TObject *Sender)
{
	SignalOutDialog->Execute(); 	
}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::imechart1Click(TObject *Sender)
{
	ChartEditor2->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::SpectrumAnalyzerParameterUpdate(
	  TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart->Height = Panel2->Height / 2;
}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::SignalTimer1Timer(TObject *Sender)
{
	if (!SignalOut1->Active) return;
	switch ((TChannel)ChannelBox->ItemIndex)
	{
		case chLeft:  SignalOut1->MonitorData(Signal1,NULL);break;
		case chRight: SignalOut1->MonitorData(NULL,Signal1);break;
	}
	SpectrumAnalyzer->Pull();  //calls update on Signal1 and Self

}
//---------------------------------------------------------------------------
void __fastcall TPlaybackDemoForm::WaitForPlayback()
{
	SignalOut1->StopAtOnce();
	int i = 0;
	while (i < 10)
	{
		i++;
		Application->ProcessMessages();
		Sleep(20);
	}
}

void __fastcall TPlaybackDemoForm::ToolButton1Click(TObject *Sender)
{
	if (OpenDialog1->Execute())
	{
		WaitForPlayback();   //because you can not start right after being stopped
		SignalRead1->FileName = OpenDialog1->FileName;
		SignalRead1->OpenFile(); //not needed otherwise, but we need Precision and SamplingFrequency fields
		int Len = (int) (0.3*SignalRead1->SamplingFrequency*SignalRead1->ChannelCount); //this is important
		if (Len%2 == 1) Len++;
		SignalRead1->Length = Len;
		// because SignalOut buffer size will use this to set its own BufferSize
		// If BufferSize is too small, the sound will be distorted->
		SignalOut1->Quantization = Math387::Min(24,SizeOfPrecision(SignalRead1->Precision,false)*8);
//		SignalOut1->SamplingFrequency = SignalRead1->SamplingFrequency;
//		SignalOut1->ChannelCount = SignalRead1->ChannelCount;
		SignalOut1->Start();
	}
}
//---------------------------------------------------------------------------

