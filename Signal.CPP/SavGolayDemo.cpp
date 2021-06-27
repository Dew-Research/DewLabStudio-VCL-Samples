//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "SavGolayDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TSavGolayDemoForm *SavGolayDemoForm;
//---------------------------------------------------------------------------
__fastcall TSavGolayDemoForm::TSavGolayDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Savitzky-golay filter is a polynomial smoothing FIR filter. In the example "
		"below it is applied to the logarithmic frequency spectrum. "
		"Change the frame size and the order of the polynomial. The frame "
		"size must be odd and order can not be bigger then frame size. "
		"Set both parameters to zero to see the raw spectrum.");

}
//---------------------------------------------------------------------------
void __fastcall TSavGolayDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TSavGolayDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TSavGolayDemoForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TSavGolayDemoForm::FrameSizeEditChange(TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TSavGolayDemoForm::SpectrumAnalyzerAfterUpdate(TObject *Sender)
{
	sMatrix H, D;
	int Frs, Ord;
	Frs = FrameSizeEdit->IntPosition;
	if (Frs%2==0) Frs++;
	Ord = OrderEdit->IntPosition;
	SavGolayImpulse(H,D,Frs,Ord,NULL);
	SavGolayFilter(SpectrumAnalyzer->Amplt,H);
}
//---------------------------------------------------------------------------
