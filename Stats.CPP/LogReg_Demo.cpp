//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "LogReg_Demo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma link "MtxBaseComp"
#pragma resource "*.dfm"
TfrmLogReg *frmLogReg;
//---------------------------------------------------------------------------
__fastcall TfrmLogReg::TfrmLogReg(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("Logistic regression is similar to regular multiple regression except that the dependent (Y) variable "
		"is integer (can be binary, but it is not obligatory) instead of continuous. "
		"Statistics for MtxVec supports ordinary logistic regression (binary dependent variable) and ordinal "
		"(dependent variables are integers) logistic regression. Example bellow is taken NCSS, another great statistical "
		"package.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Example: The data below is taken from first few rows of a set of data about leukemia patients published in Lee (1980). "
		"The response variable is whether leukemia remission occurred. These values are passed to TMtxLogistReg.Y vector. "
		"The independent variables are cellularity of the marrow clot section, smear differential percentage of blasts, percentage "
		"of absolute marrow leukemia cell infiltrate, percentage labeling index of the bone marrow leukemia cells, absolute number "
		"of blasts in the peripheral blood, and the highest temperature prior to start of treatment. "
		"We will estimate only the relationship between remission, cellularity, index of leukemia cells and temperature. Each variable "
		"is stored in separate column in TMtxLogistReg.A matrix.");
	double A[] = {0.8, 1.9, 0.996,
					0.9, 1.4, 0.992,
					0.8, 0.8, 0.982,
					1, 0.7, 0.986,
					0.9,   1.3, 0.98,
					1,   0.6, 0.982,
					0.95,   1,   0.992,
					0.95,   1.9,   1.02,
					1,   0.8,   0.999,
					0.95,   0.5, 1.038,
					0.85, 0.7, 0.988,
					0.7,   1.2, 0.982,
					0.8,   0.4, 1.006,
					0.2,   0.8, 0.99,
					1,   1.1, 0.99,
					1,   1.9, 1.02,
					0.65, 0.5,   1.014,
					1,   1,   1.004,
					0.5,   0.6, 0.99,
					1,   1.1, 0.986,
					1,   0.4,   1.01,
					0.9,   0.6, 1.02,
					1,   1,   1.002,
					0.95, 1.6, 0.988,
					1,   1.7, 0.99,
					1,   0.9, 0.986,
					1,   0.7, 0.986};
	MtxLogReg->A->SetIt(27,3,false,A,sizeof(A)/sizeof(double)-1);
	double Y[] = {1,1,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,1,1,0};
	MtxLogReg->Y->SetIt(false,Y,sizeof(Y)/sizeof(double)-1);
}
//---------------------------------------------------------------------------
void __fastcall TfrmLogReg::Button1Click(TObject *Sender)
{
	ViewValues(MtxLogReg->Y,"Grouping variable",true);
}
//---------------------------------------------------------------------------
void __fastcall TfrmLogReg::Button2Click(TObject *Sender)
{
	ViewValues(MtxLogReg->A,"Independent variables",true);
}
//---------------------------------------------------------------------------
void __fastcall TfrmLogReg::Button3Click(TObject *Sender)
{
	MtxLogReg->Recalc();
	Report();
}
//---------------------------------------------------------------------------
void __fastcall TfrmLogReg::Report()
{
	Memo2->Lines->Clear();
	Memo2->Lines->Add("Logistic regression report");
	Memo2->Lines->Add("Number of independent variables : " + IntToStr(MtxLogReg->A->Cols));
	Memo2->Lines->Add("");
	Memo2->Lines->Add("--------------------------------------------------------------------------------");
	Memo2->Lines->Add("Regression coefficients - Theta (constant term):");
	Memo2->Lines->Add("Theta\t\tTheta Std.Err");
	for (int i = 0;i<MtxLogReg->Theta->Length;i++)
	{
		AnsiString LineText = FormatFloat("0.00000",MtxLogReg->Theta->Values[i])+"\t\t"+FormatFloat("0.00000",MtxLogReg->TBStdErr->Values[i]);
		Memo2->Lines->Add(LineText);
	}
	Memo2->Lines->Add("Regression coefficients - B:");
	Memo2->Lines->Add("B\t\tB Std.Err");
	for (int i=0;i<MtxLogReg->B->Length;i++)
	{
		AnsiString LineText = FormatFloat("0.00000",MtxLogReg->B->Values[i])+
			"\t\t"+FormatFloat("0.00000",MtxLogReg->TBStdErr->Values[MtxLogReg->Theta->Length+i]);
		Memo2->Lines->Add(LineText);
	}
	Memo2->Lines->Add("--------------------------------------------------------------------------------");
	Memo2->Lines->Add("Additional parameters returned: ");
	Memo2->Lines->Add("Log-likehood function, evaluated at minimum : "+ FormatFloat("0.00000",MtxLogReg->FMin));
	Memo2->Lines->Add("Number of iterations needed to converge : " + IntToStr(MtxLogReg->Iterations));
}
