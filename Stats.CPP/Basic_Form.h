//---------------------------------------------------------------------------

#ifndef Basic_FormH
#define Basic_FormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Registry.hpp>
#include <FileCtrl.hpp>
//---------------------------------------------------------------------------
class TfrmBasic : public TForm
{
__published:	// IDE-managed Components
	TMemo *Memo1;
	TPanel *Panel1;
private:	// User declarations
public:		// User declarations
	__fastcall TfrmBasic(TComponent* Owner);
};
const AnsiString DSPRegKey = "\\Software\\Dew Research";
AnsiString __fastcall CodePath();
bool __fastcall CodePathSelect();
//---------------------------------------------------------------------------
extern PACKAGE TfrmBasic *frmBasic;
//---------------------------------------------------------------------------
#endif
