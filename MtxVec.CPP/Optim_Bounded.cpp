//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Optim_Bounded.h"
#include <MtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmOptimBounded *frmOptimBounded;
//---------------------------------------------------------------------------
__fastcall TfrmOptimBounded::TfrmOptimBounded(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
static double __fastcall OptObjFun(TVec * const Parameters, TVec * const Constants,
                                   System::TObject* const *ObjConst,
                                   #if (__BORLANDC__ >= 0x0770)
                                   const System::NativeInt ObjConst_High
                                   #else
                                   const int ObjConst_Size
                                   #endif
                                   )
{
  TVariableCollection *vars = (TVariableCollection*)ObjConst[1];
  TMtxExpression *expr = (TMtxExpression*)ObjConst[0];
  // Typecast TVec* -> TVector* (MtxVec.h): pPars->Values[i] binds to TVector's inline
  // raw-pointer property (((double*)ValuesPointer)[i]), which shadows the inherited
  // DynamicArray Values FIELD. The field throws a false range error on the SetSubRange
  // views Simplex passes; the property is fast and correct. See CPP-toolchain.md.
  Mtxvec::TVector *pPars = (Mtxvec::TVector*) Parameters;
  for (int i = 0; i < pPars->Length; i++)
  {
    expr->VarByName->Value[vars->Items[i]->VarName]->DoubleValue = pPars->Values[i];
  }
  return expr->EvaluateDouble();
}
//---------------------------------------------------------------------------
void __fastcall TfrmOptimBounded::Button1Click(TObject *Sender) { SolveProblem(); }
void __fastcall TfrmOptimBounded::ButtonDetectClick(TObject *Sender) { InitSystem(); Button1->Enabled = true; }
void __fastcall TfrmOptimBounded::EditFunctionChange(TObject *Sender) { Button1->Enabled = false; }
//---------------------------------------------------------------------------
void __fastcall TfrmOptimBounded::FormCreate(TObject *Sender)
{
  EditFunction->Text = "100*Sqr(b-Sqr(a)) + Sqr(1-a)";
  iVariables = new TVariableCollection();

  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "Optimization now supports bounded constraints. Invididual parameter "
    "can have no, lower, upper or both limits. This is done by:");
  RichEdit1->Lines->Add("1. No limit: lower bound is -INF, upper bound is INF.");
  RichEdit1->Lines->Add("2. Lower bound: lower bound is lb, upper bound is INF.");
  RichEdit1->Lines->Add("3. Upper bound: lower bound is -INF, upper bound is ub.");
  RichEdit1->Lines->Add("4. Lower and upper bound: lower bound is lb, upper bound is ub.");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("1. Enter any function in the \"Functon\" edit box.");
  RichEdit1->Lines->Add("2. Click the \"Detect\" button to get the list of variables in function.");
  RichEdit1->Lines->Add("3. Define bounds (if any) for individual variables.");
  RichEdit1->Lines->Add("4. Define starting values for individual variables.");
  RichEdit1->Lines->Add("5. Press the \"Calculate\" button to minimize function.");

  Edit1->Text = SampleToStr(1e-8);
  InitSystem();
  Button1->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TfrmOptimBounded::FormDestroy(TObject *Sender)
{
  delete iVariables;
  pars.Length = 0;
  LB.Length = 0;
  UB.Length = 0;
}
//---------------------------------------------------------------------------
void __fastcall TfrmOptimBounded::InitSystem()
{
  iVariables->Clear();
  TStringList *list = new TStringList();
  TMtxExpression *expr = new TMtxExpression();
  try {
    expr->AddExpr(EditFunction->Text);
    expr->GetVarList(list);

    StringGridVars->RowCount = list->Count + 1;
    StringGridResults->RowCount = list->Count + 1;
    StringGridVars->Cells[0][0] = "Name";
    StringGridVars->Cells[1][0] = "Lower bound";
    StringGridVars->Cells[2][0] = "Upper bound";
    StringGridVars->Cells[3][0] = "Initial value";
    StringGridResults->Cells[0][0] = "Name";
    StringGridResults->Cells[1][0] = "Value";

    for (int i = 0; i < list->Count; i++)
    {
      TNamedVariable *v = iVariables->Add(list->Strings[i]);
      v->Value->DefineDouble();
    }

    for (int i = 0; i < iVariables->Count; i++)
    {
      StringGridVars->Cells[0][i + 1] = iVariables->Items[i]->VarName;
      StringGridVars->Cells[1][i + 1] = "-INF";
      StringGridVars->Cells[2][i + 1] = "INF";
      StringGridVars->Cells[3][i + 1] = iVariables->Items[i]->Value->AsString;
      StringGridResults->Cells[0][i + 1] = iVariables->Items[i]->VarName;
    }
  } __finally {
    delete expr;
    delete list;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmOptimBounded::SolveProblem()
{
  TMtxExpression *expr = new TMtxExpression();
  Screen->Cursor = crHourGlass;
  try {
    int numvars = iVariables->Count;
    pars.Length = numvars;
    LB.Length = numvars;
    UB.Length = numvars;

    for (int i = 0; i < numvars; i++)
      expr->DefineDouble(iVariables->Items[i]->VarName)->Value = StrToSample(StringGridVars->Cells[3][i + 1]);
    expr->Expressions = EditFunction->Text;

    Memo1->Lines->Clear();
    for (int i = 0; i < numvars; i++)
    {
      pars[i] = StrToSample(StringGridVars->Cells[3][i + 1]);
      LB[i] = StrToSample(StringGridVars->Cells[1][i + 1]);
      UB[i] = StrToSample(StringGridVars->Cells[2][i + 1]);
    }

    double tol = StrToSample(Edit1->Text);
    if (tol < 1E-14) tol = 1E-14;
    int maxiter = UpDown1->Position;
    double fMin;
    TOptStopReason StopReason;

    if (CheckBox1->Checked)
      Simplex(OptObjFun, &pars[0], pars.Length - 1,
              NULL, -1,
              OPENARRAY(TObject*, (expr, iVariables)),
              &LB[0], LB.Length - 1, &UB[0], UB.Length - 1,
              fMin, StopReason, mvDouble, maxiter, tol, Memo1->Lines);
    else
      Simplex(OptObjFun, &pars[0], pars.Length - 1,
              NULL, -1,
              OPENARRAY(TObject*, (expr, iVariables)),
              &LB[0], LB.Length - 1, &UB[0], UB.Length - 1,
              fMin, StopReason, mvDouble, maxiter, tol);

    Memo1->Lines->Add("");
    switch (StopReason)
    {
      case OptResNotFound:  Memo1->Lines->Add("Minimum not found."); break;
      case OptResSmallGrad: Memo1->Lines->Add("Small gradient step."); break;
      case OptResSingular:  Memo1->Lines->Add("Singularity."); break;
      case OptResSmallStep: Memo1->Lines->Add("Small step."); break;
      case OptResZeroStep:  Memo1->Lines->Add("Zero step."); break;
      case OptResBigLambda: Memo1->Lines->Add("Big lambda."); break;
      case OptResMaxIter:   Memo1->Lines->Add("Maximum iteration limit reached."); break;
      default:              Memo1->Lines->Add("Converged within given tolerance."); break;
    }
    Memo1->Lines->Add("Function value: " + SampleToStr(fMin, 3, 6));

    for (int i = 0; i < numvars; i++)
      StringGridResults->Cells[1][i + 1] = SampleToStr(pars[i], 3, 6);
  } __finally {
    delete expr;
    Screen->Cursor = crDefault;
  }
}
//---------------------------------------------------------------------------
