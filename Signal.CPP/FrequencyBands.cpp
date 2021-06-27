//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrequencyBands.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "VCLTee.TeeEdit"
#pragma resource "*.dfm"
TFrequencyBandsForm *FrequencyBandsForm;
//---------------------------------------------------------------------------
__fastcall TFrequencyBandsForm::TFrequencyBandsForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrequencyBandsForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TFrequencyBandsForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TFrequencyBandsForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TFrequencyBandsForm::FormCreate(TObject *Sender)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	ComboBox1->ItemIndex = 0;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The frequency analyzer allows you to define frequency regions " 
					"of interest and compute RMS of those regions. Click " 
					"the spectrum button and then switch to Bands panel. " 
					"First create a new template and then define a band and " 
					"press the Update button.");
}
//---------------------------------------------------------------------------
TSpectrumMarkTool* __fastcall TFrequencyBandsForm::GetMarkTool()
{
	for (int i=0; i<SpectrumChart->Tools->Count; i++) {
		TSpectrumMarkTool* result = dynamic_cast<TSpectrumMarkTool*>(SpectrumChart->GetTool(i));
		if (result != NULL) return result;
	}
	ERaise("Spectrum mark tool not found!");
}
void __fastcall TFrequencyBandsForm::ComboBox1Change(TObject *Sender)
{
	GetMarkTool()->MarkMode = (TSpectrumMarkMode)ComboBox1->ItemIndex;
}
//---------------------------------------------------------------------------

