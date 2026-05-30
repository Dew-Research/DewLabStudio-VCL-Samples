//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "SmallMatrixMul.h"
#include <MtxVecBase.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic1"
#pragma resource "*.dfm"
TfrmSmallMatrix *frmSmallMatrix;
//---------------------------------------------------------------------------
__fastcall TfrmSmallMatrix::TfrmSmallMatrix(TComponent* Owner)
  : TBasicForm1(Owner)
{
}
//---------------------------------------------------------------------------
static void PascalMul(const Math387::TDoubleArray &A, const Math387::TDoubleArray &B,
                       Math387::TDoubleArray &C, int n)
{
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
    {
      double sum = 0.0;
      for (int k = 0; k < n; k++) sum += A[i * n + k] * B[k * n + j];
      C[i * n + j] = sum;
    }
}
//---------------------------------------------------------------------------
static void PascalMul(const Math387::TCplxArray &A, const Math387::TCplxArray &B,
                       Math387::TCplxArray &C, int n)
{
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
    {
      TCplx sum = C_ZERO;
      for (int k = 0; k < n; k++) sum = sum + A[i * n + k] * B[k * n + j];
      C[i * n + j] = sum;
    }
}
//---------------------------------------------------------------------------
void __fastcall TfrmSmallMatrix::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "Multiplying small matrices is challenging, because any error checking or layout detection code, will "
    "easily take more time than the computation itself. Hence the error checking needs to be reduced. For these reason the small matrix multiply routines "
    "are to be used with due care, with the code properly tested before deployed. ");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Press run to run the benchmark, which compares different APIs for small matrix multiply.");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("The recommended api to start with is TMtx.MulSmallInit and TMtx.MulSmall.");

  Chart1->SeriesList->Clear();
  for (int i = 0; i < 7; i++)
  {
    Chart1->AddSeries(new TLineSeries(Chart1));
    ((TLineSeries*)Chart1->Series[i])->Pointer->Visible = true;
    ((TLineSeries*)Chart1->Series[i])->Pointer->Style = (TSeriesPointerStyle)(i + 1);
  }
  Chart1->Series[0]->Title = "Matrix.Mul (dgemm)";
  Chart1->Series[1]->Title = "Delphi pascal";
  Chart1->Series[2]->Title = "jitted array";
  Chart1->Series[3]->Title = "Jitted pointer";
  Chart1->Series[4]->Title = "Jitted TMtx";
  Chart1->Series[5]->Title = "Jitted Matrix";
  Chart1->Series[6]->Title = "jitted Matrix.MulSmall";

  jit = new TSmallMatrixMultiply();
}
//---------------------------------------------------------------------------
void __fastcall TfrmSmallMatrix::FormDestroy(TObject *Sender)
{
  delete jit;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSmallMatrix::Button1Click(TObject *Sender)
{
  int Iters = ComplexBox->Checked ? 3000 : 15000;
  int MaxSize = 50;
  sMatrix aTimings;
  aTimings.Size(Chart1->SeriesCount(), MaxSize);
  Screen->Cursor = crHourGlass;
  jitLabel->Caption = "JIT kernel used for all sizes";

  for (int i = 0; i < aTimings.Cols; i++)
  {
	int aRows = i + 2;
	int aCols = aRows;

	Math387::TDoubleArray a, b, c;
	Math387::TCplxArray ac, bc, cc;
	if (!ComplexBox->Checked)
	{
	  Math387::aSetLength(a, aRows * aCols);
	  Math387::aSetLength(b, aRows * aCols);
	  Math387::aSetLength(c, aRows * aCols);
	}
	else
	{
	  Math387::aSetLength(ac, aRows * aCols);
	  Math387::aSetLength(bc, aRows * aCols);
	  Math387::aSetLength(cc, aRows * aCols);
	}

	Matrix am, bm, cm;
    am.Size(aRows, aCols, TMtxFloatPrecision::mvDouble);
    bm.Size(am);
    cm.Size(am);

    TMtx *ap = am;
    TMtx *bp = bm;
    TMtx *cp = cm;

    // Matrix.Mul
    StartTimer();
    for (int j = 0; j <= Iters; j++) cm.Mul(am, bm, TMtxOperation::opNone, TMtxOperation::opNone);
    aTimings.Values(0, i) = StopTimer() * 1000;

    if (!ComplexBox->Checked)
    {
      if (aRows < 10)
      {
        StartTimer();
        for (int j = 0; j <= Iters; j++) PascalMul(ap->Values1D, bp->Values1D, cp->Values1D, aRows);
        aTimings.Values(1, i) = StopTimer() * 1000;
      }
      else
        aTimings.Values(1, i) = 0;
    }
    else
    {
      if (aRows < 10)
      {
        StartTimer();
        for (int j = 0; j <= Iters; j++) PascalMul(ap->CValues1D, bp->CValues1D, cp->CValues1D, aRows);
        aTimings.Values(1, i) = StopTimer() * 1000;
      }
      else
        aTimings.Values(1, i) = 0;
    }

    if (!jit->Init(am, bm, cm, opNone, opNone, 1, 0))
      jitLabel->Caption = "JIT worked up to size: " + IntToStr(aRows) + "x" + IntToStr(aCols);

    // jit with fixed memory pointers as params
    StartTimer();
    for (int j = 0; j <= Iters; j++) jit->Mul();
    aTimings.Values(3, i) = StopTimer() * 1000;

    ap = am;
    bp = bm;
    cp = cm;

    // Jitted TMtx
    StartTimer();
    for (int j = 0; j <= Iters; j++) jit->Mul(ap, bp, cp);
    aTimings.Values(4, i) = StopTimer() * 1000;

    // Jitted Matrix
    StartTimer();
    for (int j = 0; j <= Iters; j++) jit->Mul(am, bm, cm);
    aTimings.Values(5, i) = StopTimer() * 1000;

    // Jitted Matrix.MulSmall
    cm.MulSmallInit(am, bm);
    StartTimer();
    for (int j = 0; j <= Iters; j++) cm.MulSmall(am, bm);
    aTimings.Values(6, i) = StopTimer() * 1000;
  }

  if (ComplexBox->Checked) aTimings.Scale(5);

  Chart1->LeftAxis->Automatic = false;
  for (int i = 0; i < aTimings.Rows; i++)
  {
    Chart1->Series[i]->Clear();
    for (int j = 0; j < aTimings.Cols; j++)
      if (aTimings.Values(i, j) != 0)
        Chart1->Series[i]->AddY(aTimings.Values(i, j), IntToStr(2 + j) + "x" + IntToStr(2 + j));
  }

  Chart1->LeftAxis->Automatic = false;
  Chart1->LeftAxis->SetMinMax(0, 1.1 * aTimings.Max());
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------
