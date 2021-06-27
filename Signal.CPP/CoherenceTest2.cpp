//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "CoherenceTest2.h"
#include "FileSignal.hpp"
#include "VCLTee.TeeStore.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TCoherenceTest2Form *CoherenceTest2Form;
//---------------------------------------------------------------------------
__fastcall TCoherenceTest2Form::TCoherenceTest2Form(TComponent* Owner)
	: TForm(Owner)
{
	OpenDialog->Filter = SignalDialogFilter;
	SamplesBox->ItemIndex = 10;
	SamplesBoxChange(this);
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::PhaseBoxClick(TObject *Sender)
{
	SpectrumChart->SpectrumPart = (TSpectrumPart)PhaseBox->Checked;
	switch (SpectrumChart->SpectrumPart)
	{
		case sppAmplt: SpectrumChart->LeftAxis->Title->Caption = "Amplitude";break;
		case sppPhase: SpectrumChart->LeftAxis->Title->Caption = "Phase [degrees]";break;
	}
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::EditSpectrumButtonClick(TObject *Sender)
{
	CrossSpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::CrossAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumChart->SpectrumPart = (TSpectrumPart)PhaseBox->Checked;
	//SpectrumChart->Title->Text->Clear();
	//SpectrumChart->Title->Text->Add(CrossTransformToString(CrossAnalyzer->CrossAnalyzer->Transform));
	CrossAnalyzer->UpdateSpectrum();
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::UpdateButtonClick(TObject *Sender)
{
	SignalRead1->SelectionStart = 0;
	SignalRead2->SelectionStart = 0;
	SignalRead1->OverlappingPercent = 90;
	SignalRead2->OverlappingPercent = 90;
	SignalRead1->LastFrameCheck = lfcLastFullBlock; //because of averaging
	SignalRead2->LastFrameCheck = lfcLastFullBlock; //because of averaging

	SignalRead1->SelectionStop = SignalRead1->RecordLength;
	SignalRead1->RecordPosition = 0;
	SignalRead2->RecordPosition = 0;
	CrossAnalyzer->Input = SignalRead1;
	CrossAnalyzer->Output = SignalRead2;
	CrossAnalyzer->CrossAnalyzer->Recursive = false;
	CrossAnalyzer->ResetAveraging();
	while (CrossAnalyzer->Pull() != pipeEnd)
	{
		ProgressLabel->Caption = "Progress: " + FormatSample("0",SignalRead1->RecordPosition*100/SignalRead1->SelectionStop) + " [%]";
		this->Update();
	}
	CrossAnalyzer->CrossAnalyzer->Update();  //if recursive would be True, this would not be neccessary.
	CrossAnalyzer->UpdateSpectrum();
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::SamplesBoxChange(TObject *Sender)
{
	SignalRead1->Length = StrToInt(SamplesBox->Text);
	SignalRead2->Length = StrToInt(SamplesBox->Text);
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::CopychartClick(TObject *Sender)
{
	bool btemp = ((TSpectrumMarkTool*)(SpectrumChart->GetTool(1)))->CursorActive;
	((TSpectrumMarkTool*)(SpectrumChart->GetTool(1)))->CursorActive = false;

	SpectrumChart->CopyToClipboardMetafile(true, Rect(0,0,750,350));
	((TSpectrumMarkTool*)(SpectrumChart->GetTool(1)))->CursorActive = btemp;
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::SaveconfigurationClick(TObject *Sender)
{
	SaveDialog->Filter = "Config files (*.cfg)|*.cfg";
	if (SaveDialog->Execute())
	{
		TFileStream *a = new TFileStream(SaveDialog->FileName, fmOpenWrite | fmCreate);
		try
		{
			SaveChartToStream((TCustomChart*)SpectrumChart,a);
			CrossAnalyzer->SaveTemplateToStream(a);
		}
		__finally
		{
			delete a;
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::OpenFile2Click(TObject *Sender)
{
	OpenDialog->Filter = SignalDialogFilter;
	if (OpenDialog->Execute())
	{
		SignalRead2->FileName = OpenDialog->FileName;
		SignalRead2->OpenFile();
	}
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::Openfile1Click(TObject *Sender)
{
	OpenDialog->Filter = SignalDialogFilter;
	if (OpenDialog->Execute())
	{
		SignalRead1->FileName = OpenDialog->FileName;
		SignalRead1->OpenFile();
	}
}
//---------------------------------------------------------------------------
void __fastcall TCoherenceTest2Form::LoadconfigurationClick(TObject *Sender)
{
	OpenDialog->Filter = "Config files (*.cfg)|*.cfg";
	if (OpenDialog->Execute())
	{
		TFileStream *a = new TFileStream(OpenDialog->FileName, fmOpenRead);
		try
		{
			//MtxLoadChartFromStream(TCustomChart(SpectrumChart),a);
//			LoadChartFromStream((TCustomChart*)SpectrumChart,a);
			CrossAnalyzer->LoadTemplateFromStream(a);
			(*SpectrumChart->Spectrums)[0]->Input = CrossAnalyzer;
		}
		__finally
		{
			delete a;
		}
	}
}
//---------------------------------------------------------------------------
