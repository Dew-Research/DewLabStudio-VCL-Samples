//---------------------------------------------------------------------------

#ifndef Quick_StartH
#define Quick_StartH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_REdit.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmQuickStart : public TfrmBaseRichEdit
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TfrmQuickStart(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmQuickStart *frmQuickStart;
//---------------------------------------------------------------------------
#endif
