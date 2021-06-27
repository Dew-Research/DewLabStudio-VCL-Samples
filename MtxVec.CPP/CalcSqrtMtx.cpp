//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "CalcSqrtMtx.h"
#include "MtxVecEdit.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TfrmSqrtMtx *frmSqrtMtx;
//---------------------------------------------------------------------------
__fastcall TfrmSqrtMtx::TfrmSqrtMtx(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add("SqrtMtx is an example of a matrix function.");
  RichEdit1->Lines->Add("");
  str = "You can apply any function (Log, Exp, Power...) ";
  str+= "to the matrix via the MtxFunction method. In this ";
  str+= "case the result is obtained via eigenvalue decomposition.";
  RichEdit1->Lines->Add(str);

  Button1Click(this);
}
//---------------------------------------------------------------------------
void __fastcall TfrmSqrtMtx::MakeSymmetric(TMtx *mtx)
{
  if (mtx->IsDouble) {

	  for (int i=0; i<mtx->Rows; i++)
		for (int j=0; j<mtx->Cols; j++)
		  if (i > j) mtx->Values[i][j] = mtx->Values[j][i];
  }
  else
  {
	  for (int i=0; i<mtx->Rows; i++)
		for (int j=0; j<mtx->Cols; j++)
		  if (i > j) mtx->SValues[i][j] = mtx->SValues[j][i];
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmSqrtMtx::Button1Click(TObject *Sender)
{
  A.Size(3,3,false);
  // Resize StringGrid1 to A size
  StringGrid1->RowCount = A.Rows + 1;
  StringGrid1->ColCount = A.Cols + 1;
  StringGrid2->RowCount = A.Rows + 1;
  StringGrid2->ColCount = A.Cols*2 + 1;
  A.RandUniform(2,10);
  // symmetric matrix
  if (RadioGroup1->ItemIndex == 0) MakeSymmetric(A);
  // Write A to StringGrid1
  ValuesToGrid(A, StringGrid1,0,0,"0.0000",true);
  Button2->Enabled = true;
  Button3->Enabled = false;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSqrtMtx::Button2Click(TObject *Sender)
{
  // resize B to match the size of A
  B.Size(A);
  // copy values for StringGrid1
  GridToValues(B, StringGrid1,B.Complex,true);
  // calculate the inverse
  if (RadioGroup1->ItemIndex == 0) C.MtxSqrt(B,mtSymmetric);
  else C.MtxSqrt(B,mtGeneral);
  // show the SQRT(matrix) in StringGrid2
  ValuesToGrid(C, StringGrid2,0,0,"0.0000",true);
  Button3->Enabled = true;
}
//---------------------------------------------------------------------------
void __fastcall TfrmSqrtMtx::StringGrid1SetEditText(TObject *Sender,
	  int ACol, int ARow, const String Value)
{
  try
  {
     StrToFloat(Value);
  }
  catch(...)
  {;}
}
//---------------------------------------------------------------------------
void __fastcall TfrmSqrtMtx::Button3Click(TObject *Sender)
{
  B.Mul(C,C,opNone,opNone);
  C.RealPart(B); // get only real part
  // compare
  if (C.Equal(A,1.0E-3)) ShowMessage("Succeeded!");
  else ShowMessage("Failed!");
  Button3->Enabled = false;
}
//---------------------------------------------------------------------------
