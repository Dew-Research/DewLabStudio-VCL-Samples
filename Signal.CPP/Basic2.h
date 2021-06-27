//---------------------------------------------------------------------------

#ifndef Basic2H
#define Basic2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <MtxVec.hpp>
#include <Math387.hpp>
#include <MtxExpr.hpp>

//---------------------------------------------------------------------------
class TBasicForm2 : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TPanel *Panel3;
  TRichEdit *RichEdit1;
private:	// User declarations
public:		// User declarations
  DWORD TimeCheck, TimeElapsed;
  __fastcall TBasicForm2(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBasicForm2 *BasicForm2;
//---------------------------------------------------------------------------
#endif
