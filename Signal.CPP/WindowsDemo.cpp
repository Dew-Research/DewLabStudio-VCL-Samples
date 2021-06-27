//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "WindowsDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TWindowsDemoForm *WindowsDemoForm;
//---------------------------------------------------------------------------
__fastcall TWindowsDemoForm::TWindowsDemoForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TWindowsDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TWindowsDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TWindowsDemoForm::Signal1AfterUpdate(TObject *Sender)
{
	Signal1->Data->SetVal(1);	
}
//---------------------------------------------------------------------------
void __fastcall TWindowsDemoForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}
//---------------------------------------------------------------------------
void __fastcall TWindowsDemoForm::FormCreate(TObject *Sender)
{
	Signal1->UsesInputs = false;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Different time signal windows have different mainlobe width and different sidelobe "
												"attenuation. Press the spectrum button to modify the parameters "
												"for the first series. Press the chart button and move the series "
												"of your choice to the first place so that it can be modified "
												"with the spectrum analyzer dialog.");
	FillSeries();

}
//---------------------------------------------------------------------------
void __fastcall TWindowsDemoForm::FillSeries()
{
	for (int i = 0; i <= 10; i++) {
	
		SpectrumChart->AddSeries(new TFastLineSeries(SpectrumChart));
		SpectrumChart->SeriesList->Exchange(0,SpectrumChart->SeriesList->Count-1);
		SpectrumAnalyzer->SidelobeAtt = 60;
		SpectrumAnalyzer->Window = (TSignalWindowType)i;
		SpectrumChart->Series[0]->Title = SignalWindowToString(SpectrumAnalyzer->Window);
		SpectrumChart->Spectrums->Items[0]->Series = SpectrumChart->Series[0]; 		// ???
		SpectrumAnalyzer->Pull();      //or update
	}
	SpectrumChart->Legend->Visible = true;
}