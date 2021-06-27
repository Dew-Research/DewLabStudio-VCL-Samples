//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Wizard_PCA.h"
#include "Basic_Form.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmShowPCAWizard *frmShowPCAWizard;
//---------------------------------------------------------------------------
__fastcall TfrmShowPCAWizard::TfrmShowPCAWizard(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("Principal Component Analysis (PCA)");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("PCA can be done with only one procedure call :");
	Memo1->Lines->Add("PCA(Data,PrinCom,EigValues,ZScores,VarPercent);");
	Memo1->Lines->Add("This form demonstrates how you can use basic and advanced "
		" Statistics procedures. In this case PCA data is pre-loaded."
		" But you can test this with your data - just press the \"Edit\" "
		" button...");
	TfrmPCAWiz *wiz = new TfrmPCAWiz(this);
	wiz->Align = alClient;
	wiz->Parent = this;
	wiz->BorderStyle = bsNone;
	wiz->btnCancel->Visible = false; // in this case hide Cancel button
	wiz->MtxPCA->Data->LoadFromFile(CodePath() + "PCA_Data.mtx");
    wiz->MtxPCA->PCAMode = PCARawData;
	wiz->Show();
}
//---------------------------------------------------------------------------
