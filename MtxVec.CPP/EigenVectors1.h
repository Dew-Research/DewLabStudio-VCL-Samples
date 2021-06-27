//---------------------------------------------------------------------------

#ifndef EigenVectors1H
#define EigenVectors1H
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
class TEigVec1 : public TBasicForm2
{                                                                
__published:	// IDE-managed Components
  TStringGrid *StringGrid4;
  TStringGrid *StringGrid2;
  TLabel *Label1;
  TLabel *Label2;
  TRadioGroup *RadioGroup1;
  TRadioGroup *RadioGroup2;
  TLabel *Label3;
  TStringGrid *StringGrid1;
  TSpeedButton *SpeedButton1;
  TSpeedButton *SpeedButton2;
  TBitBtn *Button1;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
  void __fastcall RadioGroup2Click(TObject *Sender);
  void __fastcall SpeedButton1Click(TObject *Sender);
  void __fastcall SpeedButton2Click(TObject *Sender);
private:	// User declarations
  sMatrix A, EigL, EigR, DiagMtx;
  sVector EigValues;
  TVectorForm VecForm;
  TBalanceType  Bal;
public:		// User declarations
  __fastcall TEigVec1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TEigVec1 *EigVec1;
//---------------------------------------------------------------------------
#endif
