//---------------------------------------------------------------------------

#ifndef LQR1H
#define LQR1H
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
//---------------------------------------------------------------------------
class TLQRDemo : public TBasicForm2
{
__published:	// IDE-managed Components
  TRadioGroup *RadioGroup1;
  TStringGrid *StringGrid1;                                            
  TLabel *Label1;
  TStringGrid *StringGrid2;
  TStringGrid *StringGrid3;
  TCheckBox *CheckBox1;
  TBitBtn *Button1;
  TBitBtn *Button2;
  TBitBtn *Button3;
  void __fastcall RadioGroup1Click(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
  Mtxvec::TMatrix *A, *L, *Q, *R;
  sMatrix tmpM1, tmpM2, tmpM3;
  sVector S;
public:		// User declarations
  __fastcall TLQRDemo(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TLQRDemo *LQRDemo;
//---------------------------------------------------------------------------
#endif
