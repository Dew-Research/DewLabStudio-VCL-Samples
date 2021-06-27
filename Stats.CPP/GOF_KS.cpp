//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "GOF_KS.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma link "VCLTee.StatChar"
#pragma resource "*.dfm"
TfrmGOFKS *frmGOFKS;
//---------------------------------------------------------------------------
__fastcall TfrmGOFKS::TfrmGOFKS(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("New in Stats master 2.1: The Kolmogorov-Smirnov GOF test");
	Memo1->Lines->Add("In the example 100 random numbers (for Normal, Log-normal, Student(T) and Weibull distribution) "
		"are generated and then "
		"used in K-S test to test if data comes from normal distribution.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("The graph below is a plot of the empirical "
		"distribution function with a theoretical cumulative "
		"distribution function for 100 random "
		"numbers. The K-S test is based on the maximum distance "
		"between these two curves.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Press the \"Run Test\" button to regenerate random values and "
		"perform K-S test for different alpha levels");
	Data->Size(100,false);
}
//---------------------------------------------------------------------------
void __fastcall TfrmGOFKS::Button1Click(TObject *Sender)
{
	//Perform KS normality test on three different distributions
	switch (RadioGroup1->ItemIndex)
	{
		case 0 : {
					Data->RandGauss();
					Tests();
				};break;
		case 1 : {
					RandomLogNormal(0.0,1.0,Data);
					Tests();
				};break;
		case 2 : {
					RandomStudent(3,Data);
					Tests();
				};break;
		case 3 : {
					RandomWeibull(1,1.3,Data);
					Tests();
				};break;
	}
	RefreshChart();
}
//---------------------------------------------------------------------------
void __fastcall TfrmGOFKS::DoTest(TSample Alpha)
{
	THypothesisResult hRes;
	TSample Signif;
	AnsiString st;

	DStat = GOFKolmogorov(Data,hRes,Signif,NULL,NULL,htTwoTailed,Alpha);
	st = FormatSample("0.0000",Alpha)+"\t\t"+FormatSample("0.0000",Signif)+"\t";
	if (hRes == hrNotReject) st = st+"Accept H0";
	else st = st+"Reject H0";
	Memo2->Lines->Add(st);
}

void __fastcall TfrmGOFKS::Tests()
{
	Memo2->Lines->Clear();
	Memo2->Lines->Add("KOLMOGOROV-SMIRNOV GOF TEST");
	Memo2->Lines->Add("");
	Memo2->Lines->Add("H0:\tDistribution fits the data");
	Memo2->Lines->Add("HA:\tDistribution does not fit the data");
	Memo2->Lines->Add("Distribution:\tNormal");
	Memo2->Lines->Add("Number of observations:\t"+IntToStr(Data->Length));
	Memo2->Lines->Add("");
	Memo2->Lines->Add("Alpha level\tp-value\tConclusion");
	Memo2->Lines->Add("----------------------------------------------");
	DoTest(0.005);
	DoTest(0.01);
	DoTest(0.05);
	DoTest(0.1);
	DoTest(0.15);
	DoTest(0.25);
	Memo2->Lines->Add("----------------------------------------------");
	Memo2->Lines->Insert(6,"KS statistic:\t"+FormatFloat("0.0000",DStat));
}

void __fastcall TfrmGOFKS::RefreshChart()
{
  // EmpiricalCDF needs sorted data ! 
	Data->SortAscend();
	EmpiricalCDF(Data,X,ECDF); // Empirical CDF
	NormalCDF(X,0.0,1.0,TCDF); // Theoretical standard CDF
	ECDF->SetSubRange(0,ECDF->Length-1); // ignore last value for yCDF (see help)
	DrawValues(X,ECDF,Series1,true);
	DrawValues(X,TCDF,Series2,true);
	ECDF->SetSubRange(); // reset subrange
}

void __fastcall TfrmGOFKS::RadioGroup1Click(TObject *Sender)
{
	for (int i = 0;i<Chart1->SeriesCount();i++)
	{
		Chart1->Series[i]->Clear();
	}
	Memo2->Lines->Clear();
}
//---------------------------------------------------------------------------

