//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "DiscreteSeriesDemo.h"
#include "SignalUtils.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"                                        
TDiscreteSeriesDemoForm *DiscreteSeriesDemoForm;
//---------------------------------------------------------------------------
__fastcall TDiscreteSeriesDemoForm::TDiscreteSeriesDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	StepEditChange(this);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("A new chart series for drawing discrete signals. The example below "
		"shows an oversampled FIR filter.");

}
//---------------------------------------------------------------------------
void __fastcall TDiscreteSeriesDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TDiscreteSeriesDemoForm::StepEditChange(TObject *Sender)
{
	Mtxexpr::sVector H;
	TSample Step = StepEdit->Position;
	FractionalFirImpulse(30,H,OPENARRAY(double,(0.2,0.25)),0,Step,ftLowPass,1);
	SignalChart1->Series[0]->Clear();
	DrawValues(H,SignalChart1->Series[0],0,Step);
}
//---------------------------------------------------------------------------
