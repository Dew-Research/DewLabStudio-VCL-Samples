//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PeakMarkingBasic.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPeakMarkingBasicForm *PeakMarkingBasicForm;
//---------------------------------------------------------------------------
__fastcall TPeakMarkingBasicForm::TPeakMarkingBasicForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	ComboBox1->ItemIndex = 0;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Test peak marking features:");
	RichEdit1->Lines->Add("");
	RichEdit1->Paragraph->Numbering = nsBullet;
	RichEdit1->Paragraph->FirstIndent = 10;
	RichEdit1->Lines->Add("Move the mouse and click the left mouse button to mark a peak.");
	RichEdit1->Lines->Add("Click with the left mouse button already marked peak once more to delete the mark.");
	RichEdit1->Lines->Add("Double click with left mouse button to clear all marked peaks.");
	RichEdit1->Lines->Add("Zoom-in the frequency spectrum by dragging a rectangle with the left mouse button.");
	RichEdit1->Lines->Add("Pan the frequency spectrum by dragging with the right mouse button.");
	RichEdit1->Lines->Add("Change the Mark mode edit box on the bottom of the the chart to Harmonics " 
		"and move the mouse.");
	RichEdit1->Lines->Add("Change the Mark mode edit box on the bottom of the the chart to Sidebands " 
		"and mark two peaks. Modulation sidebands will be marked.");
	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;

}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingBasicForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingBasicForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TPeakMarkingBasicForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
TSpectrumMarkTool* __fastcall TPeakMarkingBasicForm::GetMarkTool()
{
	for (int i=0; i<SpectrumChart->Tools->Count; i++) {
		TSpectrumMarkTool* result = dynamic_cast<TSpectrumMarkTool*>(SpectrumChart->GetTool(i));
		if (result != NULL) return result;
	}
	ERaise("Spectrum mark tool not found!");
}

void __fastcall TPeakMarkingBasicForm::ComboBox1Change(TObject *Sender)
{
	GetMarkTool()->MarkMode = (TSpectrumMarkMode)ComboBox1->ItemIndex;
}
//---------------------------------------------------------------------------

void __fastcall TPeakMarkingBasicForm::PhaseBoxClick(TObject *Sender)
{
	SpectrumChart->SpectrumPart = (TSpectrumPart)PhaseBox->Checked;
	switch (SpectrumChart->SpectrumPart)
	{
		case sppAmplt: SpectrumChart->LeftAxis->Title->Caption = "Amplitude";break;
		case sppPhase: SpectrumChart->LeftAxis->Title->Caption = "Phase [degress]";break;
	}
}
//---------------------------------------------------------------------------

