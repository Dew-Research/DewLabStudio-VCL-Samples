//---------------------------------------------------------------------------

#ifndef Save_PrecisionH
#define Save_PrecisionH
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
class TfrmSavePrec : public TBasicForm2
{
__published:	// IDE-managed Components
  TButton *Button1;                                             
  TComboBox *CBPrecision;
  TComboBox *CBRounding;
  TStringGrid *StringGrid1;
  TStringGrid *StringGrid2;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TLabel *Label5;
  TLabel *lblMemSize;
  void __fastcall CBPrecisionChange(TObject *Sender);
  void __fastcall CBRoundingChange(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
  Mtxvec::TMatrix *m1, *m2;
  TPrecision Precision;
  TRounding Rounding;
public:		// User declarations
  __fastcall TfrmSavePrec(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSavePrec *frmSavePrec;
//---------------------------------------------------------------------------
#endif
