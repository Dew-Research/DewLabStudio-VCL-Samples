//---------------------------------------------------------------------------

#ifndef IntroDesignH
#define IntroDesignH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroDesignForm : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TIntroDesignForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroDesignForm *IntroDesignForm;
//---------------------------------------------------------------------------
#endif
