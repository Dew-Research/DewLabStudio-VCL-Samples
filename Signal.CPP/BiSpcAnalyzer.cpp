//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "BiSpcAnalyzer.h"
#include "FileSignal.hpp"
#include "VCLTee.TeeStore.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBiSpcAnalyzerForm *BiSpcAnalyzerForm;
//---------------------------------------------------------------------------
__fastcall TBiSpcAnalyzerForm::TBiSpcAnalyzerForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	BiSpectrumAnalyzer->Amplt->SetZero();
	FrequencyEditChange(this);
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart1->Height = Panel2->Height / 2;
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::Openfile1Click(TObject *Sender)
{
	OpenDialog->Filter = SignalDialogFilter;
	if (OpenDialog->Execute())
	{
		SignalRead1->FileName = OpenDialog->FileName;
		SignalRead1->OpenFile();
	}
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::ToolButton1Click(TObject *Sender)
{
	BiSpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::SaveConfigClick(TObject *Sender)
{
	SaveDialog->Filter = "Config files (*.cfg)|*.cfg";
	if (SaveDialog->Execute())
	{
		TFileStream *a = new TFileStream(SaveDialog->FileName, fmOpenWrite | fmCreate);
		try
		{
			//MtxSaveChartToStream(TCustomChart(SpectrumChart),a);
			//MtxSaveChartToStream(TCustomChart(SpectrumChart1),a);
			SaveChartToStream((TCustomChart*)SpectrumChart,a);
			SaveChartToStream((TCustomChart*)SpectrumChart1,a);
			SpectrumAnalyzer->SaveTemplateToStream(a);
			BiSpectrumAnalyzer->SaveTemplateToStream(a);
		}
		__finally
		{
			delete a;
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::LoadConfigClick(TObject *Sender)
{
	OpenDialog->Filter = "Config files (*.cfg)|*.cfg";
	if (OpenDialog->Execute())
	{
		TFileStream *a = new TFileStream(OpenDialog->FileName, fmOpenRead);
		try
		{
			//MtxLoadChartFromStream(TCustomChart(SpectrumChart),a);
			//MtxLoadChartFromStream(TCustomChart(SpectrumChart1),a);

	 //		LoadChartFromStream((TCustomChart*)SpectrumChart,a);
//			LoadChartFromStream((TCustomChart*)SpectrumChart,a);
			SpectrumAnalyzer->LoadTemplateFromStream(a);
			BiSpectrumAnalyzer->LoadTemplateFromStream(a);
			(*SpectrumChart->Spectrums)[0]->Input = SpectrumAnalyzer;
			(*SpectrumChart1->Spectrums)[0]->Input = BiSpectrumAnalyzer;
		}
		__finally
		{
			delete a;
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::BiSpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	((TColorLineTool*)(SpectrumChart->GetTool(2)))->Value = BiSpectrumAnalyzer->BiAnalyzer->Frequency;

	BiSpectrumAnalyzer->UpdateSpectrum();
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::Recalculate1Click(TObject *Sender)
{
	Screen->Cursor = crHourGlass;
	try
	{
		SignalRead1->Length = 1024;
		SignalRead1->RecordPosition = 0;
		SignalRead1->LastFrameCheck = lfcLastFullBlock;
		SignalRead1->OverlappingPercent = 0;
		//just make sure that the processing does not take too long
		SignalRead1->SelectionStart = 0;
		SignalRead1->SelectionStop = 50000;
		SpectrumAnalyzer->Update();
		BiSpectrumAnalyzer->ResetAveraging();
		while (BiSpectrumAnalyzer->Pull() != pipeEnd) // do averaging
		{
			ProgressLabel->Caption = "Progress: " + FormatSample("0",SignalRead1->FrameNumber*100/SignalRead1->MaxFrames) + " [%]";
			Update();
		}
		BiSpectrumAnalyzer->BiAnalyzer->Update(); //compute bicoherence
		BiSpectrumAnalyzer->UpdateSpectrum();
	}
	__finally
	{
		Screen->Cursor = crDefault;
	}
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::FrequencyEditChange(TObject *Sender)
{
	BiSpectrumAnalyzer->BiAnalyzer->Frequency = FrequencyEdit->Position;
	BiSpectrumAnalyzerParameterUpdate(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TBiSpcAnalyzerForm::Copy1Click(TObject *Sender)
{
//	((TSpectrumMarkTool*)((*SpectrumChart1->Tools)[1]))->CursorActive = false;
//	SpectrumChart1->CopyToClipboardMetafile(true,Rect(0,0,750,400));
//	((TSpectrumMarkTool*)((*SpectrumChart1->Tools)[1]))->CursorActive = true;

	((TSpectrumMarkTool*)(SpectrumChart1->Tools->Items[1]))->CursorActive = false;
	SpectrumChart1->CopyToClipboardMetafile(true,Rect(0,0,750,400));
	((TSpectrumMarkTool*)(SpectrumChart1->Tools->Items[1]))->CursorActive = true;
}
//---------------------------------------------------------------------------
