//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroExport.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroExpImp *IntroExpImp;
//---------------------------------------------------------------------------
__fastcall TIntroExpImp::TIntroExpImp(TComponent* Owner)
  : TBasicForm3(Owner)
{

   RichEdit1->Lines->Clear();
   RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
   RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
   RichEdit1->SelAttributes->Size = 11;
   RichEdit1->Lines->Add("Quick and easy Export/Import to screen, file, database... text or binary.");
   RichEdit1->Lines->Add("");
   RichEdit1->Paragraph->FirstIndent = 10;
   RichEdit1->Paragraph->Numbering = nsBullet;
   RichEdit1->Lines->Add("Values to string, Strings to values (real and complex)");
   RichEdit1->Lines->Add("Read/Write stream");
   RichEdit1->Lines->Add("Read/Write file");
   RichEdit1->Lines->Add("Read/Write string grid");
   RichEdit1->Paragraph->FirstIndent = 0;
   RichEdit1->Paragraph->Numbering = nsNone;
   RichEdit1->Lines->Add("");

   RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
   RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
   RichEdit1->SelAttributes->Size = 11;
   RichEdit1->Lines->Add("Ready to use Matrix Viewer and charting tools:");
   RichEdit1->Lines->Add("");
   RichEdit1->Paragraph->FirstIndent = 10;
   RichEdit1->Paragraph->Numbering = nsBullet;
   RichEdit1->Lines->Add("Use ViewValues to display the contents of the matrix or vector");
   RichEdit1->Lines->Add("Edit data on the fly");
   RichEdit1->Lines->Add("Draw data while viewing");
   RichEdit1->Lines->Add("Save/Load from file");
   RichEdit1->Lines->Add("Use DrawValues and DrawIt for immediate data display");
   RichEdit1->Paragraph->FirstIndent = 0;
   RichEdit1->Paragraph->Numbering = nsNone;
}
//---------------------------------------------------------------------------
