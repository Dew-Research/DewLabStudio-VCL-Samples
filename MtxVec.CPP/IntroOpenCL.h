//---------------------------------------------------------------------------
#ifndef IntroOpenCLH
#define IntroOpenCLH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroOpenCLForm : public TBasicForm3
{
__published:	// IDE-managed Components
  void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TIntroOpenCLForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroOpenCLForm *IntroOpenCLForm;
//---------------------------------------------------------------------------
#endif
