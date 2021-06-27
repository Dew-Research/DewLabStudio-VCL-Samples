//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PeakInterpolate.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPeakInterpolateForm *PeakInterpolateForm;
//---------------------------------------------------------------------------
__fastcall TPeakInterpolateForm::TPeakInterpolateForm(TComponent* Owner)
	: TForm(Owner)
{
	Signal1->UsesInputs = false;
	SpectrumAnalyzer->PhaseMode = pm360;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Numeric peak interpolation works with any window and any zero padding setting. " 
		"Change the value of frequency, amplitude and phase and compare value measured "
		"on the marked peak with the actual sine parameter. Notice also that "
		"marked peak follows the frequency. This feature is called peak tracing. "
		"In the example below, peak tracking is set to always find and mark the largest peak.");
 	RichEdit1->Paragraph->Numbering = nsNone;
	RichEdit1->Paragraph->FirstIndent = 0;
}
//---------------------------------------------------------------------------
void __fastcall TPeakInterpolateForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TPeakInterpolateForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakInterpolateForm::ToolButton1Click(TObject *Sender)
{
	ChartEditor1->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TPeakInterpolateForm::Signal1AfterUpdate(TObject *Sender)
{
	TToneState ts;	
	ToneInit(FreqEdit->Position, Math387::DegToRad(PhaseEdit->Position),AmpltEdit->Position,ts);
	Tone(Signal1->Data,ts);
}
//---------------------------------------------------------------------------
void __fastcall TPeakInterpolateForm::FreqEditChange(TObject *Sender)
{
	SpectrumAnalyzer->Pull();
}
//---------------------------------------------------------------------------
void __fastcall TPeakInterpolateForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart->Height = (int) (Panel2->Height/1.8);
}
//---------------------------------------------------------------------------
