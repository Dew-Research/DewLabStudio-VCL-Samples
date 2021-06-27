//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "CZTDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TCZTDemoForm *CZTDemoForm;
//---------------------------------------------------------------------------
__fastcall TCZTDemoForm::TCZTDemoForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TCZTDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TCZTDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TCZTDemoForm::SpectrumAnalyzerParameterUpdate(TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TCZTDemoForm::CZTStartEditChange(TObject *Sender)
{
	SpectrumAnalyzer->CZT->StartFrequency = CZTStartEdit->Position;
	CZTBWEditChange(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TCZTDemoForm::CZTBWEditChange(TObject *Sender)
{
	SpectrumAnalyzer->CZT->StopFrequency = CZTStartEdit->Position + CZTBWEdit->Position;
	CZTLinesEditChange(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TCZTDemoForm::CZTLinesEditChange(TObject *Sender)
{
	SpectrumAnalyzer->CZT->FrequencyStep = (SpectrumAnalyzer->CZT->StopFrequency-
		SpectrumAnalyzer->CZT->StartFrequency) / CZTLinesEdit->Position;
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TCZTDemoForm::FormCreate(TObject *Sender)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	SpectrumAnalyzer->Method = smCZT;
	SpectrumAnalyzer->Pull();
	CZTStartEditChange(Sender);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Chirp Z-transform allows efficient oversampling of "
		"narrow frequency bands in the frequency spectrum. "
		"Start Freq defines the left edge of the frequency band. "
		"BW is the bandwidth of the frequency band and "
		"Lines defines the number of lines to be computed within "
		"that frequency band. Hold down the CTRL key and double click "
		"the edit boxes to change the up/down step.");
	RichEdit1->Lines->Add("");
}
//---------------------------------------------------------------------------
