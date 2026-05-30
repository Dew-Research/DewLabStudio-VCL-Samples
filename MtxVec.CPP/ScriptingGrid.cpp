//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ScriptingGrid.h"
#include <MtxVec.hpp>
#include <MtxExpr.hpp>
#include <MtxVecEdit.hpp>
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "ExprToolTipUnit"
#pragma resource "*.dfm"
TScriptingGridForm *ScriptingGridForm;
//---------------------------------------------------------------------------
__fastcall TScriptingGridForm::TScriptingGridForm(TComponent* Owner)
  : TForm(Owner), WorkspaceIndex(-1), Editing(false), Expr(NULL),
    grid1var(NULL), grid2var(NULL), mtxToolTip(NULL)
{
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::UpdateVarView()
{
  TStringList *aVarList = new TStringList();
  try
  {
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
        case TExprValueType::vtString:
          aItem->SubItems->Add(aVar->StringValue); break;
        case vtIntegerValue:
          aItem->SubItems->Add(IntToStr((__int64)aVar->IntegerValue)); break;
        case vtBoolValue:
          aItem->SubItems->Add(BoolToStr(aVar->BoolValue, true)); break;
        case vtRangeValue:
          if (aVar->ExtRange)
          {
            int n = aVar->ExtRangeValue->Length;
            if (n == 2)
              aItem->SubItems->Add(SampleToStr(aVar->ExtRangeValue->Values[0]) + ":" +
                                   SampleToStr(aVar->ExtRangeValue->Values[1]));
            else if (n == 3)
              aItem->SubItems->Add(SampleToStr(aVar->ExtRangeValue->Values[0]) + ":" +
                                   SampleToStr(aVar->ExtRangeValue->Values[1]) + ":" +
                                   SampleToStr(aVar->ExtRangeValue->Values[2]));
          }
          else
          {
            int n = aVar->fRange.Length;
            if (n == 2)
              aItem->SubItems->Add(IntToStr(aVar->fRange[0]) + ":" + IntToStr(aVar->fRange[1]));
            else if (n == 3)
              aItem->SubItems->Add(IntToStr(aVar->fRange[0]) + ":" +
                                   IntToStr(aVar->fRange[1]) + ":" +
                                   IntToStr(aVar->fRange[2]));
          }
          break;
        case vtCustomValue:
          aItem->SubItems->Add(aVar->CustomValue->ClassName()); break;
        case vtDoubleValue:
          aItem->SubItems->Add(SampleToStr(aVar->DoubleValue)); break;
        case vtComplexValue:
          aItem->SubItems->Add(CplxToStr(aVar->ComplexValue)); break;
        case vtVectorValue:
          aItem->SubItems->Add("1x" + IntToStr(aVar->VectorValue->Length)); break;
        case vtMatrixValue:
          aItem->SubItems->Add(IntToStr(aVar->MatrixValue->Rows) + "x" +
                               IntToStr(aVar->MatrixValue->Cols)); break;
        case vtIntVectorValue:
          aItem->SubItems->Add("1x" + IntToStr(aVar->IntVectorValue->Length)); break;
        case vtIntMatrixValue:
          aItem->SubItems->Add(IntToStr(aVar->IntMatrixValue->Rows) + "x" +
                               IntToStr(aVar->IntMatrixValue->Cols)); break;
        case vtBoolVectorValue:
          aItem->SubItems->Add("1x" + IntToStr(aVar->BoolVectorValue->Length)); break;
        case vtBoolMatrixValue:
          aItem->SubItems->Add(IntToStr(aVar->BoolMatrixValue->Rows) + "x" +
                               IntToStr(aVar->BoolMatrixValue->Cols)); break;
        default: break;
      }
    }
  }
  __finally
  {
    delete aVarList;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::VarViewDblClick(TObject *Sender)
{
  AnsiString varName = VarView->Selected->Caption;
  TValueRec *a = Expr->VarByName->Value[varName];
  switch (a->ValueType)
  {
    case vtBoolVectorValue: ViewValues(a->BoolVectorValue, varName); break;
    case vtIntVectorValue:  ViewValues(a->IntVectorValue, varName); break;
    case vtVectorValue:     ViewValues(a->VectorValue, varName); break;
    case vtBoolMatrixValue: ViewValues(a->BoolMatrixValue, varName); break;
    case vtIntMatrixValue:  ViewValues(a->IntMatrixValue, varName); break;
    case vtMatrixValue:     ViewValues(a->MatrixValue, varName); break;
    default: break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::VarViewMouseEnter(TObject *Sender)
{
  StatusBar->Panels->Items[0]->Text = "Double click vector or matrix to examine the values";
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::RunButtonClick(TObject *Sender)
{
  TValueRec *a = NULL;
  double a2 = 0;
  Expr->ClearExpressions();
  for (int i = 0; i < ScriptEdit->Lines->Count; i++)
    Expr->AddExpr(ScriptEdit->Lines->Strings[i]);
  try
  {
    Expr->Compile();
    StartTimer();
    a = Expr->EvaluateCompiled();
    a2 = StopTimer();
    Expr->VarPrint(a, Expr->EvaluatedVarName(0), RichEdit->Lines);
  }
  catch (Exception &E)
  {
    RichEdit->Lines->Add("");
    RichEdit->Lines->Add(E.Message);
    Expr->ClearExpressions();
  }
  RichEdit->Lines->Add("");
  RichEdit->Lines->Add("Elapsed time: " + FormatSample("0.0000s", a2) +
                        ", sizeof(TSample) = " + IntToStr((__int64)sizeof(TSample)));
  UpdateVarView();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::EvaluateExpression()
{
  TValueRec *a = NULL;
  RichEdit->Lines->BeginUpdate();
  Expr->ClearExpressions();
  AnsiString aCmd = Trim(ExprEdit->Text);
  if (aCmd == "cls")
  {
    RichEdit->Lines->Clear();
    RichEdit->Lines->Add("");
    ExprEdit->Text = "";
    RichEdit->Lines->EndUpdate();
    return;
  }
  else if (aCmd == "clear")
  {
    Expr->ClearAll();
    RichEdit->Lines->Clear();
    RichEdit->Lines->Add("");
    ExprEdit->Text = "";
    ListBox->Clear();
    VarView->Clear();
    RichEdit->Lines->EndUpdate();
    return;
  }
  else if (aCmd == "help")
  {
    TStringList *funcList = new TStringList();
    TStringList *hlpList = new TStringList();
    try
    {
      Expr->GetFuncList(funcList, hlpList, true);
      RichEdit->Lines->Add("");
      RichEdit->Lines->Add("Function listing:");
      RichEdit->Lines->Add("");
      for (int i = 0; i < hlpList->Count; i++)
        RichEdit->Lines->Add(hlpList->Strings[i]);

      Expr->GetOperList(funcList, hlpList);
      RichEdit->Lines->Add("");
      RichEdit->Lines->Add("Operator listing:");
      RichEdit->Lines->Add("");
      for (int i = 0; i < hlpList->Count; i++)
        RichEdit->Lines->Add(hlpList->Strings[i]);
      RichEdit->Lines->Add("");
    }
    catch (...)
    {
      delete hlpList;
      delete funcList;
      RichEdit->Lines->EndUpdate();
      throw;
    }
    delete hlpList;
    delete funcList;

    if (ExprEdit->Text != "")
    {
      if (ListBox->Items->IndexOf(ExprEdit->Text) < 0)
        ListBox->Selected[ListBox->Items->Add(ExprEdit->Text)] = true;
      ExprEdit->Text = "";
    }
    RichEdit->Lines->EndUpdate();
    return;
  }

  try
  {
    Expr->AddExpr(ExprEdit->Text);
    a = Expr->Evaluate();

    RichEdit->Lines->Add("");
    RichEdit->Lines->Add("> " + ExprEdit->Text);
    RichEdit->Lines->Add("");

    RichEdit->Lines->Add("");
    if (!TerminatedWithSemicolon(ExprEdit->Text))
      Expr->VarPrint(a, Expr->EvaluatedVarName(0), RichEdit->Lines);

    UpdateVarView();
    Expr->ClearExpressions();
  }
  catch (Exception &E)
  {
    RichEdit->Lines->Add(aCmd + " :");
    RichEdit->Lines->Add(E.Message);
    RichEdit->Lines->Add("");
    Expr->ClearExpressions();
    RichEdit->Lines->EndUpdate();
    return;
  }
  RichEdit->Lines->EndUpdate();

  if (ExprEdit->Text != "")
  {
    if (ListBox->Items->IndexOf(ExprEdit->Text) < 0)
      ListBox->Selected[ListBox->Items->Add(ExprEdit->Text)] = true;
    ExprEdit->Text = "";
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ExprEditKeyUp(TObject *Sender, WORD &Key, TShiftState Shift)
{
  switch (Key)
  {
    case VK_UP:
    {
      int i = ListBox->ItemIndex;
      if (i > 0 && ExprEdit->Text != "") i--;
      ListBox->Selected[i] = true;
      ExprEdit->Text = ListBox->Items->Strings[i];
      ExprEdit->SelStart = ListBox->Items->Strings[i].Length();
      break;
    }
    case VK_DOWN:
    {
      int i = ListBox->ItemIndex;
      if (i < (ListBox->Items->Count - 1) && ExprEdit->Text != "") i++;
      ListBox->Selected[i] = true;
      ExprEdit->Text = ListBox->Items->Strings[i];
      ExprEdit->SelStart = ListBox->Items->Strings[i].Length();
      break;
    }
    case VK_RETURN:
      EvaluateExpression();
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ExprEditMouseEnter(TObject *Sender)
{
  StatusBar->Panels->Items[0]->Text = "Type the expression";
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::DoSetGrid1(TExprGridVariable * const Sender, const UnicodeString Src,
                                                const int row, const int col)
{
  Grid1->Cells[col+1][row+1] = Src;
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::DoSetGrid2(TExprGridVariable * const Sender, const UnicodeString Src,
                                                const int row, const int col)
{
  Grid2->Cells[col+1][row+1] = Src;
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::DoGetGrid1(TExprGridVariable * const Sender, UnicodeString &Dst,
                                                const int row, const int col)
{
  Dst = Grid1->Cells[col+1][row+1];
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::DoGetGrid2(TExprGridVariable * const Sender, UnicodeString &Dst,
                                                const int row, const int col)
{
  Dst = Grid2->Cells[col+1][row+1];
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::AssignButtonClick(TObject *Sender)
{
  switch (PageControl->ActivePageIndex)
  {
    case 0:
      ScriptEdit->SelText = Format("grid1(%d,%d) = %s",
        ARRAYOFCONST((Grid1->Row-1, Grid1->Col-1, Grid1->Cells[Grid1->Col][Grid1->Row])));
      break;
    case 1:
      ScriptEdit->SelText = Format("grid2(%d,%d) = %s",
        ARRAYOFCONST((Grid2->Row-1, Grid2->Col-1, Grid2->Cells[Grid2->Col][Grid2->Row])));
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::SetupGrid(TStringGrid * const aGrid)
{
  aGrid->ColCount = 1000;
  aGrid->RowCount = 10000;
  for (int i = 0; i < aGrid->ColCount; i++) aGrid->ColWidths[i] = 80;
  aGrid->Cells[0][0] = aGrid->Name;
  for (int i = 0; i < aGrid->ColCount; i++) aGrid->Cells[i+1][0] = IntToStr(i);
  for (int i = 0; i < aGrid->RowCount; i++) aGrid->Cells[0][i+1] = IntToStr(i);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::SetupGrids()
{
  SetupGrid(Grid1);
  SetupGrid(Grid2);
}
//---------------------------------------------------------------------------
int __fastcall TScriptingGridForm::ScriptEditActiveLine()
{
  return (int)ScriptEdit->ActiveLineNo;
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::StepButtonClick(TObject *Sender)
{
  bool scriptPresent = true;
  if (Expr->ExprCount != ScriptEdit->Lines->Count)
    scriptPresent = false;
  else
    for (int k = 0; k < ScriptEdit->Lines->Count; k++)
      if (Expr->Expression[k] != ScriptEdit->Lines->Strings[k])
      {
        scriptPresent = false;
        break;
      }

  if (!scriptPresent)
  {
    Expr->ClearExpressions();
    for (int k = 0; k < ScriptEdit->Lines->Count; k++)
      Expr->AddExpr(ScriptEdit->Lines->Strings[k]);
    Expr->Compile();
  }

  int k = ScriptEditActiveLine();
  if (k >= Expr->ExprCount)
  {
    RichEdit->Lines->Add("The script is past the last line!");
    RichEdit->Lines->Add("");
    return;
  }
  k = Expr->EvaluateStep(k);
  if (k >= Expr->ExprCount)
  {
    RichEdit->Lines->Add("The script has reached the end!");
    RichEdit->Lines->Add("");
    return;
  }
  LPARAM lparmZero = 0;  // lvalue so it is not a null-pointer-constant for old BCB Perform overload set
  ScriptEdit->SelStart = ScriptEdit->Perform(EM_LINEINDEX, (WPARAM)k, lparmZero);
  ScriptEdit->SelLength = ScriptEdit->Lines->Strings[k].Length();
  ScriptEditMouseMove(Sender, TShiftState(), 0, 0);
  UpdateVarView();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::EditModeButtonClick(TObject *Sender)
{
  Editing = !Editing;
  EditModeButton->Down = Editing;
  if (Editing)
  {
    Grid1->Options = Grid1->Options << goEditing;
    Grid2->Options = Grid2->Options << goEditing;
  }
  else
  {
    Grid1->Options = Grid1->Options >> goEditing;
    Grid2->Options = Grid2->Options >> goEditing;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ResetButtonClick(TObject *Sender)
{
  int k = 0;
  LPARAM lparmZero = 0;  // lvalue, not a null-pointer-constant
  ScriptEdit->Perform(EM_LINEINDEX, (WPARAM)k, lparmZero);
  ScriptEdit->SelStart = ScriptEdit->Perform(EM_LINEINDEX, (WPARAM)k, lparmZero);
  ScriptEdit->SelLength = ScriptEdit->Lines->Strings[k].Length();
  ScriptEditMouseMove(Sender, TShiftState(), 0, 0);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ResetWorkspaceButtonClick(TObject *Sender)
{
  Expr->ClearAll();
  DefineCustomValues();
  UpdateVarView();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::DefineCustomValues()
{
  Expr->DefineCustomValue("grid1", grid1var);
  Expr->DefineCustomValue("grid2", grid2var);

  if (Chart1->SeriesCount() > 0) Expr->DefineCustomValue("series1", Chart1->Series[0]);
  if (Chart2->SeriesCount() > 0) Expr->DefineCustomValue("series2", Chart2->Series[0]);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::FormCreate(TObject *Sender)
{
  grid1var = new TExprGridVariable();
  grid2var = new TExprGridVariable();
  Expr = new TMtxExpression();

  RichEdit->Lines->Strings[0] = "";
  ExprEdit->Text = "clear";
  EvaluateExpression();
  ExprEdit->Text = "help";
  EvaluateExpression();
  ExprEdit->Text = "j = -2";
  EvaluateExpression();

  grid1var->OnSetValue = DoSetGrid1;
  grid1var->OnGetValue = DoGetGrid1;
  grid2var->OnSetValue = DoSetGrid2;
  grid2var->OnGetValue = DoGetGrid2;

  DefineCustomValues();

  Expr->DefineFunction("drawvalues", _drawvalues5, 5, 0,
    "drawvalues(vector Y, TChartSeries series, double xOffset, double xStep, boolean pixeldownsample Draws values from Y to second \"TChartSeries\" custom object.");
  Expr->DefineFunction("drawvalues", _drawvalues4, 4, 0,
    "drawvalues(vector X, vector Y, TChartSeries series, boolean pixeldownsample Draws values with (X,Y) coordinates to second \"TChartSeries\" custom object.");

  UpdateVarView();
  WorkspaceIndex = -1;

  PopulateScriptList();
  ScriptBox->ItemIndex = 0;
  ScriptBox->OnChange(this);
  SetupGrids();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::FormDestroy(TObject *Sender)
{
  for (int i = 0; i < ScriptBox->Items->Count; i++)
  {
    delete ScriptBox->Items->Objects[i];
    ScriptBox->Items->Objects[i] = NULL;
  }
  for (int i = 0; i < WorkspaceBox->Items->Count; i++)
  {
    delete WorkspaceBox->Items->Objects[i];
    WorkspaceBox->Items->Objects[i] = NULL;
  }
  delete Expr;
  delete grid1var;
  delete grid2var;
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::Grid1DrawCell(TObject *Sender, int ACol, int ARow, TRect &Rect, TGridDrawState State)
{
  // intentionally empty (Pascal source comment-only body)
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::Grid1KeyUp(TObject *Sender, WORD &Key, TShiftState Shift)
{
  TStringGrid *a = NULL;
  switch (PageControl->ActivePageIndex)
  {
    case 0: a = Grid1; break;
    case 1: a = Grid2; break;
  }
  if (a == NULL) return;

  if (Key == VK_DELETE)
  {
    for (int i = a->Selection.Top; i <= a->Selection.Bottom; i++)
      for (int j = a->Selection.Left; j <= a->Selection.Right; j++)
        a->Cells[j][i] = "";
  }
}
//---------------------------------------------------------------------------
AnsiString __fastcall TScriptingGridForm::GridSelection()
{
  AnsiString rowr, colr;
  switch (PageControl->ActivePageIndex)
  {
    case 0:
      if (Grid1->Selection.Top != Grid1->Selection.Bottom)
        rowr = Format("%d:%d", ARRAYOFCONST((Grid1->Selection.Top-1, Grid1->Selection.Bottom-1)));
      else
        rowr = IntToStr(Grid1->Selection.Top - 1);
      if (Grid1->Selection.Left != Grid1->Selection.Right)
        colr = Format("%d:%d", ARRAYOFCONST((Grid1->Selection.Left-1, Grid1->Selection.Right-1)));
      else
        colr = IntToStr(Grid1->Selection.Left - 1);
      return "grid1(" + rowr + "," + colr + ")";
    case 1:
      if (Grid2->Selection.Top != Grid2->Selection.Bottom)
        rowr = Format("%d:%d", ARRAYOFCONST((Grid2->Selection.Top-1, Grid2->Selection.Bottom-1)));
      else
        rowr = IntToStr(Grid2->Selection.Top - 1);
      if (Grid2->Selection.Left != Grid2->Selection.Right)
        colr = Format("%d:%d", ARRAYOFCONST((Grid2->Selection.Left-1, Grid2->Selection.Right-1)));
      else
        colr = IntToStr(Grid2->Selection.Left - 1);
      return "grid2(" + rowr + "," + colr + ")";
  }
  return "";
}
//---------------------------------------------------------------------------
AnsiString __fastcall TScriptingGridForm::GridSelectionValues()
{
  AnsiString rowr, colr;
  switch (PageControl->ActivePageIndex)
  {
    case 0:
      for (int i = Grid1->Selection.Top; i <= Grid1->Selection.Bottom; i++)
      {
        colr = "";
        for (int j = Grid1->Selection.Left; j <= Grid1->Selection.Right; j++)
        {
          if (j < Grid1->Selection.Right) colr = colr + Grid1->Cells[j][i] + ",";
          else colr = colr + Grid1->Cells[j][i];
        }
        if (i < Grid1->Selection.Bottom) rowr = rowr + colr + ";";
        else rowr = rowr + colr;
      }
      break;
    case 1:
      // Note: Pascal source mistakenly uses grid1 here too — preserved 1:1.
      for (int i = Grid1->Selection.Top; i <= Grid1->Selection.Bottom; i++)
      {
        colr = "";
        for (int j = Grid1->Selection.Left; j <= Grid1->Selection.Right; j++)
        {
          if (j < Grid1->Selection.Right) colr = colr + Grid1->Cells[j][i] + ",";
          else colr = colr + Grid1->Cells[j][i];
        }
        if (i < Grid1->Selection.Bottom) rowr = rowr + colr + ";";
        else rowr = rowr + colr;
      }
      break;
  }
  return "[" + rowr + "]";
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::GridInsertEditButtonClick(TObject *Sender)
{
  ExprEdit->SelText = GridSelection();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::GridInsertScriptButtonClick(TObject *Sender)
{
  ScriptEdit->SelText = GridSelection();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::GridAssignEditButtonClick(TObject *Sender)
{
  switch (PageControl->ActivePageIndex)
  {
    case 0:
    case 1:
      ExprEdit->SelText = Format("%s = %s", ARRAYOFCONST((GridSelection(), GridSelectionValues())));
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::GridAssignScriptButtonClick(TObject *Sender)
{
  switch (PageControl->ActivePageIndex)
  {
    case 0:
      ScriptEdit->SelText = Format("%s = %s",
        ARRAYOFCONST((GridSelection(), Grid1->Cells[Grid1->Col][Grid1->Row])));
      break;
    case 1:
      ScriptEdit->SelText = Format("%s = %s",
        ARRAYOFCONST((GridSelection(), Grid2->Cells[Grid2->Col][Grid2->Row])));
      break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ListBoxClick(TObject *Sender)
{
  ExprEdit->Text = ListBox->Items->Strings[ListBox->ItemIndex];
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ListBoxDblClick(TObject *Sender)
{
  ExprEdit->Text = ListBox->Items->Strings[ListBox->ItemIndex];
  EvaluateExpression();
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ListBoxMouseEnter(TObject *Sender)
{
  StatusBar->Panels->Items[0]->Text = "Double click to execute expression";
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::RichEditMouseEnter(TObject *Sender)
{
  StatusBar->Panels->Items[0]->Text = "Select and rigth click to copy text";
}
//---------------------------------------------------------------------------
AnsiString __fastcall TScriptingGridForm::WordUnderMouseInRichEdit(const TPoint &pt)
{
  TPoint p = pt;
  LPARAM lparmZero = 0;  // lvalue, not NPC
  WPARAM wparmZero = 0;
  int ci = ScriptEdit->Perform(EM_CHARFROMPOS, wparmZero, (LPARAM)&p);
  if (ci < 0) return "";
  int li = ScriptEdit->Perform(EM_EXLINEFROMCHAR, wparmZero, (LPARAM)ci);
  int co = ci - ScriptEdit->Perform(EM_LINEINDEX, (WPARAM)li, lparmZero);
  if (li > (ScriptEdit->Lines->Count - 1)) return "";
  return Expr->ExpandCharToWord(ScriptEdit->Lines->Strings[li], co);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ScriptEditMouseMove(TObject *Sender, TShiftState Shift, int X, int Y)
{
  LineLabel->Caption = "Line: " + IntToStr(ScriptEditActiveLine());

  AnsiString aName = WordUnderMouseInRichEdit(Point(X, Y));
  if (Expr->IsCompiled)
  {
    TValueRec *aVar = Expr->VarByName->Value[aName];
    if (aVar != NULL)
    {
      if (mtxToolTip == NULL) mtxToolTip = new TExprToolTipForm(this);
      if (!mtxToolTip->Showing)
      {
        TPoint aPoint = ScriptEdit->ClientToScreen(Point(X, Y));
        mtxToolTip->Left = aPoint.X - 4;
        mtxToolTip->Top = aPoint.Y + 2;
      }
      switch (aVar->ValueType)
      {
        case vtUndefined:
        case vtDoubleValue:
        case vtRangeValue:
        case TExprValueType::vtString:
        case vtComplexValue:
        case vtIntegerValue:
        case vtBoolValue:
          ScriptEdit->ShowHint = true;
          ScriptEdit->Hint = Expr->VarToolTip(aName, aVar);
          Application->ActivateHint(ScriptEdit->ClientToScreen(Point(X, Y)));
          Application->HintHidePause = 4000;
          break;
        case vtVectorValue:     mtxToolTip->UpdateGrid(aVar->VectorValue, aName); break;
        case vtIntVectorValue:  mtxToolTip->UpdateGrid(aVar->IntVectorValue, aName); break;
        case vtIntMatrixValue:  mtxToolTip->UpdateGrid(aVar->IntMatrixValue, aName); break;
        case vtBoolVectorValue: mtxToolTip->UpdateGrid(aVar->BoolVectorValue, aName); break;
        case vtBoolMatrixValue: mtxToolTip->UpdateGrid(aVar->BoolMatrixValue, aName); break;
        case vtMatrixValue:     mtxToolTip->UpdateGrid(aVar->MatrixValue, aName); break;
        case vtCustomValue: break;
        default: break;
      }
    }
    else
    {
      if (mtxToolTip != NULL) mtxToolTip->Hide();
      ScriptEdit->ShowHint = false;
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::SaveAsButtonClick(TObject *Sender)
{
  AnsiString aStr = InputBox("Create new script", "Please specify script name", "aScript");
  TStringList *aScript = new TStringList();
  aScript->Assign(ScriptEdit->Lines);
  ScriptBox->AddItem(aStr, aScript);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::SaveWorkspace(TExprWorkspace * const dst, const AnsiString &dstName)
{
  dst->Name = dstName;
  dst->History->Assign(ListBox->Items);
  dst->ScriptNames->Assign(ScriptBox->Items);

  dst->Scripts->Clear();
  for (int i = 0; i < ScriptBox->Items->Count; i++)
    dst->Scripts->Add(((TStringList*)ScriptBox->Items->Objects[i])->Text);

  Expr->SaveContext(dst->Variables);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::SaveWorkButtonClick(TObject *Sender)
{
  UnicodeString aStr = "aWorkspace";
  if (InputQuery("Create new workspace", "Workspace name", aStr))
  {
    if (ScriptBox->ItemIndex >= 0)
      ((TStringList*)ScriptBox->Items->Objects[ScriptBox->ItemIndex])->Assign(ScriptEdit->Lines);

    TExprWorkspace *aWSpace = new TExprWorkspace();
    SaveWorkspace(aWSpace, aStr);
    WorkspaceBox->AddItem(aStr, aWSpace);

    if (WorkspaceBox->Items->Count == 1)
    {
      WorkspaceBox->ItemIndex = 0;
      WorkspaceBoxChange(NULL);
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::DeleteWorkButtonClick(TObject *Sender)
{
  if (WorkspaceBox->Items->Count > 0)
  {
    delete WorkspaceBox->Items->Objects[WorkspaceBox->ItemIndex];
    WorkspaceBox->Items->Objects[WorkspaceBox->ItemIndex] = NULL;

    int i = WorkspaceBox->ItemIndex;
    WorkspaceBox->Items->Delete(i);

    if (WorkspaceBox->Items->Count > 0)
    {
      __int64 v = 0, mn = i, mx = WorkspaceBox->Items->Count - 1;
      WorkspaceBox->ItemIndex = (int)System::Math::EnsureRange(v, mn, mx);
    }
    else
      WorkspaceBox->ItemIndex = -1;
    WorkspaceBoxChange(NULL);
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::WorkspaceBoxChange(TObject *Sender)
{
  TExprWorkspace *aWSpace = NULL;
  if (WorkspaceIndex >= 0 && WorkspaceIndex < WorkspaceBox->Items->Count)
  {
    if (ScriptBox->ItemIndex >= 0)
      ((TStringList*)ScriptBox->Items->Objects[ScriptBox->ItemIndex])->Assign(ScriptEdit->Lines);

    aWSpace = (TExprWorkspace*)WorkspaceBox->Items->Objects[WorkspaceIndex];
    SaveWorkspace(aWSpace, aWSpace->Name);
  }

  WorkspaceIndex = WorkspaceBox->ItemIndex;

  if (WorkspaceIndex >= 0)
  {
    aWSpace = (TExprWorkspace*)WorkspaceBox->Items->Objects[WorkspaceIndex];
    ListBox->Items->Assign(aWSpace->History);

    for (int i = 0; i < ScriptBox->Items->Count; i++)
    {
      delete (TStringList*)ScriptBox->Items->Objects[i];
      ScriptBox->Items->Objects[i] = NULL;
    }

    ScriptBox->Items->Assign(aWSpace->ScriptNames);

    for (int i = 0; i < ScriptBox->Items->Count; i++)
    {
      ScriptBox->Items->Objects[i] = new TStringList();
      ((TStringList*)ScriptBox->Items->Objects[i])->Text = aWSpace->Scripts->Strings[i];
    }
    ScriptBox->ItemIndex = 0;
    ScriptBoxChange(Sender);

    Expr->LoadContext(aWSpace->Variables);
    Expr->ClearExpressions();
    DefineCustomValues();

    UpdateVarView();
  }
  else
  {
    ScriptEdit->Clear();
    Expr->ClearExpressions();
    for (int i = 0; i < ScriptBox->Items->Count; i++)
    {
      delete (TStringList*)ScriptBox->Items->Objects[i];
      ScriptBox->Items->Objects[i] = NULL;
    }
    ScriptBox->Clear();
    WorkspaceBox->Clear();
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::DeleteScriptButtonClick(TObject *Sender)
{
  if (ScriptBox->Items->Count > 0)
  {
    delete ScriptBox->Items->Objects[ScriptBox->ItemIndex];
    ScriptBox->Items->Objects[ScriptBox->ItemIndex] = NULL;

    int i = ScriptBox->ItemIndex;
    ScriptBox->Items->Delete(i);

    if (ScriptBox->Items->Count > 0)
    {
      __int64 v = 0, mn = i, mx = ScriptBox->Items->Count - 1;
      ScriptBox->ItemIndex = (int)System::Math::EnsureRange(v, mn, mx);
    }
    else
      ScriptBox->ItemIndex = -1;
    ScriptBoxChange(NULL);
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::PopulateScriptList()
{
  TStringList *aScript = new TStringList();
  aScript->Add("//initialize");
  aScript->Add("a = 0.1");
  aScript->Add("grid1(0:500,0:10) = \"\" //clear the grid");
  aScript->Add("grid1(1,0) = \"Frequency =\"");
  aScript->Add("grid1(1,1) = a");
  aScript->Add("");
  aScript->Add("//do the math");
  aScript->Add("f = grid1(1,1)  //pick up value from the grid");
  aScript->Add("b = cos([0.0:1023]*pi*f) //create time series");
  aScript->Add("(mag, phase) = carttopolar(fft(b))");
  aScript->Add("");
  aScript->Add("grid1(2,0) = \"Peak value =\"");
  aScript->Add("grid1(2,1) = max(mag)");
  aScript->Add("");
  aScript->Add("xOffset = 0.0;");
  aScript->Add("xStep = 2.0/length(b);");
  aScript->Add("drawvalues(mag(0:511),series1,xOffset, xStep,false);");
  aScript->Add("drawvalues(b,series2,0, 0.5/length(b),false);");
  aScript->Add("");
  aScript->Add("//display in the grid");
  aScript->Add("len = length(mag)/.2");
  aScript->Add("grid2(0,0) = \"Magnitude\"");
  aScript->Add("grid2(1:,0) = mag(0:(len-1))");
  aScript->Add("grid2(0,1) = \"Phase\"");
  aScript->Add("grid2(1:,1) = phase(0:(len-1))");
  ScriptBox->AddItem("FFT Spectrum", aScript);

  aScript = new TStringList();
  aScript->Add("grid1(0:500,0:10) = \"\" //clear the grid");
  aScript->Add("grid1(0,0) = \"Student PDF\"");
  aScript->Add("grid1(1,0) = \"x\"");
  aScript->Add("");
  aScript->Add("ax = [0:0.01:10]");
  aScript->Add("grid1(2:,0) = ax");
  aScript->Add("for i = 1:10");
  aScript->Add("    b = StudentPDF(ax, i);");
  aScript->Add("    grid1(1,i) = [\"DOF \", i];");
  aScript->Add("    grid1(2:,i) = b;");
  aScript->Add("end");
  ScriptBox->AddItem("Student distribution", aScript);

  aScript = new TStringList();
  aScript->Add("undefine(a,k) //undefine type of a, k vars if defined");
  aScript->Add("");
  aScript->Add("// some comment");
  aScript->Add("");
  aScript->Add("a = -2.0");
  aScript->Add("i = 0");
  aScript->Add("for k = 0:6666666");
  aScript->Add("   a = a + 0.0000003");
  aScript->Add("   i = i + 1");
  aScript->Add("end");
  ScriptBox->AddItem("for-loop", aScript);
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ScriptBoxChange(TObject *Sender)
{
  if (ScriptBox->ItemIndex >= 0)
  {
    TStringList *aList = (TStringList*)ScriptBox->Items->Objects[ScriptBox->ItemIndex];
    ScriptEdit->Clear();
    ScriptEdit->Lines->Assign(aList);
    Expr->ClearExpressions();
    Expr->AddExpr(aList);
    ResetButtonClick(Sender);
    ScriptEdit->SelLength = 0;
  }
  else
  {
    ScriptBox->Clear();
    ScriptEdit->Clear();
    Expr->ClearExpressions();
  }
}
//---------------------------------------------------------------------------
void __fastcall TScriptingGridForm::ScriptEditKeyUp(TObject *Sender, WORD &Key, TShiftState Shift)
{
  LineLabel->Caption = "Line: " + IntToStr(ScriptEditActiveLine());
}
//---------------------------------------------------------------------------
void __fastcall _drawvalues5(TExprRec * const Param)
{
  TExprValueType vt1 = Param->Args[0]->ValueType;
  TExprValueType vt2 = Param->Args[1]->ValueType;
  TExprValueType vt3 = Param->Args[2]->ValueType;
  TExprValueType vt4 = Param->Args[3]->ValueType;
  TExprValueType vt5 = Param->Args[4]->ValueType;
  if (vt1 != vtVectorValue || vt2 != vtCustomValue ||
      !Param->Args[2]->IsRealValue() || !Param->Args[3]->IsRealValue() ||
      vt5 != vtBoolValue)
    UnsupportedValueTypesError(Param, vt1, vt2, vt3, vt4, vt5);

  DrawValues(Param->Args[0]->VectorValue,
             dynamic_cast<TChartSeries*>(Param->Args[1]->CustomValue),
             Param->Args[2]->DoubleValue, Param->Args[3]->DoubleValue,
             Param->Args[4]->BoolValue);
}
//---------------------------------------------------------------------------
void __fastcall _drawvalues4(TExprRec * const Param)
{
  TExprValueType vt1 = Param->Args[0]->ValueType;
  TExprValueType vt2 = Param->Args[1]->ValueType;
  TExprValueType vt3 = Param->Args[2]->ValueType;
  TExprValueType vt4 = Param->Args[3]->ValueType;
  if (vt1 != vtVectorValue || vt2 != vtVectorValue ||
      vt3 != vtCustomValue || vt4 != vtBoolValue)
    UnsupportedValueTypesError(Param, vt1, vt2, vt3, vt4);

  DrawValues(Param->Args[0]->VectorValue, Param->Args[1]->VectorValue,
             dynamic_cast<TChartSeries*>(Param->Args[2]->CustomValue),
             Param->Args[3]->BoolValue);
}
//---------------------------------------------------------------------------
