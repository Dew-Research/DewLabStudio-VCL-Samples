//---------------------------------------------------------------------------

#ifndef IntroExportH
#define IntroExportH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroExpImp : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
  __fastcall TIntroExpImp(TComponent* Owner);
};                                                        
//---------------------------------------------------------------------------
extern PACKAGE TIntroExpImp *IntroExpImp;
//---------------------------------------------------------------------------
#endif
