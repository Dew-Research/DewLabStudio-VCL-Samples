//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "BispectrumTest.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBiSpectrumTestForm *BiSpectrumTestForm;
//---------------------------------------------------------------------------
__fastcall TBiSpectrumTestForm::TBiSpectrumTestForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	BiSpectrumAnalyzer->Amplt->SetZero();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Bicoherence shows the frequencies related to the selected frequency. "
		"Relation is defined as e^jw1 * e^jw2 = e^j(w1+w2). Bicoherence  "
		"will be 1 for a frequency pair (w1,w2) which has a product of itself (e^jw1*e^jw2) "
		"in the frequency spectrum. Multiplication is also called modulation. "
		"Bicoherence will be 1, if there is modulation present. Change the Frequency "
		"parameter and observe the bicoherence to see, with which frequencies is "
		"the Frequency multiplied with. Modulation is probably the most often observed type "
		"of non-linearity in mechanical systems. You can also compute only "
		"preselected frequency lines by checking the Single lines only box. (see source code for more info)"
		"This reduces the CPU and memory resources required considerably. "
		"The bicoherence is calculated on a vibration signal coming from a lathe machine, when there is chatter present. "
		"In the example below you can see that, next to the main harmonic series, "
		"a frequency of 20 Hz is the modulating frequency causing many additional peaks.");
	Button1Click(this);
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumTestForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumTestForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumTestForm::Button1Click(TObject *Sender)
{
		 Screen->Cursor = crHourGlass;

		 SignalRead1->OpenFile();
		 SignalRead1->RecordPosition = 0;
		 SignalRead1->OverlappingPercent = 75;
		 SpectrumAnalyzer->Update();
		 if (SingleLinesOnlyBox->Checked)
		 {
					BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly = True;
					BiSpectrumAnalyzer->BiAnalyzer->Lines->Length = 128;
					BiSpectrumAnalyzer->BiAnalyzer->Lines->Ramp(0,SpectrumAnalyzer->HzRes);
		 } else BiSpectrumAnalyzer->BiAnalyzer->SingleLinesOnly = false;
		 BiSpectrumAnalyzer->ResetAveraging();
//     BispectrumAnalyzer->BiAnalyzer->Recursive = False; !!! set in design time
		 while (BiSpectrumAnalyzer->Pull() != pipeEnd)  // do averaging
		 {
					ProgressLabel->Caption = "Progress: " + FormatSample("0",SignalRead1->FrameNumber*100/SignalRead1->MaxFrames) + " [%]";
					ProgressLabel->Update();
		 }
		 BiSpectrumAnalyzer->BiAnalyzer->Update(); //compute bicoherence
		 FreqEdit->Increment = SampleToStr(SpectrumAnalyzer->HzRes);
		 FreqEditChange(Sender); //get bicoherence line
		 Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumTestForm::SpectrumAnalyzerParameterUpdate(
			TObject *Sender)
{
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumTestForm::FreqEditChange(TObject *Sender)
{
	BiSpectrumAnalyzer->BiAnalyzer->Frequency = FreqEdit->Position;
	BiSpectrumAnalyzer->UpdateSpectrum();
	if (SpectrumChart->Tools->Count > 2)
		((TColorLineTool*)(SpectrumChart->GetTool(2)))->Value = FreqEdit->Position;
}
//---------------------------------------------------------------------------
void __fastcall TBiSpectrumTestForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart1->Height = Panel2->Height / 2;
}
//---------------------------------------------------------------------------
