//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "NumInt1D.h"
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmInt1D *frmInt1D;
//---------------------------------------------------------------------------
class TStringHolder : public TObject
{
public:
  AnsiString Value;
  __fastcall TStringHolder(const AnsiString &v) : TObject(), Value(v) {}
};
//---------------------------------------------------------------------------
__fastcall TfrmInt1D::TfrmInt1D(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
static double __fastcall IntObjFun(TVec * const Pars, TVec * const Constants,
                                    System::TObject* const *ObjConsts,
                                    #if (__BORLANDC__ >= 0x0770)
                                    const System::NativeInt ObjConsts_High
                                    #else
                                    const int ObjConsts_Size
                                    #endif
                                    )
{
  TMtxExpression *expr = (TMtxExpression*)ObjConsts[0];
  AnsiString parname = ((TStringHolder*)ObjConsts[1])->Value;
  // Typecast TVec* -> TVector* (MtxVec.h): Values[0] binds to TVector's inline raw-pointer
  // property, which shadows the inherited DynamicArray Values FIELD (the field throws a
  // false range error on a SetSubRange view; the property is fast and correct). See CPP-toolchain.md.
  expr->VarByName->Value[parname]->DoubleValue = ((Mtxvec::TVector*)Pars)->Values[0];
  return expr->EvaluateDouble();
}
//---------------------------------------------------------------------------
bool __fastcall TfrmInt1D::ExtractFormula(AnsiString &varname)
{
  varname = "";
  TStringList *list = new TStringList();
  try {
    parser->ClearAll();
    parser->Expressions = Edit1->Text;
    parser->GetVarList(list);
    bool Result = list->Count == 1;
    if (Result) varname = list->Strings[0];
    return Result;
  } __finally {
    delete list;
  }
  return false;
}
//---------------------------------------------------------------------------
void __fastcall TfrmInt1D::Button1Click(TObject *Sender)
{
  AnsiString vname;
  if (ExtractFormula(vname))
  {
    double lb = StrToSample(Editlb->Text);
    double ub = StrToSample(Editub->Text);

    int nquad = StrToInt(EditIntervals->Text);
    sVector bp, w, consts;
    switch (ComboBox1->ItemIndex)
    {
      case 0: WeightsNewtonCotes(1, bp, w); break;
      case 1: WeightsNewtonCotes(2, bp, w); break;
      case 2: WeightsNewtonCotes(3, bp, w); break;
      case 3: WeightsNewtonCotes(4, bp, w); break;
      case 4: WeightsGauss(10, bp, w); break;
      case 5: WeightsGauss(16, bp, w); break;
    }
    int numpoints = Math387::Max(nquad, 100);
    double step = (ub - lb) / numpoints;

    Series1->Clear();
    for (int i = 0; i < numpoints; i++)
    {
      double xv = lb + i * step;
      parser->VarByName->Value[vname]->DefineDouble();
      parser->VarByName->Value[vname]->DoubleValue = xv;
      double yv = parser->EvaluateDouble();
      if (!IsNanInf(yv))
        Series1->AddXY(xv, yv);
    }

    TStringHolder *holder = new TStringHolder(vname);
    try {
      double integral = QuadGauss(IntObjFun, lb, ub, consts,
                                   OPENARRAY(TObject*, (parser, holder)),
                                   bp, w, nquad);

      Chart1->Title->Clear();
      Chart1->Title->Text->Add("Integral of f(" + vname + ") from " +
                               FormatSample("0.000", lb) + " to " +
                               FormatSample("0.000", ub));
      Chart1->Title->Text->Add(FormatSample(integral, "0.00000000"));
      Chart1->BottomAxis->Title->Caption = vname;
      Chart1->LeftAxis->Title->Caption = "f(" + vname + ")";
    } __finally {
      delete holder;
    }
  }
  else
  {
    ShowMessage("Use only one variable");
    Edit1->Undo();
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmInt1D::FormCreate(TObject *Sender)
{
  parser = new TMtxExpression();
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "You can use Gauss quadrature formula to evaluate single, double and "
    "n-dimensional integrals. This example demonstrates how to use numerical "
    "integration routines together with TMtxParser class to evaluate integral "
    "of f(x) on interval [a,b].");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("1. Enter any function (using single variable) in \"Function\" edit box.");
  RichEdit1->Lines->Add("2. Define integration lower and upper bounds.");
  RichEdit1->Lines->Add("3. Select integration method.");
  RichEdit1->Lines->Add("4. Press the \"Evaluate\" button.");
  Button1Click(this);
}
//---------------------------------------------------------------------------
void __fastcall TfrmInt1D::FormDestroy(TObject *Sender)
{
  delete parser;
}
//---------------------------------------------------------------------------
