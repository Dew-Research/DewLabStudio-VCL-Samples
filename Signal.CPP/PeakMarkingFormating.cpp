//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PeakMarkingFormating.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPeakMarkingFormatingForm *PeakMarkingFormatingForm;
//---------------------------------------------------------------------------
__fastcall TPeakMarkingFormatingForm::TPeakMarkingFormatingForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Marked peaks can be formated in many ways:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Change the formating of the associated chart series2 by clicking on the Chart button.");
	RichEdit1->Lines->Add("Change the formating of displayed amplitude labels, by clicking on the Mark tool.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;

}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingFormatingForm::SpectrumEditButtonClick(
			TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingFormatingForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->DefaultTab = cetSeriesMarks;
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingFormatingForm::ToolButton1Click(TObject *Sender)
{
	ChartEditor->DefaultTab = cetTools;
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingFormatingForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
