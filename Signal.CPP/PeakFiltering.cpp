//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <MtxExpr.hpp>
#include "PeakFiltering.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPeakFilteringForm *PeakFilteringForm;
//---------------------------------------------------------------------------
__fastcall TPeakFilteringForm::TPeakFilteringForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	ComboBox1->ItemIndex = 0;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Mark a peak to filter it from the signal:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("The \"filter\" computes Amplitude and Phase from the frequency spectrum "
		"and then subtracts a single sine from the time series. The frequency spectrum "
		"is then recalculated.");
	RichEdit1->Lines->Add("There are two data sets to chose from and it is possible to switch between " 
		"logarithmic and linear axis.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;

}
//---------------------------------------------------------------------------
void __fastcall TPeakFilteringForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakFilteringForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakFilteringForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TPeakFilteringForm::CheckBox1Click(TObject *Sender)
{
	SpectrumAnalyzer->Logarithmic = CheckBox1->Checked;
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
TSpectrumMarkTool* __fastcall TPeakFilteringForm::GetMarkTool()
{
	for (int i=0; i<SpectrumChart->Tools->Count; i++) {
		TSpectrumMarkTool* result = dynamic_cast<TSpectrumMarkTool*>(SpectrumChart->GetTool(i));
		if (result != NULL) return result;
	}
	ERaise("Spectrum mark tool not found!");
}
//---------------------------------------------------------------------------
TAxisScaleTool* __fastcall TPeakFilteringForm::GetAxisScaleTool()
{
	for (int i=0; i<SpectrumChart->Tools->Count; i++) {
		TAxisScaleTool* result = dynamic_cast<TAxisScaleTool*>(SpectrumChart->GetTool(i));
		if (result != NULL) return result;
	}
	ERaise("Spectrum mark tool not found!");
}
void __fastcall TPeakFilteringForm::ComboBox1Change(TObject *Sender)
{
	Signal1->UsesInputs = false;  //indicate there is nothing connected to it
	SignalRead1->RecordPosition = 0; //reset the file position->
	switch (ComboBox1->ItemIndex)
	{
		case 0: SpectrumAnalyzer->Input = SignalRead1;break;
		case 1: SpectrumAnalyzer->Input = Signal1;break;
	}
	//Peak hold must be reset because its two different sets of data->
	GetAxisScaleTool()->Reset();
	GetMarkTool()->ClearMarks();
	//end peak hold reset
	SpectrumAnalyzer->Pull();
}
//---------------------------------------------------------------------------
void __fastcall TPeakFilteringForm::Signal1AfterUpdate(TObject *Sender)
{
	Mtxexpr::sVector a;
	TToneState ToneState;

	a.Size(1024);
	ToneInit(0.1,0,1,ToneState);
	Tone(a,ToneState);
	Signal1->Data->Copy(a);
	ToneInit(0.12,0,1,ToneState);
	Tone(a,ToneState);
	Signal1->Data->Add(a);
}
//---------------------------------------------------------------------------
