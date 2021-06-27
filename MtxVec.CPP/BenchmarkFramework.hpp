// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'BenchmarkFramework.pas' rev: 6.00

#ifndef BenchmarkFrameworkHPP
#define BenchmarkFrameworkHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <BenchmarkResults.hpp>	// Pascal unit
#include <MtxVec.hpp>	// Pascal unit
#include <AbstractMtxVec.hpp>	// Pascal unit
#include <Math387.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Benchmarkframework
{
//-- type declarations -------------------------------------------------------
typedef Abstractmtxvec::TMtxVec* __fastcall (__closure *TVecMethod)(Abstractmtxvec::TMtxVec* src);

typedef double __fastcall (*TSmplFunc)(double x);

typedef Math387::TCplx __fastcall (*TCplxFunc)(const Math387::TCplx &x);

struct TFuncInfo
{
	AnsiString func_name;
	TSmplFunc smpl_func;
	TCplxFunc cplx_func;
	TVecMethod vec_method;
	double smpl_val;
	Math387::TCplx cplx_val;
} ;

typedef void __fastcall (__closure *TCalcProc)(void);

typedef DynamicArray<TFuncInfo >  BenchmarkFramework__2;

class DELPHICLASS TBenchmarkFramework;
class PASCALIMPLEMENTATION TBenchmarkFramework : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Mtxvec::TVec* fSrc;
	Mtxvec::TVec* fDst;
	DynamicArray<double >  fSrca;
	DynamicArray<double >  fDsta;
	DynamicArray<Math387::TCplx >  fSrcac;
	DynamicArray<Math387::TCplx >  fDstac;
	int fIterationCount;
	int fVectorLength;
	DynamicArray<TFuncInfo >  fFuncs;
	int fFuncCount;
	TFuncInfo fSelectedFunc;
	void __fastcall InitFuncs(void);
	int __fastcall GetFuncCount(void);
	AnsiString __fastcall GetFuncName(int idx);
	int __fastcall FindFuncByName(const AnsiString func_name);
	void __fastcall InitSmplVecs(double val);
	void __fastcall InitCplxVecs(const Math387::TCplx &cval);
	void __fastcall CalcVector(void);
	void __fastcall CalcSample(void);
	void __fastcall CalcComplex(void);
	int __fastcall DoUnderTimer(TCalcProc calc_proc);
	
public:
	__fastcall TBenchmarkFramework(void);
	__fastcall virtual ~TBenchmarkFramework(void);
	int __fastcall RecalcIterationCount(void);
	void __fastcall Run(const AnsiString func_name, Benchmarkresults::TBenchmarkResults* &results);
	__property int VectorLength = {read=fVectorLength, write=fVectorLength, nodefault};
	__property int IterationCount = {read=fIterationCount, write=fIterationCount, nodefault};
	__property int FuncCount = {read=GetFuncCount, nodefault};
	__property AnsiString FuncName[int idx] = {read=GetFuncName};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Benchmarkframework */
using namespace Benchmarkframework;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// BenchmarkFramework
