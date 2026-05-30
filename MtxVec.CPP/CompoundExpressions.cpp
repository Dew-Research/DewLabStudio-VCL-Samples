//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "CompoundExpressions.h"
#include <MtxExprInt.hpp>
#include <MtxVecInt.hpp>
#include <AbstractMtxVecInt.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TCompoundExpressionsForm *CompoundExpressionsForm;
//---------------------------------------------------------------------------
__fastcall TCompoundExpressionsForm::TCompoundExpressionsForm(TComponent* Owner)
  : TForm(Owner), ak(0), ac(0), VectorLen(0), Stage(0)
{
  for (int r = 0; r < 2; r++)
    for (int c = 0; c < 6; c++)
      Timings[r][c] = 0.0;
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::DoublePrecisionMath()
{
  int loops = 10000;
  TStringList *labels = new TStringList();
  try
  {
    sVector aDst, bDst, x, y, z;

    Series1->Title = "Double Compound";
    Series2->Title = "Double Sequenced";
    x.Size(1000);
    x.Ramp();
    y.Size(x);
    y.SetVal(2.1);
    z.Size(x);
    z.SetVal(3.5);

    // X*xScale + Y*yScale + Z*zScale
    labels->Add("X*xScale + Y*yScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddScaled(x, 2.0, y, 3.0, z, 4.0);
    Timings[0][0] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, 2.0);
      bDst.AddScaled(y, 3.0);
      bDst.AddScaled(z, 4.0);
    }
    Timings[1][0] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    // X + Y + Z
    labels->Add("X + Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.Add(x, y, z);
    Timings[0][1] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Add(z);
    }
    Timings[1][1] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    // (X*xScale + Y*yScale)*Z*zScale
    labels->Add("(X*xScale + Y*yScale)*Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, 2.0, y, 3.0, z, 4.0);
    Timings[0][2] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, 2.0);
      bDst.AddScaled(y, 3.0);
      bDst.Mul(z);
      bDst.Mul(4.0);
    }
    Timings[1][2] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    // (X + Y)*Z
    labels->Add("(X + Y)*Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, y, z);
    Timings[0][3] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Mul(z);
    }
    Timings[1][3] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    // X*Y*xyScale + Z*zScale
    labels->Add("X*Y*xyScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, 3.0, z, 4.0);
    Timings[0][4] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, y);
      bDst.Mul(3.0);
      bDst.AddScaled(z, 4.0);
    }
    Timings[1][4] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    // X*Y + Z
    labels->Add("X*Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, z);
    Timings[0][5] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, y);
      bDst.Add(z);
    }
    Timings[1][5] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    Series1->Clear();
    Series2->Clear();
    for (int i = 0; i < 6; i++)
    {
      Series1->AddY(Timings[0][i], labels->Strings[i]);
      Series2->AddY(Timings[1][i], labels->Strings[i]);
    }
  }
  __finally
  {
    delete labels;
  }
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::ComplexDoublePrecisionMath()
{
  int loops = 10000;
  TStringList *labels = new TStringList();
  try
  {
    sVector aDst, bDst, x, y, z;

    Series1->Title = "Complex Compound";
    Series2->Title = "Complex Sequenced";
    x.Size(1000, true);
    x.Ramp();
    y.Size(x);
    y.SetVal(Cplx(2.1, 1.9));
    z.Size(x);
    z.SetVal(Cplx(3.5, 2.5));

    labels->Add("X*xScale + Y*yScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddScaled(x, Cplx(2.0, 1.3), y, Cplx(3.0, 1.2), z, Cplx(4.0, 1.8));
    Timings[0][0] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, Cplx(2.0, 1.3));
      bDst.AddScaled(y, Cplx(3.0, 1.2));
      bDst.AddScaled(z, Cplx(4.0, 1.8));
    }
    Timings[1][0] = StopTimer() * 1000;
    // Pascal source intentionally skips IsEqual check here.

    labels->Add("X + Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.Add(x, y, z);
    Timings[0][1] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Add(z);
    }
    Timings[1][1] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    labels->Add("(X*xScale + Y*yScale)*Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, Cplx(2.0, 1.3), y, Cplx(3.0, 1.2), z, Cplx(4.0, 1.8));
    Timings[0][2] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, Cplx(2.0, 1.3) * Cplx(4.0, 1.8));
      bDst.AddScaled(y, Cplx(3.0, 1.2) * Cplx(4.0, 1.8));
      bDst.Mul(z);
    }
    Timings[1][2] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    labels->Add("(X + Y)*Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, y, z);
    Timings[0][3] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Mul(z);
    }
    Timings[1][3] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    labels->Add("X*Y*xyScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, Cplx(3.0, 1.2), z, Cplx(4.0, 1.8));
    Timings[0][4] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, y);
      bDst.Mul(Cplx(3.0, 1.2));
      bDst.AddScaled(z, Cplx(4.0, 1.8));
    }
    Timings[1][4] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    labels->Add("X*Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, z);
    Timings[0][5] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Mul(x, y);
      bDst.Add(z);
    }
    Timings[1][5] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst, 1E-5)) ERaise("Not equal");

    Series1->Clear();
    Series2->Clear();
    for (int i = 0; i < 6; i++)
    {
      Series1->AddY(Timings[0][i], labels->Strings[i]);
      Series2->AddY(Timings[1][i], labels->Strings[i]);
    }
  }
  __finally
  {
    delete labels;
  }
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::SaturatedIntegerMath()
{
  int loops = 10000;
  TStringList *labels = new TStringList();
  try
  {
    sVectorInt aDst, bDst, cDst, x, y, z;

    Series1->Title = "Integer Compound";
    Series2->Title = "Integer Sequenced";
    x.Size(1000, prInt32);
    x.SetVal(1);
    y.Size(x);
    y.SetVal(2);
    z.Size(x);
    z.SetVal(3);

    labels->Add("X*xScale + Y*yScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddScaled(x, 2, y, 3, z, 4);
    Timings[0][0] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, 2);
      cDst.Multiply(y, 3);
      bDst.Add(cDst);
      cDst.Multiply(z, 4);
      bDst.Add(cDst);
    }
    Timings[1][0] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X + Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.Add(x, y, z);
    Timings[0][1] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Add(z);
    }
    Timings[1][1] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("(X*xScale + Y*yScale)*Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, 2, y, 3, z, 4);
    Timings[0][2] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, 2);
      cDst.Multiply(y, 3);
      bDst.Add(cDst);
      bDst.Multiply(z);
      bDst.Multiply(4);
    }
    Timings[1][2] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("(X + Y)*Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, y, z);
    Timings[0][3] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Multiply(z);
    }
    Timings[1][3] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X*Y*xyScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, 3, z, 4);
    Timings[0][4] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, y);
      bDst.Multiply(3);
      cDst.Multiply(z, 4);
      bDst.Add(cDst);
    }
    Timings[1][4] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X*Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, z);
    Timings[0][5] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, y);
      bDst.Add(z);
    }
    Timings[1][5] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    Series1->Clear();
    Series2->Clear();
    for (int i = 0; i < 6; i++)
    {
      Series1->AddY(Timings[0][i], labels->Strings[i]);
      Series2->AddY(Timings[1][i], labels->Strings[i]);
    }
  }
  __finally
  {
    delete labels;
  }
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::SaturatedSmallIntMath()
{
  int loops = 10000;
  TStringList *labels = new TStringList();
  try
  {
    sVectorInt aDst, bDst, cDst, x, y, z;

    Series1->Title = "SmallInt Compound";
    Series2->Title = "SmallInt Sequenced";
    x.Size(1000, prInt16);
    x.SetVal(1);
    y.Size(x);
    y.SetVal(2);
    z.Size(x);
    z.SetVal(3);

    labels->Add("X*xScale + Y*yScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddScaled(x, 2, y, 3, z, 4);
    Timings[0][0] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, 2);
      cDst.Multiply(y, 3);
      bDst.Add(cDst);
      cDst.Multiply(z, 4);
      bDst.Add(cDst);
    }
    Timings[1][0] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X + Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.Add(x, y, z);
    Timings[0][1] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Add(z);
    }
    Timings[1][1] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("(X*xScale + Y*yScale)*Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, 2, y, 3, z, 4);
    Timings[0][2] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, 2);
      cDst.Multiply(y, 3);
      bDst.Add(cDst);
      bDst.Multiply(z);
      bDst.Multiply(4);
    }
    Timings[1][2] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("(X + Y)*Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, y, z);
    Timings[0][3] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Multiply(z);
    }
    Timings[1][3] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X*Y*xyScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, 3, z, 4);
    Timings[0][4] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, y);
      bDst.Multiply(3);
      cDst.Multiply(z, 4);
      bDst.Add(cDst);
    }
    Timings[1][4] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X*Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, z);
    Timings[0][5] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, y);
      bDst.Add(z);
    }
    Timings[1][5] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    Series1->Clear();
    Series2->Clear();
    for (int i = 0; i < 6; i++)
    {
      Series1->AddY(Timings[0][i], labels->Strings[i]);
      Series2->AddY(Timings[1][i], labels->Strings[i]);
    }
  }
  __finally
  {
    delete labels;
  }
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::SaturatedByteMath()
{
  int loops = 10000;
  TStringList *labels = new TStringList();
  try
  {
    sVectorInt aDst, bDst, cDst, x, y, z;

    Series1->Title = "Byte Compound";
    Series2->Title = "Byte Sequenced";
    x.Size(1000, prInt8);
    x.SetVal(1);
    y.Size(x);
    y.SetVal(2);
    z.Size(x);
    z.SetVal(3);

    labels->Add("X*xScale + Y*yScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddScaled(x, 2, y, 3, z, 4);
    Timings[0][0] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, 2);
      cDst.Multiply(y, 3);
      bDst.Add(cDst);
      cDst.Multiply(z, 4);
      bDst.Add(cDst);
    }
    Timings[1][0] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X + Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.Add(x, y, z);
    Timings[0][1] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Add(z);
    }
    Timings[1][1] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("(X*xScale + Y*yScale)*Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, 2, y, 3, z, 4);
    Timings[0][2] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, 2);
      cDst.Multiply(y, 3);
      bDst.Add(cDst);
      bDst.Multiply(z);
      bDst.Multiply(4);
    }
    Timings[1][2] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("(X + Y)*Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.AddAndMul(x, y, z);
    Timings[0][3] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Add(x, y);
      bDst.Multiply(z);
    }
    Timings[1][3] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X*Y*xyScale + Z*zScale");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, 3, z, 4);
    Timings[0][4] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, y);
      bDst.Multiply(3);
      cDst.Multiply(z, 4);
      bDst.Add(cDst);
    }
    Timings[1][4] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    labels->Add("X*Y + Z");
    StartTimer();
    for (int i = 0; i < loops; i++)
      aDst.MulAndAdd(x, y, z);
    Timings[0][5] = StopTimer() * 1000;

    StartTimer();
    for (int i = 0; i < loops; i++)
    {
      bDst.Multiply(x, y);
      bDst.Add(z);
    }
    Timings[1][5] = StopTimer() * 1000;
    if (!aDst.IsEqual(bDst)) ERaise("Not equal");

    Series1->Clear();
    Series2->Clear();
    for (int i = 0; i < 6; i++)
    {
      Series1->AddY(Timings[0][i], labels->Strings[i]);
      Series2->AddY(Timings[1][i], labels->Strings[i]);
    }
  }
  __finally
  {
    delete labels;
  }
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::RunButtonClick(TObject *Sender)
{
  switch (PrecisionGroup->ItemIndex)
  {
    case 0: DoublePrecisionMath(); break;
    case 1: ComplexDoublePrecisionMath(); break;
    case 2: SaturatedIntegerMath(); break;
    case 3: SaturatedSmallIntMath(); break;
    case 4: SaturatedByteMath(); break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::FormCreate(TObject *Sender)
{
  Memo->Clear();
  Memo->Lines->Add(
    "Compound expressions join together multiple (+,-,/,*) math operations in to a single loop thus increasing the possibility to vectorize code and lower the "
    "use of main memory bandwidth. The functions are available for TVec/TMtx and Vector/Matrix types. Check below the performance advantage by pressing Run. "
    "In this benchmark only 6 different variants are compared, but a total of 162 distinct overloads have been added with version 6.31 to the TVec and the same also to TMtx.");
  Memo->Lines->Add("");
  Memo->Lines->Add("Note that the more complex expressions take about equal time as the simpler math operations.");
}
//---------------------------------------------------------------------------
void __fastcall TCompoundExpressionsForm::PrecisionGroupClick(TObject *Sender)
{
  RunButtonClick(Sender);
}
//---------------------------------------------------------------------------
