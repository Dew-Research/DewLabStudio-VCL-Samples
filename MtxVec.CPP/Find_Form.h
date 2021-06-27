//---------------------------------------------------------------------------

#ifndef Find_FormH
#define Find_FormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TfrmFind : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TEdit *Edit1;
        TButton *Button1;
        TButton *Button2;                               
        TCheckBox *CheckBox1;
        void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
private:	// User declarations

public:		// User declarations
       bool FindAll;
       AnsiString FindText;
       __fastcall TfrmFind(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmFind *frmFind;
//---------------------------------------------------------------------------
#endif
