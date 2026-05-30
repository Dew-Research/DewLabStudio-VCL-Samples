//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "ProbEditor.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
__fastcall TFrameDist::TFrameDist(TComponent* Owner)
  : TFrame(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::ListViewParamsDblClick(TObject *Sender)
{
  TListItem *Item = ListViewParams->Selected;
  if (Item != NULL)
  {
    TProbParameter *par = (TProbParameter*)Item->Data;

    AnsiString parstr = InputBox("Set parameter " + Item->Caption,
                                 "Valid range: " + Item->SubItems->Strings[1] + ", " + Item->SubItems->Strings[0],
                                 Item->SubItems->Strings[2]);
    if (par->ParameterType == parInteger)
    {
      par->Value = StrToInt(parstr);
      Item->SubItems->Strings[2] = parstr;
    }
    else
    {
      par->Value = StrToFloat(parstr);
      Item->SubItems->Strings[2] = parstr;
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::SetDistType(TDistribution DistType, const AnsiString &Caption)
{
  Distribution->DistType = DistType;
  EditNumPoints->Text = IntToStr(Distribution->NumPoints);
  EditLB->Text = SampleToStr(Distribution->LB);
  EditUB->Text = SampleToStr(Distribution->UB);
  RefreshParListView();
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::RefreshParListView()
{
  Button2->Enabled = ListBoxDist->ItemIndex < ListBoxDist->Items->Count - 1;
  Button1->Enabled = ListBoxDist->ItemIndex > 0;

  ListViewParams->Items->Clear();
  // Add x
  TListItem *lItem = ListViewParams->Items->Add();
  lItem->Caption = Distribution->X->Name;
  if (Distribution->X->ParameterType == parInteger)
    lItem->SubItems->Add("integer");
  else
    lItem->SubItems->Add("real");
  lItem->SubItems->Add(Distribution->X->Notes);
  lItem->SubItems->Add(SampleToStr(Distribution->X->Value));
  lItem->Data = Distribution->X;

  for (int i = 0; i < Distribution->DistParams->Count; i++)
  {
    lItem = ListViewParams->Items->Add();
    lItem->Caption = Distribution->DistParams->Items[i]->Name;
    if (Distribution->DistParams->Items[i]->ParameterType == parInteger)
      lItem->SubItems->Add("integer");
    else
      lItem->SubItems->Add("real");
    lItem->SubItems->Add(Distribution->DistParams->Items[i]->Notes);
    lItem->SubItems->Add(SampleToStr(Distribution->DistParams->Items[i]->Value));
    lItem->Data = Distribution->DistParams->Items[i];
  }
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::SetDistribution(TProbDistribution *Value)
{
  if (Value != FDistribution)
  {
    FDistribution = Value;
    RefreshParListView();
  }
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::ListBoxDistClick(TObject *Sender)
{
  TListBox *lb = (TListBox*)Sender;
  SetDistType((TDistribution)lb->ItemIndex, lb->Items->Strings[lb->ItemIndex]);
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::RadioGroupOutClick(TObject *Sender)
{
  GroupBoxRange->Visible = (RadioGroupOut->ItemIndex == 1);
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::EditNumPointsChange(TObject *Sender)
{
  int ival = StrToInt(EditNumPoints->Text);
  Distribution->NumPoints = ival;
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::EditLBChange(TObject *Sender)
{
  Distribution->LB = StrToFloat(EditLB->Text);
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::EditUBChange(TObject *Sender)
{
  Distribution->UB = StrToFloat(EditUB->Text);
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::Button2Click(TObject *Sender)
{
  if (ListBoxDist->ItemIndex < ListBoxDist->Items->Count - 1)
    ListBoxDist->ItemIndex = ListBoxDist->ItemIndex + 1;
  SetDistType((TDistribution)ListBoxDist->ItemIndex, ListBoxDist->Items->Strings[ListBoxDist->ItemIndex]);
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::Button1Click(TObject *Sender)
{
  if (ListBoxDist->ItemIndex > 0)
    ListBoxDist->ItemIndex = ListBoxDist->ItemIndex - 1;
  SetDistType((TDistribution)ListBoxDist->ItemIndex, ListBoxDist->Items->Strings[ListBoxDist->ItemIndex]);
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::Edit1Change(TObject *Sender)
{
  FFormatString = Edit1->Text;
}
//---------------------------------------------------------------------------
void __fastcall TFrameDist::SetFormatString(const AnsiString &Value)
{
  FFormatString = Value;
}
//---------------------------------------------------------------------------
