//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ParserUsage.h"
#include <Math387.hpp>
#include <AbstractMtxVec.hpp>
#include <MtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmParserUsage *frmParserUsage;
//---------------------------------------------------------------------------
__fastcall TfrmParserUsage::TfrmParserUsage(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
static void PleaseConfirm(const AnsiString &question)
{
  if (MessageDlg("Please confirm", mtConfirmation, TMsgDlgButtons() << mbYes << mbNo, 0) != mrYes)
    Abort();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::FormCreate(TObject *Sender)
{
  // inherited handled automatically by TBasicForm2
  fVars = new TVariableCollection();
  fConstHelp = new TStringList();
  fFuncHelp = new TStringList();
  fOperHelp = new TStringList();

  // CreateValueEditor
  fValueEditor = new TfmValueEditor(this);
  fValueEditor->Visible = false;
  fValueEditor->Left = btn7->Left - 16;
  fValueEditor->Top = btn7->Top - 16;
  fValueEditor->Width = cbExamples->Left + cbExamples->Width - btn7->Left + 24;
  fValueEditor->Height = lbResults->Top + lbResults->Height - btn7->Top + 24;
  fValueEditor->frmValueEditor1->btnOk->OnClick = OnEditOk;
  fValueEditor->frmValueEditor1->btnCancel->OnClick = OnEditCancel;

  // PrepareExamples
  cbExamples->Clear();
  for (int i = 0; i < ComponentCount; i++)
  {
    TMtxFunctionEvaluator *eval = dynamic_cast<TMtxFunctionEvaluator*>(Components[i]);
    if (eval != NULL)
    {
      AnsiString line = StringReplace(eval->Context->Expression, "\r\n", " ",
                                      TReplaceFlags() << rfReplaceAll);
      cbExamples->AddItem(line, eval);
    }
  }
  cbExamples->ItemIndex = 0;
  cbExamplesChanged();

  // LoadSymbols
  eval1->Expressions->GetConstList(lbConstants->Items, fConstHelp);
  eval1->Expressions->GetFuncList(lbFunctions->Items, fFuncHelp, true);
  eval1->Expressions->GetOperList(lbOperators->Items, fOperHelp);

  for (int i = lbOperators->Items->Count - 1; i >= 0; i--)
  {
    if (lbOperators->Items->Strings[i].Length() == 2 &&
        lbOperators->Items->Strings[i][2] == '@')
    {
      lbOperators->Items->Delete(i);
      fOperHelp->Delete(i);
    }
  }

  lbConstants->ItemIndex = 0;
  lbFunctions->ItemIndex = 0;
  lbOperators->ItemIndex = 0;

  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add("TMtxExpression class is used for evaluating math formulas.");
  RichEdit1->Lines->Add("Real numbers, complex numbers, vectors and matrices are supported.");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("1. Enter arithmetic expression (or select one of the predefined list).");
  RichEdit1->Lines->Add("2. Press [Detect] button to collect variables to the list (already done for predefined examples).");
  RichEdit1->Lines->Add("3. Define each variable with type and value (already done for predefined examples).");
  RichEdit1->Lines->Add("4. Press [Evaluate] button and look at the results.");
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::FormDestroy(TObject *Sender)
{
  delete fOperHelp;
  delete fFuncHelp;
  delete fConstHelp;
  delete fVars;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::cbExamplesChanged()
{
  memoExpr->Clear();
  lbVars->Clear();
  fVars->Clear();
  lbResults->Clear();

  int idx = cbExamples->ItemIndex;
  if (idx == -1) Abort();

  TMtxFunctionEvaluator *eval = dynamic_cast<TMtxFunctionEvaluator*>(cbExamples->Items->Objects[idx]);
  memoExpr->Lines->Text = eval->Context->Expression;
  fVars->Assign(eval->Context->Variables);
  for (int i = 0; i < fVars->Count; i++)
    lbVars->AddItem(fVars->Items[i]->VarName + ": " + fVars->Items[i]->Value->AsString,
                    fVars->Items[i]);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::cbExamplesChange(TObject *Sender)
{
  cbExamplesChanged();
  btnEvaluate->Click();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::InsertText(const AnsiString &txt)
{
  if (txt.IsEmpty()) return;

  int p = memoExpr->SelStart;
  AnsiString s = txt;

  // Trim leading space if at start of line or after space/(
  if (s[1] == ' ' && (p == 0 ||
       memoExpr->Lines->Text[p] == ' ' || memoExpr->Lines->Text[p] == '('))
    s.Delete(1, 1);

  // Trim trailing space if before ,)
  if (s.Length() > 0 && s[s.Length()] == ' ' &&
      p < memoExpr->Lines->Text.Length() &&
      (memoExpr->Lines->Text[p+1] == ',' || memoExpr->Lines->Text[p+1] == ')'))
    s.Delete(s.Length(), 1);

  int bp = s.Pos("(");
  memoExpr->SelText = s;
  if (bp > 0) memoExpr->SelStart = p + bp;
  if (memoExpr->CanFocus()) memoExpr->SetFocus();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnDetectClick(TObject *Sender)
{
  memoErrMsg->Text = "";
  TMtxExpression *eval = new TMtxExpression();
  TStringList *list = new TStringList();
  try
  {
    eval->AddExpr(memoExpr->Text);
    eval->GetVarList(list);

    for (int i = 0; i < list->Count; i++)
    {
      if (fVars->FindByName(list->Strings[i]) == NULL)
      {
        TNamedVariable *v = fVars->Add(list->Strings[i]);
        lbVars->AddItem(v->VarName + ": " + v->Value->AsString, v);
      }
    }
    lbVars->ItemIndex = 0;
  }
  catch (Exception &Ex)
  {
    memoErrMsg->Text = Ex.Message;
  }
  delete list;
  delete eval;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnEvaluateClick(TObject *Sender)
{
  memoErrMsg->Text = "";
  TMtxExpression *eval = new TMtxExpression();
  TStringList *list = new TStringList();
  try
  {
    lbResults->Clear();

    for (int i = 0; i < lbVars->Count; i++)
    {
      TNamedVariable *vr = dynamic_cast<TNamedVariable*>(lbVars->Items->Objects[i]);
      switch (vr->Value->ValueType)
      {
        case vtIntegerValue:
          eval->DefineInteger(vr->VarName)->Value = vr->Value->IntegerValue;
          break;
        case vtBoolValue:
          eval->DefineBool(vr->VarName)->Value = vr->Value->BoolValue;
          break;
        case vtDoubleValue:
          eval->DefineDouble(vr->VarName)->Value = vr->Value->DoubleValue;
          break;
        case vtComplexValue:
          eval->DefineComplex(vr->VarName)->Value = vr->Value->ComplexValue;
          break;
        case vtVectorValue:
          eval->DefineVector(vr->VarName)->Value->Copy(vr->Value->VectorValue);
          break;
        case vtMatrixValue:
          eval->DefineMatrix(vr->VarName)->Value->Copy(vr->Value->MatrixValue);
          break;
        case vtIntVectorValue:
          eval->DefineIntVector(vr->VarName)->Value->Copy(vr->Value->IntVectorValue);
          break;
        case vtIntMatrixValue:
          eval->DefineIntMatrix(vr->VarName)->Value->Copy(vr->Value->IntMatrixValue);
          break;
        case vtBoolVectorValue:
          eval->DefineBoolVector(vr->VarName)->Value->Copy(vr->Value->BoolVectorValue);
          break;
        case vtBoolMatrixValue:
          eval->DefineBoolMatrix(vr->VarName)->Value->Copy(vr->Value->BoolMatrixValue);
          break;
        default: break;
      }
    }

    eval->Expressions = memoExpr->Text;
    TValueRec *res = eval->Evaluate();

    lbResults->AddItem("Result: " + res->AsString, NULL);

    eval->GetVarList(list);
    for (int i = 0; i < list->Count; i++)
    {
      UnicodeString vname = list->Strings[i];
      lbResults->AddItem(vname + ": " + eval->VarByName->Value[vname]->AsString, NULL);
    }

    lbResults->ItemIndex = 0;
  }
  catch (Exception &Ex)
  {
    memoErrMsg->Text = Ex.Message;
  }
  delete list;
  delete eval;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::EnableControls(bool enabled)
{
  TControl *controls[] = {
    cbExamples, memoExpr, btnClearExpr, btnDetect,
    lbVars, btnClearVarList, btnAddVar, btnDelVar, btnSetVar, lbResults,
    btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn0, btnI, btnDot,
    btnOpenBracket, btnCloseBracket,
    PageControl1, btnEvaluate, memoErrMsg
  };
  const int n = sizeof(controls) / sizeof(controls[0]);
  for (int i = 0; i < n; i++)
    controls[i]->Enabled = enabled;

  if (!enabled) fValueEditor->ShowModal();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::OnEditOk(TObject *Sender)
{
  TNamedVariable *vr = dynamic_cast<TNamedVariable*>(lbVars->Items->Objects[lbVars->ItemIndex]);
  lbVars->Items->Strings[lbVars->ItemIndex] = vr->VarName + ": " + fValueEditor->frmValueEditor1->VR->AsString;
  EnableControls(true);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::OnEditCancel(TObject *Sender)
{
  EnableControls(true);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnSetVarClick(TObject *Sender)
{
  if (lbVars->ItemIndex == -1) Abort();
  fValueEditor->frmValueEditor1->VR =
    (dynamic_cast<TNamedVariable*>(lbVars->Items->Objects[lbVars->ItemIndex]))->Value;
  EnableControls(false);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::lbVarsDblClick(TObject *Sender)
{
  if (lbVars->ItemIndex >= 0) btnSetVar->Click();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnAddVarClick(TObject *Sender)
{
  UnicodeString var_name = "";
  if (!InputQuery("New variable", "Enter variable name", var_name)) Abort();

  int i = 0;
  TNamedVariable *v = NULL;
  while (true)
  {
    if (i >= lbVars->Items->Count)
    {
      v = fVars->Add(var_name);
      i = lbVars->Items->AddObject(v->VarName + ": " + v->Value->AsString, v);
      break;
    }
    if (AnsiSameText((dynamic_cast<TNamedVariable*>(lbVars->Items->Objects[i]))->VarName, var_name))
      break;
    i++;
  }
  lbVars->ItemIndex = i;
  btnSetVar->Click();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnDelVarClick(TObject *Sender)
{
  int idx = lbVars->ItemIndex;
  if (idx == -1) Abort();

  TNamedVariable *v = dynamic_cast<TNamedVariable*>(lbVars->Items->Objects[idx]);
  PleaseConfirm(Format("Do you want to delete variable \"%s\"?", ARRAYOFCONST((v->VarName))));

  delete v;
  lbVars->Items->Delete(idx);

  if (idx >= lbVars->Count) idx--;
  lbVars->ItemIndex = idx;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnClearExprClick(TObject *Sender)
{
  PleaseConfirm("Do you want to clear expressions?");
  memoExpr->Clear();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnClearVarListClick(TObject *Sender)
{
  PleaseConfirm("Do you want to clear defined variables list?");
  lbVars->Clear();
  fVars->Clear();
  lbResults->Clear();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::lbVarsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y)
{
  TListBox *lb = dynamic_cast<TListBox*>(Sender);
  int idx = lb->ItemAtPos(Point(X, Y), true);
  if (idx >= 0) lb->Hint = lb->Items->Strings[idx];
  else lb->Hint = "";
  Application->ActivateHint(lb->ClientToScreen(Point(X, Y)));
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::btnSymClick(TObject *Sender)
{
  InsertText((dynamic_cast<TSpeedButton*>(Sender))->Caption);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::lbSymbolsDblClick(TObject *Sender)
{
  TListBox *lb = dynamic_cast<TListBox*>(Sender);
  int idx = lb->ItemIndex;
  if (idx == -1) return;

  AnsiString s = " " + lb->Items->Strings[idx] + " ";
  InsertText(s);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::ShowHelp(TListBox *lb, TStrings *help, int x, int y)
{
  TPoint p = Point(x, y);
  int idx = lb->ItemAtPos(p, true);
  if (idx >= 0) lb->Hint = help->Strings[idx];
  else lb->Hint = "";
  Application->ActivateHint(lb->ClientToScreen(p));
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::lbConstantsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y)
{
  ShowHelp(lbConstants, fConstHelp, X, Y);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::lbFunctionsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y)
{
  ShowHelp(lbFunctions, fFuncHelp, X, Y);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserUsage::lbOperatorsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y)
{
  ShowHelp(lbOperators, fOperHelp, X, Y);
}
//---------------------------------------------------------------------------
