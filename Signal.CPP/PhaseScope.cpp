//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PhaseScope.h"
#include "MtxExpr.hpp"
#include "OptimalFIR.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "SignalSeriesTee"
#pragma resource "*.dfm"
TPhaseScopeForm *PhaseScopeForm;
//---------------------------------------------------------------------------
__fastcall TPhaseScopeForm::TPhaseScopeForm(TComponent* Owner)
	: TForm(Owner)
{
//	Mtxexpr::sVector H;
//	H.Length = 256;
//	RemezImpulse(H,OPENARRAY(double,(0.25,0.495)),ftHilbertIV,1); //type four hilbert
//	FirInit(H,HilbertState);
//	RemezImpulse(H,OPENARRAY(double,(0.05,0.1)),ftHighPass,1);  // need a DC filter on original
//	DelayInit((H->Length-1) / 2,DelayState);
	Signal1->Data->Size(1024);  //defines how much data to copy and consequently also frequency resolution
	Signal1->Data->SetZero();
	Signal1->UsesInputs = false;
	Signal2->Data->Size(1024);  //defines how much data to copy and consequently also frequency resolution
	Signal2->Data->SetZero();
	Signal2->UsesInputs = false;
	ChannelBox->ItemIndex = 0;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The recording is setup for 11025 kHz stereo. You can select "
		"the channel you wish to monitor."
		"This example shows, the relative phases of each channel separately."
		"This is not especially usefull for audio analysis, because a true phase scope compares "
		"left and right channel. This example demonstrates the use of a hilbert "
		"transformer.");
}
//---------------------------------------------------------------------------
void __fastcall TPhaseScopeForm::ChartButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------
void __fastcall TPhaseScopeForm::Panel2Resize(TObject *Sender)
{
	Panel3->Height = Panel2->Height / 2;
	LeftPhaseChart->Width = Panel3->Width / 2;
}
//---------------------------------------------------------------------------
void __fastcall TPhaseScopeForm::SignalTimer1Timer(TObject *Sender)
{
	Mtxexpr::sVector a,Re,Im;
	if (!SignalIn1->Active) SignalIn1->Start();
	SignalIn1->MonitorData(Signal1,Signal2);
	RemoveDC(Signal1->Data); //should be FIR filter, but this will work also
	RemoveDC(Signal2->Data); //should be FIR filter, but this will work also
	a.Hilbert(Signal1->Data);
	a.SetSubRange((int) (a->Length*0.01), (int) (a->Length*0.8)); //leave out the edges, because they are bad->->-> (rectangular window ripple effect)
	a.CplxToReal(Re,Im);
//	a.CartToPolar(Re,Im);
//	Im.Scale(180/PI); //from radians to degrees
//	Re.Scale(1 / Re->Max());  //normalize
	DrawValues(Im,Re,LeftPhaseChart->Series[0]); //angle is x
	a.SetFullRange();
	a.Hilbert(Signal2->Data);
	a.SetSubRange((int) (a->Length*0.01), (int) (a->Length*0.8)); //leave out the edges, because they are bad->->-> (rectangular window ripple effect)
	a.CplxToReal(Re,Im);
//	a.CartToPolar(Re,Im);
//	Re.Scale(1/Re->Max());  //normalize
//	Im.Scale(180/PI); //from radians to degrees
	DrawValues(Im,Re,RightPhaseChart->Series[0]); //angle is x
	SignalChart1->Title->Text->Clear();
	switch (ChannelBox->ItemIndex)
	{
		case 0:
		{
			(*SignalChart1->Signals)[0]->Input = Signal1;
			SignalChart1->Title->Text->Add("Time signal - Left channel");
		};break;
		case 1:
		{
			(*SignalChart1->Signals)[0]->Input = Signal2;
			SignalChart1->Title->Text->Add("Time signal - Right channel");
		};break;
	}
	(*SignalChart1->Signals)[0]->Input->UpdateNotify();
}
//---------------------------------------------------------------------------
void __fastcall TPhaseScopeForm::FormDestroy(TObject *Sender)
{
	SignalTimer1->Enabled = false;
//	FirFree(HilbertState);
//	DelayFree(DelayState);
}
//---------------------------------------------------------------------------
