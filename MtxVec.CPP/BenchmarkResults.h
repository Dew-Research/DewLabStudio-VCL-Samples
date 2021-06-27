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
  int fSmplVecTicks;
  int fCplxFuncTicks;
  int fVecLen;
  int fSmplFuncTicks;
  int fCplxVecTicks;
  AnsiString fFuncName;
protected:
  void __fastcall AssignTo (TPersistent* dest);
__published:
  __property AnsiString FuncName = {read = fFuncName, write = fFuncName};
  __property int VecLen = {read = fVecLen, write = fVecLen};
  __property int IterationCount = {read = fIterationCount, write = fIterationCount};
  __property int SmplVecTicks = {read = fSmplVecTicks, write = fSmplVecTicks};
  __property int CplxVecTicks = {read = fCplxVecTicks, write = fCplxVecTicks};
  __property int SmplFuncTicks = {read = fSmplFuncTicks, write = fSmplFuncTicks};
  __property int CplxFuncTicks = {read = fCplxFuncTicks, write = fCplxFuncTicks};
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
                       int smpl_vec_ticks, int cplx_vec_ticks, int smpl_func_ticks, int cplx_func_ticks);

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
