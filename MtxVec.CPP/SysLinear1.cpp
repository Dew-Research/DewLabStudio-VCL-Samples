//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "SysLinear1.h"
#include "MtxVecEdit.hpp"
#include "MtxExpr.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TLinearSystem1 *LinearSystem1;
//---------------------------------------------------------------------------
__fastcall TLinearSystem1::TLinearSystem1(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "MtxVec offers three different methods to solve a system ";
  str+= "of linear equations : LU, LQR and singular value ";
  str+= "decomposition. Each of these methods has its advantages ";
  str+= "and disadvantages. Try changing values in matrix A, ";
  str+= "vector b and method used to calculate the solution vector ";
  str+= "x. The displayed matrix is nearly singular. You can add ";
  str+= "more non-zero elements to the diagonal to make it non-singular.";
  RichEdit1->Lines->Add(str);
  str = "In practice, most computations are performed with rounding ";
  str+= "errors. The LUSolve method offers you additional tools for ";
  str+= "refining the solution and estimating its error. They are ";
  str+= "evaluated only if RefineSolution is set to true";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Parameters in this demo :");
  str = "ConditionNr: If your matrix is ill-conditioned ";
  str+= "(that is, it""s ConditionNr is very small), then the error in ";
  str+= "the solution x is also large. ";
  RichEdit1->Lines->Add(str);
  str = "BackError: the smallest relative perturbation in elements ";
  str+= "of A and b such that x is the exact solution of the perturbed system.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("ForwError: the component-wise forward error in the computed solution.");
  RichEdit1->Lines->Add("");

  RichEdit1->Lines->Add("Try changing the matrix values and observe the solution, CondtionNr, ForwError and BackError.");

  A = new Mtxvec::TMatrix;
  A->SetIt(4,4,false,OPENARRAY(double,(0.001,  0,   0,   0,
										3,      0.1,   0,   0,
										2.5,    2,   3,   0,
										4,     -1, 0.5, 0.1)));
  b = new Mtxvec::TVector;
  b->Size(4);
  b->SetIt(OPENARRAY(double,(3,1.5,-2,4)));
  ValuesToGrid(A, StringGrid1,0,0,"0.0000",false);
  ValuesToGrid(b,StringGrid3,0,0,"0.0000",false,true);
  ComboBox1->ItemIndex = 0;
  ComboBox1Change(ComboBox1);
  CheckBox1Click(CheckBox1);
  RadioGroup1Click(RadioGroup1);
}
//---------------------------------------------------------------------------

void __fastcall TLinearSystem1::Button1Click(TObject *Sender)
{
  sVector x, S;

  GridToValues(A, StringGrid1,A->Complex, false);
  GridToValues(b, StringGrid3,b->Complex,true,false);
  switch (ComboBox1->ItemIndex)
  {
    case 0:
		  {
//            A->LUSolve(b,x,mtGeneral,opNone);
			x = DivLeft(A,b);  // x = A^(-1)*b
            Memo2->Lines->Clear();
            if (CheckBox1->Checked && RadioGroup1->ItemIndex != 0)
            {
              Memo2->Lines->Add("Forward error = "+ FormatFloat("0.0000E+00 ",A->ForwError));
              Memo2->Lines->Add("Backward error = "+ FormatFloat("0.0000E+00 ",A->BackError));
              Memo2->Lines->Add("ConditionNr = "+ FormatFloat("0.0000E+00",A->ConditionNr));
            }
          };break;
    case 1:
          {
            A->SVDSolve(b,x,S,1.0E-9);
            ValuesToGrid(S, StringGrid4,0,0,"0.0000E+00",false,true);
          };break;
    }
  ValuesToGrid(x, StringGrid2,0,0,"0.0000E+00",false,true);
}
//---------------------------------------------------------------------------

void __fastcall TLinearSystem1::CheckBox1Click(TObject *Sender)
{
  A->RefineSolution = CheckBox1->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TLinearSystem1::RadioGroup1Click(TObject *Sender)
{
  switch (RadioGroup1->ItemIndex)
  {
    case 0: A->ConditionNumber = cnNone; break;
    case 1: A->ConditionNumber = cnNorm1; break;
    case 2: A->ConditionNumber = cnNormInf; break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TLinearSystem1::FormDestroy(TObject *Sender)
{
  delete A;
  delete b;
}
//---------------------------------------------------------------------------

void __fastcall TLinearSystem1::ComboBox1Change(TObject *Sender)
{
  Panel4->Visible = (ComboBox1->ItemIndex == 0);
  Panel5->Visible = (ComboBox1->ItemIndex == 1);
  Memo2->Lines->Clear();
}
//---------------------------------------------------------------------------

