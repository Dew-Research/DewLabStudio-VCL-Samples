//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "RateConvert.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TRateConvertForm *RateConvertForm;
//---------------------------------------------------------------------------
__fastcall TRateConvertForm::TRateConvertForm(TComponent* Owner)
	: TForm(Owner)
{
	RateFactorEdit->Position = SignalRateConverter->Factor;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Change rate conversion factor and observe the frequency response. For this " 
		"example, the noise attenuation is set to 100dB. Maximum range is 150dB.  "
		"Signal generator allows you to test the rate converter with two preset signals. "
		"Gaussian noise and 3 independent single tone frequencies. Each time you press update "
		"signal generator advances and a new block data is streamed in to the buffers through "
		"the rate converter. The Reset button resets the buffers and the rate conversion."
		"There is no limit on maximum or minimum rate conversion factor or its precision. "
		"All filters used are linear phase. The rate converter is of substantially higher quality"
		"than those provided by Windows or by Soundcard makers. The test is not very responsive "
		"because the charts have to do a lot of drawing, but the conversion itself is very fast.");

}
//---------------------------------------------------------------------------
void __fastcall TRateConvertForm::Button1Click(TObject *Sender)
{
	SignalGeneratorDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TRateConvertForm::RateFactorEditChange(TObject *Sender)
{
	SignalRateConverter->Factor = RateFactorEdit->Position;
	Reset();
	UpdatebuttonClick(Sender);
	UpdatebuttonClick(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TRateConvertForm::Reset()
{
	SignalStoreBuffer->Reset();
	SignalStoreBuffer1->Reset();
	SignalGenerator->Reset();
	SignalRateConverter->Reset();
}
void __fastcall TRateConvertForm::ResetButtonClick(TObject *Sender)
{
	Reset();
}
//---------------------------------------------------------------------------

void __fastcall TRateConvertForm::UpdatebuttonClick(TObject *Sender)
{
	SpectrumAnalyzer->Pull();
	SpectrumAnalyzer1->Pull();
}
//---------------------------------------------------------------------------

void __fastcall TRateConvertForm::SignalGeneratorParameterUpdate(
			TObject *Sender)
{
	Reset();
	UpdatebuttonClick(Sender);
	UpdatebuttonClick(Sender);
}
//---------------------------------------------------------------------------

