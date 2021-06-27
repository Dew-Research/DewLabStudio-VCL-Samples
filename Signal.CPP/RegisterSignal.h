//---------------------------------------------------------------------------

#ifndef RegisterSignalH
#define RegisterSignalH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TRegisterSignalForm : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TRegisterSignalForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TRegisterSignalForm *RegisterSignalForm;
//---------------------------------------------------------------------------
#endif
