//---------------------------------------------------------------------------
#ifndef Optim_BoundedH
#define Optim_BoundedH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <Grids.hpp>

#include <MtxExpr.hpp>
#include <Optimization.hpp>
#include <MtxIntDiff.hpp>
#include <MtxParseClass.hpp>
#include <MtxParseExpr.hpp>
#include <Math387.hpp>
//---------------------------------------------------------------------------
class TfrmOptimBounded : public TBasicForm2
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TEdit *EditFunction;
  TLabel *Label2;
  TStringGrid *StringGridVars;
  TButton *ButtonDetect;
  TButton *Button1;
  TMemo *Memo1;
  TGroupBox *GroupBox1;
  TLabel *Label3;
  TEdit *Edit1;
  TLabel *Label4;
  TEdit *Edit2;
  TUpDown *UpDown1;
  TCheckBox *CheckBox1;
  TStringGrid *StringGridResults;
  TLabel *Label5;
  void __fastcall ButtonDetectClick(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall EditFunctionChange(TObject *Sender);
private:
  TVariableCollection *iVariables;
  Math387::TDoubleArray pars, LB, UB;
  void __fastcall InitSystem();
  void __fastcall SolveProblem();
public:
  __fastcall TfrmOptimBounded(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmOptimBounded *frmOptimBounded;
//---------------------------------------------------------------------------
#endif
