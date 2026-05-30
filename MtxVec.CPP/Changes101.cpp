//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Changes101.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TfrmChanges101 *frmChanges101;
//---------------------------------------------------------------------------
__fastcall TfrmChanges101::TfrmChanges101(TComponent* Owner)
  : TBasicForm3(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmChanges101::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v1.0.1:");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxVec.pas and Math387.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("More thread safety for dlls and MtxVec.pas");
  RichEdit1->Lines->Add("Better single precision support");
  RichEdit1->Lines->Add("StrToCplx now works with any string formating");
  RichEdit1->Lines->Add("StrToVal same as StrToFloat except for NAN and INF");
  RichEdit1->Lines->Add("StringsToValues uses new StrToCplx and StrToVal methods");
  RichEdit1->Lines->Add("SaveToStream now has a parameter for precision rounding type");
  RichEdit1->Lines->Add("LoadFromStream now loads any precision and has new version control");
  RichEdit1->Lines->Add("LoadFromFile now uses LoadFromStream");
  RichEdit1->Lines->Add("Added property editors and IDE streaming to TMtx and TVec objects");
  RichEdit1->Lines->Add("TVec Rotate method now accepts negative indexes");
  RichEdit1->Lines->Add("Most trigonometric functions now use VML");
  RichEdit1->Lines->Add("TVec : added DivideVec, Cbrt, InvCbrt, InvSqrt methods");
  RichEdit1->Lines->Add("Improved algorithm for CreateIt and FreeIt procedures");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Probabilities.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added 4 new distributions : Cauchy, Maxwell, Pareto and Rayleigh PDF, CDF and inverse CDF");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Optimization.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Removed global variables/functions. Now all procedures/functions are thread-safe");
  RichEdit1->Lines->Add("Improved the numerical gradient and Hessian matrix calculation algorithm");
  RichEdit1->Lines->Add("Improved BFGS method");
  RichEdit1->Lines->Add("MinBrent now returns number of iterations needed to reach minimum value. Minimum position is now stored in MinX variable");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxVecEdit.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("MtxVecEdit form does not save changes if not displayed modaly");
  RichEdit1->Lines->Add("\"Copy as Real\" option allows copying complex matrix as real columns");
  RichEdit1->Lines->Add("\"Paste as Complex\" option allows pasting real colums as complex matrix");
  RichEdit1->Lines->Add("The new \"Copy as Real\" and \"Paste as Complex\" options allow copying/pasting tables from Word or Excel");
  RichEdit1->Lines->Add("TeeChart dependant code has been moved from MtxVecEdit to MtxVecTee unit");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxVecTools.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("New unit encapsulates all MtxVec components");
  RichEdit1->Lines->Add("TMtxOptimization component - interfaces Optimization unit");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("MtxDBTools.pas :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("New unit encapsulates all MtxVec DB components");
  RichEdit1->Lines->Add("TMtxDataset component - provides direct read/write access to any TDataset descendant");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Miscellaneous :");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("New installer automatically instals help files, runtime/design time packages and all MtxVec files.");
}
//---------------------------------------------------------------------------
