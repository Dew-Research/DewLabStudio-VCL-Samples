//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Demodulator.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TDemodulatorForm *DemodulatorForm;
//---------------------------------------------------------------------------
__fastcall TDemodulatorForm::TDemodulatorForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("TSignalDemodulator component moves the selected bandwidth down to 0Hz. "
						"The component features multi-rate, multi-stage decimation which allows "
						"demodulation of very narrow frequency bands (less then 0.01% of original bandwidth "
						"is not a problem). In the example below you can change the Frequency and Bandwidth "
						"parameters. Bandwidth change will have effect only when the change made will "
						"result in sampling frequency reduction/increase by 2x. Both frequency and bandwidth are "
						"defined in radians and must range between 0 and 0.5 and frequency + bandwidth may not be bigger then 0.5. "
						"The component also allows you to sample with sampling frequency of 44.1Khz directly from "
						"the sound card and have a real time frequency spectrum display of bandwidth between 20 and 20.1 Khz "
						"with frequency resolution of 1 mHz (for example).");
	SignalRead1->OpenFile();
	SignalRead1->RecordPosition = 0;
	SpectrumAnalyzer1->Pull();
	SpectrumAnalyzer1->Pull();
	SpectrumAnalyzer3->Update();
}
//---------------------------------------------------------------------------
void __fastcall TDemodulatorForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog1->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TDemodulatorForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor1->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TDemodulatorForm::FormResize(TObject *Sender)
{
	SpectrumChart3->Height = Panel1->Height / 2;	
}
//---------------------------------------------------------------------------
void __fastcall TDemodulatorForm::MtxFloatEdit1Change(TObject *Sender)
{
	SG1->SubBandFrequency = MtxFloatEdit1->Position;
	SG1->SubBandWidth = MtxFloatEdit2->Position;
	SignalRead1->RecordPosition = 0;
	SpectrumAnalyzer1->Pull();
	SpectrumAnalyzer1->Pull();
	SpectrumAnalyzer3->Update();
}
//---------------------------------------------------------------------------
void __fastcall TDemodulatorForm::SpectrumAnalyzer1ParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer1->Update();
	SpectrumAnalyzer3->Update();
}
//---------------------------------------------------------------------------
