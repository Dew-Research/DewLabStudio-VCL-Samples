//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "BlockProcessing.h"
#include <Probabilities.hpp>
#include <math.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)

// noinline guard for the pure-C++ scalar baseline (see MaxwellPdfCpp below).
// __attribute__((noinline)) is the Clang/GCC spelling and works on every clang
// BCB target; classic bcc32 has no such attribute, but it only auto-inlines
// functions explicitly declared `inline`, so a plain static stays out-of-line.
#if defined(__clang__)
  #define BENCH_NOINLINE __attribute__((noinline))
#else
  #define BENCH_NOINLINE
#endif
#pragma link "Basic1"
#pragma resource "*.dfm"
TfrmBlockProc *frmBlockProc;
//---------------------------------------------------------------------------
__fastcall TfrmBlockProc::TfrmBlockProc(TComponent* Owner)
  : TBasicForm1(Owner)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "Block processing tests the speed of processing of various vector sizes. "
    "In the \"block\" example it also breaks down the vector in to smaller "
    "pieces to make it fit the size of CPU cache. "
    "Notice that Vector expressions are only marginally slower "
    "than TVec and that substantial performance gains depend "
    "upon the vector length. The \"block\" example is faster than other only "
    "for very long vectors due to large CPU cache sizes of "
    "modern CPUs. The function being benchmarked is Maxwell PDF.");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add(
    "Block length (size of the sub vector) is automatically set "
    "by MtxVec to match the CPU cache size and so is the number of "
    "iterations required to process the entire vector length.");

  X.Size(Len, false);
  Res.Size(X);
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellBlock(int Iter, double &Result)
{
  StartTimer();
  double a = 1;
  for (int i = 1; i <= Iter; i++)
  {
    Res.BlockInit();
    X.BlockInit();
    while (!X.BlockEnd)
    {
      tmp.Sqr(X);
      Res.Copy(tmp);
      Res.Mul(-0.5 * a);
      Res.Exp();
      Res.Mul(tmp);
      Res.Mul(Math387::Sqrt(4 * INVTWOPI) * a);
      Res.BlockNext();
      X.BlockNext();
    }
  }
  Result = StopTimer() * 1000;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellNoBlock(int Iter, double &Result)
{
  // Maxwell distribution, a = 1.0
  double a = 1;
  StartTimer();
  int j = Iter;
  for (int i = 1; i <= j; i++)
  {
    tmp.Sqr(X);
    Res.Copy(tmp);
    Res.Mul(-0.5 * a);
    Res.Exp();
    Res.Mul(tmp);
    Res.Mul(Math387::Sqrt(4 * INVTWOPI) * a);
  }
  Result = StopTimer() * 1000;
}
//---------------------------------------------------------------------------
// Pure C++ scalar Maxwell PDF: identical math to Probabilities::MaxwellPDF,
// but using the C runtime sqrt/exp instead of the Math387 assembler versions.
// noinline so it is a REAL call per element - the same as the Delphi/Math387
// path's external MaxwellPDF call, which the compiler cannot inline. Without it
// the compiler inlines + constant-folds this into the loop and the timing is
// meaningless (the work gets optimized away).
static BENCH_NOINLINE double MaxwellPdfCpp(double x, double a)
{
  if ((x >= 0) && (a > 0))
  {
    double t = x / a;
    double xxaa = t * t;
    return sqrt(1.0 / (PIDIV2 * a)) * xxaa * exp(-0.5 * xxaa);
  }
  return NAN;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellFunction(int Iter, double &Result)
{
  // Maxwell distribution, a = 1.0  (Math387-enhanced scalar function)
  // Read X and write Res through their internal buffers (PValues1D) and hoist
  // Length, so the timed loop matches Delphi's native array indexing - no
  // per-element DynamicArray::operator[] or Length-getter overhead, and no copy.
  double a = 1;
  int n = X.Length;
  double *axp = X.PValues1D(0);
  double *arp = Res.PValues1D(0);
  StartTimer();
  for (int i = 1; i <= Iter; i++)
  {
    for (int j = 0; j < n; j++)
	  arp[j] = MaxwellPDF(axp[j], a);  }
  Result = StopTimer() * 1000;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellFunctionCpp(int Iter, double &Result)
{
  // Maxwell distribution, a = 1.0  (pure C++ scalar function, C runtime math)
  double a = 1;
  int n = X.Length;
  double *axp = X.PValues1D(0);
  double *arp = Res.PValues1D(0);
  StartTimer();
  for (int i = 1; i <= Iter; i++)
  {
    for (int j = 0; j < n; j++)
	  arp[j] = MaxwellPdfCpp(axp[j], a);  }
  Result = StopTimer() * 1000;
}
//---------------------------------------------------------------------------
sVector __fastcall TfrmBlockProc::MaxwellVecExpression(double a, TVec * const X_)
{
  sVector tmp_local;
  tmp_local = Sqr(X_);
  return Math387::Sqrt(4 * a * INVTWOPI) * a * tmp_local * Exp(-0.5 * a * tmp_local);
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::MaxwellExpression(int Iter, double &Result)
{
  // Maxwell distribution, a = 1.0
  double a = 1;
  StartTimer();
  for (int i = 1; i <= Iter; i++)
  {
    MaxwellVecExpression(a, X);
  }
  Result = StopTimer() * 1000;
}
//---------------------------------------------------------------------------
static double FindMax(double *a, int n)
{
  double Result = MINNUM;
  for (int i = 1; i < n; i++) // Pascal: 1 to High(a)
    if (a[i] > Result) Result = a[i];
  return Result;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBlockProc::Button1Click(TObject *Sender)
{
  double Step = 2;
  int Points = (int)Math387::RoundToInt(Math387::LogN(Step, 100000)) - 1;
  int TotalIters = (int)Math387::RoundToInt(Math387::Power(Step, Points));
  int Iters = TotalIters;

  double *a1 = new double[Points];
  double *a2 = new double[Points];
  double *a3 = new double[Points];
  double *a4 = new double[Points];
  double *a5 = new double[Points];

  Screen->Cursor = crHourGlass;
  X.Size(4, false);
  X.SetVal(2);
  Res.Size(X);

  for (int i = 0; i < Points; i++)
  {
    Res.SetZero();
    MaxwellFunction(Iters, a1[i]);
    Label1->Caption = "Progress: " + FormatFloat("0", (i + 0.33) / Points * 100) + "%";
    Update();

    Res.SetZero();
    MaxwellNoBlock(Iters, a2[i]);
    Label1->Caption = "Progress: " + FormatFloat("0", (i + 0.66) / Points * 100) + "%";
    Update();

    Res.SetZero();
    MaxwellBlock(Iters, a3[i]);
    Label1->Caption = "Progress: " + FormatFloat("0", (i + 0.99) / Points * 100) + "%";
    Update();

    Res.SetZero();
    MaxwellExpression(Iters, a4[i]);
    Label1->Caption = "Progress: " + FormatFloat("0", (i + 0.99) / Points * 100) + "%";
    Update();

    Res.SetZero();
    MaxwellFunctionCpp(Iters, a5[i]);   // pure C++ scalar baseline (C runtime math)
    Update();

    Iters = (int)Math387::RoundToInt(TotalIters / Math387::Power(Step, i + 2));
    X.Length = (int)Math387::RoundToInt(2 * Math387::Power(Step, i + 2));
    Res.Size(X);
    X.SetVal(2);
  }
  Label1->Caption = "Progress: 100%";
  Chart1->LeftAxis->Automatic = false;
  for (int i = 0; i < Chart1->SeriesCount(); i++) Chart1->Series[i]->Clear();
  for (int i = 1; i < Points; i++)
    Chart1->Series[0]->AddY(a1[i], FormatFloat("0", Math387::Power(Step, i + 2)), clTeeColor);
  for (int i = 1; i < Points; i++)
    if (a2[i] != 0) Chart1->Series[1]->AddY(a2[i], "", clTeeColor);
  for (int i = 1; i < Points; i++)
    if (a3[i] != 0) Chart1->Series[2]->AddY(a3[i], "", clTeeColor);
  for (int i = 1; i < Points; i++)
    if (a4[i] != 0) Chart1->Series[3]->AddY(a4[i], "", clTeeColor);
  for (int i = 1; i < Points; i++)
    if (a5[i] != 0) Chart1->Series[4]->AddY(a5[i], "", clTeeColor);

  Chart1->LeftAxis->Automatic = false;
  Chart1->LeftAxis->SetMinMax(0,
    1.1 * Math387::Max(Math387::Max(Math387::Max(Math387::Max(FindMax(a1, Points), FindMax(a2, Points)),
                                    FindMax(a3, Points)), FindMax(a4, Points)), FindMax(a5, Points)));
  Screen->Cursor = crDefault;

  delete[] a1;
  delete[] a2;
  delete[] a3;
  delete[] a4;
  delete[] a5;
}
//---------------------------------------------------------------------------
