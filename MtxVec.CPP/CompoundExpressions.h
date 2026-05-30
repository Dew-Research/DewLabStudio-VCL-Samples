//---------------------------------------------------------------------------
#ifndef CompoundExpressionsH
#define CompoundExpressionsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>

#include <MtxBaseComp.hpp>
#include <MtxDialogs.hpp>
#include <MtxExpr.hpp>
#include <MtxComCtrls.hpp>
#include <Math387.hpp>
#include <MtxVecBase.hpp>
#include <MtxVec.hpp>
#include <AbstractMtxVec.hpp>

#include <VclTee.TeeGDIPlus.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
enum TTestMethod { tmGetMem, tmTVec, tmVector, tmVectorGlobal };
//---------------------------------------------------------------------------
class TCompoundExpressionsForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TButton *RunButton;
  TChart *Chart;
  TRichEdit *Memo;
  TBarSeries *Series1;
  TBarSeries *Series2;
  TRadioGroup *PrecisionGroup;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall RunButtonClick(TObject *Sender);
  void __fastcall PrecisionGroupClick(TObject *Sender);
private:
  void __fastcall DoublePrecisionMath();
  void __fastcall ComplexDoublePrecisionMath();
  void __fastcall SaturatedIntegerMath();
  void __fastcall SaturatedSmallIntMath();
  void __fastcall SaturatedByteMath();
public:
  double Timings[2][6];
  int ak, ac;
  int VectorLen;
  int Stage;
  __fastcall TCompoundExpressionsForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TCompoundExpressionsForm *CompoundExpressionsForm;
//---------------------------------------------------------------------------
#endif
