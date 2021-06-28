//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "PhaseDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPhaseDemoForm *PhaseDemoForm;
//---------------------------------------------------------------------------
__fastcall TPhaseDemoForm::TPhaseDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	StepEditChange(this);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The package also provides phase unwrapping algorithm. The example below " 
					"shows the phase of a lowpass FIR filter. In the passband, the linear " 
					"phase is clearly visible. The success of phase unwrapping stronly " 
					"depends upon the level of zero padding.");

}
//---------------------------------------------------------------------------
void __fastcall TPhaseDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TPhaseDemoForm::StepEditChange(TObject *Sender)
{
	Mtxexpr::sVector H,Resp,Amplt,Phase;

	H->Length = StepEdit->IntPosition;
	FirImpulse(H,OPENARRAY(double,(0.25,0.28)),ftLowpass);
	TSample ActualZeroPadding = FrequencyResponse(H,NULL,Resp,(int) (Exp2(ZeroPaddEdit->IntPosition)));
	Phase->PhaseSpectrum(Resp);
	Phase->Scale(180/PI);
	PhaseUnwrap(Phase,Amplt,rpConstPhase,ActualZeroPadding*H->Length/(H->Length-1),false,180);
	SignalChart1->Series[0]->Clear();
	DrawValues(Amplt,SignalChart1->Series[0]);
}
//---------------------------------------------------------------------------
