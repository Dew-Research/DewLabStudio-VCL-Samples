//---------------------------------------------------------------------------
#pragma hdrstop

#include "BenchmarkFramework.h"
#include "math.h"
#include "MtxExpr.hpp"
//---------------------------------------------------------------------------

#pragma package(smart_init)

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
								  TDbleFunc const smpl_func, TCplxFunc const cplx_func, TVecMethod const vec_method)
{
  if (fFuncCount >= fFuncs.size())
    fFuncs.resize (fFuncCount + 20);

  fFuncs[fFuncCount].func_name = func_name;
  fFuncs[fFuncCount].smpl_func = smpl_func;
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

  AddFunc ( "Sin", VAL1, CVAL1, sin, Math387::Sin, fDst->Sin);
  AddFunc ("Cos", VAL1, CVAL1, cos, Math387::Cos, fDst->Cos);
  AddFunc ("Exp", VAL1, CVAL1, exp, Math387::Exp, fDst->Exp);
  AddFunc ("Ln", VAL1, CVAL1, log, Math387::Ln, fDst->Ln);

  AddFunc ("Log10", VAL1, CVAL1, log10, Math387::Log10, fDst->Log10);
  AddFunc ("Tan", VAL1, CVAL1, tan, Math387::Tan, fDst->Tan);
  AddFunc ("ArcTan", VAL1, CVAL1, atan, Math387::ArcTan, fDst->ArcTan);
  AddFunc ("ArcSin", VAL1, CVAL1, asin, Math387::ArcSin, fDst->ArcSin);
  AddFunc ("ArcCos", VAL1, CVAL1, acos, Math387::ArcCos, fDst->ArcCos);

  AddFunc ("Tanh", VAL1, CVAL1, tanh, Math387::Tanh, fDst->Tanh);
  AddFunc ("Sinh", VAL1, CVAL1, sinh, Math387::Sinh, fDst->Sinh);
  AddFunc ("Cosh", VAL1, CVAL1, sinh, Math387::Cosh, fDst->Cosh);

//Cant run because there is no common calling convetion or math.h equivalent:
//  AddFunc( "ArcTanh", VAL1, CVAL1, Math387::ArcTanh, Math387::ArcTanh, fDst->ArcTanh);
//  AddFunc ("ArcSinh", VAL1, CVAL1, asinh, Math387::ArcSinh, fDst->ArcSinh);
//  AddFunc ("ArcCosh", VAL1, CVAL1, asinh, Math387::ArcCosh, fDst->ArcCosh);
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
  int smpl_vec_ticks = DoUnderTimer (CalcVector);

  InitCplxVecs (fSelectedFunc.cplx_val);
  int cplx_vec_ticks = DoUnderTimer (CalcVector);

  InitSmplVecs (fSelectedFunc.smpl_val);
  int smpl_func_ticks = DoUnderTimer (CalcSample);

  InitCplxVecs (fSelectedFunc.cplx_val);
  int cplx_func_ticks = DoUnderTimer (CalcComplex);

  results->Add (func_name, VectorLength, IterationCount,
    smpl_vec_ticks, cplx_vec_ticks, smpl_func_ticks, cplx_func_ticks);
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
  TDbleFunc smpl_func = fSelectedFunc.smpl_func;
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

int BenchmarkFramework::DoUnderTimer(TCalcProc calc_proc)
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

