//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "QC_Attr.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_QC"
#pragma resource "*.dfm"
TfrmQCAttr *frmQCAttr;
//---------------------------------------------------------------------------
__fastcall TfrmQCAttr::TfrmQCAttr(TComponent* Owner)
	: TfrmBasicQC(Owner)
{
	Memo1->Lines->Add("By using TQCSeries you can easily plot Attribute Quality Control Charts.");
	Memo1->Lines->Add(" This example shows you how to construct P and U Attribute Control Charts"
			" Data comes from 20 samples, each of size 100. Most TQCSeries properties"
			" are fuly customizable. To change them , click on the \"Edit Series\" button.");
	// load prepared data
	DataVec->LoadFromFile(CodePath() + "QC_Attribute.vec");
	SampleSize = 100;
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCAttr::Button2Click(TObject *Sender)
{
	ViewValues(DataVec,"Data vector",true,false);
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCAttr::Edit2Change(TObject *Sender)
{
	if (Showing && Edit2->Text != "")
	{
		SampleSize = StrToInt(Edit2->Text);
		Recalculate();
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCAttr::BeforeRecalculate()
{
	TSample CL, UCL, LCL;
	switch (RadioGroup1->ItemIndex)
	{
		case 0:  { // P Chart 
				QCPChart(DataVec,SampleSize,DrawVec,CL,UCL,LCL,Confidence*0.01);
				Chart1->Title->Text->Strings[0] = "P Chart";
			};break;
		case 1:  { // NP Chart
				QCNPChart(DataVec,SampleSize,DrawVec,CL,UCL,LCL,Confidence*0.01);
				Chart1->Title->Text->Strings[0] = "NP Chart";
			};break;
		case 2:  { // U Chart
				QCUChart(DataVec,SampleSize,DrawVec,CL,UCL,LCL,Confidence*0.01);
				Chart1->Title->Text->Strings[0] = "U Chart";
			};break;
		case 3:  { // C Chart
				QCCChart(DataVec,DrawVec,CL,UCL,LCL,Confidence*0.01);
				Chart1->Title->Text->Strings[0] = "C Chart";
			};break;
	}
	Series1->CL = CL;
	Series1->LCL = LCL;
	Series1->UCL = UCL;
	DrawValues(DrawVec,Series1);
}
void __fastcall TfrmQCAttr::RadioGroup1Click(TObject *Sender)
{
	Recalculate();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmQCAttr::FormShow(TObject *Sender)
{
	Edit2->Text = IntToStr(SampleSize);
	RadioGroup1Click(this);
}
//---------------------------------------------------------------------------

