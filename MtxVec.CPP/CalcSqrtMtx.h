//---------------------------------------------------------------------------
#ifndef CalcSqrtMtxH
#define CalcSqrtMtxH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
#include <MtxExpr.hpp>
//---------------------------------------------------------------------------
class TfrmSqrtMtx : public TBasicForm2
{
__published:	// IDE-managed Components
    TBitBtn *Button1;                                        
    TBitBtn *Button2;
    TButton *Button3;
    TStringGrid *StringGrid1;                    
    TStringGrid *StringGrid2;
    TLabel *Label1;
    TLabel *Label2;
    TRadioGroup *RadioGroup1;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall StringGrid1SetEditText(TObject *Sender, int ACol,
          int ARow, const String Value);
  void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
	sMatrix A, B, C;
    void __fastcall MakeSymmetric(TMtx *mtx);
public:		// User declarations
  __fastcall TfrmSqrtMtx(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSqrtMtx *frmSqrtMtx;
//---------------------------------------------------------------------------
#endif
