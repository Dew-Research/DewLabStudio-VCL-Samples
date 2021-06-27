//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "BenchmarkX.h"
#include "MtxVec.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TBenchmarkXForm *BenchmarkXForm;
//---------------------------------------------------------------------------
__fastcall TBenchmarkXForm::TBenchmarkXForm(TComponent* Owner)
  : TBasicForm2(Owner)
{
    fFirstActivation = true;
    fBenchmarkFramework = new BenchmarkFramework();
    fBenchmarkResults = new TBenchmarkResults();
    LoadFuncListBox();

    AnsiString str;

    RichEdit1->Lines->Clear();
    str = "These benchmarks compare vectorized and not vectorized ";
    str+= "versions of real and complex versions of basic math functions. ";
    str+= "The vectorized versions are labeled with MtxVec and the non-vectorized ";
    str+= "versions are labeled with Math387.";
    RichEdit1->Lines->Add(str);
    RichEdit1->Lines->Add("");
    str = "The non-vectorized real and complex versions ";
    str+= "are written in assembler for maximum performance. ";
    str+= "Despite this, the vectorized versions are substantially faster. ";
    str+= "Before running the tests double click on the iterations combobox. ";
    str+= "That will compute the number of iterations that have to be performed ";
    str+= "to get sufficiently long timings. The resolution of the timings is about 15ms.";
    RichEdit1->Lines->Add(str);
}
//---------------------------------------------------------------------------
void __fastcall TBenchmarkXForm::FormDestroy(TObject *Sender)
{
    delete fBenchmarkFramework;
    delete fBenchmarkResults;
}
//---------------------------------------------------------------------------
void __fastcall TBenchmarkXForm::ShowResults(TBenchmarkResults *results)
{
    UpdateChart();
}
//---------------------------------------------------------------------------
void __fastcall TBenchmarkXForm::LoadFuncListBox()
{
  int i;

  clbFuncs->Items->BeginUpdate();
  try {
    clbFuncs->Items->Clear();

    for (i = 0; i < fBenchmarkFramework->FuncCount; i++) {

      clbFuncs->Items->Add (fBenchmarkFramework->FuncName[i]);
      clbFuncs->Checked[i] = true;
    }
  }
  __finally {
    clbFuncs->Items->EndUpdate();
  }
}
//---------------------------------------------------------------------------
void __fastcall TBenchmarkXForm::SelectAllFuncs(bool select)
{
  int i;

  for (i = 0; i < clbFuncs->Items->Count; i++) {
    clbFuncs->Checked[i] = select;
  }
}

//---------------------------------------------------------------------------


