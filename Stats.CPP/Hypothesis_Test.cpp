//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Hypothesis_Test.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmHypTest *frmHypTest;
//---------------------------------------------------------------------------
__fastcall TfrmHypTest::TfrmHypTest(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Add("Ready-to use hypothesis testing editor can be invoked with a single "
		" procedure call (see the code) or simply by dropping a TMtxHypothesisTest "
		" component on the form and then double clicking on it.");
	Memo1->Lines->Add("Try changing data, hypothesis type and hypothesis method...");
	// add some sample data
	MtxHypTest->DataVec1->Size(50);
	MtxHypTest->DataVec2->Size(50);
	MtxHypTest->DataVec1->RandGauss(5.0,0.2);
	MtxHypTest->DataVec2->RandGauss(3,0.2);
	MtxHypTest->Mean = 5.0;
	MtxHypTest->Sigma = 0.2;
	// invoke editor
	// normally you would use ShowDialog(....) procedure
	THypothesisTestDialog* dialog = new THypothesisTestDialog(this);
	dialog->OnBeforeUpdate = CustomizeEditorForm; // here we customize editor form 
	dialog->Source = MtxHypTest;
  dialog->ExecuteModal();

}
//---------------------------------------------------------------------------
/* This example also demonstrates, how you can fully
	customize component editor
*/
void __fastcall TfrmHypTest::CustomizeEditorForm(TObject* Sender)
{
	THypothesisTestEditor* editor = dynamic_cast<THypothesisTestEditor*>(Sender);
	editor->ButtonOK->Visible = false;
	editor->ButtonCancel->Visible = false;
}
