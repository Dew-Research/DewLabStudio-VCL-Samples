//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Wizard_Decomp.h"
#include "DecompWizard.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmDecompDemo *frmDecompDemo;
//---------------------------------------------------------------------------
__fastcall TfrmDecompDemo::TfrmDecompDemo(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Add("Decomposition forecasting");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Classical time series decomposition separates a time series into five components: mean, long-range trend, seasonality, cycle, and randomness. "
		"The decomposition model is:");
	Memo1->Lines->Add("Value = (Mean) x (Trend) x (Seasonality) x (Cycle) x (Random).");
	Memo1->Lines->Add("Note that this model is multiplicative rather than additive. Although additive models are more popular in other areas of statistics, forecasters "
		"have found that the multiplicative model fits a wider range of forecasting situations.");
	Memo1->Lines->Add("Decomposition is popular among forecasters because it is easy to understand (and explain to others). While complex ARIMA models are often "
		"popular among statisticians, they are not as well accepted among forecasting practitioners. For seasonal (monthly, weekly, or quarterly) data, "
		"decomposition methods are often as accurate as the ARIMA methods and they provide additional information about the trend and cycle which may "
		"not be available in ARIMA methods.");
	Memo1->Lines->Add("Decomposition has one disadvantage: the cycle component must be input by the forecaster since it is not estimated by the algorithm. You can "
		"get around this by ignoring the cycle, or by assuming a constant value. Some forecasters consider this a strength because it allows the forecaster "
		"to enter information about the current business cycle into the forecast.");
	TfrmDecompositionWizard *wiz = new TfrmDecompositionWizard(this);
	wiz->Align = alClient;
	wiz->Parent = this;
	wiz->BorderStyle = bsNone;
	wiz->btnCancel->Visible = false; // in this case hide Cancel button
	// load prepared data
	wiz->TimeSeries->LoadFromFile(CodePath() + "airpass.vec");
	wiz->Show();
}
//---------------------------------------------------------------------------
