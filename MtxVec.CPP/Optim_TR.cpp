//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Optim_TR.h"
#include <MtxIntDiff.hpp>
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmTRDemo *frmTRDemo;
//---------------------------------------------------------------------------
static const int NumRep = 200;
//---------------------------------------------------------------------------
__fastcall TfrmTRDemo::TfrmTRDemo(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
static void __fastcall BananaVector(TVec * const x, TVec * const f,
                                     const double *c,
                                     #if (__BORLANDC__ >= 0x0770)
                                     const System::NativeInt c_High,
                                     #else
                                     const int c_Size,
                                     #endif
                                     System::TObject * const *o,
                                     #if (__BORLANDC__ >= 0x0770)
                                     const System::NativeInt o_High
                                     #else
                                     const int o_Size
                                     #endif
                                     )
{
  // Typecast TVec* -> TVector* (layout-identical subclass, MtxVec.h): its Values[]
  // property is inline raw pointer math (((double*)ValuesPointer)[i]) that shadows
  // the inherited DynamicArray Values FIELD -- fast, and correct on the SetSubRange
  // views the optimizer passes. Indexing the field directly (TVec::Values[i], or the
  // get_DefaultArray property) is wrong here: the field's C++ operator[] bounds-checks
  // against a counterfeit length and throws. See CPP-toolchain.md. Matches Delphi x[i]/f[i].
  Mtxvec::TVector *px = (Mtxvec::TVector*) x;
  Mtxvec::TVector *pf = (Mtxvec::TVector*) f;
  double x0 = px->Values[0];
  double x1 = px->Values[1];
  double t  = x1 - x0 * x0;
  double u  = 1 - x0;
  pf->Values[0] = 100 * t * t;
  pf->Values[1] = u * u;
}
//---------------------------------------------------------------------------
static double __fastcall BananaScalar(TVec * const x, TVec * const c,
                                       System::TObject * const *o,
                                       #if (__BORLANDC__ >= 0x0770)
                                       const System::NativeInt o_High
                                       #else
                                       const int o_Size
                                       #endif
                                       )
{
  // Typecast TVec* -> TVector* (MtxVec.h): Values[] = inline raw pointer math, correct
  // on the SetSubRange views Simplex passes. Indexing the inherited DynamicArray field
  // (TVec::Values[i]) would bounds-check against a counterfeit length and throw. See
  // CPP-toolchain.md "the Values[] field bounds-check trap". Matches Delphi.
  Mtxvec::TVector *px = (Mtxvec::TVector*) x;
  double x0 = px->Values[0];
  double x1 = px->Values[1];
  double t  = x1 - x0 * x0;
  double u  = 1 - x0;
  return 100 * t * t + u * u;
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add("New in MtxVec 3.0 : Trust Region optimization algorithm.");
  RichEdit1->Lines->Add(
    "Using TR algorithm it's now possible to minimize vector function of "
    " several variables with or without bounds.");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add(
    "This example minimizes the famous \"Banana\" function using several different "
    " algorithms and compares the results. As seen from results, TR algorithm is not "
    "the best choice if you're minimizing small scale problems. TR algorithm is the "
    "preffered choice if you're working on large scale bounded or unbouded problems.");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("NOTE: Check http://plato.la.asu.edu/guide.html when in doubt which algorithm to use.");

  Edit1->Text = FormatSample(0.0);
  Edit2->Text = FormatSample(0.0);
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::Button1Click(TObject *Sender)
{
  Series1->Clear();
  Series2->Clear();
  initpars[0] = StrToSample(Edit1->Text);
  initpars[1] = StrToSample(Edit2->Text);
  Screen->Cursor = crHourGlass;
  try {
    TRTest();
    SimplexTest();
    MarquardtTest();
    BFGSTest();
    DFPTest();
    ConjGradFletcher();
    ConjGradPolack();
  } __finally {
    Screen->Cursor = crDefault;
  }
  RadioGroup1Click(this);
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::RadioGroup1Click(TObject *Sender)
{
  Series1->Active = RadioGroup1->ItemIndex == 0;
  Series2->Active = RadioGroup1->ItemIndex == 1;
  Chart1->Title->Text->Clear();
  switch (RadioGroup1->ItemIndex)
  {
    case 0: Chart1->Title->Text->Add("Average number of iterations needed to converge."); break;
    case 1: Chart1->Title->Text->Add("Time needed to converge (" + IntToStr(NumRep) + " iterations)."); break;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::TRTest()
{
  sVector x, y;
  x.SetIt(false, OPENARRAY(double, (initpars[0], initpars[1])));
  y.Size(2);
  TEPSArray EPSArray;
  EPSArray[0] = 1.0E-10;
  EPSArray[1] = 1.0E-8;
  EPSArray[2] = 1.0E-8;
  EPSArray[3] = 1.0E-8;
  EPSArray[4] = 1.0E-8;
  EPSArray[5] = 1.0E-10;

  StartTimer();
  IterArray[0] = 0;
  TOptStopReason stopReason;
  for (int i = 1; i <= NumRep; i++)
  {
    x.SetIt(false, OPENARRAY(double, (initpars[0], initpars[1])));
    IterArray[0] += TrustRegion(BananaVector, NULL, x, y, NULL, -1, NULL, -1, 1000, 100, EPSArray, 0.0, stopReason);
  }
  TimeArray[0] = StopTimer() * 1000;
  IterArray[0] = Math387::RoundToInt((double)IterArray[0] / NumRep);
  if (stopReason == OptResConverged)
  {
    Series1->Add(IterArray[0], "TR\rconverged");
    Series2->Add(TimeArray[0], "TR\rconverged");
  }
  else
  {
    Series1->Add(IterArray[0], "TR\rNOT converged: " + StopReasonToStr(stopReason));
    Series2->Add(TimeArray[0], "TR\rNOT converged: " + StopReasonToStr(stopReason));
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::SimplexTest()
{
  double x[2];
  StartTimer();
  IterArray[1] = 0;
  TOptStopReason stopReason;
  double fMin;
  for (int i = 1; i <= NumRep; i++)
  {
    x[0] = initpars[0];
    x[1] = initpars[1];
    IterArray[1] += Simplex(BananaScalar, &x[0], 1, NULL, -1, NULL, -1, fMin, stopReason, mvDouble, 1000);
  }
  TimeArray[1] = StopTimer() * 1000;
  IterArray[1] = Math387::RoundToInt((double)IterArray[1] / NumRep);
  AnsiString lbl = (stopReason == OptResConverged) ? "Simplex\rconverged" : "Simplex\rNOT converged";
  Series1->Add(IterArray[1], lbl);
  Series2->Add(TimeArray[1], lbl);
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::MarquardtTest()
{
  double x[2];
  TMtx *iHess;
  CreateIt(iHess);
  try {
    StartTimer();
    IterArray[2] = 0;
    TOptStopReason stopReason;
    double fMin;
    for (int i = 1; i <= NumRep; i++)
    {
      x[0] = initpars[0];
      x[1] = initpars[1];
      IterArray[2] += Marquardt(BananaScalar, NumericGradHess, &x[0], 1, NULL, -1, NULL, -1,
                                fMin, iHess, stopReason, mvDouble, 1000);
    }
    TimeArray[2] = StopTimer() * 1000;
    IterArray[2] = Math387::RoundToInt((double)IterArray[2] / NumRep);
    AnsiString lbl = (stopReason == OptResConverged) ? "Marquardt\rconverged" : "Marquardt\rNOT converged";
    Series1->Add(IterArray[2], lbl);
    Series2->Add(TimeArray[2], lbl);
  } __finally {
    FreeIt(iHess);
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::BFGSTest()
{
  double x[2];
  sMatrix iHess;
  StartTimer();
  IterArray[3] = 0;
  TOptStopReason stopReason;
  double fMin;
  for (int i = 1; i <= NumRep; i++)
  {
    x[0] = initpars[0];
    x[1] = initpars[1];
    IterArray[3] += BFGS(BananaScalar, NumericGradDifference, &x[0], 1, NULL, -1, NULL, -1,
                         fMin, iHess, stopReason, mvDouble, false, true, 1000);
  }
  TimeArray[3] = StopTimer() * 1000;
  IterArray[3] = Math387::RoundToInt((double)IterArray[3] / NumRep);
  AnsiString lbl = (stopReason == OptResConverged) ? "BFGS\rconverged" : "BFGS\rNOT converged";
  Series1->Add(IterArray[3], lbl);
  Series2->Add(TimeArray[3], lbl);
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::DFPTest()
{
  double x[2];
  sMatrix iHess;
  StartTimer();
  IterArray[4] = 0;
  TOptStopReason stopReason;
  double fMin;
  for (int i = 1; i <= NumRep; i++)
  {
    x[0] = initpars[0];
    x[1] = initpars[1];
    IterArray[4] += BFGS(BananaScalar, NumericGradDifference, &x[0], 1, NULL, -1, NULL, -1,
                         fMin, mvDouble, true);
  }
  TimeArray[4] = StopTimer() * 1000;
  IterArray[4] = Math387::RoundToInt((double)IterArray[4] / NumRep);
  AnsiString lbl = (stopReason == OptResConverged) ? "DFP\rconverged" : "DFP\rNOT converged";
  Series1->Add(IterArray[3], lbl);
  Series2->Add(TimeArray[3], lbl);
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::ConjGradFletcher()
{
  double x[2];
  StartTimer();
  IterArray[5] = 0;
  TOptStopReason stopReason;
  double fMin;
  for (int i = 1; i <= NumRep; i++)
  {
    x[0] = initpars[0];
    x[1] = initpars[1];
    IterArray[5] += ConjGrad(BananaScalar, NumericGradDifference, &x[0], 1, NULL, -1, NULL, -1,
                              fMin, stopReason, mvDouble, true, true, 1500);
  }
  TimeArray[5] = StopTimer() * 1000;
  IterArray[5] = Math387::RoundToInt((double)IterArray[5] / NumRep);
  AnsiString lbl = (stopReason == OptResConverged) ? "Fletcher\rconverged" : "Fletcher\rNOT converged";
  Series1->Add(IterArray[5], lbl);
  Series2->Add(TimeArray[5], lbl);
}
//---------------------------------------------------------------------------
void __fastcall TfrmTRDemo::ConjGradPolack()
{
  double x[2];
  StartTimer();
  IterArray[6] = 0;
  TOptStopReason stopReason;
  double fMin;
  for (int i = 1; i <= NumRep; i++)
  {
    x[0] = initpars[0];
    x[1] = initpars[1];
    IterArray[6] += ConjGrad(BananaScalar, NumericGradDifference, &x[0], 1, NULL, -1, NULL, -1,
                              fMin, stopReason, mvDouble, false, true, 1500);
  }
  TimeArray[6] = StopTimer() * 1000;
  IterArray[6] = Math387::RoundToInt((double)IterArray[6] / NumRep);
  AnsiString lbl = (stopReason == OptResConverged) ? "Polack\rconverged" : "Polack\rNOT converged";
  Series1->Add(IterArray[6], lbl);
  Series2->Add(TimeArray[6], lbl);
}
//---------------------------------------------------------------------------
