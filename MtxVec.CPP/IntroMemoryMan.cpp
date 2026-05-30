//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IntroMemoryMan.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroMemMan *IntroMemMan;
//---------------------------------------------------------------------------
__fastcall TIntroMemMan::TIntroMemMan(TComponent* Owner)
  : TBasicForm3(Owner)
{

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Enhanced memory handling:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Built in dynamic memory allocation makes it easier for the user");
  RichEdit1->Lines->Add("Object cache with object precreation speeds up Create and Destroy");
  RichEdit1->Lines->Add("Memory preallocation gives instant access to new memory.");
  RichEdit1->Lines->Add("Super conductive object cache allows linear multi-core scaling with CPU core count!");
  RichEdit1->Lines->Add("Dedicated memory allocated per thread typically does not exceed CPU cache size (2MB). This makes the processing memory and CPU cache efficient.");
  RichEdit1->Lines->Add("Object cache does not interfere with other parts of the application which continue to use the default memory manager. Only those parts of code running via TMtxThread and using MtxVec object cache are affected.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Array access options:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Default arrays allow cleaner syntax");
  RichEdit1->Lines->Add("Array pointers give you more speed");
  RichEdit1->Lines->Add("Single memory block matrices allow even faster matrix operations");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;

}
//---------------------------------------------------------------------------
