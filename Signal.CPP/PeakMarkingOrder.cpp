//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PeakMarkingOrder.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPeakMarkingOrderForm *PeakMarkingOrderForm;
//---------------------------------------------------------------------------
__fastcall TPeakMarkingOrderForm::TPeakMarkingOrderForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	ComboBox1->ItemIndex = 0;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Order tracking is a method known from vibration analysis of shafts, which makes " 
		"the sampling frequency of the A/D to be an "
		"integer multiple of the frequency of the rotating shaft. In the example below "
		"you can examine the ratios between different frequency peaks. The first peak "
		"clicked will become the order frequency.");
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingOrderForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingOrderForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingOrderForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();		
}
//---------------------------------------------------------------------------
TSpectrumMarkTool* __fastcall TPeakMarkingOrderForm::GetMarkTool()
{
	for (int i=0; i<SpectrumChart->Tools->Count; i++) {
		TSpectrumMarkTool* result = dynamic_cast<TSpectrumMarkTool*>(SpectrumChart->GetTool(i));
		if (result != NULL) return result;
	}
	ERaise("Spectrum mark tool not found!");
}
void __fastcall TPeakMarkingOrderForm::ComboBox1Change(TObject *Sender)
{
	GetMarkTool()->MarkMode = (TSpectrumMarkMode)ComboBox1->ItemIndex;
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingOrderForm::SpectrumChartAfterMarkPeak(
      TObject *Sender)
{
	SpectrumAnalyzer->Peaks->Update();
	SpectrumAnalyzer->UpdateNotify();
}
//---------------------------------------------------------------------------
