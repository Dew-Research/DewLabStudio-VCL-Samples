//---------------------------------------------------------------------------

#ifndef Basic3H
#define Basic3H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TBasicForm3 : public TForm
{
__published:	// IDE-managed Components
  TRichEdit *RichEdit1;
private:	// User declarations
public:		// User declarations
  __fastcall TBasicForm3(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBasicForm3 *BasicForm3;
//---------------------------------------------------------------------------
#endif
