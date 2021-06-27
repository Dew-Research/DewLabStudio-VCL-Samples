//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ProgDialog.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma link "MtxBaseComp"
#pragma link "MtxComCtrls"
#pragma link "MtxDialogs"
#pragma resource "*.dfm"
TfrmProgDialog *frmProgDialog;
//---------------------------------------------------------------------------
__fastcall TfrmProgDialog::TfrmProgDialog(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  str  =  "MtxVec 1.5 introduces new TMtxProgressDialog control. ";
  str +=  "The TMtxProgressDialog component greatly simplifies ";
  str +=  "the threading of numerical algorithms and offers ";
  str +=  "built-in support to cancel the execution of algorithms ";
  str +=  "running in it's thread, provide information about the ";
  str +=  "progress of the executing numerical algorithm and even ";
  str +=  "display progress dialog showing progress indications ";
  str +=  "updated with user defined update frequency. Component ";
  str +=  "design does not use the Synchronize procedure to update ";
  str +=  "progress indicators and makes the most out of the ";
  str +=  "available CPU power.";
  RichEdit1->Lines->Add(str);

  ThreadBox->ItemIndex = 3;
  MtxThread->DefineLoop(0,1500);
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
void __fastcall TfrmProgDialog::WhileLoopInProcedure(int &Counter, bool &Cancel)
{
  while (!(MtxThread->Max == Counter))
  {
    if (Cancel) break;
    C->Mul(A,B,opNone,opNone);
    Counter ++;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmProgDialog::ShowFormBoxClick(TObject *Sender)
{
  MtxThread->ShowDialog = ShowFormBox->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::LoopTypeGroupClick(TObject *Sender)
{
  switch (LoopTypeGroup->ItemIndex)
  {
    case 0 : MtxThread->InfiniteLoop = false; break;
    case 1 : MtxThread->InfiniteLoop = true; break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::MtxThreadCompute(TObject *Sender)
{
  switch(IteratorGroup->ItemIndex)
  {
    case 0: C->Mul(A,A,opNone,opNone);  break;//Internal loop
    case 1: for (int i = MtxThread->Min; i<MtxThread->Max; i++)
           {
             //external loop,
             MtxThread->Counter = i;
             if (MtxThread->Cancel) break;
             //
             C->Mul(A,B,opNone,opNone);
           } break;
    case 2: WhileLoopInProcedure(MtxThread->Counter,MtxThread->Cancel);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::IteratorGroupClick(TObject *Sender)
{
  switch (IteratorGroup->ItemIndex)
  {
    case 0:  MtxThread->InternalLoop = true; break;
	case 1:  MtxThread->InternalLoop = false; break;
	case 2:  MtxThread->InternalLoop = false; break;
  }
}
//---------------------------------------------------------------------------


void __fastcall TfrmProgDialog::MinEditChange(TObject *Sender)
{
  MtxThread->Min = StrToInt(MinEdit->Value);
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::MaxEditChange(TObject *Sender)
{
  MtxThread->Max = StrToInt(MaxEdit->Value);
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::UpdateIntervalEditChange(TObject *Sender)
{
  MtxThread->UpdateInterval = StrToInt(UpdateIntervalEdit->Value);
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::ThreadBoxChange(TObject *Sender)
{
  MtxThread->ThreadPriority  = static_cast<TThreadPriority>(ThreadBox->ItemIndex);
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::StartButtonClick(TObject *Sender)
{
  MtxThread->Start();
  /*
   Sequence of calls:
   1. Calls  MtxThread OnProgressUpdate event with peInit
   2. Calls  OnCompute once or more times depending of InternalLoop
   3. Calls  MtxThread OnProgressUpdate event with peCycle in
      regular intervals to advance progress indicators.
   4. Calls MtxThread OnProgressUpdate event with peCleanUp to
      continue with the further processing of the processed data,
      once the the thread has finished.
  */                               
}
//---------------------------------------------------------------------------


void __fastcall TfrmProgDialog::StopButtonClick(TObject *Sender)
{
  MtxThread->Cancel = true;
}
//---------------------------------------------------------------------------

void __fastcall TfrmProgDialog::MtxThreadProgressUpdate(TObject *Sender,
      TMtxProgressEvent Event)
{
  if (Event == peInit)
  {
    MtxThread->DefineProgressBar(ProgressBar);
	A = new Mtxvec::TMatrix;
	B = new Mtxvec::TMatrix;
    C = new Mtxvec::TMatrix;

    A->Size(100,100,false);
    A->RandGauss();
    B->Copy(A);
  }
  else if (Event == peCycle)
  {
    ProgressBar->Position = MtxThread->Counter;
    ProgressLabel->Caption = "Progress indicator: " + FormatFloat("0 %",MtxThread->Counter/(double)MtxThread->Max*100.0);
  }
  else // Cleanup
  {
    if (!MtxThread->Cancel)
    {
      ProgressBar->Position = MtxThread->Max;
      ProgressLabel->Caption = "Progress indicator: " + FormatFloat("0.00",100);
    }
    delete A;
    delete B;
    delete C;
  }
}
//---------------------------------------------------------------------------

