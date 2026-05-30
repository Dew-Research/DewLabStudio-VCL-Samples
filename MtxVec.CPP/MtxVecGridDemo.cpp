//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "MtxVecGridDemo.h"
#include "MtxVec.hpp"
#include "Math387.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmGridDemo *frmGridDemo;
//---------------------------------------------------------------------------
__fastcall TfrmGridDemo::TfrmGridDemo(TComponent* Owner)
  : TBasicForm2(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add("TMtxVecGrid control allows you easy viewing/editing of real or complex matrices or vectors. The control is derived from TCustomGrid and inherits all it's properties/methods and introduces some new features: cell text alignment, cell string format, full support for complex numbers, ability to edit, remove or append/insert rows into matrix or vector.");

  // Create a grid at runtime
  Grid = new TMtxVecGrid(this);
  Grid->Parent = Panel3;
  Grid->Align = alClient;
  Grid->AutoSizeColumns = true;

  // Setup test matrix and vector
  testMatrix.Size(30, 30, true);
  testMatrix.RandGauss();
  testVector.Size(50, false);
  testVector.RandUniform(5, 12);

  // initially, connect Grid with testmatrix
  Grid->Datasource = testMatrix;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::FormShow(TObject *Sender)
{
  ComboBox1->ItemIndex = (int)Grid->TextAlign;
  Edit1->Text = Grid->StringFormat;
  CheckBox1->Checked = Grid->Editable;
  CheckBox2->Checked = Grid->AllowAppend;
  CheckBox3->Checked = Grid->AutoSizeColumns;
  CheckBox4->Checked = Grid->SplitComplexNumbers;
  CheckBox6->Checked = Grid->ShowInfo;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::Button1Click(TObject *Sender)
{
  Grid->Datasource = testVector;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::Button2Click(TObject *Sender)
{
  Grid->Datasource = testMatrix;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::CheckBox1Click(TObject *Sender)
{
  Grid->Editable = CheckBox1->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::CheckBox2Click(TObject *Sender)
{
  Grid->AllowAppend = CheckBox2->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::CheckBox3Click(TObject *Sender)
{
  Grid->AutoSizeColumns = CheckBox3->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::CheckBox4Click(TObject *Sender)
{
  Grid->SplitComplexNumbers = CheckBox4->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::CheckBox5Click(TObject *Sender)
{
  Grid->Scientific = CheckBox5->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::CheckBox6Click(TObject *Sender)
{
  Grid->ShowInfo = CheckBox6->Checked;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::ComboBox1Change(TObject *Sender)
{
  Grid->TextAlign = (TCellTextAlign)ComboBox1->ItemIndex;
}
//---------------------------------------------------------------------------
void __fastcall TfrmGridDemo::Edit1Change(TObject *Sender)
{
  Grid->StringFormat = Edit1->Text;
}
//---------------------------------------------------------------------------
