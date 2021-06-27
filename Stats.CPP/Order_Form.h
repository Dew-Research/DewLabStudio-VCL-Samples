//---------------------------------------------------------------------------

#ifndef Order_FormH
#define Order_FormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_REdit.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmOrder : public TfrmBaseRichEdit
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TfrmOrder(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmOrder *frmOrder;
//---------------------------------------------------------------------------
#endif
