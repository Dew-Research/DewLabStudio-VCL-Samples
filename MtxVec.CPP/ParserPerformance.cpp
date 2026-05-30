//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ParserPerformance.h"
#include <MtxVecTee.hpp>
#include <MtxVecEdit.hpp>
#include <AbstractMtxVec.hpp>
#include <MtxVecBase.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmParserPerformance *frmParserPerformance;
//---------------------------------------------------------------------------
__fastcall TfrmParserPerformance::TfrmParserPerformance(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserPerformance::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "Example demonstrates performance benefits and usage differences "
    "when using a classical single value parser and a vectorized parser."
    "Try changing the math formula and measure the time needed with both approaches.");
  Expr = new TMtxExpression();
  UpdateX();
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserPerformance::FormDestroy(TObject *Sender)
{
  delete Expr;
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserPerformance::UpdateX()
{
  x.Length = Math387::RoundToInt(fabs(StopXEdit->Position - StartXEdit->Position) / StepXEdit->Position);
  x.Ramp(Math387::Min(StopXEdit->Position, StartXEdit->Position), StepXEdit->Position);
  y.Size(x);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserPerformance::BenchmarkButtomClick(TObject *Sender)
{
  UpdateButtonClick(Sender);
  StandardLabel->Visible = true;
  vectorLabel->Visible = true;
  RatioLabel->Visible = true;

  int Loops = (1000 * 1000 / 2) / x.Length;

  Expr->ClearAll();
  x1 = Expr->DefineDouble("x");
  Expr->Expressions = FormulaEdit->Text;

  Math387::TDoubleArray xValues, yValues;
  x.CopyToArray(xValues);
  y.SizeToArray(yValues);

  StartTimer();
  for (int j = 0; j < Loops; j++)
  {
    for (int i = 0; i < x.Length; i++)
    {
      x1->DoubleValue = xValues[i];
      yValues[i] = Expr->EvaluateDouble();
    }
  }
  double Tick = 1000 * StopTimer();
  StandardLabel->Caption = "Standard = " + FormatSample("0.00ms", Tick);

  Expr->ClearAll();
  Expr->DefineVector("x", x);
  Expr->Expressions = FormulaEdit->Text;

  StartTimer();
  for (int j = 0; j < Loops; j++)
  {
    yResult = Expr->EvaluateVector();
  }
  double Tick1 = 1000 * StopTimer();
  vectorLabel->Caption = "Vectorized = " + FormatSample("0.00ms", Tick1);
  RatioLabel->Caption = "Ratio = " + FormatSample("0.00x", Tick / Tick1);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserPerformance::UpdateButtonClick(TObject *Sender)
{
  StandardLabel->Visible = false;
  vectorLabel->Visible = false;
  RatioLabel->Visible = false;

  Expr->ClearAll();
  switch (ComputationGroup->ItemIndex)
  {
    case 0:
      x1 = Expr->DefineDouble("x");
      Expr->Expressions = FormulaEdit->Text;
      if (x.IsDouble)
      {
        for (int i = 0; i < x.Length; i++)
        {
          x1->DoubleValue = x.Values(i);
          y.Values(i) = Expr->EvaluateDouble();
        }
      }
      else
      {
        for (int i = 0; i < x.Length; i++)
        {
          x1->DoubleValue = x.SValues(i);
          y.SValues(i) = Expr->EvaluateDouble();
        }
      }
      yResult = y;
      break;
    case 1:
      Expr->DefineVector("x", x);
      Expr->Expressions = FormulaEdit->Text;
      yResult = Expr->EvaluateVector();
      break;
  }

  Chart1->Title->Text->Clear();
  Chart1->Title->Text->Add("y = " + FormulaEdit->Text);
  DrawValues(x, yResult, Series1);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParserPerformance::StartXEditChange(TObject *Sender) { UpdateX(); }
void __fastcall TfrmParserPerformance::StepXEditChange(TObject *Sender)  { UpdateX(); }
void __fastcall TfrmParserPerformance::StopXEditChange(TObject *Sender)  { UpdateX(); }
//---------------------------------------------------------------------------
