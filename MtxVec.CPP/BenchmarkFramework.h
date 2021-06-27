//---------------------------------------------------------------------------
#ifndef BenchmarkFrameworkH
#define BenchmarkFrameworkH
//---------------------------------------------------------------------------

#include <MtxVec.hpp>
#include "BenchmarkResults.h"
#include <vector>
//---------------------------------------------------------------------------

#if  (__BORLANDC__ >= 0x0650)
typedef TMtxVec* __fastcall (__closure *TVecMethod)(TMtxVec* const src);
#else
typedef TMtxVec* __fastcall (__closure *TVecMethod)(const TMtxVec* src);
#endif

typedef double (*TDbleFunc)(double x);
typedef TCplx __fastcall (*TCplxFunc)(const TCplx& x);


struct TFuncInfo {
  AnsiString func_name;
  TDbleFunc smpl_func;
  TCplxFunc cplx_func;
  TVecMethod vec_method;
  double smpl_val;
  TCplx cplx_val;
};

typedef void __fastcall (__closure *TCalcProc)(void);

class BenchmarkFramework {
private:
  TVec* fSrc;
  TVec* fDst;
  std::vector<double> fSrca, fDsta;
  std::vector<TCplx> fSrcac, fDstac;
  int fIterationCount;
  int fVectorLength;

  std::vector<TFuncInfo> fFuncs;
  unsigned fFuncCount;
  TFuncInfo fSelectedFunc;

  void InitFuncs();
  void AddFunc (const AnsiString& func_name, double smpl_val, const TCplx& cplx_val,
				TDbleFunc const smpl_func, TCplxFunc const cplx_func, TVecMethod const vec_method);
  int GetFuncCount();
  AnsiString GetFuncName(int idx);
  int FindFuncByName (const AnsiString& func_name);
  void InitSmplVecs (double val);
  void InitCplxVecs (const TCplx& cval);

  void __fastcall CalcVector();
  void __fastcall CalcSample();
  void __fastcall CalcComplex();

  int DoUnderTimer (TCalcProc calc_proc);

public:
  BenchmarkFramework();
  virtual ~BenchmarkFramework();

  int RecalcIterationCount();

  void Run (const AnsiString& func_name, TBenchmarkResults* results);

  __property int VectorLength = { read = fVectorLength, write = fVectorLength };
  __property int IterationCount = { read = fIterationCount, write = fIterationCount };

  __property int FuncCount = { read = GetFuncCount };
  __property AnsiString FuncName[int idx] = { read = GetFuncName };
};

//---------------------------------------------------------------------------
#endif
