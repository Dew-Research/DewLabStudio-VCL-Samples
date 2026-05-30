//---------------------------------------------------------------------------
#ifndef BlockProcessingH
#define BlockProcessingH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic1.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <MtxExpr.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TfrmBlockProc : public TBasicForm1
{                                                             
__published:	// IDE-managed Components
  TButton *Button1;
  TLabel *Label1;
  TLineSeries *Series1;
  TLineSeries *Series2;
  TLineSeries *Series3;
  TLineSeries *Series4;
  TLineSeries *Series5;
  void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
  sVector Res, X, tmp;
  int Len;
  DWORD Counter;
  void __fastcall MaxwellBlock(int Iter, double &Result);
  void __fastcall MaxwellNoBlock(int Iter, double &Result);
  void __fastcall MaxwellFunction(int Iter, double &Result);
  void __fastcall MaxwellFunctionCpp(int Iter, double &Result);
  void __fastcall MaxwellExpression(int Iter, double &Result);
  sVector __fastcall MaxwellVecExpression(double a, TVec * const X_);
public:		// User declarations
  __fastcall TfrmBlockProc(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBlockProc *frmBlockProc;
//---------------------------------------------------------------------------
#endif
