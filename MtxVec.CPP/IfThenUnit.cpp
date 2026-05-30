//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "IfThenUnit.h"
#include <MtxVecBase.hpp>
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIfThenForm *IfThenForm;
//---------------------------------------------------------------------------
struct TThreadStats
{
  double TotalTime;
  int PoolIndex;
  int aCI;
  int bCI;
  int agCI;
  int bgCI;
  int aiCI;
  int cCI;
  int TotalLength;
  int BlockLength;
};

static const double DPOS_FRAC = 0.5;
static const float  SPOS_FRAC = 0.5f;
static DynamicArray<TThreadStats> stats;
//---------------------------------------------------------------------------
__fastcall TIfThenForm::TIfThenForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
static void DoAssign(int &Dst, int Src)
{
  if (Dst == -2) Dst = Src;
}
//---------------------------------------------------------------------------
static void __fastcall ForLoopR(int IdxMin, int IdxMax, const TObjectArray Context, int ThreadIndex)
{
  __int64 aTimer;
  StartTimer(aTimer);

  TVec *a, *b, *ag, *bg, *c, *c2;
  TVecInt *ai;
  CreateIt(a);
  CreateIt(b);
  CreateIt(ag);
  CreateIt(bg);
  CreateIt(c);
  CreateIt(c2);
  CreateIt(ai);
  try
  {
    ag->SetSubRange((TVec*)Context[0], IdxMin, IdxMax - IdxMin + 1);
    bg->SetSubRange((TVec*)Context[1], IdxMin, IdxMax - IdxMin + 1);

    a->BlockInit(ag);
    b->BlockInit(bg);

    stats[ThreadIndex].BlockLength = a->Length;

    while (!a->BlockEnd)
    {
      Abstractmtxvec::FindMask(ai, a, cmpGT_EQ, DPOS_FRAC);
      c2->GatherByMask(b, ai);
      c->AddAndMul(c2, 1, 2);
      b->ScatterByMask(c, ai);

      a->BlockNext();
      b->BlockNext();
    }

    DoAssign(stats[ThreadIndex].PoolIndex, ag->PoolIndex);
    DoAssign(stats[ThreadIndex].TotalLength, ag->Length);
    DoAssign(stats[ThreadIndex].aCI, a->CacheIndex);
    DoAssign(stats[ThreadIndex].bCI, b->CacheIndex);
    DoAssign(stats[ThreadIndex].cCI, c->CacheIndex);
    DoAssign(stats[ThreadIndex].agCI, ag->CacheIndex);
    DoAssign(stats[ThreadIndex].bgCI, bg->CacheIndex);
    DoAssign(stats[ThreadIndex].aiCI, ai->CacheIndex);
  }
  __finally
  {
    FreeIt(a);
    FreeIt(b);
    FreeIt(ag);
    FreeIt(bg);
    FreeIt(c);
    FreeIt(c2);
    FreeIt(ai);
  }

  stats[ThreadIndex].TotalTime = StopTimer(aTimer);
}
//---------------------------------------------------------------------------
static void __fastcall ForLoopRI(int IdxMin, int IdxMax, const TObjectArray Context, int ThreadIndex)
{
  TVec *a = (TVec*)Context[0];
  TVec *b = (TVec*)Context[1];

  if (a->IsDouble)
  {
    for (int i = IdxMin; i <= IdxMax; i++)
      if (a->Values[i] >= DPOS_FRAC) b->Values[i] = (b->Values[i] + 1.0) * 2.0;
  }
  else
  {
    for (int i = IdxMin; i <= IdxMax; i++)
      if (a->SValues[i] >= SPOS_FRAC) b->SValues[i] = (b->SValues[i] + 1) * 2;
  }
}
//---------------------------------------------------------------------------
void __fastcall TIfThenForm::MaskThreadButtonClick(TObject *Sender)
{
  stats.Length = mtxThreadPool->ThreadCount;
  for (int i = 0; i < stats.Length; i++)
  {
    stats[i].TotalTime = -2;
    stats[i].PoolIndex = -2;
    stats[i].TotalLength = -2;
    stats[i].BlockLength = -2;
    stats[i].aCI = -2;
    stats[i].bCI = -2;
    stats[i].cCI = -2;
    stats[i].agCI = -2;
    stats[i].bgCI = -2;
    stats[i].aiCI = -2;
  }

  barSeries->Clear();
  Math387::TDoubleArray ar;
  Math387::aSetLength(ar, 6);

  int DataLen = 100000 * Math387::RoundToInt(Exp10((double)DataLenBox->ItemIndex));

  sVector a, b1, b2, c, c2;
  sVectorInt ai;

  a.Size(DataLen);
  a.RandUniform(0, 1);
  b1.Size(a);
  b1.SetVal(1);
  b2.Copy(b1);

  StartTimer();
  for (int i = 0; i < a.Length; i++)
    if (a[i] >= DPOS_FRAC) b1[i] = (b1[i] + 1) * 2;
  ar[0] = Math387::RoundToInt(StopTimer() * 1000);

  if (PlainBox->Checked)
    barSeries->Add(ar[0], "Plain");

  if (VecBox->Checked)
  {
    StartTimer();
	Abstractmtxvec::FindMask(ai, a, cmpGT_EQ, DPOS_FRAC);
	c2.GatherByMask(b2, ai);
    c.AddAndMul(c2, 1, 2);
	b2.ScatterByMask(c, ai);
    ar[1] = StopTimer() * 1000;
	barSeries->Add(ar[1], UnicodeString(TeeLineSeparator) + "Vectorized");

    if (!b1.IsEqual(b2, 0.001)) ERaise("Not equal");
    b2.SetVal(1);
  }

  if (FindIndexBlockBox->Checked)
  {
    StartTimer();
    a.BlockInit();
    b2.BlockInit();
    while (!a.BlockEnd)
	{
      Mtxvec::FindIndexes(ai, a, ">=", DPOS_FRAC);
      c2.GatherByIndex(b2, ai);
      c.AddAndMul(c2, 1, 2);
      b2.ScatterByIndexes(c, ai);
      a.BlockNext();
      b2.BlockNext();
    }
    b2.SetFullRange();
    ai.SetFullRange();
    ar[2] = StopTimer() * 1000;
    barSeries->Add(ar[2], "Vectorized with bp (FindIndexes)");

    if (!b1.IsEqual(b2, 0.001)) ERaise("Not equal");
    b2.SetVal(1);
  }

  if (MaskBlockBox->Checked)
  {
    StartTimer();
    a.BlockInit();
    b2.BlockInit();
    while (!a.BlockEnd)
    {
      Abstractmtxvec::FindMask(ai, a, cmpGT_EQ, DPOS_FRAC);
      c2.GatherByMask(b2, ai);
      c.AddAndMul(c2, 1, 2);
      b2.ScatterByMask(c, ai);
      a.BlockNext();
      b2.BlockNext();
    }
    b2.SetFullRange();
    ar[3] = StopTimer() * 1000;
    barSeries->Add(ar[3], UnicodeString(TeeLineSeparator) + "Vectorized with bp (FindMask)");

    if (!b1.IsEqual(b2, 0.001)) ERaise("Not equal");
    b2.SetVal(1);
  }

  if (mtxThreadPool == NULL) mtxThreadPool = new TMtxForLoop();
  mtxThreadPool->BlockGranularity = Math387::RoundToInt(Exp2((double)GranBox->ItemIndex));

  if (MaskBlockThreadBox->Checked)
  {
    StartTimer();
    DoForLoop(0, a.Length - 1, (Mtxforloop::TForLoopRangeFunEvent)ForLoopR, mtxThreadPool,
              OPENARRAY(TObject*, (a, b2)));
    ar[4] = StopTimer() * 1000;
    barSeries->Add(ar[4], "Vectorized, bp and threaded");

    if (!b1.IsEqual(b2, 0.001)) ERaise("Not equal");
    b2.SetVal(1);
  }

  if (PlainThreadBox->Checked)
  {
    StartTimer();
    DoForLoop(0, a.Length - 1, (Mtxforloop::TForLoopRangeFunEvent)ForLoopRI, mtxThreadPool,
              OPENARRAY(TObject*, (a, b2)));
    ar[5] = StopTimer() * 1000;
    barSeries->Add(ar[5], UnicodeString(TeeLineSeparator) + "Plain and threaded");

    if (!b1.IsEqual(b2, 0.001)) ERaise("Not equal");
  }

  Memo1->Clear();
  Memo1->Lines->Add("ThrdIdx\tTime\tPool\tLength\t\tbLength\ta_cIdx\tb_cIdx\tc_cIdx\tag_cIdx\tbg_cIdx\tai_cIdx");
  for (int i = 0; i < stats.Length; i++)
  {
    Memo1->Lines->Add(IntToStr(i) + "\t" +
                      FormatSample("0.00ms", stats[i].TotalTime * 1000) + "\t" +
                      IntToStr(stats[i].PoolIndex) + "\t" +
                      IntToStr(stats[i].TotalLength) + "\t\t" +
                      IntToStr(stats[i].BlockLength) + "\t" +
                      IntToStr(stats[i].agCI) + "\t" +
                      IntToStr(stats[i].bgCI) + "\t" +
                      IntToStr(stats[i].aCI) + "\t" +
                      IntToStr(stats[i].bCI) + "\t" +
                      IntToStr(stats[i].cCI) + "\t" +
                      IntToStr(stats[i].aiCI));
  }
}
//---------------------------------------------------------------------------
void __fastcall TIfThenForm::FormCreate(TObject *Sender)
{
  if (mtxThreadPool == NULL) mtxThreadPool = new TMtxForLoop();
  mtxThreadPool->ThreadCount = Controller->CpuCores;
  Controller->ThreadDimension = mtxThreadPool->ThreadCount + 1;

  Memo1->Lines->Clear();
  Memo1->Lines->Add("Efficient if-then vectorization is possible with the use of masks. Using sparse indexes does not allow for vectorization."
                    "The example below handles memory block much larger than CPU cache and applies:");
  Memo1->Lines->Add("");
  Memo1->Lines->Add("if a[i] >= 0.5 then b[i] := (b[i] + 1)*2;");
  Memo1->Lines->Add("");
  Memo1->Lines->Add("The different cases start with Delphi and end with multithreaded vectorized code. The performance of multi-threaded "
                    "variants depends heavily on active CPU memory channel count (typically 1, 2 or 4).");
  Memo1->Lines->Add("The example demonstrates two features: ability to vectorize if-then and ability to thread code, which takes less than 20ms to execute.");

  DataLenBox->ItemIndex = 2;
}
//---------------------------------------------------------------------------
void __fastcall TIfThenForm::FormDestroy(TObject *Sender)
{
  if (mtxThreadPool != NULL)
  {
    delete mtxThreadPool;
    mtxThreadPool = NULL;
  }
}
//---------------------------------------------------------------------------
