//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ExprToolTipUnit.h"
#include <DateUtils.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TExprToolTipForm *ExprToolTipForm;
//---------------------------------------------------------------------------
__fastcall TExprToolTipForm::TExprToolTipForm(TComponent* Owner)
  : TForm(Owner), FData(NULL)
{
}
//---------------------------------------------------------------------------
void __fastcall TExprToolTipForm::FormCreate(TObject *Sender)
{
//  FData = new TMtx();
//  MtxVecGrid->Datasource = FData;
}
//---------------------------------------------------------------------------
void __fastcall TExprToolTipForm::FormDestroy(TObject *Sender)
{
//  delete FData;
}
//---------------------------------------------------------------------------
void __fastcall TExprToolTipForm::SetData(TMtx * const Value)
{
//  FData = Value;
}
//---------------------------------------------------------------------------
void __fastcall TExprToolTipForm::UpdateGrid(TMtxVecBase * const Src, const AnsiString &aName)
{
  if (aName == bName)
  {
    if ((double)(Now() - mark) > (0.25 * (double)OneSecond))
    {
      MtxVecGrid->Datasource = Src;
      Show();
      mark = Now();
    }
  }
  else
  {
    mark = Now();
    bName = aName;
  }
}
//---------------------------------------------------------------------------
void __fastcall TExprToolTipForm::WMNCHitTest(TWMNCHitTest &Message)
{
  const int EDGEDETECT = 7;
  TForm::Dispatch(&Message);
  if (BorderStyle == bsNone)
  {
    TRect deltaRect;
    deltaRect.Left = Message.XPos - BoundsRect.Left;
    deltaRect.Right = BoundsRect.Right - Message.XPos;
    deltaRect.Top = Message.YPos - BoundsRect.Top;
    deltaRect.Bottom = BoundsRect.Bottom - Message.YPos;

    if (deltaRect.Top < EDGEDETECT && deltaRect.Left < EDGEDETECT)
      Message.Result = HTTOPLEFT;
    else if (deltaRect.Top < EDGEDETECT && deltaRect.Right < EDGEDETECT)
      Message.Result = HTTOPRIGHT;
    else if (deltaRect.Bottom < EDGEDETECT && deltaRect.Left < EDGEDETECT)
      Message.Result = HTBOTTOMLEFT;
    else if (deltaRect.Bottom < EDGEDETECT && deltaRect.Right < EDGEDETECT)
      Message.Result = HTBOTTOMRIGHT;
    else if (deltaRect.Top < EDGEDETECT)
      Message.Result = HTTOP;
    else if (deltaRect.Left < EDGEDETECT)
      Message.Result = HTLEFT;
    else if (deltaRect.Bottom < EDGEDETECT)
      Message.Result = HTBOTTOM;
    else if (deltaRect.Right < EDGEDETECT)
      Message.Result = HTRIGHT;
  }
}
//---------------------------------------------------------------------------
