//---------------------------------------------------------------------------

#ifndef List_FuncH
#define List_FuncH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TfrmListFunc : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TLabel *Label1;
	TStringGrid *StringGrid1;
	void __fastcall FormResize(TObject *Sender);
private:	// User declarations
	int __fastcall ListToStringGrid(UnicodeString filename);
public:		// User declarations
	__fastcall TfrmListFunc(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmListFunc *frmListFunc;
//---------------------------------------------------------------------------
#endif
