//---------------------------------------------------------------------------

#ifndef Hypothesis_TestH
#define Hypothesis_TestH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include "MtxBaseComp.hpp"
#include "StatTools.hpp"
#include <ExtCtrls.hpp>
#include "StatHypTestEditor.hpp"
#include "StatToolsDialogs.hpp"
//---------------------------------------------------------------------------
class TfrmHypTest : public TfrmBasic
{
__published:	// IDE-managed Components
	TMtxHypothesisTest *MtxHypTest;
private:	// User declarations
public:		// User declarations
	__fastcall TfrmHypTest(TComponent* Owner);
	void __fastcall CustomizeEditorForm(TObject* Sender);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmHypTest *frmHypTest;
//---------------------------------------------------------------------------
#endif
