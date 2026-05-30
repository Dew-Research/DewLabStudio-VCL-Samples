//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ForLoopExample.h"
#include <MtxVecEdit.hpp>
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForLoopExampleForm *ForLoopExampleForm;
//---------------------------------------------------------------------------
static TMtxForLoop *forLoop = NULL;
//---------------------------------------------------------------------------
__fastcall TForLoopExampleForm::TForLoopExampleForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleForm::FormCreate(TObject *Sender)
{
  forLoop = new TMtxForLoop();
  ForLoopExampleForm = this;
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleForm::FormDestroy(TObject *Sender)
{
  delete forLoop;
  forLoop = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleForm::FormResize(TObject *Sender)
{
  Chart->Height = (ClientHeight - Panel1->Height) / 2;
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleForm::Timer1Timer(TObject *Sender)
{
  if (forLoop != NULL)
    Label1->Caption = "Loop running time: " + FormatSample(forLoop->LoopRunningTime(), "0.0") + "ms";
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleForm::OnComputationEnded2(TObject *Sender)
{
  if (forLoop->HasRaisedErrors())
    ShowMessage("Exceptions raised within threads: " + forLoop->ErrorMessages());

  for (int j = 0; j < TimingResults.Length; j++)
  {
    int Len = 8;
    Chart->Series[j]->Clear();
    for (int i = 0; i < TimingResults[j].Length; i++)
    {
      Chart->Series[j]->AddXY(Len, TimingResults[j][i]);
      Len = 2 * Len;
    }
  }

  Chart1->Series[0]->Clear();
  int Len = 8;
  for (int i = 0; i < TimingResults[0].Length; i++)
  {
    Chart1->Series[0]->AddXY(Len, TimingResults[0][i] / TimingResults[1][i]);
    Len = 2 * Len;
  }

  for (int i = 0; i < Mtxvec::Controller->Pool.Length; i++)
    Controller->Pool[i]->Vec->DebugReport();

  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------
static sVector TestFunction(TVec *xp, TVec *mp, TVec *bp)
{
  sVector x, m, b;
  x.Adopt(xp);
  m.Adopt(mp);
  b.Adopt(bp);
  return 0.5 * (1.0 + Sgn(x - m) * (1.0 - Exp(-Abs(x - m) / b)));
}
//---------------------------------------------------------------------------
static void __fastcall MyLoop3Static(int LoopIndex, const TObjectArray Context, int ThreadIndex)
{
  TVecList *aResult = (TVecList*)Context[3];
  TVec *xp = (TVec*)Context[0];
  int LoopCount = (1024 * 32) / xp->Length;

  sVector c;
  for (int k = 0; k < LoopCount; k++)
  {
    c = TestFunction((TVec*)Context[0], (TVec*)Context[1], (TVec*)Context[2]);
  }
  (*aResult)[LoopIndex]->Copy(c);
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleForm::MyLoop3(int LoopIndex, const TObjectArray Context, int ThreadIndex)
{
  MyLoop3Static(LoopIndex, Context, ThreadIndex);
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleForm::Button2Click(TObject *Sender)
{
  if (!forLoop->IsProcessingFinished()) return;
  Screen->Cursor = crHourGlass;

  if (MultiThreadedBox->Checked) forLoop->ThreadCount = Controller->CpuCores;
  else forLoop->ThreadCount = 1;

  TThread *aThread = new TForLoopExampleThread(true);
  aThread->FreeOnTerminate = true;
  aThread->OnTerminate = OnComputationEnded2;
  aThread->Suspended = false;
}
//---------------------------------------------------------------------------
void __fastcall TForLoopExampleThread::Execute()
{
  int LoopCount = 10;
  ForLoopExampleForm->TimingResults.Length = 2;
  ForLoopExampleForm->TimingResults[0].Length = LoopCount;
  ForLoopExampleForm->TimingResults[1].Length = LoopCount;

  Controller->SuperConductive = false;
  for (int TestIdx = 0; TestIdx < 2; TestIdx++)
  {
    int vecLen = 8;
    for (int i = 0; i < LoopCount; i++)
    {
      sVector x, b, m;
      x.Size(vecLen);
      x.Ramp();
      b.Size(x);
      b.SetVal(1);
      m.Size(x);
      m.Ramp(0.5, 1);

      TVecList *Results = new TVecList(NULL);
      Results->Count = 401;
      DoForLoop(0, 400, (Mtxforloop::TForLoopFunEvent)MyLoop3Static, forLoop,
                OPENARRAY(TObject*, (x, m, b, Results)));
      delete Results;

      ForLoopExampleForm->TimingResults[TestIdx][i] = forLoop->LoopRunningTime();
      vecLen = vecLen * 2;
    }
    Controller->SuperConductive = true;
  }
}
//---------------------------------------------------------------------------
