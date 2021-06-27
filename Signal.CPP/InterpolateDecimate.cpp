//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "InterpolateDecimate.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TInterpolateDecimateForm *InterpolateDecimateForm;
//---------------------------------------------------------------------------
__fastcall TInterpolateDecimateForm::TInterpolateDecimateForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	SignalWrite1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.dat";
	SignalWrite1->PullUntilEnd(); //creates a new filtered file
	SignalWrite1->CloseFile();
	SignalRead1->CloseFile();	
	
	SignalRead2->Length = 1024; //define the read block size (and frequency resolution)
	SignalRead3->Length = 1024; //define the read block size
	SignalRead2->FileName = SignalRead1->FileName;
	SignalRead3->FileName = SignalWrite1->FileName;

	SignalRead2->OpenFile();
	SignalRead2->RecordPosition = 0;
	SpectrumAnalyzer->DCDump = False;
	SpectrumAnalyzer->LogType = ltRelative;
	SpectrumAnalyzer->LogSpan = ls150;
	SpectrumAnalyzer->Logarithmic = true;
	SpectrumAnalyzer->Window = wtKaiser;
	SpectrumAnalyzer->SidelobeAtt = 130;
	SpectrumAnalyzer1->AssignTemplate(SpectrumAnalyzer); //make it the same
	SpectrumAnalyzer->Update();
	FilePositionEdit2->Position = 1838; //SpectrumAnalyzer1->Update;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("High speed low-pass filter. When it is neccessary to obtain extremely "
		"narrow transition bands, eliptic IIR and ParksMcClellan FIR filters "
		"fail to perform. An alternative in such cases is to employ multi-rate "
		"multi-stage FIR decimation and then interpolation. "
		"In the example below, the signal has a cutoff at 73 Hz and stopband "
		"attenuation of 80dB. The width of the "
		"transition region is only 3 Hz. The sampling frequency of the signal is 4666Hz. "
		"3 Hz is less then 0.1% of the bandwidth. Examine the chart and notice that in the pass band both frequency "
		"spectrums have an exact match. This type of low-pass filtering takes "
		"only a small fraction of time of a single FIR low pass filter whose length "
		"would exceed 3600 taps. To processing time required is about the same as "
		"filtering the original signal 4x with a 30 taps long filter. "
		"To make the strong attenuation in the passband evident, Kaiser window "
		"has been employed with sidelobe attenuation of 130dB. Try "
		"lowering the sidelobe attenuation in the spectrum analyzer dialog and observe "
		"what happens. The transition band is not as narrow as "
		"was the filter specification, but this is only because "
		"the Kaiser has a very wide mainlobe (frequency spectrum does not "
		"show the true reality). With TSignalDemodulator and TSignalModulator "
		"components this filtering approach can be used for any lowpass, bandpass, highpass "
		"filter specification.");
	

}
//---------------------------------------------------------------------------
void __fastcall TInterpolateDecimateForm::SpectrumEditButtonClick(
			TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TInterpolateDecimateForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TInterpolateDecimateForm::SpectrumAnalyzerParameterUpdate(
			TObject *Sender)
{
	SpectrumAnalyzer->Update();
	SpectrumAnalyzer1->AssignTemplate(SpectrumAnalyzer);
	SpectrumAnalyzer1->Update();
}
//---------------------------------------------------------------------------
void __fastcall TInterpolateDecimateForm::FilePositionEdit1Change(
      TObject *Sender)
{
	SignalRead2->RecordPosition = FilePositionEdit1->IntPosition;
	SpectrumAnalyzer->Update();
}
//---------------------------------------------------------------------------
void __fastcall TInterpolateDecimateForm::FilePositionEdit2Change(
      TObject *Sender)
{
	SignalRead3->RecordPosition = FilePositionEdit2->IntPosition;
	SpectrumAnalyzer1->Update();
}
//---------------------------------------------------------------------------
