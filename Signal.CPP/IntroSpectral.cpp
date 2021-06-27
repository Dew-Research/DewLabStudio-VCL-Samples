//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroSpectral.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroSpectralForm *IntroSpectralForm;
//---------------------------------------------------------------------------
__fastcall TIntroSpectralForm::TIntroSpectralForm(TComponent* Owner)
	: TBasicForm3(Owner)
{
		RichEdit1->Lines->Clear();
		RichEdit1->DefAttributes->Size = 12;
		RichEdit1->DefAttributes->Style = RichEdit1->DefAttributes->Style << TFontStyle::fsBold;
		RichEdit1->SelAttributes->Color = (TColor) RGB(51,51,153);
		RichEdit1->SelAttributes->Size = 14;
		RichEdit1->Lines->Add("Frequency spectrum analysis features:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Lines->Add("Very fast FFT for real and complex signals");
		RichEdit1->Lines->Add("Chirp-Z Transform for high speed frequency zoom-in");
		RichEdit1->Lines->Add("4 autoregressive methods for spectral estimation: "
				"Yulle-Walker, Burg, Covariance and Modified covariance");
		RichEdit1->Lines->Add("10 different time signal windows: Hanning, Hamming, FlatTop, "
				"Bartlet, Blackman, BlackmanHarris, BlackmanExact, "
				"Cosine-tappered, Kaiser, Chebyshev and  Exponential");
		RichEdit1->Lines->Add("THD, THD-N, SNR, NF, RMS, SFDR spectral statistics");
		RichEdit1->Lines->Add("Integration and differentiation in the frequency domain");
		RichEdit1->Lines->Add("Amplitude, power, peak-peak and RMS spectrums.");
		RichEdit1->Lines->Add("Real and complex cepstrum.");
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Paragraph->FirstIndent = 0;
}
//---------------------------------------------------------------------------
