//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Quick_Start.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_REdit"
#pragma resource "*.dfm"
TfrmQuickStart *frmQuickStart;
//---------------------------------------------------------------------------
__fastcall TfrmQuickStart::TfrmQuickStart(TComponent* Owner)
	: TfrmBaseRichEdit(Owner)
{
		RichEdit1->DefAttributes->Size = 11;
		RichEdit1->SelAttributes->Size = 16;
		RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
//		RichEdit1->SelAttributes->Color = RGB(51,104,196);
		RichEdit1->Lines->Add("Quick start: Multiple linear regression.");
		RichEdit1->Lines->Add("");
		RichEdit1->Lines->Add("With Stats Master it""s not difficult to do complex tasks. Doing multiple linear "
				"regression is a peace of cake:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Lines->Add("Add MtxVecEdit, MtxVec to Uses section.");
		RichEdit1->Lines->Add("Drop TMtxMulLinReg component and TButton on the form.");
		RichEdit1->Lines->Add("Bring up the TMtxMulLinReg design time editor by double  clicking  on MtxMulLinReg1.");
		RichEdit1->Lines->Add("Define Y, A and (optionally) Weights. You can do this at design time or at runtime (load values from file, stream...)."
			"Close TMtxMulLinReg editor.");
		RichEdit1->Lines->Add("Double click on Button1 and add the following code:");
		RichEdit1->Paragraph->FirstIndent = 20;
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Lines->Add("");
		AnsiString St = "MtxMulLinReg1.Recalculate;\n"
					"ViewValues(MtxMulLinReg1.RegressResult.B,""Regression coefficients"",True,False);";
		RichEdit1->SelAttributes->Name = "Courier New";
		RichEdit1->Lines->Add(St);
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Lines->Add("");
		RichEdit1->Lines->Add("Other thing to try:");
		RichEdit1->Lines->Add("");
		RichEdit1->Paragraph->FirstIndent = 10;
		RichEdit1->Paragraph->Numbering = nsBullet;
		RichEdit1->Lines->Add("Access RegressResult properties (YCalc, Residuals). Draw these  values by using "
				"DrawValues method (in this case add MtxVecTee to Uses section).");
		RichEdit1->Lines->Add("Copy Y, A data from Excel table. Repeat procedure.");
		RichEdit1->Lines->Add("Load Y,A data from ASCII file (demonstrated in demo). Repeat  procedure.");
		RichEdit1->Paragraph->FirstIndent = 0;
		RichEdit1->Paragraph->Numbering = nsNone;
		RichEdit1->Lines->Add("");
}
//---------------------------------------------------------------------------
