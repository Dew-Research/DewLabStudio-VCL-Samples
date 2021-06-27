//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "MtxExpr.hpp"
#include "BispectrumSurface.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBiSpectrumSurfaceForm *BiSpectrumSurfaceForm;
//---------------------------------------------------------------------------
__fastcall TBiSpectrumSurfaceForm::TBiSpectrumSurfaceForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	BiSpectrumAnalyzer->Amplt->SetZero();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Bicoherence shows peaks where the frequency pair is related to a third frequency component "
		"defined as e^jw1 * e^jw2 = e^j(w1+w2). Bicoherence  "
		"will be 1 for a frequency pair (w1,w2) which has a product of itself (e^jw1*e^jw2) "
		"in the frequency spectrum. You can also compute only "
		"preselected frequency lines by checking the Single lines only box.");
	Button1Click(this);
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumSurfaceForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumSurfaceForm::Button1Click(TObject *Sender)
{
	Mtxexpr::sVector av,bv;
	sMatrix AMtx;

	SignalRead1->OpenFile();
	SignalRead1->RecordPosition = 0;
	SignalRead1->OverlappingPercent = 50;
	Screen->Cursor = crHourGlass;

	if (SingleLinesOnlyBox->Checked)
	{
		BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly = true;
		BiSpectrumAnalyzer->BiAnalyzer->Lines->Length = 32; //compute only 32 lines
		BiSpectrumAnalyzer->BiAnalyzer->Lines->Ramp(16*SignalRead1->HzRes,SignalRead1->HzRes);
	} else BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly = false;

	BiSpectrumAnalyzer->ResetAveraging();
	while (BiSpectrumAnalyzer->Pull() != pipeEnd)
	{
		ProgressLabel->Caption = "Progress: " + FormatSample("0",SignalRead1->FrameNumber*100/SignalRead1->MaxFrames) + " [%]";
		ProgressLabel->Update();
	}

	BiSpectrumAnalyzer->BiAnalyzer->Update(); //compute bicoherence

	ClearFPU(); //Required only for Delphi 4 and 5

	Series1->Clear();
	Series1->IrregularGrid = True;

	for (int i=0;i<BiSpectrumAnalyzer->Length/2;i++)
	{
		BiSpectrumAnalyzer->BiAnalyzer->Frequency = i*BiSpectrumAnalyzer->HzRes;
		if (!BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly)
			BiSpectrumAnalyzer->BiAnalyzer->DecodeBispectrumMatrix(av);
		else
			BiSpectrumAnalyzer->BiAnalyzer->DecodeSingleLineMatrix(av);
		for (int j = 0;j<BiSpectrumAnalyzer->Length;j++)
		{
			if (av[j] != 0) Series1->AddXYZ(j*BiSpectrumAnalyzer->HzRes,av[j],i*BiSpectrumAnalyzer->HzRes);
		}
	}
	Screen->Cursor = crDefault;

}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumSurfaceForm::SingleLinesOnlyBoxClick(TObject *Sender)
{
	Button1Click(Sender);	
}
//---------------------------------------------------------------------------
