//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "AutoRegressDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TAutoRegressDemoForm *AutoRegressDemoForm;
//---------------------------------------------------------------------------
__fastcall TAutoRegressDemoForm::TAutoRegressDemoForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TAutoRegressDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TAutoRegressDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TAutoRegressDemoForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}

void __fastcall TAutoRegressDemoForm::FillSeries()
{
	SpectrumAnalyzer->Window = wtHanning;
	SpectrumAnalyzer->ZeroPadding = 8;
	SpectrumAnalyzer->Logarithmic = true;
	SpectrumAnalyzer->LogType = ltRelative;
	SpectrumAnalyzer->ArOrder = 180; //guess
	for (int i = 0;i<5;i++)
	{
		SpectrumChart->AddSeries(new TFastLineSeries(SpectrumChart));
		SpectrumChart->SeriesList->Exchange(0,SpectrumChart->SeriesList->Count-1);
		SpectrumAnalyzer->Method = (TSpectrumMethod)i;
		SpectrumChart->Series[0]->Title = SpectrumMethodToString(SpectrumAnalyzer->Method);
		SpectrumChart->Spectrums->Items[0]->Series = SpectrumChart->Series[0];
		SpectrumAnalyzer->Pull();
	}
	SpectrumChart->Legend->Visible = true;
}

//---------------------------------------------------------------------------
void __fastcall TAutoRegressDemoForm::FormCreate(TObject *Sender)
{
	SignalRead1->FileName = ExtractFileDir(Application->ExeName) + "\\bz.sfs";
	SignalRead1->OpenFile();
	SignalRead1->RecordPosition = 0; //moves to the start and loads Length samples
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Different frequency estimation methods have different success estimating frequency spectrum ."
		"Press the spectrum button to modify the parameters "
		"for the first series. Press the chart button and move the series "
		"of your choice to the first place so that it can be modified "
		"with the spectrum analyzer dialog. Autoregressive methods are affected "
		"by the AROrder paramter and FFT is affected by the Window parameter. All "
		"methods are affected by the \"Zero pRichEdit1->Lines->Adding\".");
	FillSeries();
}
//---------------------------------------------------------------------------
