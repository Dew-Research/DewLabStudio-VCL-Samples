//---------------------------------------------------------------------------
#ifndef DemoHowToH
#define DemoHowToH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmDemoHowTo : public TBasicForm3
{
__published:	// IDE-managed Components
  void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TfrmDemoHowTo(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmDemoHowTo *frmDemoHowTo;
//---------------------------------------------------------------------------
#endif
