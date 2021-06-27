//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "ANOVA1_Box.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmANOVA1Box *frmANOVA1Box;
//---------------------------------------------------------------------------
__fastcall TfrmANOVA1Box::TfrmANOVA1Box(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Memo1->Lines->Clear();
	Memo1->Lines->Add("TMtxANOVA component - Analysis of variance in one step");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Just drop the TMtxANOVA component on the form, define "
		"data, connect it to TStringGrid and .... that's it");
	Memo1->Lines->Add("By using TeeChart v5 (http://www.steema.com) series you can "
		"also visualize results of ANOVA. Most properies of chart are fully "
		"editable - just click \"Edit Chart\" button.");

	MtxAnova->Data->LoadFromFile(CodePath() + "ANOVA1_Data.mtx");
}
//---------------------------------------------------------------------------
void __fastcall TfrmANOVA1Box::Edit1Change(TObject *Sender)
{
	try
	{
		MtxAnova->Alpha = StrToFloat(Edit1->Text);
	} catch (...) {}
}
//---------------------------------------------------------------------------
void __fastcall TfrmANOVA1Box::FormShow(TObject *Sender)
{
	Edit1->Text = FormatFloat("0.00",MtxAnova->Alpha);
	Button2Click(Sender); // force recalculation
}
//---------------------------------------------------------------------------
void __fastcall TfrmANOVA1Box::Button2Click(TObject *Sender)
{
	MtxAnova->Recalc();
	sVector tmpVec;
	// draw box plots - one series for each column
	Chart1->FreeAllSeries();
	for (int i = 0;i<MtxAnova->Data->Cols;i++)
	{
			Chart1->AddSeries(new THorizBoxSeries(Chart1));
			tmpVec->GetCol(MtxAnova->Data,i);
			((THorizBoxSeries*)Chart1->Series[i])->Position = i;
			((THorizBoxSeries*)Chart1->Series[i])->Box->Brush->Color = clYellow;
			((THorizBoxSeries*)Chart1->Series[i])->Pen->Color = clRed;
			((THorizBoxSeries*)Chart1->Series[i])->SeriesColor = clRed;
			Chart1->Series[i]->Title = "Column " + IntToStr(i);
			tmpVec->SortAscend();
			DrawValues(tmpVec,Chart1->Series[i],0);
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmANOVA1Box::Button3Click(TObject *Sender)
{
	EditChart(this,Chart1);	
}
//---------------------------------------------------------------------------
void __fastcall TfrmANOVA1Box::Button1Click(TObject *Sender)
{
	ViewValues(MtxAnova->Data,"Editing data ...", true, false);
}
//---------------------------------------------------------------------------
