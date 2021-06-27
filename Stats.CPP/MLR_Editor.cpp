//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MLR_Editor.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmMLREditor *frmMLREditor;
//---------------------------------------------------------------------------
__fastcall TfrmMLREditor::TfrmMLREditor(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("Ready to use multiple linear regression editor can be"
			" invoked with a single  procedure call (see the code) or"
			" simply by dropping a TMtxMulLinReg component on the form"
			" and then double clicking on it.");
	Memo1->Lines->Add("Try changing data and parameters ...");
	// load prepared data

	MtxMulLinReg->Y->LoadFromFile(CodePath() + "MulLinReg_Y.vec");
	MtxMulLinReg->A->LoadFromFile(CodePath() + "MulLinReg_A.mtx");

	// invoke editor
	// normally you would use ShowDialog(....) method
	RegDialog = new TMulLinRegDialog(this);

	RegDialog->OnBeforeUpdate = CustomizeEditorForm; // here we customize editor form }
	RegDialog->Source = MtxMulLinReg;
	RegDialog->ExecuteModal();
}
//---------------------------------------------------------------------------
void __fastcall TfrmMLREditor::CustomizeEditorForm(TObject *Sender) {
	((TMulLinRegressEditor*)Sender)->ButtonOK->Visible = false;
	((TMulLinRegressEditor*)Sender)->ButtonCancel->Visible = false;
}
