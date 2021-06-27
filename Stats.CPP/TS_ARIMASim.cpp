//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "TS_ARIMASim.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Chart"
#pragma resource "*.dfm"
TfrmARIMASim *frmARIMASim;
//---------------------------------------------------------------------------
__fastcall TfrmARIMASim::TfrmARIMASim(TComponent* Owner)
	: TfrmBasicChart(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("New in Stats Master 2.1: ARMA/ARIMA routines.");
	Memo1->Lines->Add("This example demonstrates usage of ARMA and ARIMA simulation and prediction routines."
			 " Change AR, MA and d parameters to simulate different ARMA and ARIMA models.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Press the \"Simulate\" button for random ARMA/ARIMA model time series.");

}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMASim::Simulate()
{
	MemoLog->Lines->Clear();
	if (d==0)
	{
		ARMASimulate(Phi,Theta,n,timeSer);
		sVector phiest;
		sVector thetaest;
		phiest->Length = Phi->Length;
		thetaest->Length = Theta->Length;

		TSample s2;
		if (Phi->Length!=0 && Theta->Length==0) ARYuleWalkerFit(timeSer,phiest,s2);
		else if (Phi->Length==0 && Theta->Length!=0) ARMAInnovationsFit(timeSer,thetaest,s2);
		else ARMAInnovationsFit(timeSer,phiest,thetaest,s2);
		MemoLog->Lines->Add("Initial estimates");
		if (Phi->Length>0)
		{
			MemoLog->Lines->Add("AR coefficients");
			for (int i = 0;i<Phi->Length;i++)
				MemoLog->Lines->Add("AR["+IntToStr(i+1)+"]="+FormatSample("0.000",phiest->Values[i]));
		}
		if (Theta->Length>0)
		{
			MemoLog->Lines->Add("MA coefficients");
			for (int i = 0;i<Theta->Length;i++)
				MemoLog->Lines->Add("MA["+IntToStr(i+1)+"]="+FormatSample("0.000",thetaest->Values[i]));
		}
	}
	else
		ARIMASimulate(Phi,Theta,d,zinit,n,timeSer);

	Chart1->Title->Text->Clear();
	Chart1->Title->Text->Add("Simulating :");
	if (d==0) Chart1->Title->Text->Add("ARMA ("+IntToStr(Phi->Length)+","+IntToStr(Theta->Length)+") process");
	else Chart1->Title->Text->Add("ARIMA ("+IntToStr(Phi->Length)+","+IntToStr(Theta->Length)+","+IntToStr(d)+") process");
	PlotSeries(RadioGroupCT->ItemIndex);

}
void __fastcall TfrmARIMASim::EditARChange(TObject *Sender)
{
	Phi->Length = StrToInt(EditAR->Text);
	Phi->SetZero();
	Series1->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::EditMAChange(TObject *Sender)
{
  Theta->Length = StrToInt(EditMA->Text);
	Theta->SetZero();
	Series1->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::EditDChange(TObject *Sender)
{
	d = StrToInt(EditD->Text);
	// an example ONLY 
	zinit->Size(d);
	zinit->SetZero();
	Series1->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::EditNChange(TObject *Sender)
{
  n = StrToInt(EditN->Text);
	Series1->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::Button2Click(TObject *Sender)
{
	ViewValues(Phi,"AR coefficients",true,false,true);
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::Button3Click(TObject *Sender)
{
	ViewValues(Theta,"MA coefficients",true,false,true);	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::Button4Click(TObject *Sender)
{
	Simulate();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::Button5Click(TObject *Sender)
{
	ViewValues(zinit,"initial values for d",true,false,true);	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMASim::RadioGroupCTClick(TObject *Sender)
{
	PlotSeries(RadioGroupCT->ItemIndex);
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMASim::PlotSeries(int stype)
{
	sVector acfv, pacfv;

	Series2->Active = false;
	switch (stype)
	{
			case 0:  {
						DrawValues(timeSer,Series1);
						Series1->Title = "Time series";
					};break;
			case 1:  { // ACF
						ACF(timeSer,acfv,timeSer->Length / 2);
						Series1->Title = "Time series ACF";
						DrawValues(acfv,Series1);
						if (d == 0)
						{
							Series2->Active = true;
							ARMAAcf(Phi,Theta,timeSer->Length / 2, pacfv);
							DrawValues(pacfv,Series2);
						}
					};break;
			case 2:  {
						ACF(timeSer,acfv,timeSer->Length / 2);
						PACF(acfv,pacfv);
						Series1->Title = "Time series PACF";
						DrawValues(pacfv,Series1);
					};break;
	}
}
