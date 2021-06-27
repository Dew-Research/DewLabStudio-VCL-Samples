//---------------------------------------------------------------------------

#ifndef MLR_EditorH
#define MLR_EditorH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include "StatToolsDialogs.hpp"
#include "MtxBaseComp.hpp"
#include "StatTools.hpp"
#include "StatMulLinRegEditor.hpp"
//---------------------------------------------------------------------------
class TfrmMLREditor : public TfrmBasic
{
__published:	// IDE-managed Components
	TMtxMulLinReg *MtxMulLinReg;
private:	// User declarations
	TMulLinRegDialog* RegDialog;
	void __fastcall CustomizeEditorForm(TObject *Sender);
public:		// User declarations
	__fastcall TfrmMLREditor(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMLREditor *frmMLREditor;
//---------------------------------------------------------------------------
#endif
