//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "SignalAnalysisDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TSignalAnalysisDemoForm *SignalAnalysisDemoForm;
//---------------------------------------------------------------------------
__fastcall TSignalAnalysisDemoForm::TSignalAnalysisDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFilePath(Application->ExeName) + "\\bz.sfs";
	SignalRead1->RecordPosition = 0;
	FilterBox->ItemIndex = 0;
	FilterBoxChange(this);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("A simple drop-in component gives instant access to a wide array " 
					"of standard signal processing operations like autocorrelation, discrete "
					"cosine transform, signal statistics and more...");

}
//---------------------------------------------------------------------------
void __fastcall TSignalAnalysisDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TSignalAnalysisDemoForm::AnalysisButtonClick(TObject *Sender)
{
	SignalAnalyzerDialog1->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TSignalAnalysisDemoForm::FilterBoxChange(TObject *Sender)
{
	SignalAnalyzer1->Transform = (TTimeTransform)FilterBox->ItemIndex;
	SignalAnalyzer1->Update();
}
//---------------------------------------------------------------------------
void __fastcall TSignalAnalysisDemoForm::SignalAnalyzer1ParameterUpdate(
      TObject *Sender)
{
	SignalAnalyzer1->Update();	
}
//---------------------------------------------------------------------------
