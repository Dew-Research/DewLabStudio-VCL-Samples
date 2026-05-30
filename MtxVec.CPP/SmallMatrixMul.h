//---------------------------------------------------------------------------
#ifndef SmallMatrixMulH
#define SmallMatrixMulH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic1.h"
#include <ComCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>

#include <MtxVec.hpp>
#include <MtxComCtrls.hpp>
#include <Probabilities.hpp>
#include <Math387.hpp>
#include <MtxExpr.hpp>
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
class TfrmSmallMatrix : public TBasicForm1
{
__published:	// IDE-managed Components
  TButton *Button1;
  TLabel *jitLabel;
  TCheckBox *ComplexBox;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
private:
  TSmallMatrixMultiply *jit;
public:
  __fastcall TfrmSmallMatrix(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSmallMatrix *frmSmallMatrix;
//---------------------------------------------------------------------------
#endif
