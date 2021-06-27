//---------------------------------------------------------------------------

#ifndef FloatEdit1H
#define FloatEdit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "MtxComCtrls.hpp"
#include "Math387.hpp"
//---------------------------------------------------------------------------
class TfrmFloatEdit1 : public TBasicForm2
{
__published:	// IDE-managed Components                        
    TMtxFloatEdit *MtxFloatEdit1;
    TMtxFloatEdit *MtxFloatEdit2;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TButton *Button1;
    TButton *Button2;
    TButton *Button3;
    TButton *Button4;
    TButton *Button5;
    TButton *Button6;
    TEdit *Edit1;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button5Click(TObject *Sender);
  void __fastcall Button6Click(TObject *Sender);
private:	// User declarations
    TCplx Res;
    TCplx Z1,Z2;
public:		// User declarations
  __fastcall TfrmFloatEdit1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmFloatEdit1 *frmFloatEdit1;
//---------------------------------------------------------------------------
#endif
