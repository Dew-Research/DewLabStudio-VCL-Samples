//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "EigenVectors1.h"
#include "MtxDialogs.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TEigVec1 *EigVec1;
//---------------------------------------------------------------------------
__fastcall TEigVec1::TEigVec1(TComponent* Owner)
  : TBasicForm2(Owner)
{
  A.SetIt(4,4,false,OPENARRAY(double,(1,-3,5,-3,
								-1,12,0.3,2.5,
                                5,1.22,2.33,-0.5,
                                2.4,-1,5,3)));

  ValuesToGrid(A,StringGrid4,0,0,"0.000;-0.000",true);

  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "The Eig method is a powerful tool. With it you can ";
  str+= "easily calculate eigenvalues and left/right eigenvectors.";
  RichEdit1->Lines->Add(str);

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("VectorForm");
  str = "If  ""Vector Form"" is vfEig, then full balance will ";
  str+= "be used to find eigenvalues eigenvectors (check help ";
  str+= "file for more on this topic). The computed eigenvectors ";
  str+= "are normalized to have Euclidean norm equal to 1 and ";
  str+= "largest component real and are stored in the rows of ";
  str+= "the VL and VR matrices. If ""Vector Form"" is vfSchur ";
  str+= "then  user defined balance will be used to find eigenvalues ";
  str+= "eigenvectors (check help file for more on this topic)";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->Lines->Add("Balance");
  str = "Balancing the matrix can be very useful when calculating the ";
  str+= "eigenvalues and eigenvector. Balancing operation can perform ";
  str+= "one or both of the following similarity transformations:";
  RichEdit1->Lines->Add("1) Permutation, 2) Similarity transformation.");
  RichEdit1->Lines->Add("");
  str = "Try changing A matrix values, ""Vector Form""  and (optionally) ";
  str+= """Balance"". The ""Left"" and ""Right"" buttons show left and right ";
  str+= "(check help for more info on this topic) eigenvectors.";
  RichEdit1->Lines->Add(str);

  RadioGroup1Click(RadioGroup1);
  RadioGroup2Click(RadioGroup2);
}
//---------------------------------------------------------------------------


void __fastcall TEigVec1::Button1Click(TObject *Sender)
{
  // get values for A }
  GridToValues(A,StringGrid4,A.Complex);
  TMtxType MtxType = A.DetectMtxType();
  // find eigenvalues and eigenvectors
  A.Balance = Bal;
  A.Eig(EigL,EigValues,EigR,MtxType,VecForm);
  // write results to grids,
  //  write eigenvalues as diagonal matrix
  StringGrid2->Cells[0][0] = "D 4x1";
  ValuesToGrid(EigValues, StringGrid2,0,0,"0.000E+00");
  if (SpeedButton1->Down) SpeedButton1Click(SpeedButton1);
  else SpeedButton2Click(SpeedButton2);
}
//---------------------------------------------------------------------------

void __fastcall TEigVec1::RadioGroup1Click(TObject *Sender)
{
  switch (RadioGroup1->ItemIndex)
  {
    case 0 :{
              VecForm = vfEig;
              RadioGroup2->ItemIndex = 3;
              RadioGroup2->Enabled = false;
            };break;
    case 1 :{
              VecForm = vfSchur;
              RadioGroup2->Enabled = true;
            };break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TEigVec1::RadioGroup2Click(TObject *Sender)
{
  switch (RadioGroup2->ItemIndex)
  {
    case 0:   Bal = btNone; break;
    case 1:   Bal = btScale; break;
    case 2:   Bal = btPerm; break;
    case 3:   Bal = btFull; break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TEigVec1::SpeedButton1Click(TObject *Sender)
{
  ValuesToGrid(EigL,StringGrid1,0,0,"0.000E+00",true);
  StringGrid1->Cells[0][0] = "VL 4x4";
}
//---------------------------------------------------------------------------

void __fastcall TEigVec1::SpeedButton2Click(TObject *Sender)
{
  ValuesToGrid(EigR, StringGrid1,0,0,"0.000E+00",true);
  StringGrid1->Cells[0][0] = "VR 4x4";
}
//---------------------------------------------------------------------------


