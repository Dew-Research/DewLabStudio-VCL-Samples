//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "TS_ARAR.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Chart"
#pragma resource "*.dfm"
TfrmARAR *frmARAR;
//---------------------------------------------------------------------------
__fastcall TfrmARAR::TfrmARAR(TComponent* Owner)
	: TfrmBasicChart(Owner)
{
	Memo1->Lines->Add("The idea of ARAR algorithm is to apply automatically selected "
		 "\"memory-shortening\" algorithm (if necessary) to the time series "
		 "and then fit AR model to the transformed series. Stats Master implements "
		 "algorithm, in which fitting of a subset AR model is done on the transformed "
		 "time series.");
	Memo1->Lines->Add("Stats Master allows the ARAR algorithm on shortened or unshortened time "
		 "time series (try selecting/unselecting \"Shorten memory filter\" checkbox).");

	timeSer->LoadFromFile(CodePath() + "deaths.vec");

	UpdateChart();
}
//---------------------------------------------------------------------------
void __fastcall TfrmARAR::btnLoadClick(TObject *Sender)
{
	if (OpenDialog->Execute())
	{
		timeSer->LoadFromFile(OpenDialog->FileName);
		UpdateChart();
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmARAR::TransformSeries()
{
	if (chkShorten->Checked) ShortenFilter(timeSer,sTS,tau,Filter);
	else
	{
		sTS->Copy(timeSer);
		tau = 0;
		double a[] = {1.0};
		Filter->SetIt(a,0);
	}
}

void __fastcall TfrmARAR::UpdateChart()
{
	MemoLog->Lines->Clear();
	TransformSeries();
	if (chkShorten->Checked)
	{
		MemoLog->Lines->Add("#1: Shortening");
		MemoLog->Lines->Add("tau : "+IntToStr(tau));
		MemoLog->Lines->Add("Filter:");
		AnsiString st = "[  ";
		for (int i = 0;i<Filter->Length;i++) st = st + FormatSample("0.000",Filter->Values[i])+ "  ";
		st = st + "]";
		MemoLog->Lines->Add(st);
		MemoLog->Lines->Add("");
	}

	ARARFit(sTS,Phi,l1,l2,l3,Sigma2,13);
	MemoLog->Lines->Add("#2: Fitting");
	MemoLog->Lines->Add("Optimal lags\tCoefficient");
	MemoLog->Lines->Add("1\t\t"+FormatSample("0->000",Phi->Values[0]));
	MemoLog->Lines->Add(IntToStr(l1)+"\t\t"+FormatSample("0.000",Phi->Values[1]));
	MemoLog->Lines->Add(IntToStr(l2)+"\t\t"+FormatSample("0.000",Phi->Values[2]));
	MemoLog->Lines->Add(IntToStr(l3)+"\t\t"+FormatSample("0.000",Phi->Values[3]));
	MemoLog->Lines->Add("WN variance : "+FormatFloat("0.000",Sigma2));
	MemoLog->Lines->Add("");

	DrawValues(timeSer,Series1);
	DoForecasts();
}
void __fastcall TfrmARAR::chkShortenClick(TObject *Sender)
{
	UpdateChart();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARAR::Edit1Change(TObject *Sender)
{
	DoForecasts();
}
//---------------------------------------------------------------------------
void __fastcall TfrmARAR::DoForecasts()
{
  double rmse;
	noForecasts = UpDown1->Position;
	ARARForecast(timeSer,Phi,Filter,tau,l1,l2,l3,sTS->Mean(),noForecasts,Forecasts,stdErrs,rmse);
	DrawValues(Forecasts,Series2,timeSer->Length);
}
