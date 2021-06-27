//---------------------------------------------------------------------------

#ifndef Wizard_PCAH
#define Wizard_PCAH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include "PCAWizard.h"
//---------------------------------------------------------------------------
class TfrmShowPCAWizard : public TfrmBasic
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TfrmShowPCAWizard(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmShowPCAWizard *frmShowPCAWizard;
//---------------------------------------------------------------------------
#endif
