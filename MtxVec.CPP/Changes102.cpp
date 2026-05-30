//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Changes102.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TfrmChanges102 *frmChanges102;
//---------------------------------------------------------------------------
__fastcall TfrmChanges102::TfrmChanges102(TComponent* Owner)
  : TBasicForm3(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmChanges102::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v1.0.2:");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxVec.pas and Math387.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added TMtx.Determinant method (calculates determinant of a squared matrix)");
  RichEdit1->Lines->Add("Added TMtx.OnSetSize event (triggers when matrix Rows or Cols is changed)");
  RichEdit1->Lines->Add("Added TVec.Shift methid (similar to rotate method)");
  RichEdit1->Lines->Add("Added IsNANInf boolean function");
  RichEdit1->Lines->Add("Most Math387.pas functions are now written in assembler (much faster)");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxVecEdit.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added StayOnTop boolean parameter to ViewValues procedure");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Optimization.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Improved all existing optimization algorithms");
  RichEdit1->Lines->Add("Added new optimization algorithms: Conjugate gradient (Fletcher and Polak algorithm)");
  RichEdit1->Lines->Add("Upgraded existing BFGS algorithm. Now BFGS and DFP update schemes are supported (see Optimization demo)");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxVecTools, MtxVecDBTools and MtxVecComCtrls.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added TMtxOptimization.Assign and TMtxDataset.Assign methods");
  RichEdit1->Lines->Add("Added TMtxOptimization.StopReason, GradTolerance properties");
  RichEdit1->Lines->Add("Added TMtxDataSet.ColumnsToMtx method");
  RichEdit1->Lines->Add("Improved TMtxDataSet reading/writing to DB algorithms");
  RichEdit1->Lines->Add("Added new TMtxFloatEdit component to allow easy complex number editing");
  RichEdit1->Lines->Add("Added new TMtxProgressDialog component. It can be used to show progress bar while executing loop tests");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxVecTee.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Improved drawing routines (support for Teechart v5 TChartValueList.Value)");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Miscellaneous :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added support for Delphi 6 and C++Builder 6");
  RichEdit1->Lines->Add("Reorganized MtxVec packages - separated runtime packages from design time packages");
  RichEdit1->Lines->Add("Combined all Delphi (and C++ Builder) versions into single distribution *.exe file.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------
