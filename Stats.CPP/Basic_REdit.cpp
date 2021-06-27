//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic_REdit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmBaseRichEdit *frmBaseRichEdit;
//---------------------------------------------------------------------------
__fastcall TfrmBaseRichEdit::TfrmBaseRichEdit(TComponent* Owner)
	: TForm(Owner)
{
	InitRichEditURLDetection(RichEdit1);
}
//---------------------------------------------------------------------------
void __fastcall TfrmBaseRichEdit::InitRichEditURLDetection(TRichEdit* re)
{
	long mask = SendMessage(re->Handle, EM_GETEVENTMASK, 0, 0);
	SendMessage(re->Handle, EM_SETEVENTMASK, 0, mask | ENM_LINK);
	SendMessage(re->Handle, EM_AUTOURLDETECT, (int)true, 0);
}
