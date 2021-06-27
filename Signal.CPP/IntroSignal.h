//---------------------------------------------------------------------------

#ifndef IntroSignalH
#define IntroSignalH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroSignalForm : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TIntroSignalForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroSignalForm *IntroSignalForm;
//---------------------------------------------------------------------------
#endif
