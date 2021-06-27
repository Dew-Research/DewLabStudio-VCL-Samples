//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "QC_XR.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_QC"
#pragma resource "*.dfm"
TfrmQCXR *frmQCXR;
//---------------------------------------------------------------------------
__fastcall TfrmQCXR::TfrmQCXR(TComponent* Owner)
	: TfrmBasicQC(Owner)
{
	Memo1->Lines->Add("By using TQCSeries you can easily plot all Quality Control Charts.");
	Memo1->Lines->Add(" This example shows you how to construct <X>, R and S Variable Control Charts"
			" Most TQCSeries properties are fuly customizable. To change them , click on the \"Edit Series\" button.");
	// load prepared data
	Data->LoadFromFile(CodePath() + "QC_XR.mtx");
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCXR::BeforeRecalculate()
{
	TSample CL,UCL,LCL;
	switch (RadioGroup1->ItemIndex)
	{
		case 0:  { // X Chart
				QCXChart(Data,DrawVec,CL,UCL,LCL,Confidence*0.01);
				Chart1->Title->Text->Strings[0] = "<X> Chart";
			};break;
		case 1:  { // R Chart
				QCRChart(Data,DrawVec,CL,UCL,LCL,Confidence*0.01);
				Chart1->Title->Text->Strings[0] = "R Chart";
			};break;
		case 2:  { // S Chart
				QCSChart(Data,DrawVec,CL,UCL,LCL,Confidence*0.01);
				Chart1->Title->Text->Strings[0] = "S Chart";
			};break;
	}
	Series1->CL = CL;
	Series1->LCL = LCL;
	Series1->UCL = UCL;
	DrawValues(DrawVec,Series1);
}
void __fastcall TfrmQCXR::RadioGroup1Click(TObject *Sender)
{
	Recalculate();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmQCXR::FormShow(TObject *Sender)
{
	RadioGroup1Click(RadioGroup1);	
}
//---------------------------------------------------------------------------

