//---------------------------------------------------------------------------

#include <vcl.h>

#pragma hdrstop

#include "InverseMtx.h"
#include <MtxVecEdit.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TInvMtx *InvMtx;
//---------------------------------------------------------------------------
__fastcall TInvMtx::TInvMtx(TComponent* Owner)
  : TBasicForm2(Owner)
{
   AnsiString str;

   RichEdit1->Lines->Clear();
   RichEdit1->Lines->Add("Calculating the inverse matrix is a peace of cake. It can be done with just one function call :");
   RichEdit1->Lines->Add("");
   RichEdit1->SelAttributes->Name = "Courier New";
   RichEdit1->Lines->Add("A.Inv;");
   RichEdit1->Lines->Add("");
   str = "The Inv method optionally accepts the matrix type ";
   str+= "parameter. Depending of matrix type (symmetric, ";
   str+= "triangular, etc..)  optimized methods will be used ";
   str+= "to calculate the inverse matrix.";
   RichEdit1->Lines->Add(str);

   A = new Mtxvec::TMatrix;
   B = new Mtxvec::TMatrix;
   C = new Mtxvec::TMatrix;

   TrackBar1Change(TrackBar1);
   Button1Click(this);

}
//---------------------------------------------------------------------------
void __fastcall TInvMtx::TrackBar1Change(TObject *Sender)
{
  DimMtx = TrackBar1->Position;
  Label2->Caption = IntToStr(DimMtx);
  Button2->Enabled = false;
  Button3->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TInvMtx::Button1Click(TObject *Sender)
{
  A->Size(DimMtx,DimMtx);
  // Resize StringGrid1 to A size
  StringGrid1->RowCount = DimMtx;
  StringGrid1->ColCount = DimMtx;
  StringGrid2->RowCount = DimMtx;
  StringGrid2->ColCount = DimMtx;
  A->RandUniform(-5,5);
  // Write A to StringGrid1
  ValuesToGrid(A,StringGrid1,0,0,"0.0000",false);
  Button2->Enabled = true;
  Button3->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TInvMtx::Button2Click(TObject *Sender)
{
  // resize B to match the size of A
  B->Size(A);
  // copy values for StringGrid1
  GridToValues(B,StringGrid1,B->Complex,false);
  // calculate the inverse
  B->AutoMtxType = true;
  B->Inv(mtGeneral);
  // show the inverse matrix in StringGrid1
  ValuesToGrid(B,StringGrid2,0,0,"0.0000",false);
  Button3->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TInvMtx::FormDestroy(TObject *Sender)
{
  delete A;
  delete B;
  delete C;
}
//---------------------------------------------------------------------------

void __fastcall TInvMtx::Button3Click(TObject *Sender)
{
  C->Mul(A,B);
  ViewValues(C,"A*A-1 = ?",true,true,false);
}
//---------------------------------------------------------------------------


