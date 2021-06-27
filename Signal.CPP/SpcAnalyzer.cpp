//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "SpcAnalyzer.h"
#include "VCLTee.TeeStore.hpp"
#include "FileSignal.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TSpcAnalyzerForm *SpcAnalyzerForm;
//---------------------------------------------------------------------------
__fastcall TSpcAnalyzerForm::TSpcAnalyzerForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::PhaseBoxClick(TObject *Sender)
{
	SpectrumChart->SpectrumPart = (TSpectrumPart)PhaseBox->Checked;
	switch (SpectrumChart->SpectrumPart)
	{
		case sppAmplt: SpectrumChart->LeftAxis->Title->Caption = "Amplitude";break;
		case sppPhase: SpectrumChart->LeftAxis->Title->Caption = "Phase [degrees]";break;
	}
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::Copychart1Click(TObject *Sender)
{
	((TSpectrumMarkTool*)(SpectrumChart->GetTool(1)))->CursorActive = false;
	SpectrumChart->CopyToClipboardMetafile(true,Rect(0,0,750,350));
	((TSpectrumMarkTool*)(SpectrumChart->GetTool(1)))->CursorActive = true;
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::Saveconfiguration1Click(TObject *Sender)
{
	SaveDialog->Filter = "Config files (*.cfg)|*.cfg";
	if (SaveDialog->Execute())
	{
		TFileStream* a = new TFileStream(SaveDialog->FileName, fmOpenWrite | fmCreate);
		try
		{
			//MtxSaveChartToStream(TCustomChart(SpectrumChart),a);
			SaveChartToStream((TCustomChart*)SpectrumChart,a);
			SpectrumAnalyzer->SaveTemplateToStream(a);
		}
		__finally
		{
			delete a;
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::Openfile1Click(TObject *Sender)
{
	OpenDialog->Filter = SignalDialogFilter;
	if (OpenDialog->Execute())
	{
		SignalRead1->FileName = OpenDialog->FileName;
		SpectrumAnalyzer->Pull();
	}
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::Loadconfiguration1Click(TObject *Sender)
{
	OpenDialog->Filter = "Config files (*.cfg)|*.cfg";
	if (OpenDialog->Execute())
	{
		TFileStream *a = new TFileStream(OpenDialog->FileName, fmOpenRead);
		try
		{
			//MtxLoadChartFromStream(TCustomChart(SpectrumChart),a);
			TCustomChart* CustomChart = (TCustomChart*)SpectrumChart;
			LoadChartFromStream(CustomChart,a);
			SpectrumAnalyzer->LoadTemplateFromStream(a);
			(*SpectrumChart->Spectrums)[0]->Input = SpectrumAnalyzer;
		}
		__finally
		{
			delete a;
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::SignalRead1ParameterUpdate(TObject *Sender)
{
	SignalRead1->Update();
	SignalDemux1->Update();
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::SignalRead1ProcessAll(TObject *Sender)
{
	SpectrumAnalyzer->ResetAveraging();
	SpectrumAnalyzer->PullUntilEnd();
	SpectrumAnalyzer->UpdateNotify();
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::Spectrum1Click(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::Chart1Click(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TSpcAnalyzerForm::File1Click(TObject *Sender)
{
	SignalReadDialog1->Execute();
}
//---------------------------------------------------------------------------
