//---------------------------------------------------------------------------
#ifndef NumaUnitH
#define NumaUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>

#include <MtxExpr.hpp>
#include <MtxVec.hpp>
#include <Math387.hpp>
//---------------------------------------------------------------------------
class TNumaForm : public TForm
{
__published:	// IDE-managed Components
  TButton *RunButton;
  TMemo *Memo1;
  TChart *Chart1;
  TBarSeries *Series1;
  TRadioGroup *ComputeKindGroup;
  TMemo *Memo;
  TEdit *CountEdit;
  TLabel *Label1;
  TRadioGroup *MemoryGroup;
  void __fastcall RunButtonClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
public:
  __int64 aLength;
  __int64 Count;
  __fastcall TNumaForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TNumaForm *NumaForm;
//---------------------------------------------------------------------------
#endif
