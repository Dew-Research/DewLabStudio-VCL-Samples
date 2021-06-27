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
        TButton *Button1;                                      
        TStringGrid *StringGrid1;
        TButton *Button2;
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
private:	// User declarations
        int LastIndex;
        AnsiString LastSearchText;
        bool LastFindAll;
        int __fastcall ListToStringGrid(AnsiString AFileName);
        int __fastcall DoSearch(const AnsiString FindText, bool FindAllWords);                
public:		// User declarations
        __fastcall TfrmListFunc(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmListFunc *frmListFunc;
//---------------------------------------------------------------------------
#endif
