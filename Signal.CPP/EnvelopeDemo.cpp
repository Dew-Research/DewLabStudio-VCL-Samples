//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "EnvelopeDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TEnvelopeDemoForm *EnvelopeDemoForm;
//---------------------------------------------------------------------------
__fastcall TEnvelopeDemoForm::TEnvelopeDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	SignalIncBuffer2->SuspendNotifyUpdate = true; //prevent chart updates for every call to Update
	SignalIncBuffer2->Factor = 13;  //increase the buffer by 13x, because SignalRead1->Length = 1024 and SignalRead1->RecordLength = 14000
	SignalIncBuffer1->Factor = 11;  //increase the buffer of the decimator output only by 11x,
																	//because the first two blocks will contain FIR filter delay
																	//in that way the 12th and 13th block will push out blocks 0 and 1
																	//from the circular buffer
	while (SignalIncBuffer1->Pull() != pipeEnd) //Pull is True until the end of file-> (Until the last full frame)
	{
		SignalIncBuffer2->Update(); //Copy data from SignalRead1 to SignalIncBuffer2
	}
	SpectrumAnalyzer->ZeroPadding = 4;
	SpectrumAnalyzer->Update(); //compute the spectrum and update TSpectrumChart
	SignalIncBuffer2->UpdateNotify();  //update TSignalChart
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The strongest peak in the spectrum shows the frequency of the envelope. "
		"That frequency is noticed on the bottom chart when looking at the peaks "
		"of the time signal only. The sampling frequency is reduced by 64 times.");

}
//---------------------------------------------------------------------------
void __fastcall TEnvelopeDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TEnvelopeDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TEnvelopeDemoForm::SpectrumAnalyzerParameterUpdate(
			TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TEnvelopeDemoForm::FormResize(TObject *Sender)
{
	SpectrumChart->Height = Panel2->Height / 2;
}
//---------------------------------------------------------------------------
