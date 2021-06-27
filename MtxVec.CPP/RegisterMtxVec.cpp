//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "RegisterMtxVec.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TRegisterM *RegisterM;
//---------------------------------------------------------------------------
__fastcall TRegisterM::TRegisterM(TComponent* Owner)
  : TBasicForm3(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "You may use MtxVec trial version without any costs for the period of one month. MtxVec trial version runs within IDE only. ";
  str+= "If you wish to keep on using it after one month, you have to register it with the DewResearch and pay a registration fee.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  str = "MtxVec will still function even if you don't register after one month. If the trial version is used for educational ";
  str+= "purposes, it can be used for a longer period, but you have to register it;s use by sending an email to support@dewresearch.com";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  str = "Once you have registered, you will receive fully functional packages and links to our dll repository by email. CDs are also ";
  str+= "available, but only through Regsoft registration service.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  str = "When new versions of MtxVec are released, you will be able to download them from www.dewresearch.com.  Your MtxVec license ";
  str+= "will be valid for all future minor version upgrades of MtxVec. Tech support is fee free with 24h response.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  str = "For MtxVec pricing info and offline and online ordering methods, please visit http://www.dewresearch.com/order.htm where ";
  str+= "you will find all the information that you need.  If you would still have any questions, send an email to sales@dewresearch.com.";
  RichEdit1->Lines->Add(str);
}
//---------------------------------------------------------------------------