void __fastcall TBenchmarkXForm::clbFuncsClick(TObject *Sender)
{
  int idx;

  idx = clbFuncs->ItemIndex;
  if (idx != -1) {

      clbFuncs->Checked[idx] = !(clbFuncs->Checked[idx]);
  }
}
//---------------------------------------------------------------------------
void __fastcall TBenchmarkXForm::UpdateComboBoxHistory (TComboBox *cb)
{
  int idx,i;

  if (cb->Text != "") {

    i = cb->Items->Count -1;

    while (i >= 0) {
      if (cb->Items->Strings[i] == cb->Text) {
        break;
      } else i--;
    }

    if (i < 0) {

      cb->Items->Insert (0, cb->Text);

    } else {

      if (i > 0) { cb->Items->Move (i, 0); }
    }

    cb->Text = cb->Items->Strings[0];
  }
}
//---------------------------------------------------------------------------
int __fastcall TBenchmarkXForm::ReadIntValue(TComboBox *cb, int min,int max)
{
  int Result;
  
  if (TryStrToInt (cb->Text, Result)) {
    if ((Result >= min) && (Result <= max)) {
      return Result;
    }
  } else {
    if (cb->CanFocus() ) { cb->SetFocus(); }
  }

  return min;
//  throw Exception("Expected value in range [%d..%d]", [min, max]);
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkXForm::btnRunClick(TObject *Sender)
{

//  Mtxvec::Controller->SetVecCacheSize(32,2048);
//  Mtxvec::Controller->SetMtxCacheSize(32,2048);

  TCursor cursor;
  int i;
  TBenchmarkResults *results;

  UpdateComboBoxHistory (cbVectorLength);
  UpdateComboBoxHistory (cbIterationCount);

  cursor = Screen->Cursor;
  Screen->Cursor = crHourGlass;
  try  {
    fBenchmarkFramework->VectorLength = ReadIntValue (cbVectorLength, 0, 1000000);
    fBenchmarkFramework->IterationCount = ReadIntValue (cbIterationCount, 1, 1000000);

    results = fBenchmarkResults;

    results->Clear();
    for (i = 0; i < clbFuncs->Count; i++) {
      if (clbFuncs->Checked[i]) {

        fBenchmarkFramework->Run (clbFuncs->Items->Strings[i], results);
      }
    }

    results->Title = Format( "CB6:  Length: %d   Count: %d ",
      OPENARRAY(TVarRec,(fBenchmarkFramework->VectorLength, fBenchmarkFramework->IterationCount)));

    ShowResults(results);
  }
  __finally {
    Screen->Cursor= cursor;
  }
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkXForm::btnOpenClick(TObject *Sender)
{
       LoadFile("");   
}
//---------------------------------------------------------------------------
void __fastcall TBenchmarkXForm::LoadFile(const AnsiString file_name)
{
   if (FileExists (file_name)) {

      fBenchmarkResults->LoadFromFile(file_name);
      UpdateChart();

  } else {

    LoadFromFileItemClick(NULL);
  }
}
//-----
void __fastcall TBenchmarkXForm::RecalcIterationCount()
{
  TCursor cursor;

  cursor = Screen->Cursor;
  Screen->Cursor = crHourGlass;
  try {
  
    cbIterationCount->Text = IntToStr(fBenchmarkFramework->RecalcIterationCount());
  }
  __finally {

    Screen->Cursor = cursor;
  }
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkXForm::FormActivate(TObject *Sender)
{
  if (fFirstActivation) {

    fFirstActivation = false;
    Application->ProcessMessages();
    RecalcIterationCount();
  }
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkXForm::LoadFromFileItemClick(TObject *Sender)
{
   if (OpenDialog1->Execute()) {
   
    fBenchmarkResults->LoadFromFile(OpenDialog1->FileName);
    UpdateChart();
  }
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkXForm::SaveToFileItemClick(TObject *Sender)
{
  if (SaveDialog1->Execute())  fBenchmarkResults->SaveToFile(SaveDialog1->FileName);
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkXForm::miSelectAllFuncsClick(TObject *Sender)
{
  SelectAllFuncs (true);
}
//---------------------------------------------------------------------------

void __fastcall TBenchmarkXForm::miUnselectAllFuncsClick(TObject *Sender)
{
  SelectAllFuncs (false);
}
//---------------------------------------------------------------------------
void __fastcall TBenchmarkXForm::UpdateChart()
{
  int i;

  Series1->Clear();
  Series2->Clear();
  Series3->Clear();
  Series4->Clear();

  chartResults->Height = 100 + (60 * fBenchmarkResults->Count);
  Caption = fBenchmarkResults->Title;

  for (i = fBenchmarkResults->Count-1; i > -1; i--) {

    Series1->AddBar(fBenchmarkResults->Items[i]->SmplVecTicks, fBenchmarkResults->Items[i]->FuncName, clDefault);
    Series2->AddBar(fBenchmarkResults->Items[i]->CplxVecTicks, fBenchmarkResults->Items[i]->FuncName, clDefault);
    Series3->AddBar(fBenchmarkResults->Items[i]->SmplFuncTicks, fBenchmarkResults->Items[i]->FuncName, clDefault);
    Series4->AddBar(fBenchmarkResults->Items[i]->CplxFuncTicks, fBenchmarkResults->Items[i]->FuncName, clDefault);
  }
}

void __fastcall TBenchmarkXForm::cbIterationCountDblClick(TObject *Sender)
{
  fBenchmarkFramework->VectorLength = ReadIntValue (cbVectorLength, 0, 1000000);
  RecalcIterationCount();
}
//---------------------------------------------------------------------------


