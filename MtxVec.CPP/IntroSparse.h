//---------------------------------------------------------------------------

#ifndef IntroSparseH
#define IntroSparseH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroSparseForm : public TBasicForm3
{
	__published: // IDE-managed Components
	private:	 // User declarations
	public:		 // User declarations
  __fastcall TIntroSparseForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroSparseForm *IntroSparseForm;
//---------------------------------------------------------------------------
#endif
