//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "LQR1.h"
#include "MtxVecEdit.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TLQRDemo *LQRDemo;
//---------------------------------------------------------------------------
__fastcall TLQRDemo::TLQRDemo(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "MtxVec offers several methods for matrix decomposition. ";
  str+= "If matrix is squared, then LU decomposition can be used. ";
  str+= "If this is not the case (number of rows <> number of columns) ";
  str+= "then either LQ,QR, or SVD decomposition method can be used. ";
  str+= "All these methods are used extensively for solving system of ";
  str+= "linear equations (LUSolve, LQRSolve, SVDSolve). In this example ";
  str+= "the following decompositions are demonstrated.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("LQ decomposition : Mtx.Rows < Mtx.Cols;  Mtx = L*Q; Mtx must have full rank");
  RichEdit1->Lines->Add("QR decomposition : Mtx.Rows > Mtx.Cols; Mtx = Q*R; Mtx must have full rank");
  RichEdit1->Lines->Add("SVD decomposition : Mtx = U*S*V""; Mtx does not have full rank");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  str = "The ""Economy size"" checkbox indicates economy size matrices will be calculated. ";
  str+= "For more on this check the help file.";
  RichEdit1->Lines->Add(str);

  A  = new Mtxvec::TMatrix();
  L  = new Mtxvec::TMatrix();
  Q  = new Mtxvec::TMatrix();
  R  = new Mtxvec::TMatrix();

  S.Caption = "Singular values";
  RadioGroup1Click(RadioGroup1);
}
//---------------------------------------------------------------------------
void __fastcall RefreshGrid(TStringGrid *AStringGrid, Mtxvec::TMatrix *Mtx)
{
  AStringGrid->RowCount = Mtx->Rows+1;
  AStringGrid->ColCount = Mtx->Cols+1;
  AStringGrid->Width = (AStringGrid->ColCount)* AStringGrid->DefaultColWidth+10;
  AStringGrid->Height = (AStringGrid->RowCount)* AStringGrid->DefaultRowHeight+10;
  ValuesToGrid(Mtx,AStringGrid,0,0,"0.0000",true);
  AStringGrid->Cells[0][0] = Mtx->Caption;
}
//---------------------------------------------------------------------------


void __fastcall TLQRDemo::RadioGroup1Click(TObject *Sender)
{
  if (RadioGroup1->ItemIndex == 0)
  {
    A->Size(2,4);
    A->RandUniform(2,10);
    Button3->Caption = "LQ = A ? ";
  }
  else if (RadioGroup1->ItemIndex == 1)
  {
    A->Size(3,2);
    A->RandUniform(-10,-3);
    Button3->Caption = "QR = A ? ";
  }
  else if (RadioGroup1->ItemIndex == 2)
  {
    A->Size(2,4);
    A->RandUniform(2,10);
	A->SetZero(0,0,1,0);
    Button3->Caption = "USV' = A ? ";
  }
  else if (RadioGroup1->ItemIndex == 3)
  {
    A->Size(3,2);
    A->RandUniform(2,10);
    A->SetZero(0,0,0,1);
    Button3->Caption = "USV' = A ? ";
  }
  Button3->Enabled = false;
  Button2->Enabled = false;
  A->Caption = "A "+IntToStr(A->Rows)+"x"+IntToStr(A->Cols);
  RefreshGrid(StringGrid1,A);
}
//---------------------------------------------------------------------------

void __fastcall TLQRDemo::FormDestroy(TObject *Sender)
{
  delete A;
  delete L;
  delete Q;
  delete R;
}
//---------------------------------------------------------------------------

void __fastcall TLQRDemo::Button1Click(TObject *Sender)
{
  GridToValues(A, StringGrid1,A->Complex,true);
  switch (RadioGroup1->ItemIndex)
  {
    case 0:
          {
            A->LQR(L,Q,NULL,CheckBox1->Checked);
            L->Caption = "L";
            Q->Caption = "Q";
            RefreshGrid(StringGrid2,L);
            RefreshGrid(StringGrid3,Q);
          };break;
    case 1:
          {
            A->LQR(NULL,Q,R,CheckBox1->Checked);
            R->Caption = "R";
            Q->Caption = "Q";
            RefreshGrid(StringGrid2,Q);
            RefreshGrid(StringGrid3,R);
          };break;
    default:
          {
            Button2->Enabled = true;
            A->SVD(L,S,Q,CheckBox1->Checked);
            L->Caption = "U";
            Q->Caption = "V";
            RefreshGrid(StringGrid2,L);
            RefreshGrid(StringGrid3,Q);
          };break;
  }
  Button3->Enabled = true;
  StringGrid3->Left = StringGrid2->Left+StringGrid2->Width+10;
}
//---------------------------------------------------------------------------

void __fastcall TLQRDemo::Button2Click(TObject *Sender)
{
  // Q.Cols because we are multiplying with V'
  tmpM1.Size(L->Cols,Q->Cols,S.Complex); // D size
  tmpM1.SetZero();
  tmpM1.Diag(S,0);
  ViewValues(tmpM1,"Singular values",true);
}
//---------------------------------------------------------------------------

void __fastcall TLQRDemo::Button3Click(TObject *Sender)
{
  switch (RadioGroup1->ItemIndex)
  {
	case 0:
		  {
			tmpM2 = Mul(L,Q);
			ViewValues(tmpM2,"LQ = A ?",true);
		  };break;
	case 1:
		  {
			tmpM2 = Mul(Q,R);
			ViewValues(tmpM2,"QR = A ?",true);
		  };break;
	default:
		  {
			// Q.Cols because we are multiplying with V'
			// First, calculate S
			tmpM1.Size(L->Cols,Q->Cols,S.Complex);
			tmpM1.SetZero();
			tmpM1.Diag(S,0);
			// Multiply S by V'=Q'
			tmpM2 = Mul(tmpM1,Q,opNone,opTran);
			// Multiply from left by U=L
			tmpM3 = Mul(L,tmpM2);
			ViewValues(tmpM3,"U*S*V'= A ?",true,false,false);
		  };break;
	}
}
//---------------------------------------------------------------------------

