//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "CepstrumDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TCepstrumDemoForm *CepstrumDemoForm;
//---------------------------------------------------------------------------
__fastcall TCepstrumDemoForm::TCepstrumDemoForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::FormCreate(TObject *Sender)
{
	SignalRead1->Length = 4096;
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OverlappingPercent = 50;
	SignalRead1->OpenFile();
	CepstrumBox->ItemIndex = 0;
	CepstrumBoxChange(Sender);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Complex cepstrum can be used to measure echo delays and for homomorphic filtering." 
		"Real cepstrum can detect periodicities in the frequency spectrum. ");
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::CepstrumBoxChange(TObject *Sender)
{
	SignalRead1->RecordPosition = 0;
	SpectrumAnalyzer1->ResetAveraging();
	SpectrumAnalyzer1->PullUntilEnd();
	SpectrumAnalyzer1->UpdateNotify(); //Notify disabled within PullUntilEnd
	Signal1->SamplingTime = Signal1->Length;
	Signal1->UpdateNotify();  //update connected chart->
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::SpectrumAnalyzer1ParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer1->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::FormResize(TObject *Sender)
{
	SpectrumChart2->Height = Panel1->Height / 2;	
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog1->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor1->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::ToolButton1Click(TObject *Sender)
{
	ChartEditor2->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TCepstrumDemoForm::SpectrumAnalyzer1AfterUpdate(TObject *Sender)
{
	switch (CepstrumBox->ItemIndex)
	{
		case 0: RealCepstrum(SignalRead1->Data,Data,True,wtHanning,True);break;
		case 1: CplxCepstrum(SignalRead1->Data,Data);break;
	}
	Signal1->Data->SetVal(0,0,1); //set DC to zero
	RunningAverage(Signal1->Data,Data,SignalRead1->FrameNumber);
}
//---------------------------------------------------------------------------
