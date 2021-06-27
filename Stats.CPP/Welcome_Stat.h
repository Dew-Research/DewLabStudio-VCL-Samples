//---------------------------------------------------------------------------

#ifndef Welcome_StatH
#define Welcome_StatH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_REdit.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmWelcome : public TfrmBaseRichEdit
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TfrmWelcome(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmWelcome *frmWelcome;
//---------------------------------------------------------------------------
#endif
