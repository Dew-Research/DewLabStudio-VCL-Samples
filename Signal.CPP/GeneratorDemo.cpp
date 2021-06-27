//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "GeneratorDemo.h"
#include "FileSignal.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TGeneratorDemoForm *GeneratorDemoForm;
//---------------------------------------------------------------------------
__fastcall TGeneratorDemoForm::TGeneratorDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalGenerator1->SamplingFrequency = 1024;
	SignalGenerator1->Length = 1024;
	SpectrumAnalyzer->Pull();
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("Vectorized signal generator allows generatation of very complex signals " 
		"in real time and needs only a small fraction of time required by the best function evaluators. "
		"The generator uses postfix notation. (HP style). "
		"It has a wide range of built-in functions and it is easy to connect "
		"them to form processing chains. Press on the Generator button to "
		"get to know the editor. For the start just select different functions "
		"from the template menu.");


}
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::SpectrumEditButtonClick(TObject *Sender)
{
	SpectrumAnalyzerDialog->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::SpectrumAnalyzerParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Update();	
}                                                  
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::Panel2Resize(TObject *Sender)
{
	SpectrumChart->Height = (int) (Panel2->Height/1.8);
}
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::ToolButton1Click(TObject *Sender)
{
	ChartEditor1->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::GeneratorButtonClick(TObject *Sender)
{
	SignalGeneratorDialog1->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::SignalGenerator1ParameterUpdate(
      TObject *Sender)
{
	SpectrumAnalyzer->Pull();	
}
//---------------------------------------------------------------------------
void __fastcall TGeneratorDemoForm::ToolButton2Click(TObject *Sender)
{
	SaveDialog->Filter = SignalDialogFilter;
	if (SaveDialog->Execute())
	{
		SignalWrite->FileName = SaveDialog->FileName;
		int N = StrToInt(InputBox("Define file length", "Samples count", "100000"));
		(*SignalGenerator1->Sounds->Template)[0]->Continuous = true;
		for (int i = 0;i<(N / SignalGenerator1->Length);i++)
			SignalWrite->Pull();
		SignalGenerator1->Update();
		SignalGenerator1->Data->Resize(N % SignalGenerator1->Length);
		SignalWrite->Update();
		SignalWrite->CloseFile();
		SignalGenerator1->Data->Length = 1024;
	}
}
//---------------------------------------------------------------------------
