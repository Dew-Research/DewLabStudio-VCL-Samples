//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "BufferUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TBufferForm *BufferForm;
//What is this good for:

//Imagine you have a rational factor rate converter giving
//non constant number of samples per iteration. If rate
//conversion is 0.3 from 100Hz with input buffer length
//of 100 samples, the rate converter will be outputing
//33, 33, 34, 33, 33, 34....
// But some components like TSignalOut "require" fixed
//number of samples in the input buffer, because that
//is a requirement of Windows.
//TSignalBuffer allows you to ensure that fixed buffer
//length by inserting it between the rate converter
//and TSignalOut component.
//---------------------------------------------------------------------------
__fastcall TBufferForm::TBufferForm(TComponent* Owner)
	: TForm(Owner)
{
	BufferSizeEdit->IntPosition = SignalBuffer->Length;
	InputBufferEdit->IntPosition = SignalGenerator->Length;
	DisplayUpdate();
}
//---------------------------------------------------------------------------
void __fastcall TBufferForm::ButtonUpdateClick(TObject *Sender)
{
	SignalUpdateLabel->Caption = "Signal gen not updated";
	TPipeState a = SpectrumAnalyzer1->Pull();
	switch (a)
	{
		case pipeOK: DataReadLabel->Caption = "Stream state = pipeOK";break;
		case pipeStream: DataReadLabel->Caption = "Stream state = pipeStream";break;
		case pipeBuffer: DataReadLabel->Caption = "Stream state = pipeBuffer";break;
	}
}
//---------------------------------------------------------------------------
void __fastcall TBufferForm::SignalGeneratorAfterUpdate(TObject *Sender)
{
	SignalUpdateLabel->Caption = "Signal gen was updated!";
}
//---------------------------------------------------------------------------
void __fastcall TBufferForm::DisplayUpdate()
{
	BufferSizeLabel->Caption = "Buffer size: " + IntToStr(SignalBuffer->BufferLength());
	WriteCursorLabel->Caption = "Write cursor: " + IntToStr(SignalBuffer->BufferWritePosition());
	UnreadBufferDataLabel->Caption = "Samples in buffer: " + IntToStr(SignalBuffer->BufferedSamplesCount());
	ReadCursorLabel->Caption = "Read cursor: " + IntToStr(SignalBuffer->BufferReadPosition());
	InputBufferSizeLabel->Caption = "Input buffer size: " + IntToStr(SignalGenerator->Length);
	StoreBufferLabel->Caption = "Store buffer size: " + IntToStr(SignalStoreBuffer->Length);
}
void __fastcall TBufferForm::SignalBufferAfterUpdate(TObject *Sender)
{
	DisplayUpdate();	
}
//---------------------------------------------------------------------------

void __fastcall TBufferForm::BufferSizeEditChange(TObject *Sender)
{
	SignalBuffer->Length = BufferSizeEdit->IntPosition;
	DisplayUpdate();
}
//---------------------------------------------------------------------------

void __fastcall TBufferForm::SignalBufferBeforeUpdate(TObject *Sender)
{
	SignalChart2->Series[0]->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TBufferForm::InputBufferEditChange(TObject *Sender)
{
	SignalGenerator->Length = InputBufferEdit->IntPosition;
	DisplayUpdate();
}
//---------------------------------------------------------------------------

void __fastcall TBufferForm::ResetButtonClick(TObject *Sender)
{
	SignalBuffer->Reset();
	SignalStoreBuffer->Reset();
	DisplayUpdate();
}
//---------------------------------------------------------------------------

