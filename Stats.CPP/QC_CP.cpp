//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "QC_CP.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma link "VCLTee.StatChar"
#pragma link "VCLTee.TeeTools"
#pragma resource "*.dfm"
TfrmQCCP *frmQCCP;
//---------------------------------------------------------------------------
__fastcall TfrmQCCP::TfrmQCCP(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Series1->GetVertAxis->AutomaticMinimum = false;
	Series1->GetVertAxis->Minimum = 0.0;
	Alpha = 0.05;
	Edit1->Text = FormatFloat("0.000",Alpha);
	Memo1->Lines->Add("CP and CPK charts");
	Memo1->Lines->Add("By using new TeeChart v5 TColorLineTool you can easily"
			" do Process Capability Charts-> Try dragging upper and "
			" lower control limit (red lines) - p, CP and CPK coefficients "
			" and their confidence intervals (CI) are recalculated automatically.");
	try
	{
		sMatrix tmpMtx;
		sVector X, XDense, Bell,Y;
		TSample Mean, StdDev;
		// load prepared data
		tmpMtx->LoadFromFile(CodePath() + "QC_XR.mtx");
		Data->Copy(tmpMtx);
		Histogram(Data,10,Y,X,true);
		// get values for Bell curve
		Mean = Data->Mean();
		StdDev = Data->StdDev(Mean);
		// 200 calc points
		XDense->Length = 500;
		XDense->Ramp(0.0,(X->Max()-0.0)*0.005);
		NormalPDF(XDense,Mean,StdDev,Bell);
		Series1->GetHorizAxis->Automatic = false;
		Series1->GetHorizAxis->SetMinMax(Data->Min() - 10, Data->Max() + 10);
		DrawValues(X,Y,Series1,false);
		DrawValues(XDense,Bell,Series2,false);
		ChartTool1->Value = X->Min() + 1;
		ChartTool2->Value = X->Max() - 1;
		Recalculate();
	}
	catch (...) {}
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCCP::Recalculate()
{
	TSample LB = ChartTool1->Value;
	TSample UB = ChartTool2->Value;
	QCCapIndexes(Data,LB,UB,p,CP,CPK,CPConfInt,CPKConfInt, Alpha);
	Label1->Caption = "p = " + FormatFloat("0.0000",p);
	Label3->Caption = "CP = " + FormatFloat("0.0000",CP);
	Label4->Caption = "CP CI = [" + FormatFloat("0.0000",CPConfInt[0])+" ; "+
										FormatFloat("0.0000",CPConfInt[1])+"]";
	Label5->Caption = "CPK = " + FormatFloat("0.0000",CPK);
	Label6->Caption = "CPK CI = [" + FormatFloat("0.0000",CPKConfInt[0])+" ; "+
										FormatFloat("0.0000",CPKConfInt[1])+"]";}

void __fastcall TfrmQCCP::ChartTool1EndDragLine(TColorLineTool *Sender)
{
	if (ChartTool1->Value >= ChartTool2->Value)
		ChartTool1->Value = ChartTool2->Value - EPS;
	Recalculate();
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCCP::ChartTool2EndDragLine(TColorLineTool *Sender)
{
	if (ChartTool2->Value <= ChartTool1->Value) ChartTool2->Value = ChartTool1->Value + EPS;
	Recalculate();
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCCP::Edit1Change(TObject *Sender)
{
	if (Showing)
	{
		Alpha = StrToFloat(Edit1->Text);
		Recalculate();
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmQCCP::CheckBox1Click(TObject *Sender)
{
	Series2->Active = CheckBox1->Checked;
}
//---------------------------------------------------------------------------
