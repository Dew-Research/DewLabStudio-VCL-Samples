//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Wizard_MLReg.h"
#include "MLRegWizard.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmShowMLRWizard *frmShowMLRWizard;
//---------------------------------------------------------------------------
__fastcall TfrmShowMLRWizard::TfrmShowMLRWizard(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("By using TMtxMulLinReg component you can easiliy perform"
			" multiple linear regression. Just add a matrix of independent"
			" variables, vector of dependent variable and (optionally)"
			" weights and let Statistics regression routines do the rest.");

	TfrmMulLinRegWiz* frmMulLinRegWiz = new TfrmMulLinRegWiz(this);
	frmMulLinRegWiz->Align = alClient;
	frmMulLinRegWiz->Parent = this;
	frmMulLinRegWiz->BorderStyle = bsNone;
	frmMulLinRegWiz->btnCancel->Visible = false; // in this case hide Cancel button
	// load prepared data

	frmMulLinRegWiz->MtxMulLinReg->Y->LoadFromFile(CodePath() + "MulLinReg_Y.vec");
	frmMulLinRegWiz->MtxMulLinReg->A->LoadFromFile(CodePath() + "MulLinReg_A.mtx");

	frmMulLinRegWiz->Show();
}
//---------------------------------------------------------------------------
