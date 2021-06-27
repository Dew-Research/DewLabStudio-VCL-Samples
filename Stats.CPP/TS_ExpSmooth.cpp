//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "TS_ExpSmooth.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Chart"
#pragma resource "*.dfm"
TfrmExpSmooth *frmExpSmooth;
//---------------------------------------------------------------------------
__fastcall TfrmExpSmooth::TfrmExpSmooth(TComponent* Owner)
	: TfrmBasicChart(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("Exponential smoothing is a very popular scheme to produce a smoothed time series. Whereas in Single Moving Averages the past "
		"observations are weighted equally, exponential smoothing assigns exponentially decreasing weights as the observation get older. "
		"In other words, recent observations are given relatively more weight in forecasting than the older observations.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("This example demonstrates single, double and triple exponential smoothing. The following data set represents 24 observations. "
		"These are six years of quarterly data (each year = 4 quarters).");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Things to try");
	Memo1->Lines->Add("(1) Press the \"Smooth\" button to perform single, double and triple exponential smoothing.");
	Memo1->Lines->Add("(2) Try changing initial values for alpha, beta and/or gamma parameters. Values must lie in the [0,1] interval.");
	Memo1->Lines->Add("(3) Change the \"Forecast period\" value - the last forecast point.");
	Memo1->Lines->Add("(4) Load different data set by pressing the \"Edit data\" button.");

	EditAlphaS->Text = FloatToStr(0.1);
	EditAlphaD->Text = FloatToStr(0.1);
	EditGammaD->Text = FloatToStr(0.1);
	EditAlphaT->Text = FloatToStr(0.1);
	EditBetaT->Text = FloatToStr(0.1);
	EditGammaT->Text = FloatToStr(0.1);
	EditPeriod->Text = IntToStr(4);
	double DataBuf[] = {362,385,432,341,382,409,498,387,473,513,582,474,
										544,582,681,557,628,707,773,592,627,725,854,661};
	Data->SetIt(false,DataBuf,sizeof(DataBuf)/sizeof(double)-1);
	ResetForecast();
	DrawValues(Data,Series1);
}
//---------------------------------------------------------------------------
void __fastcall TfrmExpSmooth::ResetForecast()
{
	UpDown1->Max = Data->Length * 2;
	UpDown1->Position = Data->Length;
}

void __fastcall TfrmExpSmooth::Smooth()
{
	TSample AlphaS, AlphaD, GammaD;
	TSample AlphaT,BetaT,GammaT;
	TSample MSE;
	int Period;
  // read variables ... 
	try {
		AlphaS = StrToFloat(EditAlphaS->Text);
	} catch(...) {
		AlphaS = 0.1;
	}
	try {
		AlphaD = StrToFloat(EditAlphaD->Text);
	} catch(...) {
		AlphaD = 0.1;
	}
	try {
		GammaD = StrToFloat(EditGammaD->Text);
	} catch(...) {
		GammaD = 0.1;
	}
	try {
		AlphaT = StrToFloat(EditAlphaT->Text);
	} catch(...) {
		AlphaT = 0.1;
	}
	try {
		BetaT = StrToFloat(EditBetaT->Text);
	} catch(...) {
		BetaT = 0.1;
	}
	try {
		GammaT = StrToFloat(EditGammaT->Text);
	} catch(...) {
		GammaT = 0.1;
	}
	try {
		Period = StrToInt(EditPeriod->Text);
	} catch(...) {
		Period = 4;
	}
	T = UpDown1->Position;
	// step 1 => estimate parameters Alpha
	// step 2 => forecast and store the results in YHat
	SingleExpForecast(Data,YHat,AlphaS,T,MSE,0);
	singletext = "Single EXP: alpha="+FormatFloat("0.000",AlphaS);
	Series2->Title = "Single EXP (MSE="+FormatFloat("0.000",MSE)+")";
	DrawValues(YHat,Series2,1,1); // offset by first point

	// step 1 => estimate parameters Alpha,Gamma
	// step 2 => forecast and store the results in YHat
	DoubleExpForecast(Data,YHat,AlphaD,GammaD,T,MSE,1);
	doubletext = "Double EXP: alpha="+FormatFloat("0.000",AlphaD)+" gamma="+FormatFloat("0.000",GammaD);
	Series3->Title = "Double EXP (MSE="+FormatFloat("0.000",MSE)+")";
	DrawValues(YHat,Series3,1,1); // offset by first point

	// step 1 => estimate parameters Alpha,Beta, Gamma
	// step 2 => forecast and store the results in YHat
	TripleExpForecast(Data,YHat,AlphaT,BetaT,GammaT,T,MSE,Period);
	tripletext = "Triple EXP: alpha="+FormatFloat("0.000",AlphaT)+" beta="+FormatFloat("0.000",BetaT)+ " gamma="+FormatFloat("0.000",GammaT);
	Series4->Title = "Triple EXP (MSE="+FormatFloat("0.000",MSE)+")";
	DrawValues(YHat,Series4,Period,1); // offset by first period
}

void __fastcall TfrmExpSmooth::ResetChart()
{
	singletext = "";
	doubletext = "";
	tripletext = "";
	Series2->Clear();
	Series3->Clear();
	Series4->Clear();
}

void __fastcall TfrmExpSmooth::Button2Click(TObject *Sender)
{
	ViewValues(Data,"Raw data",true,false,true);
	ResetChart();
	ResetForecast();
	DrawValues(Data,Series1);
}
//---------------------------------------------------------------------------

void __fastcall TfrmExpSmooth::Button3Click(TObject *Sender)
{
	Smooth();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmExpSmooth::Chart1AfterDraw(TObject *Sender)
{
		WideString aw = "W";

		int x = Chart1->ChartRect.Left + 20;
		int y = Chart1->ChartRect.Top + 20;
		Chart1->Canvas->Font->Color = clGreen;
		Chart1->Canvas->Font->Style = Font->Style << TFontStyle::fsBold;
		Chart1->Canvas->TextOut(x,y,singletext);
		Chart1->Canvas->Font->Color = clYellow;
		Chart1->Canvas->TextOut(x,y+Chart1->Canvas->TextHeight(aw)*2,doubletext);
		Chart1->Canvas->Font->Color = clBlue;
		Chart1->Canvas->TextOut(x,y+Chart1->Canvas->TextHeight(aw)*4,tripletext);

}
//---------------------------------------------------------------------------

