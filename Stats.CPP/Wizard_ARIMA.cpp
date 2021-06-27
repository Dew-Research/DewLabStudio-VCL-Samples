//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Wizard_ARIMA.h"
#include "ARIMAWizard.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmWizardARIMA *frmWizardARIMA;
//---------------------------------------------------------------------------
__fastcall TfrmWizardARIMA::TfrmWizardARIMA(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Add("ARMA/ARIMA model fitting and forecasting");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Time series analysis by using ARMA/ARIMA models");
	Memo1->Lines->Add("This form demonstrates how you can use time series analysis routines for "
			" approximating and forecasting time series values with ARMA/ARIMA models. "
			"  In this case sample time series is preloaded with it's mean value removed." 
			" Time series still doesn't \"look\" stationary. Try differencing time series to obtain"
			" approximately stationary series.");
	Memo1->Lines->Add("You can also test this wizard with your data - just press the \"Load\" "
			" button on the first wizard page.");
	TfrmARIMAWizard* wiz = new TfrmARIMAWizard(this);
	wiz->Align = alClient;
	wiz->Parent = this;
	wiz->BorderStyle = bsNone;
	wiz->btnCancel->Visible = false; // in this case hide Cancel button
	// load prepared data

	wiz->TimeSeries->LoadFromFile(CodePath() + "dowjones.vec");
	wiz->TimeSeries->Caption = "dowjones.vec";
	wiz->Show();

}
//---------------------------------------------------------------------------
