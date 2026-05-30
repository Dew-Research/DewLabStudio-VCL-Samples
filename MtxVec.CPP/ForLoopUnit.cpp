//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ForLoopUnit.h"
#include <MtxVecTee.hpp>
#include <MtxExpr.hpp>
#include <MtxForLoop.hpp>
#include <Math387.hpp>
#include <AbstractMtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TForLoopForm *ForLoopForm;
//---------------------------------------------------------------------------
static Matrix B1;
static TMtxForLoop *forLoop = NULL;
//---------------------------------------------------------------------------
__fastcall TForLoopForm::TForLoopForm(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForLoopForm::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Add(
    "Threading a for or while loop can be very easy with MtxVec components. "
    "Press the button to see the code execute and then examine the source code by "
    "clicking the tab at the bottom of the form. The code automaticaly detects core count "
    "and executes at maximum speed. Code example also shows how to monitor the progress of execution.");

  B1 = Matrix(0, 0);
  forLoop = new TMtxForLoop();
}
//---------------------------------------------------------------------------
void __fastcall TForLoopForm::FormDestroy(TObject *Sender)
{
  delete forLoop;
  forLoop = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TForLoopForm::TimerTimer(TObject *Sender)
{
  if (forLoop != NULL)
    Label1->Caption = "Loop running time: " + FormatSample(forLoop->LoopRunningTime(), "0.0") + "ms";
}
//---------------------------------------------------------------------------
void __fastcall TForLoopForm::Button1Click(TObject *Sender)
{
  if (!forLoop->IsProcessingFinished()) return;

  if (ThreadedBox->Checked) forLoop->ThreadCount = Controller->CpuCores;
  else forLoop->ThreadCount = 1;

  TThread *aThread = new TForLoopUnitThread(true);
  aThread->FreeOnTerminate = true;
  aThread->OnTerminate = OnComputationEnded;
  aThread->Suspended = false;
}
//---------------------------------------------------------------------------
void __fastcall TForLoopForm::OnComputationEnded(TObject *Sender)
{
  ViewValues(B1);
  if (forLoop->HasRaisedErrors())
    ShowMessage("Exceptions raised within threads: " + forLoop->ErrorMessages());
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------
static void __fastcall MyLoop(int LoopIndex, const TObjectArray Context, int ThreadIndex)
{
  TMtx *a = (TMtx*)Context[0];
  for (int k = 0; k < 1000; k++)
  {
    for (int j = 0; j < a->Cols; j++)
    {
      a->Values[LoopIndex][j] = a->Values[LoopIndex][j] + 1;
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TForLoopUnitThread::Execute()
{
  Matrix am;
  am.Size(1001, 100);
  am.SetVal(1);

  DoForLoop(0, 1000, (Mtxforloop::TForLoopFunEvent)MyLoop, forLoop,
            OPENARRAY(TObject*, (am)));

  B1.Copy(am);
}
//---------------------------------------------------------------------------
