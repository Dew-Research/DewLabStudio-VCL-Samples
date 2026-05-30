//---------------------------------------------------------------------------
#ifndef BenchmarkResultsH
#define BenchmarkResultsH
//---------------------------------------------------------------------------

#include <Classes.hpp>

//---------------------------------------------------------------------------

class TBenchmarkItem: public TCollectionItem
{
private:
  int fIterationCount;
  double fSmplVecTicks;
  double fCplxFuncTicks;
  int fVecLen;
  double fSmplFuncTicks;
  double fSmplRtlFuncTicks;
  double fCplxVecTicks;
  AnsiString fFuncName;
protected:
  void __fastcall AssignTo (TPersistent* dest);
__published:
  __property AnsiString FuncName = {read = fFuncName, write = fFuncName};
  __property int VecLen = {read = fVecLen, write = fVecLen};
  __property int IterationCount = {read = fIterationCount, write = fIterationCount};
  __property double SmplVecTicks = {read = fSmplVecTicks, write = fSmplVecTicks};
  __property double CplxVecTicks = {read = fCplxVecTicks, write = fCplxVecTicks};
  __property double SmplFuncTicks = {read = fSmplFuncTicks, write = fSmplFuncTicks};
  __property double SmplRtlFuncTicks = {read = fSmplRtlFuncTicks, write = fSmplRtlFuncTicks};
  __property double CplxFuncTicks = {read = fCplxFuncTicks, write = fCplxFuncTicks};
}; // TBenchmarkItem


class TBenchmarkResults : public TPersistent
{
private:
  TCollection* fList;
  AnsiString fTitle;

  TBenchmarkItem* GetItems(int idx);
  void SetItems(int idx, TBenchmarkItem* Value);
  void __fastcall SetList(TCollection* Value);
  int GetCount();

protected:
  void __fastcall AssignTo (TPersistent* dest);

public:
  TBenchmarkResults();
  __fastcall ~TBenchmarkResults();

  void Clear();
  TBenchmarkItem* Add (const AnsiString& func_name, int vec_len, int iteration_count,
                       double smpl_vec_ticks, double cplx_vec_ticks, double smpl_func_ticks,
                       double smpl_rtl_func_ticks, double cplx_func_ticks);

  void SaveToFile (const AnsiString& file_name);
  void LoadFromFile (const AnsiString& file_name);

  __property TBenchmarkItem* Items[int idx] = { read = GetItems, write = SetItems };
  __property int Count = { read = GetCount };

__published:
  __property AnsiString Title = { read = fTitle, write = fTitle };
  __property TCollection* List = { read = fList, write = SetList };
}; // TBenchmarkResults

//---------------------------------------------------------------------------
#endif
