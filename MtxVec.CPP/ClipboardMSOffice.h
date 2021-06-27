//---------------------------------------------------------------------------

#ifndef ClipboardMSOfficeH
#define ClipboardMSOfficeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <MtxExpr.hpp>
//---------------------------------------------------------------------------
class TMSOffice : public TBasicForm2
{                                                     
__published:	// IDE-managed Components
  TButton *Button1;
  TButton *Button2;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
private:	// User declarations
  sMatrix AMtx;
public:		// User declarations
  __fastcall TMSOffice(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMSOffice *MSOffice;
//---------------------------------------------------------------------------
#endif
