//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Scripting.h"
#include <Math387.hpp>
#include <MtxVec.hpp>
#include <MtxExpr.hpp>
#include <MtxVecEdit.hpp>
#include <MtxVecTee.hpp>
#include <AbstractMtxVec.hpp>
using namespace Mtxparseclass;
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TScriptingForm *ScriptingForm;
//---------------------------------------------------------------------------
__fastcall TScriptingForm::TScriptingForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::UpdateVarView()
{
  TStringList *aVarList = new TStringList();
  try {
    Expr->GetVarList(aVarList);
    VarView->Clear();
    for (int i = 0; i < aVarList->Count; i++)
    {
      TListItem *aItem = VarView->Items->Add();
      aItem->Caption = aVarList->Strings[i];
      TValueRec *aVar = Expr->VarByName->Value[aVarList->Strings[i]];
      aItem->SubItems->Add(ValTypeAsStr[aVar->ValueType]);
      switch (aVar->ValueType)
      {
        case TExprValueType::vtString:        aItem->SubItems->Add(aVar->StringValue); break;
        case TExprValueType::vtIntegerValue:  aItem->SubItems->Add(IntToStr(aVar->IntegerValue)); break;
        case TExprValueType::vtBoolValue:     aItem->SubItems->Add(BoolToStr(aVar->BoolValue, true)); break;
        case TExprValueType::vtCustomValue:   aItem->SubItems->Add(aVar->CustomValue->ClassName()); break;
        case TExprValueType::vtDoubleValue:   aItem->SubItems->Add(SampleToStr(aVar->DoubleValue)); break;
        case TExprValueType::vtComplexValue:  aItem->SubItems->Add(CplxToStr(aVar->ComplexValue)); break;
        case TExprValueType::vtVectorValue:   aItem->SubItems->Add("1x" + IntToStr(aVar->VectorValue->Length)); break;
        case TExprValueType::vtMatrixValue:   aItem->SubItems->Add(IntToStr(aVar->MatrixValue->Rows) + "x" +
                                                    IntToStr(aVar->MatrixValue->Cols)); break;
        case TExprValueType::vtIntVectorValue: aItem->SubItems->Add("1x" + IntToStr(aVar->IntVectorValue->Length)); break;
        case TExprValueType::vtIntMatrixValue: aItem->SubItems->Add(IntToStr(aVar->IntMatrixValue->Rows) + "x" +
                                                     IntToStr(aVar->IntMatrixValue->Cols)); break;
        case TExprValueType::vtBoolVectorValue: aItem->SubItems->Add("1x" + IntToStr(aVar->BoolVectorValue->Length)); break;
        case TExprValueType::vtBoolMatrixValue: aItem->SubItems->Add(IntToStr(aVar->BoolMatrixValue->Rows) + "x" +
                                                      IntToStr(aVar->BoolMatrixValue->Cols)); break;
        default: break;
      }
    }
  } __finally {
    delete aVarList;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::VarViewDblClick(TObject *Sender)
{
  AnsiString varName = VarView->Selected->Caption;
  TValueRec *a = Expr->VarByName->Value[varName];
  switch (a->ValueType)
  {
    case TExprValueType::vtBoolVectorValue:
    case TExprValueType::vtIntVectorValue: ViewValues(a->IntVectorValue, varName); break;
    case TExprValueType::vtVectorValue:    ViewValues(a->VectorValue, varName); break;
    case TExprValueType::vtBoolMatrixValue:
    case TExprValueType::vtIntMatrixValue: ViewValues(a->IntMatrixValue, varName); break;
    case TExprValueType::vtMatrixValue:    ViewValues(a->MatrixValue, varName); break;
    default: break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::VarViewMouseEnter(TObject *Sender)
{
  StatusBar->Panels->Items[0]->Text = "Double click vector or matrix to examine the values";
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::RunButtonClick(TObject *Sender)
{
  TValueRec *a = NULL;
  double a2 = 0;
  Expr->ClearExpressions();
  for (int i = 0; i < ScriptEdit->Lines->Count; i++) Expr->AddExpr(ScriptEdit->Lines->Strings[i]);

  Expr->Compile();
  try {
    StartTimer();
    a = Expr->EvaluateCompiled();
    a2 = StopTimer();
    Expr->VarPrint(a, Expr->EvaluatedVarName(0), RichEdit->Lines);
  } catch (Exception &E) {
    RichEdit->Lines->Add("");
    RichEdit->Lines->Add(E.Message);
  }
  RichEdit->Lines->Add("Elapsed time: " + FormatSample("0.0000s", a2) + ", sizeof(double) = " + IntToStr((int)sizeof(double)));
  UpdateVarView();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::EvaluateExpression()
{
  AnsiString aCmd = Trim(ExprEdit->Text);
  Expr->ClearExpressions();
  if (aCmd == "cls")
  {
    for (int i = 0; i < RichEdit->Lines->Count; i++) RichEdit->Lines->Delete(0);
    RichEdit->Lines->Strings[0] = "";
    return;
  }
  else if (aCmd == "clear")
  {
    Expr->ClearAll();
    for (int i = 0; i < RichEdit->Lines->Count; i++) RichEdit->Lines->Delete(0);
    ListBox->Clear();
    VarView->Clear();
    return;
  }
  else if (aCmd == "help")
  {
    TStringList *funcList = new TStringList();
    TStringList *hlpList = new TStringList();
    try {
      Expr->GetFuncList(funcList, hlpList, true);
      RichEdit->Lines->Add("");
      RichEdit->Lines->Add("Function listing:");
      RichEdit->Lines->Add("");
      for (int i = 0; i < hlpList->Count; i++) RichEdit->Lines->Add(hlpList->Strings[i]);

      Expr->GetOperList(funcList, hlpList);
      RichEdit->Lines->Add("");
      RichEdit->Lines->Add("Operator listing:");
      RichEdit->Lines->Add("");
      for (int i = 0; i < hlpList->Count; i++) RichEdit->Lines->Add(hlpList->Strings[i]);
    } catch (...) {
      delete funcList;
      delete hlpList;
      throw;
    }
    delete funcList;
    delete hlpList;

    if (ExprEdit->Text != "")
    {
      if (ListBox->Items->IndexOf(ExprEdit->Text) < 0)
        ListBox->Selected[ListBox->Items->Add(ExprEdit->Text)] = true;
      ExprEdit->Text = "";
    }
    return;
  }

  TValueRec *a = NULL;
  try {
    Expr->AddExpr(ExprEdit->Text);
    a = Expr->Evaluate();
    RichEdit->Lines->Add("");
    RichEdit->Lines->Add("> " + ExprEdit->Text);
    RichEdit->Lines->Add("");
  } catch (Exception &E) {
    RichEdit->Lines->Add(aCmd + " :");
    RichEdit->Lines->Add(E.Message);
    RichEdit->Lines->Add("");
    return;
  }

  UpdateVarView();
  RichEdit->Lines->Add("");
  if (!TerminatedWithSemicolon(ExprEdit->Text))
    Expr->VarPrint(a, Expr->EvaluatedVarName(0), RichEdit->Lines);

  if (ExprEdit->Text != "")
  {
    if (ListBox->Items->IndexOf(ExprEdit->Text) < 0)
      ListBox->Selected[ListBox->Items->Add(ExprEdit->Text)] = true;
    ExprEdit->Text = "";
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::ExprEditKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
  switch (Key)
  {
    case VK_UP:
    {
      int i = ListBox->ItemIndex;
      if ((i > 0) && (ExprEdit->Text != "")) i--;
      ListBox->Selected[i] = true;
      ExprEdit->Text = ListBox->Items->Strings[i];
      break;
    }
    case VK_DOWN:
    {
      int i = ListBox->ItemIndex;
      if ((i < (ListBox->Items->Count - 1)) && (ExprEdit->Text != "")) i++;
      ListBox->Selected[i] = true;
      ExprEdit->Text = ListBox->Items->Strings[i];
      break;
    }
    case VK_RETURN: EvaluateExpression(); break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::ExprEditMouseEnter(TObject *Sender)
{
  StatusBar->Panels->Items[0]->Text = "Type the expression";
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::FormCreate(TObject *Sender)
{
  grid1var = new TExprGridVariable();
  grid2var = new TExprGridVariable();
  Expr = new TMtxExpression();
  RichEdit->Lines->Strings[0] = "";
  ExprEdit->Text = "clear"; EvaluateExpression();
  ExprEdit->Text = "help"; EvaluateExpression();
  ExprEdit->Text = "j = -2"; EvaluateExpression();
  ExprEdit->Text = "y = 10:15"; EvaluateExpression();
  ExprEdit->Text = "y = y(:)"; EvaluateExpression();
  ExprEdit->Text = "x = double(y)"; EvaluateExpression();
  ExprEdit->Text = "m = x(0:2)'*x(2:-1:0)"; EvaluateExpression();
  ExprEdit->Text = "m'"; EvaluateExpression();
  ExprEdit->Text = "rows(m)"; EvaluateExpression();
  ExprEdit->Text = "length(x)"; EvaluateExpression();
  ExprEdit->Text = "m(0:2) = 2:-1:0"; EvaluateExpression();
  ExprEdit->Text = "b = m\\x(0:2)"; EvaluateExpression();
  ExprEdit->Text = "m*b'"; EvaluateExpression();
  ExprEdit->Text = "c = fft([1, b])"; EvaluateExpression();
  ExprEdit->Text = "c1 = [1,2,3,4,5]"; EvaluateExpression();
  ExprEdit->Text = "c2 = [1,2;2,3]"; EvaluateExpression();
  ExprEdit->Text = "c3 = [[1;2],[2;3]]"; EvaluateExpression();
  ExprEdit->Text = "c4 = [\"Rows = \", rows(m),\", Complex = \", (3+12.4i)*2i]"; EvaluateExpression();

  Expr->DefineCustomValue("grid1", grid1var);
  Expr->DefineCustomValue("grid2", grid2var);
  UpdateVarView();

  ScriptBox->ItemIndex = 0;
  ScriptBox->OnChange(this);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::FormDestroy(TObject *Sender)
{
  delete Expr;
  delete grid1var;
  delete grid2var;
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::ListBoxDblClick(TObject *Sender)
{
  ExprEdit->Text = ListBox->Items->Strings[ListBox->ItemIndex];
  EvaluateExpression();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::ListBoxMouseEnter(TObject *Sender)
{ StatusBar->Panels->Items[0]->Text = "Double click to execute expression"; }
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::RichEditMouseEnter(TObject *Sender)
{ StatusBar->Panels->Items[0]->Text = "Select and rigth click to copy text"; }
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::RichEditMouseMove(TObject *Sender, TShiftState Shift, int X, int Y) {}
//---------------------------------------------------------------------------
void __fastcall TScriptingForm::ScriptBoxChange(TObject *Sender)
{
  ScriptEdit->Clear();
  switch (ScriptBox->ItemIndex)
  {
    case 0:
      ScriptEdit->Lines->Add("undefine(a,b,c) //undefine type of a,b,c vars if defined");
      ScriptEdit->Lines->Add("");
      ScriptEdit->Lines->Add("// some comment");
      ScriptEdit->Lines->Add("");
      ScriptEdit->Lines->Add("a = 2");
      ScriptEdit->Lines->Add("b = -1");
      ScriptEdit->Lines->Add("if a < 0  // more comment");
      ScriptEdit->Lines->Add("   c = 12");
      ScriptEdit->Lines->Add("   c = 2*c");
      ScriptEdit->Lines->Add("else");
      ScriptEdit->Lines->Add("   if b < 0");
      ScriptEdit->Lines->Add("      c = 1.5");
      ScriptEdit->Lines->Add("   else");
      ScriptEdit->Lines->Add("      c = 3.5 + b");
      ScriptEdit->Lines->Add("   end");
      ScriptEdit->Lines->Add("end");
      break;
    case 1:
      ScriptEdit->Lines->Add("undefine(a,i) //undefine type of a, i vars if defined");
      ScriptEdit->Lines->Add("");
      ScriptEdit->Lines->Add("// some comment");
      ScriptEdit->Lines->Add("");
      ScriptEdit->Lines->Add("a = -2.0");
      ScriptEdit->Lines->Add("i = 0");
      ScriptEdit->Lines->Add("while a < 0");
      ScriptEdit->Lines->Add("   a = a + 0.0000003");
      ScriptEdit->Lines->Add("   i = i + 1");
      ScriptEdit->Lines->Add("end");
      break;
    case 2:
      ScriptEdit->Lines->Add("undefine(a,k) //undefine type of a, k vars if defined");
      ScriptEdit->Lines->Add("");
      ScriptEdit->Lines->Add("// some comment");
      ScriptEdit->Lines->Add("");
      ScriptEdit->Lines->Add("a = -2.0");
      ScriptEdit->Lines->Add("i = 0");
      ScriptEdit->Lines->Add("for k = 0:6666666");
      ScriptEdit->Lines->Add("   a = a + 0.0000003");
      ScriptEdit->Lines->Add("   i = i + 1");
      ScriptEdit->Lines->Add("end");
      break;
  }
}
//---------------------------------------------------------------------------
