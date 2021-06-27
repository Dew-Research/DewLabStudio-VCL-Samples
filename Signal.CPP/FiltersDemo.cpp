//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FiltersDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFiltersDemoForm *FiltersDemoForm;
//---------------------------------------------------------------------------
__fastcall TFiltersDemoForm::TFiltersDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	Signal1->UsesInputs = false;
	Signal1->Length = 4096;
	Signal1->Data->SetZero();
	Signal1->Data->SetVal(Signal1->Length / 2,0,1);
	SpectrumAnalyzer->PhaseMode = pm360;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("A filter designer component is available. Click on the Filter editor " 
		"in the example below to display a filter design window. The TSignalFilter "
		"component can be used to design almost any filter that comes with "
		"the package and provides a convinient user interface. The component "
		"can also be used for on-line filtering. All filter setups "
		"can be saved on disk as templates.");

}
//---------------------------------------------------------------------------
void __fastcall TFiltersDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TFiltersDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TFiltersDemoForm::ToolButton1Click(TObject *Sender)
{
	ChartEditor1->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TFiltersDemoForm::FilterButtonClick(TObject *Sender)
{
	SignalFilterDialog1->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TFiltersDemoForm::SignalFilter1ParameterUpdate(TObject *Sender)
{
	SpectrumAnalyzer->Pull();
}
//---------------------------------------------------------------------------
void __fastcall TFiltersDemoForm::SignalFilter1AfterUpdate(TObject *Sender)
{
	Signal2->Data->Copy(SignalFilter1->Taps);
	//In Delphi 4 and 5 this might cause floating point overflow message
	//when trying to draw axis labels.
	Signal2->UpdateNotify();
}
//---------------------------------------------------------------------------
void __fastcall TFiltersDemoForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart->Height = (int) (Panel2->Height/1.8);
}
//---------------------------------------------------------------------------

void __fastcall TFiltersDemoForm::SpectrumAnalyzerParameterUpdate(TObject *Sender)
{
	SpectrumAnalyzer->Pull();
}
//---------------------------------------------------------------------------

