//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "SuperConductive.h"
#include <stdlib.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TSuperConductiveForm *SuperConductiveForm;
//---------------------------------------------------------------------------
__fastcall TSuperConductiveForm::TSuperConductiveForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TSuperConductiveForm::SetTestMethod(TTestMethod Value)
{
  FTestMethod = Value;
}
//---------------------------------------------------------------------------
void __fastcall TSuperConductiveForm::FormCreate(TObject *Sender)
{
  TestBox->ItemIndex = 0;
  cpuCores = Math387::Min(4, Controller->CpuCores);

  Timings.Length = cpuCores;
  for (int t = 0; t < cpuCores; t++)
  {
    Timings[t].Length = TestBox->Items->Count;
    for (int u = 0; u < TestBox->Items->Count; u++)
      Timings[t][u].Length = 3;
  }

  Threads.Length = cpuCores;
  TimedThread.Length = cpuCores;

  for (int i = 0; i < Threads.Length; i++)
  {
    Threads[i] = new TMtxProgressDialog(this);
    Threads[i]->OnCompute = Thread1Compute;
    Threads[i]->OnProgressUpdate = Thread1ProgressUpdate;
    Threads[i]->Loops = Thread1->Loops;
    Threads[i]->Min = Thread1->Min;
    Threads[i]->Max = Thread1->Max;
    Threads[i]->InfiniteLoop = false;
    Threads[i]->InternalLoop = true;
    Threads[i]->ShowDialog = false;
    Threads[i]->UpdateInterval = 80;
    Threads[i]->Tag = i;
  }

  av.Length = cpuCores;
  bv.Length = cpuCores;
  cv.Length = cpuCores;
  dv.Length = cpuCores;
  TimeStart.Length = cpuCores;
}
//---------------------------------------------------------------------------
void __fastcall TSuperConductiveForm::FullRunButtonClick(TObject *Sender)
{
  if (Working) return;
  Working = true;

  bool b = MultithreadBox->Checked;

  TStringList *threadDim = new TStringList();
  try {
    threadDim->Add("Single threaded");
    threadDim->Add("Multi-threaded, standard");
    threadDim->Add("Multi-threaded, super-conductive");

    VectorLen = VectorLenEdit->IntPosition;

    for (int j = 0; j < TestBox->Items->Count; j++)
    {
      TestMethod = (TTestMethod)j;

      for (int i = 0; i < threadDim->Count; i++)
      {
        for (int k = 0; k < av.Length; k++)
        {
          av[k] = dv[k];
          bv[k] = dv[k];
          cv[k] = dv[k];
        }

        Stage = i;
        bool a = true;
        switch (Stage)
        {
          case 0: b = false; break;
          case 1: Controller->SuperConductive = false; b = true; break;
          case 2: Controller->SuperConductive = true; b = true; break;
        }

        ak = 0;
        ac = 0;

        Threads[0]->Loops = 1200000 / VectorLen;
        if (VectorLen > 20)   Threads[0]->Loops *= 6;
        if (VectorLen > 200)  Threads[0]->Loops *= 6;
        if (VectorLen > 2000) Threads[0]->Loops *= 6;

        for (int k = 1; k < Threads.Length; k++) Threads[k]->Loops = Threads[0]->Loops;

        Thread1Label->Caption = "Please wait...";
        Thread2Label->Caption = "Please wait...";
        Thread3Label->Caption = "Please wait...";
        Thread4Label->Caption = "Please wait...";

        if (a) Threads[0]->Start();
        if (b)
          for (int k = 1; k < Threads.Length; k++) Threads[k]->Start();

        for (int k = 0; k < Threads.Length; k++) Threads[k]->WaitToFinish();
      }
    }

    for (int i = 0; i < TestBox->Items->Count; i++)
    {
      TChartSeries *aSeries;
      if (Chart->SeriesCount() <= i)
      {
        aSeries = Chart->AddSeries(__classid(TBarSeries));
        ((TBarSeries*)aSeries)->Marks->Visible = false;
        aSeries->Title = TestBox->Items->Strings[i];
      }
      else
        aSeries = Chart->Series[i];

      aSeries->Clear();
      for (int j = 0; j < 3; j++)
      {
        double aSum = 0;
        for (int k = 0; k < Timings.Length; k++)
          aSum += Timings[k][i][j];
        if (j > 0) aSum /= Timings.Length;
        aSeries->AddY(aSum * 1000, threadDim->Strings[j]);
      }
    }

    Sleep(100);
    Working = false;
  } __finally {
    delete threadDim;
  }
}
//---------------------------------------------------------------------------
void __fastcall TSuperConductiveForm::SingleRunButtonClick(TObject *Sender)
{
  if (Working) return;
  Working = true;

  bool a = true;
  bool b = MultithreadBox->Checked;

  TestMethod = (TTestMethod)TestBox->ItemIndex;
  VectorLen = VectorLenEdit->IntPosition;

  for (int i = 0; i < av.Length; i++)
  {
    av[i] = dv[i];
    bv[i] = dv[i];
    cv[i] = dv[i];
  }

  Controller->SuperConductive = SuperConductiveMMBox->Checked;
  ak = 0;
  ac = 0;

  Threads[0]->Loops = 1200000 / VectorLen;
  if (VectorLen > 20)   Threads[0]->Loops *= 6;
  if (VectorLen > 200)  Threads[0]->Loops *= 6;
  if (VectorLen > 2000) Threads[0]->Loops *= 6;

  for (int i = 1; i < Threads.Length; i++) Threads[i]->Loops = Threads[0]->Loops;

  StartTimer(TimeStart[0]);
  if (a) Threads[0]->Start();

  if (b)
    for (int i = 1; i < Threads.Length; i++)
    {
      StartTimer(TimeStart[i]);
      Threads[i]->Start();
    }

  Thread1Label->Caption = "Please wait...";
  Thread2Label->Caption = "Please wait...";
  Thread3Label->Caption = "Please wait...";
  Thread4Label->Caption = "Please wait...";

  for (int i = 0; i < Threads.Length; i++) Threads[i]->WaitToFinish();

  Working = false;
}
//---------------------------------------------------------------------------
void __fastcall TSuperConductiveForm::Thread1Compute(TObject *Sender)
{
  TMtxProgressDialog *aThread = (TMtxProgressDialog*)Sender;
  int k = aThread->Tag;
  if (aThread->Counter == aThread->Min)
    StartTimer(TimeStart[k]);

  switch (TestMethod)
  {
    case tmGetMem:
    {
      int ByteLen = VectorLen * sizeof(double);
      void *ap = malloc(ByteLen);
      void *bp = malloc(ByteLen);
      void *cp = malloc(ByteLen);
      free(ap);
      free(bp);
      free(cp);
      break;
    }
    case tmTVec:
    {
      TVec *av1, *bv1, *cv1;
      CreateIt(av1);
      CreateIt(bv1);
      CreateIt(cv1);
      av1->Size(VectorLen);
      bv1->Size(VectorLen);
      cv1->Size(VectorLen);
      FreeIt(av1);
      FreeIt(bv1);
      FreeIt(cv1);
      break;
    }
    case tmVector:
    {
      sVector a, b, c;
      a.Size(VectorLen);
      b.Size(VectorLen);
      c.Size(VectorLen);
      a = dv[k];
      b = dv[k];
      c = dv[k];
      break;
    }
    case tmVectorGlobal:
      av[k].Size(VectorLen);
      bv[k].Size(VectorLen);
      cv[k].Size(VectorLen);
      av[k] = dv[k];
      bv[k] = dv[k];
      cv[k] = dv[k];
      break;
  }

  if (aThread->Counter == aThread->Max)
  {
    TimedThread[aThread->Tag] = StopTimer(TimeStart[aThread->Tag]);
    Timings[aThread->Tag][(int)TestMethod][Stage] = TimedThread[aThread->Tag];
  }
}
//---------------------------------------------------------------------------
void __fastcall TSuperConductiveForm::Thread1ProgressUpdate(TObject *Sender, TMtxProgressEvent Event)
{
  TMtxProgressDialog *aThread = (TMtxProgressDialog*)Sender;
  AnsiString strCycle = "Thread " + IntToStr(aThread->Tag) + " counter: " + IntToStr(aThread->Counter);
  AnsiString strCleanUp = "Thread " + IntToStr(aThread->Tag) + " time needed: " +
                          FormatSample(TimedThread[aThread->Tag] * 1000, "0.0") + "ms";
  switch (Event)
  {
    case peInit: break;
    case peCycle:
      switch ((int)aThread->Tag)
      {
        case 0: Label1->Caption = strCycle; break;
        case 1: Label2->Caption = strCycle; break;
        case 2: Label3->Caption = strCycle; break;
        case 3: Label4->Caption = strCycle; break;
      }
      break;
    case peCleanUp:
      switch ((int)aThread->Tag)
      {
        case 0: Thread1Label->Caption = strCleanUp; break;
        case 1: Thread2Label->Caption = strCleanUp; break;
        case 2: Thread3Label->Caption = strCleanUp; break;
        case 3: Thread4Label->Caption = strCleanUp; break;
      }
      break;
  }
}
//---------------------------------------------------------------------------
