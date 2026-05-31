//---------------------------------------------------------------------------
#pragma hdrstop

#include "BenchmarkFramework.h"
#include "math.h"
#include "MtxExpr.hpp"
//---------------------------------------------------------------------------

#pragma package(smart_init)

//---------------------------------------------------------------------------
// The Math387 enhanced scalar routines are stored and timed DIRECTLY as
// __fastcall function pointers (TFastDbleFunc) - exactly as the complex column
// already stores Math387 via TCplxFunc. No __cdecl adapter wrapper is used: a
// wrapper would either inline (silently assuming a zero-cost call) or add a
// second call the pure-C/C++ runtime column never pays, distorting the
// comparison. The runtime (<math.h>) versions are timed separately as the
// pure-C baseline (smpl_rtl_func), each likewise stored as a direct pointer.
//
// asinh/acosh/atanh are C99 inverse hyperbolics used by the pure-C/C++ runtime
// baseline column. Modern Embarcadero clang (bcc64x / bcc32x, clang >= 15)
// declares them in <math.h> and links them, so there we time the genuine
// runtime function. Classic bcc32 does not declare them, and the early clang
// Win64 RTL (XE6/D20) declares but does not export them; on those toolchains
// fall back to the standard pure-C log/sqrt identities so the baseline column
// still measures a real scalar computation instead of dropping the demo.
#if defined(__clang__) && (__clang_major__ >= 15)
  #define rt_asinh asinh
  #define rt_acosh acosh
  #define rt_atanh atanh
#else
  static double rt_asinh(double x) { return log(x + sqrt(x * x + 1.0)); }
  static double rt_acosh(double x) { return log(x + sqrt(x * x - 1.0)); }
  static double rt_atanh(double x) { return 0.5 * log((1.0 + x) / (1.0 - x)); }
#endif

//---------------------------------------------------------------------------

/* TBenchmarksFramework */

BenchmarkFramework::BenchmarkFramework()
{
  fSrc = new TVec();
  fDst = new TVec();
//  CreateIt (fSrc, fDst);
  InitFuncs();
}
//---------------------------------------------------------------------------

BenchmarkFramework::~BenchmarkFramework()
{
  delete fSrc;
  delete fDst;	
//  FreeIt (fSrc, fDst);
}
//---------------------------------------------------------------------------

int BenchmarkFramework::FindFuncByName (const AnsiString& func_name)
{
  for (unsigned i = 0; i < fFuncCount; i++)
    if (SameText (fFuncs[i].func_name, func_name))
      return i;

  throw Exception ("BenchmarkFramework::FindFuncByName: Name of function was not found", ARRAYOFCONST((func_name)));
}
//---------------------------------------------------------------------------

int BenchmarkFramework::GetFuncCount()
{
  return fFuncCount;
}
//---------------------------------------------------------------------------

AnsiString BenchmarkFramework::GetFuncName(int idx)
{
  return fFuncs[idx].func_name;
}
//---------------------------------------------------------------------------

void BenchmarkFramework::AddFunc (const AnsiString& func_name, double smpl_val, const TCplx& cplx_val,
								  TFastDbleFunc const smpl_func, TDbleFunc const smpl_rtl_func,
								  TCplxFunc const cplx_func, TVecMethod const vec_method)
{
  if (fFuncCount >= fFuncs.size())
    fFuncs.resize (fFuncCount + 20);

  fFuncs[fFuncCount].func_name = func_name;
  fFuncs[fFuncCount].smpl_func = smpl_func;
  fFuncs[fFuncCount].smpl_rtl_func = smpl_rtl_func;
  fFuncs[fFuncCount].cplx_func = cplx_func;
  fFuncs[fFuncCount].vec_method = vec_method;
  fFuncs[fFuncCount].smpl_val = smpl_val;
  fFuncs[fFuncCount].cplx_val = cplx_val;

  fFuncCount++;
}
//---------------------------------------------------------------------------

void BenchmarkFramework::InitFuncs()
{
  const double VAL1(0.5);
  const TCplx CVAL1(Cplx(0.5,0.5));

  fFuncCount = 0;

  // Per function:  name, real val, cplx val,
  //                Math387 scalar (enhanced),  C/C++ runtime scalar (baseline),
  //                Math387 complex scalar,     MtxVec vectorized method.
  // Order matches BenchmarkFramework.pas so the charts line up across platforms.
  AddFunc ("Sin",     VAL1, CVAL1, Math387::Sin,     sin,   Math387::Sin,     fDst->Sin);
  AddFunc ("Cos",     VAL1, CVAL1, Math387::Cos,     cos,   Math387::Cos,     fDst->Cos);
  AddFunc ("Exp",     VAL1, CVAL1, Math387::Exp,     exp,   Math387::Exp,     fDst->Exp);
  AddFunc ("Ln",      VAL1, CVAL1, Math387::Ln,      log,   Math387::Ln,      fDst->Ln);

  AddFunc ("Log10",   VAL1, CVAL1, Math387::Log10,   log10, Math387::Log10,   fDst->Log10);
  AddFunc ("Tan",     VAL1, CVAL1, Math387::Tan,     tan,   Math387::Tan,     fDst->Tan);
  AddFunc ("ArcSin",  VAL1, CVAL1, Math387::ArcSin,  asin,  Math387::ArcSin,  fDst->ArcSin);
  AddFunc ("ArcCos",  VAL1, CVAL1, Math387::ArcCos,  acos,  Math387::ArcCos,  fDst->ArcCos);
  AddFunc ("ArcTan",  VAL1, CVAL1, Math387::ArcTan,  atan,  Math387::ArcTan,  fDst->ArcTan);

  AddFunc ("Sinh",    VAL1, CVAL1, Math387::Sinh,    sinh,  Math387::Sinh,    fDst->Sinh);
  AddFunc ("Cosh",    VAL1, CVAL1, Math387::Cosh,    cosh,  Math387::Cosh,    fDst->Cosh);
  AddFunc ("Tanh",    VAL1, CVAL1, Math387::Tanh,    tanh,  Math387::Tanh,    fDst->Tanh);

  AddFunc ("ArcSinh", VAL1, CVAL1, Math387::ArcSinh, rt_asinh, Math387::ArcSinh, fDst->ArcSinh);
  AddFunc ("ArcCosh", VAL1, CVAL1, Math387::ArcCosh, rt_acosh, Math387::ArcCosh, fDst->ArcCosh);
  AddFunc ("ArcTanh", VAL1, CVAL1, Math387::ArcTanh, rt_atanh, Math387::ArcTanh, fDst->ArcTanh);
}
//---------------------------------------------------------------------------

