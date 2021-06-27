// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'BenchmarkResults.pas' rev: 6.00

#ifndef BenchmarkResultsHPP
#define BenchmarkResultsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Benchmarkresults
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBenchmarkItem;
class PASCALIMPLEMENTATION TBenchmarkItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int fIterationCount;
	int fSmplVecTicks;
	int fCplxFuncTicks;
	int fVecLen;
	int fSmplFuncTicks;
	int fCplxVecTicks;
	AnsiString fFuncName;
	
protected:
	virtual void __fastcall AssignTo(Classes::TPersistent* dest);
	
__published:
	__property AnsiString FuncName = {read=fFuncName, write=fFuncName};
	__property int VecLen = {read=fVecLen, write=fVecLen, nodefault};
	__property int IterationCount = {read=fIterationCount, write=fIterationCount, nodefault};
	__property int SmplVecTicks = {read=fSmplVecTicks, write=fSmplVecTicks, nodefault};
	__property int CplxVecTicks = {read=fCplxVecTicks, write=fCplxVecTicks, nodefault};
	__property int SmplFuncTicks = {read=fSmplFuncTicks, write=fSmplFuncTicks, nodefault};
	__property int CplxFuncTicks = {read=fCplxFuncTicks, write=fCplxFuncTicks, nodefault};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TBenchmarkItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TBenchmarkItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TBenchmarkResults;
class PASCALIMPLEMENTATION TBenchmarkResults : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
public:
	TBenchmarkItem* operator[](int idx) { return Items[idx]; }
	
private:
	Classes::TCollection* fList;
	AnsiString fTitle;
	TBenchmarkItem* __fastcall GetItems(int idx);
	void __fastcall SetItems(int idx, const TBenchmarkItem* Value);
	void __fastcall SetList(const Classes::TCollection* Value);
	int __fastcall GetCount(void);
	
protected:
	virtual void __fastcall AssignTo(Classes::TPersistent* dest);
	
public:
	__fastcall TBenchmarkResults(void);
	__fastcall virtual ~TBenchmarkResults(void);
	void __fastcall Clear(void);
	TBenchmarkItem* __fastcall Add(const AnsiString func_name, int vec_len, int iteration_count, int smpl_vec_ticks, int cplx_vec_ticks, int smpl_func_ticks, int cplx_func_ticks);
	void __fastcall SaveToFile(const AnsiString file_name);
	void __fastcall LoadFromFile(const AnsiString file_name);
	__property TBenchmarkItem* Items[int idx] = {read=GetItems, write=SetItems/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	
__published:
	__property AnsiString Title = {read=fTitle, write=fTitle};
	__property Classes::TCollection* List = {read=fList, write=SetList};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Benchmarkresults */
using namespace Benchmarkresults;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// BenchmarkResults
