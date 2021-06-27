//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "BispectrumColorGrid.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBiSpectrumGridForm *BiSpectrumGridForm;
//---------------------------------------------------------------------------
__fastcall TBiSpectrumGridForm::TBiSpectrumGridForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	BiSpectrumAnalyzer->Amplt->SetZero();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Bicoherence shows dark blue dots where the frequency pair is related to a third frequency component "
		"defined as e^jw1 * e^jw2 = e^j(w1+w2). Bicoherence  "
		"will be 1 for a frequency pair (w1,w2) which has a product of itself (e^jw1*e^jw2) "
		"in the frequency spectrum. You can also compute only "
		"preselected frequency lines by checking the Only a few lines box.");
	Button1Click(this);
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumGridForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumGridForm::Button1Click(TObject *Sender)
{
	Mtxexpr::sVector av;
	sMatrix AMtx;
	Screen->Cursor = crHourGlass;
	SignalRead1->OpenFile();
	SignalRead1->RecordPosition = 0;
	SignalRead1->OverlappingPercent = 50;
	if (SingleLinesOnlyBox->Checked)
	{
		BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly = true;
		BiSpectrumAnalyzer->BiAnalyzer->Lines->Length = 128; //compute only 256 lines
		BiSpectrumAnalyzer->BiAnalyzer->Lines->Ramp(64*SignalRead1->HzRes,SignalRead1->HzRes);
	} else BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly = false;
	BiSpectrumAnalyzer->ResetAveraging();
	while (BiSpectrumAnalyzer->Pull() != pipeEnd)
	{
		ProgressLabel->Caption = "Progress: " + FormatSample("0",SignalRead1->FrameNumber*100/SignalRead1->MaxFrames) + " [%]";
		ProgressLabel->Update();
	}
	BiSpectrumAnalyzer->BiAnalyzer->Update(); //compute bicoherence
	BiSpectrumAnalyzer->BiAnalyzer->GetFullSpectrum(BMtx,true);

	ClearFPU(); //Required only for Delphi 4 and 5
	Series1->Clear();
	Series1->ColorPalette->TopColor = clBlue;                         
	Series1->ColorPalette->BottomColor = clWhite;
	Series1->Matrix = BMtx; //must be set->->->
	//        Series1->CreateDefaultPalette;
	Series1->Repaint();

	Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumGridForm::SingleLinesOnlyBoxClick(TObject *Sender)
{
	Button1Click(Sender);	
}
//---------------------------------------------------------------------------
