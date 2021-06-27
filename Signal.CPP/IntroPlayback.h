//---------------------------------------------------------------------------

#ifndef IntroPlaybackH
#define IntroPlaybackH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroPlaybackForm : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TIntroPlaybackForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroPlaybackForm *IntroPlaybackForm;
//---------------------------------------------------------------------------
#endif
