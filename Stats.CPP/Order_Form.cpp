//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Order_Form.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_REdit"
#pragma resource "*.dfm"
TfrmOrder *frmOrder;
//---------------------------------------------------------------------------
__fastcall TfrmOrder::TfrmOrder(TComponent* Owner)
	: TfrmBaseRichEdit(Owner)
{
	RichEdit1->DefAttributes->Size = 11;
	RichEdit1->SelAttributes->Size = 16;
//	RichEdit1->SelAttributes->Color = RGB(72,123,180);
	RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit1->Lines->Add("Ordering Stats Master");
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("You may use Stats Master trial version without any costs "
			"for the period of one month. Applications which include "
			"Stats Master Trial version will allways start with a nag screen "
			"reminding you are using Trial version. If you wish to keep "
			"on using it after one month, you have to register it with the "
			"Dew Research and pay a registration fee. Stats Master will still "
			"function even if you don""t register after one month. If the "
			"trial version is used for educational purposes, it can be used "
			"for a longer period, but you have to register it""s use by sending "
			"an email to info@dewresearch.com .");
	RichEdit1->Lines->Add("Once you have registered, you will receive fully functional packages "
			"and links to our dll repository by email. CDs are also available, but "
			"only through Regsoft registration service. When new versions of Stats Master "
			"are released, you will be able to download them from www.dewresearch.com.");
	RichEdit1->Lines->Add("Your Stats Master license will be valid for all future MINOR version "
			"upgrades. Tech support is fee free with 48h response.");
	RichEdit1->Lines->Add("");
	RichEdit1->Lines->Add("NOTE: Stats Master is build on top of the latest MtxVec package and therefore requres it."
			"For MtxVec and Stats Master pricing info and offline and online ordering methods, "
			"please visit http://www.dewresearch.com/order.htm where you will find all the "
			"information that you need. If you would still have any questions, send an email "
			"to sales@dewresearch.com.");
}
//---------------------------------------------------------------------------
