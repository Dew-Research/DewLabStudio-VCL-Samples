//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "AmpltRatios.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TAmpltRatiosForm *AmpltRatiosForm;
//---------------------------------------------------------------------------
__fastcall TAmpltRatiosForm::TAmpltRatiosForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	ComboBox1->ItemIndex = 0;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("In the example below "
		"you can examine the amplitude ratios between different frequency peaks. The first peak "
		"clicked will become 1.");

}
//---------------------------------------------------------------------------
void __fastcall TAmpltRatiosForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
//void ButterFilterFun(int order, double cutOff, int lowHighPass, double sampleRate, double* coeffA, double *coeffB)
//{
//	int result = 0;
//	TVec *num,*den;
//	CreateIt(num,den);
//	try
//	{
//		 if (lowHighPass > 1) return;
//		 if (lowHighPass < 0) return;
//
//		 ButterFilter( order, OPENARRAY(double, (cutOff)), Signalutils::TFilterType(lowHighPass), false, num, den);
//		 for (int i = 0; i <= order; i++) {
//
//			 coeffA[i] = num->Values1D[i];
//			 coeffB[i] = den->Values1D[i];
//		 }
//	}
//	__finally
//	{
//		FreeIt(num,den);
//	}
//
//
//	return;
//}
//
void __fastcall TAmpltRatiosForm::ChartEditButtonClick(TObject *Sender)
{
//	double num[3], den[3];
//	ButterFilterFun(2, 0.2, 0, 3, &num[0], &den[0]);
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TAmpltRatiosForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
TSpectrumMarkTool* __fastcall TAmpltRatiosForm::GetMarkTool()
{
	for (int i=0; i<SpectrumChart->Tools->Count; i++) {
		TSpectrumMarkTool* result = dynamic_cast<TSpectrumMarkTool*>(SpectrumChart->GetTool(i));
		if (result != NULL) return result;
	}
	ERaise("Spectrum mark tool not found!");
}
//---------------------------------------------------------------------------

void __fastcall TAmpltRatiosForm::ComboBox1Change(TObject *Sender)
{
	GetMarkTool()->MarkMode = (TSpectrumMarkMode)ComboBox1->ItemIndex;
}
//---------------------------------------------------------------------------

void __fastcall TAmpltRatiosForm::SpectrumChartAfterMarkPeak(TObject *Sender)
{
	if (SpectrumAnalyzer->Peaks->List->Count == 1)
	{
		SpectrumAnalyzer->ScaleFactor = SpectrumAnalyzer->ScaleFactor/(*SpectrumAnalyzer->Peaks)[0]->Amplt;
		SpectrumAnalyzer->Update();
	}
}
//---------------------------------------------------------------------------

