//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MtxDialogs.hpp"
#include "Save_Precision.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmSavePrec *frmSavePrec;
//---------------------------------------------------------------------------
__fastcall TfrmSavePrec::TfrmSavePrec(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "SaveToStream allows you to specify the precision ";
  str+= "and rounding method. This enables you to minimize ";
  str+= "the storage space required for your data and at ";
  str+= "the same time gives you the ability to process ";
  str+= "data written in any number format.";
  RichEdit1->Lines->Add(str);

  m1 = new Mtxvec::TMatrix;
  m2 = new Mtxvec::TMatrix;
  m1->Size(50,50,false);
  // setup StringGrids
  StringGrid1->RowCount = 51;
  StringGrid1->ColCount = 51;
  StringGrid2->RowCount = 51;
  StringGrid2->ColCount = 51;
  m1->RandGauss(5,0.5); // generate sample values
  // visualize
  ValuesToGrid(m1, StringGrid1,0,0,"0.0000000000",true);
}
//---------------------------------------------------------------------------

void __fastcall TfrmSavePrec::CBPrecisionChange(TObject *Sender)
{
  Precision = TPrecision(CBPrecision->ItemIndex);
}
//---------------------------------------------------------------------------

void __fastcall TfrmSavePrec::CBRoundingChange(TObject *Sender)
{
  Rounding = TRounding(CBRounding->ItemIndex);
}
//---------------------------------------------------------------------------

void __fastcall TfrmSavePrec::FormShow(TObject *Sender)
{
  CBPrecision->ItemIndex = 0;
  CBRounding->ItemIndex = 0;
}
//---------------------------------------------------------------------------

void __fastcall TfrmSavePrec::FormDestroy(TObject *Sender)
{
  delete m1;
  delete m2;
}
//---------------------------------------------------------------------------

void __fastcall TfrmSavePrec::Button1Click(TObject *Sender)
{
  TMemoryStream *MemStream = new TMemoryStream;
  try
  {
    // save from m1 to stream
    m1->Precision = Precision;
    m1->Rounding = Rounding;
    m1->SaveToStream(MemStream);        
    lblMemSize->Caption = IntToStr(MemStream->Size) + " bytes";
    // load to m2 from stream
    MemStream->Seek(0,0);
    m2->LoadFromStream(MemStream);
    // visualize
    ValuesToGrid(m2, StringGrid2,0,0,"0.0000000000",true);
  }
  __finally
  {
    delete MemStream;
  }
}
//---------------------------------------------------------------------------

