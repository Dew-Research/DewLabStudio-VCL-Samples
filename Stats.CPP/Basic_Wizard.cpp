//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Basic_Wizard.h"
#include "Math387.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmBasicWizard *frmBasicWizard;
//---------------------------------------------------------------------------
__fastcall TfrmBasicWizard::TfrmBasicWizard(TComponent* Owner)
	: TForm(Owner)
{
	FFormatString = "0.0000";
  movebackward = true;
  moveforward = true;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::btnCancelClick(TObject *Sender)
{
	Close();
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::RefreshWizardControls()
{
  btnBack->Enabled = (PageControl->ActivePage->PageIndex > 0);
  btnNext->Enabled = (PageControl->ActivePage->PageIndex < PageControl->PageCount-1);
  lblHeader->Caption = PageControl->ActivePage->Caption;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::DoMoveForward()
{
  int index = PageControl->ActivePageIndex;
  if ((index<PageControl->PageCount) && (moveforward))
  {
      index ++;
    	PageControl->ActivePageIndex = index;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::DoMoveBackward()
{
  int index = PageControl->ActivePageIndex;
  if ((index>0) && (movebackward))
  {
      index --;
    	PageControl->ActivePageIndex = index;
  }
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::SetupTabs(int NumTabs, TRichEdit *RichEdit)
{
	if (DefTabWidth == 0 && Visible) {
		FormShow(this);
	}
	RichEdit->Paragraph->Tab[0] = 0;
	for (int i = 1;i< RichEdit->Paragraph->TabCount;i++)
	{
		RichEdit->Paragraph->Tab[i] = RichEdit->Paragraph->Tab[i-1]+DefTabWidth;
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::FormShow(TObject *Sender)
{
	DefTabWidth = Max(70,Canvas->TextWidth("+"+FormatString)+10);
  RefreshWizardControls();
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::SetFormatString(AnsiString Value)
{
	FFormatString = Value;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::btnNextClick(TObject *Sender)
{
	DoMoveForward();
  RefreshWizardControls();
}
//---------------------------------------------------------------------------
void __fastcall TfrmBasicWizard::btnBackClick(TObject *Sender)
{
		DoMoveBackward();
    RefreshWizardControls();
}
//---------------------------------------------------------------------------

