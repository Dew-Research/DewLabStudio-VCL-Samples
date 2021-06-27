//---------------------------------------------------------------------------

#ifndef IntroMemoryManH
#define IntroMemoryManH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroMemMan : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
  __fastcall TIntroMemMan(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroMemMan *IntroMemMan;
//---------------------------------------------------------------------------
#endif
