//---------------------------------------------------------------------------
#pragma hdrstop

#include "BenchmarkResults.h"
#include "PersistentStreamer.h"

//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

/* TBenchmarkItem */

void __fastcall TBenchmarkItem::AssignTo (TPersistent* dest)
{
  TBenchmarkItem* item = dynamic_cast<TBenchmarkItem*>(dest);

  if (item != NULL) {
    item->FuncName = fFuncName;
    item->VecLen = fVecLen;
    item->IterationCount = fIterationCount;
    item->SmplVecTicks = fSmplVecTicks;
    item->CplxVecTicks = fCplxVecTicks;
    item->SmplFuncTicks = fSmplFuncTicks;
    item->CplxFuncTicks = fCplxFuncTicks;
  } else
    TCollectionItem::AssignTo (dest);
}
//---------------------------------------------------------------------------

/* TBenchmarkResults */

TBenchmarkResults::TBenchmarkResults()
{
  fList = new TCollection (__classid(TBenchmarkItem));
}
//---------------------------------------------------------------------------

__fastcall TBenchmarkResults::~TBenchmarkResults()
{
  delete fList;
}
//---------------------------------------------------------------------------

void TBenchmarkResults::Clear()
{
  fTitle = "";
  fList->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkResults::AssignTo (TPersistent* dest)
{
  TBenchmarkResults* item = dynamic_cast<TBenchmarkResults*>(dest);
  if (item != NULL) {
    item->Title = fTitle;
    item->List = fList;
  } else
    TPersistent::AssignTo (dest);
}
//---------------------------------------------------------------------------

TBenchmarkItem* TBenchmarkResults::Add (const AnsiString& func_name, int vec_len, int iteration_count,
                                        int smpl_vec_ticks, int cplx_vec_ticks, int smpl_func_ticks, int cplx_func_ticks)
{
  TBenchmarkItem* result;

  result = dynamic_cast<TBenchmarkItem*>(fList->Add());
  result->FuncName = func_name;
  result->VecLen = vec_len;
  result->IterationCount = iteration_count;
  result->SmplVecTicks = smpl_vec_ticks;
  result->CplxVecTicks = cplx_vec_ticks;
  result->SmplFuncTicks = smpl_func_ticks;
  result->CplxFuncTicks = cplx_func_ticks;

  return result;
}
//---------------------------------------------------------------------------

int TBenchmarkResults::GetCount()
{
  return fList->Count;
}
//---------------------------------------------------------------------------

TBenchmarkItem* TBenchmarkResults::GetItems(int idx)
{
  return dynamic_cast<TBenchmarkItem*>(fList->Items[idx]);
}
//---------------------------------------------------------------------------

void TBenchmarkResults::LoadFromFile (const AnsiString& file_name)
{
  Clear();
  LoadPersistentFromFile (*this, file_name.c_str());
}
//---------------------------------------------------------------------------

void TBenchmarkResults::SaveToFile (const AnsiString& file_name)
{
  SavePersistentToFile (*this, file_name, sofText);
}
//---------------------------------------------------------------------------

void TBenchmarkResults::SetItems(int idx, TBenchmarkItem* Value)
{
  fList->Items[idx]->Assign(Value);
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkResults::SetList(TCollection* Value)
{
  fList->Assign(Value);
}
//---------------------------------------------------------------------------

