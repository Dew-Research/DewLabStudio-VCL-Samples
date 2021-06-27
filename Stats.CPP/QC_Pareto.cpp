//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "QC_Pareto.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Chart"
#pragma resource "*.dfm"
TfrmParetoChart *frmParetoChart;
//---------------------------------------------------------------------------
__fastcall TfrmParetoChart::TfrmParetoChart(TComponent* Owner)
	: TfrmBasicChart(Owner)
{
	Memo1->Lines->Add("The Pareto and Pareto Cumulative Charts");
	Memo1->Lines->Add("As with all TeeChart series, all parts of chart are fully"
				" configurable (click the \"Edit Chart\" button). "
				"You can also export result chart to different graphic"
				" formats. Click on \"Edit Chart\" button. Then select the \"Export\" tab...");

	Data->LoadFromFile(CodePath() + "QC_Pareto.vec");
}
//---------------------------------------------------------------------------
void __fastcall TfrmParetoChart::Button2Click(TObject *Sender)
{
	ViewValues(Data,"Data",true,false);
}
//---------------------------------------------------------------------------
void __fastcall TfrmParetoChart::Recalc()
{
	sVector DrawVec;
	sVector CumSumVec;

	Series2->Active = RadioGroup1->ItemIndex == 1;
	Series1->Marks->Visible = RadioGroup1->ItemIndex == 0;

	DrawVec->Copy(Data);
	// that's all there is to Pareto
	DrawVec->SortDescend();
	// draw pareto chart
	DrawValues(DrawVec,Series1,0.0,1.0,false);
	if (RadioGroup1->ItemIndex == 1)
	{
			// Cumulative pareto
			CumSumVec->CumSum(DrawVec);
			Factor = 100.0 / DrawVec->Sum();
			CumSumVec->Scale(Factor);
			// draw cumulatiove pareto chart
			Series2->GetVertAxis->SetMinMax(0.0,100);
			Series1->GetVertAxis->SetMinMax(0.0,DrawVec->Sum());
			DrawValues(CumSumVec,Series2, 0.0, 1.0,false);
	} else Series1->GetVertAxis->Automatic = true;
}

void __fastcall TfrmParetoChart::RadioGroup1Click(TObject *Sender)
{
	Recalc();
}
//---------------------------------------------------------------------------

void __fastcall TfrmParetoChart::FormShow(TObject *Sender)
{
	Recalc();
}

//---------------------------------------------------------------------------

void __fastcall TfrmParetoChart::Series2GetMarkText(TChartSeries *Sender, int ValueIndex,
		  UnicodeString &MarkText)
{
	MarkText = FormatFloat("0.00 %", (*Series2->YValues)[ValueIndex]);
}
//---------------------------------------------------------------------------

