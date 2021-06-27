//---------------------------------------------------------------------------

#ifndef LogMemoH
#define LogMemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmLogForm : public TForm
{
__published:	// IDE-managed Components
	TMemo *Memo1;
	TPanel *Panel1;
	TButton *Button1;
	void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TfrmLogForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmLogForm *frmLogForm;
//---------------------------------------------------------------------------
#endif
