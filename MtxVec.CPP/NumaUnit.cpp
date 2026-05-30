//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "NumaUnit.h"
#include <MtxForLoop.hpp>
#include <AbstractMtxVec.hpp>
#include <MtxVecBase.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TNumaForm *NumaForm;
//---------------------------------------------------------------------------
__fastcall TNumaForm::TNumaForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
static void __fastcall DoThreading(int LoopIndex, const TObjectArray Context, int ThreadIndex)
{
  TNumaForm *aSelf = (TNumaForm*)Context[0];
  sVector a;
  sVector b;
  a.Size(aSelf->aLength);
  double aSum = 0;
  switch (aSelf->ComputeKindGroup->ItemIndex)
  {
    case 0:
      for (int i = 0; i < aSelf->Count; i++) b.Copy(a);
      break;
    case 1:
      for (int i = 0; i < aSelf->Count; i++) aSum = a.Sum();
      break;
  }
  a[0] = aSum;
}
//---------------------------------------------------------------------------
void __fastcall TNumaForm::RunButtonClick(TObject *Sender)
{
  if (mtxThreadPool == NULL) mtxThreadPool = new TMtxForLoop();
  mtxThreadPool->ThreadCount = Controller->CpuCores;
  Memo1->Lines->Clear();

  Math387::TDoubleArray aTime;
  Math387::aSetLength(aTime, mtxThreadPool->ThreadCount);
  Series1->Clear();

  double Factor = 0;
  switch (ComputeKindGroup->ItemIndex)
  {
    case 0: Factor = 2; break;
    case 1: Factor = 1; break;
  }

  Count = StrToInt(CountEdit->Text);
  switch (MemoryGroup->ItemIndex)
  {
    case 0: aLength = 1000; Count = 10 * 1000 * 1000; break;
    case 1: aLength = 64 * 1000; Count = 4 * 1000; break;
    case 2: aLength = 10 * 1000 * 1000; Count = 7; break;
  }

  Memo1->Lines->Add("Memory block size: " +
                    IntToStr((int)(aLength * sizeof(double) / (1024 * 1024))) + "MB");

  for (int k = 1; k <= aTime.Length; k++)
  {
    int channelCount = k;
    StartTimer();
    DoForLoop(0, channelCount - 1, (Mtxforloop::TForLoopFunEvent)DoThreading, mtxThreadPool,
              OPENARRAY(TObject*, (this)));
    aTime[k - 1] = StopTimer();
    Memo1->Lines->Add("Time (Thread count = " + IntToStr(k) + "): " +
                      FormatSample("0.00s", aTime[k - 1]));
    double aBandwidth = (double)aLength * sizeof(double) * Count * channelCount * Factor /
                        (aTime[k - 1] * (1024.0 * 1024.0 * 1024.0));
    Memo1->Lines->Add("Bandwidth (Thread count = " + IntToStr(k) + "): " +
                      FormatSample("0.0GB/s", aBandwidth));
    Series1->Add(aBandwidth, IntToStr(k));
  }
}
//---------------------------------------------------------------------------
void __fastcall TNumaForm::FormCreate(TObject *Sender)
{
  Memo->Lines->Add(
    "When data blocks are too big to make them fit in to CPU cache and block processesing cant be applied, "
    "then the performance depends upon the raw main memory bandwidth. Main memory bandwidth is defined "
    "with its data rate per memory channel and with memory channel count. A single thread can use at "
    "most a single main memory channel. For an application to use more than one memory channel, it "
    "needs to distribute the processing across multiple threads. "
    "At a minimum, the thread count needs to match memory channel count. For a two socket system with 6 memory channels "
    "per CPU, the memory bandwidth will come to be fully used only with 2x6 = 12 threads. "
    "About 30% more performance can sometimes be gained by allocating two threads per memory channel to work "
    "over any inefficencies in data prefetching. Typical desktop computers today have two memory channels with "
    "typical memory bandwidth per channel around 15GB/s. Recommendations for multi-socket HPC machines (servers): "
    "1.) Always allocate working memory from within the thread, which will use that memory. That "
    "will make it much easier for the OS to keep that memory on the same NUMA node as the thread. "
    "2.) Install more memory per NUMA node than what will be needed to avoid memory being swapped out "
    "to disk or moved to another NUMA node.");
}
//---------------------------------------------------------------------------
void __fastcall TNumaForm::FormDestroy(TObject *Sender)
{
  if (mtxThreadPool != NULL)
  {
    delete mtxThreadPool;
    mtxThreadPool = NULL;
  }
}
//---------------------------------------------------------------------------
