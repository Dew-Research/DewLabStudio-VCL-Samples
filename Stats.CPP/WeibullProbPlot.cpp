//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "WeibullProbPlot.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmWeibullProb *frmWeibullProb;
//---------------------------------------------------------------------------
__fastcall TfrmWeibullProb::TfrmWeibullProb(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Chart1->Tools->Clear();
	Chart1->FreeAllSeries(NULL);
	ProbSeries = new TStatProbSeries(Chart1);
	ProbSeries->Title = "Probability";
	ProbSeries->ParentChart = Chart1;
	ProbSeries->GetHorizAxis->Logarithmic = true;
	ProbSeries->ProbSeriesType = stWeibullSeries;
	ProbSeries->SeriesColor = clYellow;
	ProbSeries->Pointer->Style = psCircle;
	ProbSeries->SlopePen->Color = clWhite;


	ButtonPen1->LinkPen(ProbSeries->SlopePen);
	Memo1->Lines->Add("Weibull probability plot");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("The TStatSpecialSeries can be used to plot the Weibull probability Chart. "
				"Most properties can be customized (click the \"Edit\" button)");
	Data->Size(100);
	RandomWeibull(3,2.2,Data);
	Recalc();
}
//---------------------------------------------------------------------------
void __fastcall TfrmWeibullProb::Button2Click(TObject *Sender)
{
	EditSeries(this, ProbSeries);
}
//---------------------------------------------------------------------------
void __fastcall TfrmWeibullProb::Button1Click(TObject *Sender)
{
	AnsiString ResStr;
	TSample a,b;

	ResStr = InputBox("Data size","Number of points to be generated : ","100");
	try {
		Data->Size(StrToInt(ResStr));
	} catch (...) {
		Data->Size(100);
	}
	ResStr = InputBox("a","a: ",FormatFloat("0.00",3.0));
	try {
		a = StrToFloat(ResStr);
	} catch (...) {
		a = 3.0;
	}
	ResStr = InputBox("b","b: ",FormatFloat("0.00",2.2));
	try {
		b = StrToFloat(ResStr);
	} catch (...) {
		b = 2.2;
	}
	RandomWeibull(a,b,Data);
	Recalc();
}
//---------------------------------------------------------------------------
void __fastcall TfrmWeibullProb::Recalc()
{
  StatWeibullPlot(Data,X,Y,MinX,MaxX,MinY,MaxY,false);
	ProbSeries->MinX = MinX;
	ProbSeries->MaxX = MaxX;
	ProbSeries->MinY = MinY;
	ProbSeries->MaxY = MaxY;
	DrawValues(X,Y,ProbSeries);
}
