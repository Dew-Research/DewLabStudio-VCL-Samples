//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Optim_LP.h"
#include <Optimization.hpp>
#include <Math387.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmLP *frmLP;
//---------------------------------------------------------------------------
__fastcall TfrmLP::TfrmLP(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::Button1Click(TObject *Sender)
{
  Memo1->Lines->Clear();
  Memo1->Lines->Add("Algorithm log");
  Memo1->Lines->Add("");
  MtxLP1->Recalculate();

  switch (MtxLP1->SolutionType)
  {
    case LPEmptyFeasableRegion:
      Memo1->Lines->Add("Empty feasable region."); break;
    case LPFiniteSolution:
      Memo1->Lines->Add("Problem has finite optimal solution."); break;
    case LPUnboundedObjectiveFunction:
      Memo1->Lines->Add("Unbounded optimal solution."); break;
  }
  Memo1->Lines->Add("");
  Memo1->Lines->Add("Values of legitimate variables:");
  MtxLP1->x->ValuesToStrings(Memo1->Lines);
  Memo1->Lines->Add("");
  Memo1->Lines->Add("f(x) value at optimal point:\t" + FormatSample(MtxLP1->z));
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::CheckBox1Click(TObject *Sender)
{
  MtxLP1->Minimize = CheckBox1->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::CheckBox2Click(TObject *Sender)
{
  if (!formCreating)
  {
    if (CheckBox2->Checked) MtxLP1->Verbose = Memo1->Lines;
    else MtxLP1->Verbose = NULL;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::ComboBox1Change(TObject *Sender)
{
  MtxLP1->Algorithm = (TLPAlgorithm)ComboBox1->ItemIndex;
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::EditRelationsChange(TObject *Sender)
{
  if (!formCreating)
    MtxLP1->Relations = EditRelations->Text;
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::FormCreate(TObject *Sender)
{
  formCreating = true;

  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "New in MtxVec 3.0: Optimization unit now includes several routines plus component for solving linear programming problems (LP). "
    "Routines include support for solving dual, two phase and ordinary LP problems. Now the following LP problems can be solved:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("f(x) =c(T)*x ; A*x>=b; x=>0  (Dual Simplex)");
  RichEdit1->Lines->Add("f(x) =c(T)*x ; A*x relation b; x=>0 (Two Phase Simplex)");
  RichEdit1->Lines->Add("f(x) =c(T)*x ; A*x<=b; x=>0 (Simplex)");
  RichEdit1->Lines->Add("f(x) =c(T)*x ; A*x<=b; x=>0, integers (Gomory's CPA)");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("In the example bellow a system with 7 equations and 2 constraints is minimized. The system is defined by:");
  RichEdit1->Lines->Add("f(x) = 3x1 + 4x2 + 6x3 + 7x4 +x5");
  RichEdit1->Lines->Add("subject to:");
  RichEdit1->Lines->Add("2x1 - x2 + x3 +6x4 -5x5 -x6 = 6");
  RichEdit1->Lines->Add("x1 + x2 +2x3 + x4 +2x5 -x7 = 3");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add(
    "In this case a two-phase Simplex algorithm (because of the constraints) should be used to solve the LP problem. "
    "Also try changing LP problem parameters (number of equations, constraint type, ... and use other appropriate algorithms to solve the problem.");

  MtxLP1->Verbose = Memo1->Lines;
  MtxLP1->Minimize = CheckBox1->Checked;
  MtxLP1->Algorithm = (TLPAlgorithm)ComboBox1->ItemIndex;
  MtxLP1->Relations = "==";
  MtxLP1->A->SetIt(2, 7, false,
                   OPENARRAY(double, (2.0, -1.0, 1.0, 6.0, -5.0, -1.0, 0.0,
                                      1.0, 1.0, 2.0, 1.0, 2.0, 0.0, -1.0)));
  MtxLP1->c->SetIt(false,
                   OPENARRAY(double, (3.0, 4.0, 6.0, 7.0, 1.0, 0.0, 0.0)));
  MtxLP1->b->SetIt(false,
                   OPENARRAY(double, (6.0, 3.0)));

  MtxFloatEdit1->IntPosition = MtxLP1->c->Length;
  MtxFloatEdit2->IntPosition = MtxLP1->b->Length;
  EditRelations->Text = MtxLP1->Relations;
  MtxVecGrid1->Datasource = MtxLP1->A;
  MtxVecGrid2->Datasource = MtxLP1->b;
  MtxVecGrid3->Datasource = MtxLP1->c;

  formCreating = false;
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::MtxFloatEdit1Change(TObject *Sender)
{
  if (!formCreating)
  {
    MtxLP1->c->Length = MtxFloatEdit1->IntPosition;
    MtxLP1->A->Cols = MtxLP1->c->Length;
    MtxVecGrid1->CalcDimensions();
    MtxVecGrid2->CalcDimensions();
    MtxVecGrid3->CalcDimensions();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmLP::MtxFloatEdit2Change(TObject *Sender)
{
  if (!formCreating)
  {
    MtxLP1->b->Length = MtxFloatEdit2->IntPosition;
    MtxLP1->A->Rows = MtxLP1->b->Length;
    MtxVecGrid1->CalcDimensions();
    MtxVecGrid2->CalcDimensions();
    MtxVecGrid3->CalcDimensions();
  }
}
//---------------------------------------------------------------------------
