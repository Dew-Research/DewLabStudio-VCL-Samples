//---------------------------------------------------------------------------

#ifndef IntroApplicationH
#define IntroApplicationH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroApplicationForm : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TIntroApplicationForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroApplicationForm *IntroApplicationForm;
//---------------------------------------------------------------------------
#endif
