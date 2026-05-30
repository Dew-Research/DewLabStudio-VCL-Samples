//---------------------------------------------------------------------------
#ifndef Optim_TRH
#define Optim_TRH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>

#include <MtxVec.hpp>
#include <MtxExpr.hpp>
#include <Optimization.hpp>
#include <Math387.hpp>
//---------------------------------------------------------------------------
class TfrmTRDemo : public TBasicForm2
{
__published:	// IDE-managed Components
  TRadioGroup *RadioGroup1;
  TButton *Button1;
  TChart *Chart1;
  TBarSeries *Series1;
  TBarSeries *Series2;
  TGroupBox *GroupBox1;
  TLabel *Label1;
  TEdit *Edit1;
  TLabel *Label2;
  TEdit *Edit2;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
private:
  int IterArray[7];
  double TimeArray[7];
  double initpars[2];
  void __fastcall TRTest();
  void __fastcall SimplexTest();
  void __fastcall MarquardtTest();
  void __fastcall BFGSTest();
  void __fastcall DFPTest();
  void __fastcall ConjGradFletcher();
  void __fastcall ConjGradPolack();
public:
  __fastcall TfrmTRDemo(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmTRDemo *frmTRDemo;
//---------------------------------------------------------------------------
#endif
