//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "MtxFastLineDemo.h"
#include "MtxVec.hpp"
#include "MtxVecTee.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic1"
#pragma resource "*.dfm"
TMtxFastLineForm *MtxFastLineForm;
//---------------------------------------------------------------------------
__fastcall TMtxFastLineForm::TMtxFastLineForm(TComponent* Owner)
  : TBasicForm1(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMtxFastLineForm::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add("New TMtxFastLinesSeires draws 3x faster than TFastLineSeries.");
  RichEdit1->Lines->Add("Allows zoom-in and zoom-out with pixeldownsamle enabled.");
  RichEdit1->Lines->Add("TMtxFastLineSeries can be used with all TeeChart versions (v4 Standard, v4 Pro, 5,6,7 and 8).");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Try different data sizes and zooming and panning in the chart.");

  Chart1->FreeAllSeries(NULL);
  normalFast = Chart1->AddSeries(new TFastLineSeries(Chart1));
  normalFast->Title = "TFastlineSeries";

  mtxFast = Chart1->AddSeries(new TMtxFastLineSeries(Chart1));
  mtxFast->Title = "TMTxFastLineSeries";

  MtxFloatEditChange(NULL);
}
//---------------------------------------------------------------------------
void __fastcall TMtxFastLineForm::MtxFloatEditChange(TObject *Sender)
{
  Chart1->Zoom->Allow = true;
  Data.Size(MtxFloatEdit->IntPosition);
  Data.RandGauss(4.0, 1.0);

  Screen->Cursor = crHourGlass;
  TimeCheck = GetTickCount();
  try {
    DrawValues(Data, mtxFast, 0, 1, false);
  }
  __finally {
    TimeElapsed = GetTickCount() - TimeCheck;
    Screen->Cursor = crDefault;
  }

  Screen->Cursor = crHourGlass;
  TimeCheck = GetTickCount();
  try {
    DrawValues(Data, normalFast, 0, 1, CheckDownSample->Checked);
  }
  __finally {
    TimeElapsed = GetTickCount() - TimeCheck;
    Screen->Cursor = crDefault;
  }
}
//---------------------------------------------------------------------------
