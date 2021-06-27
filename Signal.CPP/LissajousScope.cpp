//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "LissajousScope.h"
#include "MtxExpr.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TLissajousScopeForm *LissajousScopeForm;          
//---------------------------------------------------------------------------
__fastcall TLissajousScopeForm::TLissajousScopeForm(TComponent* Owner)
	: TForm(Owner)
{
	Signal1->Data->Size(1000);  //defines how much data to copy and consequently also frequency resolution
	Signal1->Data->SetZero();
	Signal1->UsesInputs = false;
	Signal2->Data->Size(1000);  //defines how much data to copy and consequently also frequency resolution
	Signal2->Data->SetZero();
	Signal2->UsesInputs = false;

	SamplesBox->ItemIndex = 1;
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("This example shows the angle of the Left versus Right channel, if Left is on the Y and Right "
					"is on the X axis. The coordinates are rotated by 45 degrees counterclockwise. "
					"This type of a phase scope is also refered to as Lissajou. "
					"if there will be more low frequencies the scope will start showing lines."
					"If there will be more high frequencies the dots will be scattered around."
					"Vertical line indicates a mono signal. "
					"Horizontal line indicates that left and right channel are 180 degrees out of phase "
					"(cancelation). ");
}
//---------------------------------------------------------------------------

void __fastcall TLissajousScopeForm::SignalTimer1Timer(TObject *Sender)
{
	Mtxexpr::sVector a,Re,Im;
	if (!SignalIn1->Active) SignalIn1->Start();
	SignalIn1->MonitorData(Signal1,Signal2);
	a.RealToCplx(Signal2->Data,Signal1->Data);
	a.CartToPolar(Re,Im);
	Im.Scale(180/PI); //from radians to degrees
	Im.Offset(45); //add 45 degrees
	Re.Scale(1/Re->Max());  //normalize to 1
	DrawValues(Im,Re,PhaseChart->Series[0]); //angle is x
}
//---------------------------------------------------------------------------

void __fastcall TLissajousScopeForm::ChartButtonClick(TObject *Sender)
{
	ChartEditor->Execute();	
}
//---------------------------------------------------------------------------

void __fastcall TLissajousScopeForm::FormDestroy(TObject *Sender)
{
	SignalTimer1->Enabled = false;	
}
//---------------------------------------------------------------------------

void __fastcall TLissajousScopeForm::SamplesBoxChange(TObject *Sender)
{
	Signal1->Data->Length = StrToInt(SamplesBox->Text);
	Signal2->Data->Length = StrToInt(SamplesBox->Text);
}
//---------------------------------------------------------------------------

