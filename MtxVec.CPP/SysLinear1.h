//---------------------------------------------------------------------------

#ifndef SysLinear1H
#define SysLinear1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TLinearSystem1 : public TBasicForm2
{
__published:	// IDE-managed Components
  TStringGrid *StringGrid1;
  TLabel *Label1;
  TStringGrid *StringGrid2;                                     
  TLabel *Label2;
  TLabel *Label3;
  TStringGrid *StringGrid3;
  TLabel *Label4;
  TLabel *Label5;
  TButton *Button1;
  TPanel *Panel4;
  TMemo *Memo2;
  TRadioGroup *RadioGroup1;
  TCheckBox *CheckBox1;
  TLabel *Label6;
  TComboBox *ComboBox1;
  TPanel *Panel5;
  TLabel *Label7;
  TStringGrid *StringGrid4;
  TLabel *Label8;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall CheckBox1Click(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall ComboBox1Change(TObject *Sender);
private:	// User declarations
  Mtxvec::TMatrix *A;
  Mtxvec::TVector *b;
public:		// User declarations
  __fastcall TLinearSystem1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TLinearSystem1 *LinearSystem1;
//---------------------------------------------------------------------------
#endif
