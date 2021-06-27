//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "EWMA_Demo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmEWMA *frmEWMA;
//---------------------------------------------------------------------------
__fastcall TfrmEWMA::TfrmEWMA(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Add("New in release 1.1: support for Exponential weighted moving average chart (EWMA)");
	Memo1->Lines->Add(" This example shows you how to construct EWMA chart. EWMAChart procedure supports "
 		"asymptote value and exact value for control limits.");

	Data->LoadFromFile(CodePath() + "ewma_data.mtx");

	r = 0.35;
	Confidence = 0.9987;
	Edit1->Text = FloatToStr(r);
	Edit2->Text = FloatToStr(Confidence);
	RadioGroup1Click(RadioGroup1);
}
//---------------------------------------------------------------------------
void __fastcall TfrmEWMA::RadioGroup1Click(TObject *Sender)
{
	Chart1->FreeAllSeries();
	switch (RadioGroup1->ItemIndex)
	{
		case 0:  {
					Chart1->AddSeries(new TQCSeries(Chart1));
					EWMAChart(Data,DrawVec,cl,ucl,lcl,r,Confidence);
					Chart1->Legend->Visible = false;
					DrawValues(DrawVec,Chart1->Series[0],0,1,false);
					Chart1->Series[0]->SeriesColor = clBlue;
					((TQCSeries*) Chart1->Series[0])->ControlLimitPen->Color = clRed;
					((TQCSeries*) Chart1->Series[0])->CL = cl;
					((TQCSeries*) Chart1->Series[0])->UCL = ucl;
					((TQCSeries*) Chart1->Series[0])->LCL = lcl;
				};break;
		case 1:  {
					Chart1->AddSeries(new TLineSeries(Chart1));
					Chart1->AddSeries(new TLineSeries(Chart1));
					Chart1->AddSeries(new TLineSeries(Chart1));
					EWMAChart(Data,DrawVec,cl,vucl,vlcl,r,Confidence);
					Chart1->Legend->Visible = true;
					((TLineSeries*)Chart1->Series[0])->Pointer->Visible = true;
					((TLineSeries*)Chart1->Series[0])->SeriesColor = clBlue;
					((TLineSeries*)Chart1->Series[0])->Title = "Data";
					Chart1->Series[1]->SeriesColor = clRed;
					((TLineSeries*)Chart1->Series[1])->Pen->Style = psDot;
					Chart1->Series[1]->Title = "UCL";
					Chart1->Series[2]->SeriesColor = clRed;
					((TLineSeries*)Chart1->Series[2])->Pen->Style = psDot;
					Chart1->Series[2]->Title = "LCL";
					DrawValues(DrawVec,Chart1->Series[0],0,1,false);
					DrawValues(vucl,Chart1->Series[1],0,1,false);
					DrawValues(vlcl,Chart1->Series[2],0,1,false);
				};break;
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmEWMA::Button1Click(TObject *Sender)
{
	ViewValues(Data,"EWMA data",true,false);
}
//---------------------------------------------------------------------------
void __fastcall TfrmEWMA::Edit1Change(TObject *Sender)
{
	if (Showing)
	{
		try
		{
			r = StrToFloat(Edit1->Text);
		}
		catch (...) {
			r = 0.35;
		}
		RadioGroup1Click(RadioGroup1);
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmEWMA::Edit2Change(TObject *Sender)
{
	if (Showing)
	{
		try
		{
			Confidence = StrToFloat(Edit2->Text);
		}
		catch (...) {
			Confidence = 0.9987;
		}
		RadioGroup1Click(RadioGroup1);
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmEWMA::Chart1AfterDraw(TObject *Sender)
{
	if (RadioGroup1->ItemIndex == 1) {
		Chart1->Canvas->Pen->Color = clBlue;
		Chart1->Canvas->MoveTo(Chart1->ChartRect.Left,Chart1->LeftAxis->CalcPosValue(cl));
		Chart1->Canvas->ClipRectangle(Chart1->ChartRect);
		Chart1->Canvas->LineTo(Chart1->ChartRect.Right,Chart1->LeftAxis->CalcPosValue(cl));
		Chart1->Canvas->UnClipRectangle();
	}
}
//---------------------------------------------------------------------------
