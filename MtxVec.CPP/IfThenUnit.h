//---------------------------------------------------------------------------
#ifndef IfThenUnitH
#define IfThenUnitH
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

#include <MtxVec.hpp>
#include <MtxExpr.hpp>
#include <Math387.hpp>
#include <MtxExprInt.hpp>
#include <MtxVecTee.hpp>
#include <MtxVecInt.hpp>
#include <MtxForLoop.hpp>
//---------------------------------------------------------------------------
class TIfThenForm : public TForm
{
__published:	// IDE-managed Components
  TMemo *Memo1;
  TButton *MaskThreadButton;
  TChart *Chart;
  TBarSeries *barSeries;
  TCheckBox *PlainBox;
  TCheckBox *VecBox;
  TCheckBox *FindIndexBlockBox;
  TCheckBox *MaskBlockThreadBox;
  TCheckBox *PlainThreadBox;
  TCheckBox *MaskBlockBox;
  TComboBox *DataLenBox;
  TLabel *Label1;
  TComboBox *GranBox;
  TLabel *Label2;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall MaskThreadButtonClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
public:
  __fastcall TIfThenForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIfThenForm *IfThenForm;
//---------------------------------------------------------------------------
#endif
