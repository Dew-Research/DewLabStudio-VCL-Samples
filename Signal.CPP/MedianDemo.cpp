//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxExpr.hpp"
#include "MedianDemo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TMedianDemoForm *MedianDemoForm;
//---------------------------------------------------------------------------
__fastcall TMedianDemoForm::TMedianDemoForm(TComponent* Owner)
	: TForm(Owner)
{
	SignalChart1->Legend->Visible = true;
	FilterBox->ItemIndex = 0;
	FilterBoxChange(this);
	RichEdit1->Lines->Clear();
	RichEdit1->Lines->Add("The chart shows a ramp filtered through a median or an integer delay filter. "
		"Median and delay filter are both streaming filters. The size of the block "
		"is set to 10 and the mask size can be varied. Change the mask size to test both " 
		"filters. If the filter work Ok, increasing the mask size will shift the ramp to the right.");

}
//---------------------------------------------------------------------------
void __fastcall TMedianDemoForm::ChartEditButtonClick(TObject *Sender)
{
	ChartEditor->Execute();
}
//---------------------------------------------------------------------------
void __fastcall TMedianDemoForm::UpdateMedian()
{
	Mtxexpr::sVector a,b;
	int MaskSize = StepEdit->IntPosition;
	MedianInit(MaskSize,MedianState,a.FloatPrecision);
	try
	{
		a.Size(1000,false);
		b.Size(a);
		a.Ramp();
		int BlockLength = 10;
		int len = (a.Length / BlockLength);
		for (int i=0;i<len;i++)
		{
			a.SetSubRange(i*BlockLength,BlockLength);
			b.SetSubRange(i*BlockLength,BlockLength);
			MedianFilter(a,b,MedianState);
		}
		a.SetFullRange();
		b.SetFullRange();
		DrawValues(a,SignalChart1->Series[0]);
		DrawValues(b,SignalChart1->Series[1]);
	}
	__finally
	{
		MedianFree(MedianState);
	}
}

void __fastcall TMedianDemoForm::UpdateDelay()
{
	Mtxexpr::sVector a,b;
	int DelayLength = StepEdit->IntPosition;
	DelayInit(DelayLength,DelayState, a.FloatPrecision);
	try
	{
		a.Size(1000,false);
		b.Size(a);
		a.Ramp();
		int BlockLength = 10;  //try with n >  mask size
		int len = (a.Length / BlockLength);
		for (int i=0;i<len;i++)
		{
			a->SetSubRange(i*BlockLength,BlockLength);
			b->SetSubRange(i*BlockLength,BlockLength);
			DelayFilter(a,b,DelayState);
		}
		a.SetFullRange();
		b.SetFullRange();
		DrawValues(a,SignalChart1->Series[0]);
		DrawValues(b,SignalChart1->Series[1]);
	}
	__finally
	{
		DelayFree(DelayState);
	}
}
void __fastcall TMedianDemoForm::FilterBoxChange(TObject *Sender)
{
	switch (FilterBox->ItemIndex)
	{
		case 0: UpdateMedian();break;
		case 1: UpdateDelay();break;
	}
}
//---------------------------------------------------------------------------