void BenchmarkFramework::InitSmplVecs (double val)
{
  fSrc->Size (VectorLength, false);
  fSrc->SetVal (val);
  fSrca.resize(VectorLength);
  for (int i = 0; i < VectorLength; i++)
    fSrca[i] = val;

  fDst->Size (VectorLength, false);
  fDst->SetZero();
  fDsta.resize(VectorLength);
  for (int i = 0; i < VectorLength; i++)
    fDsta[i] = 0;
}
//---------------------------------------------------------------------------

void BenchmarkFramework::InitCplxVecs (const TCplx& cval)
{
  fSrc->Size (VectorLength, true);
  fSrc->SetVal (cval);
  fSrcac.resize(VectorLength);
  for (int i = 0; i < VectorLength; i++)
    fSrcac[i] = cval;

  fDst->Size (VectorLength, true);
  fDst->SetZero();
  fDstac.resize(VectorLength);
  for (int i = 0; i < VectorLength; i++)
    fDstac[i] = C_ZERO;
}
//---------------------------------------------------------------------------

void BenchmarkFramework::Run(const AnsiString& func_name, TBenchmarkResults* results)
{
  fSelectedFunc = fFuncs[FindFuncByName(func_name)];

  InitSmplVecs (fSelectedFunc.smpl_val);
  double smpl_vec_ticks = DoUnderTimer (CalcVector);

  InitCplxVecs (fSelectedFunc.cplx_val);
  double cplx_vec_ticks = DoUnderTimer (CalcVector);

  InitSmplVecs (fSelectedFunc.smpl_val);
  double smpl_func_ticks = DoUnderTimer (CalcSample);       // Math387 enhanced scalar

  InitSmplVecs (fSelectedFunc.smpl_val);
  double smpl_rtl_func_ticks = DoUnderTimer (CalcSampleRtl); // pure C/C++ runtime scalar

  InitCplxVecs (fSelectedFunc.cplx_val);
  double cplx_func_ticks = DoUnderTimer (CalcComplex);

  results->Add (func_name, VectorLength, IterationCount,
    smpl_vec_ticks, cplx_vec_ticks, smpl_func_ticks, smpl_rtl_func_ticks, cplx_func_ticks);
}
//---------------------------------------------------------------------------

void __fastcall BenchmarkFramework::CalcVector()
{
  TVecMethod vec_method = fSelectedFunc.vec_method;
  for (int i = 0; i < fIterationCount; i++)
    vec_method(fSrc);
}
//---------------------------------------------------------------------------

void __fastcall BenchmarkFramework::CalcSample()
{
  TFastDbleFunc smpl_func = fSelectedFunc.smpl_func;
  for (int i = 0; i < fIterationCount; i++)
    for (int j = 0; j < VectorLength; j++)
      fDsta[j] = smpl_func (fSrca[j]);
}
//---------------------------------------------------------------------------

void __fastcall BenchmarkFramework::CalcSampleRtl()
{
  TDbleFunc smpl_func = fSelectedFunc.smpl_rtl_func;
  for (int i = 0; i < fIterationCount; i++)
    for (int j = 0; j < VectorLength; j++)
      fDsta[j] = smpl_func (fSrca[j]);
}
//---------------------------------------------------------------------------

void __fastcall BenchmarkFramework::CalcComplex()
{
  TCplxFunc cplx_func = fSelectedFunc.cplx_func;
  for (int i = 0; i < fIterationCount; i++)
    for (int j = 0; j < VectorLength; j++)
      fDstac[j] = cplx_func (fSrcac[j]);
}
//---------------------------------------------------------------------------

double BenchmarkFramework::DoUnderTimer(TCalcProc calc_proc)
{
  StartTimer();
  calc_proc();
  return StopTimer()*1000;
}
//---------------------------------------------------------------------------

int BenchmarkFramework::RecalcIterationCount()
{
  sVector a,b;
  a.Size (VectorLength, false);
  b.Size (VectorLength, false);

  int n = 0;
  double delta;
  StartTimer();
  while (true) {
	b.Sin(a);
	n++;
    delta = StopTimer()*1000;
    if (delta > 1000)
      break;
  }

  return n / 4; // iterations per 1/4 second
}
//---------------------------------------------------------------------------

