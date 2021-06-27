//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "NormalProbPlot.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmNormalProb *frmNormalProb;
//---------------------------------------------------------------------------
__fastcall TfrmNormalProb::TfrmNormalProb(TComponent* Owner)
	: TfrmBasic(Owner)
{
	// Setup probability plot series
	Chart1->FreeAllSeries(NULL);
	ProbSeries = new TStatProbSeries(Chart1);
	ProbSeries->Title = "Probability";
	ProbSeries->ParentChart = Chart1;
	ProbSeries->ProbSeriesType = stWeibullSeries;
	ProbSeries->SeriesColor = clYellow;
	ProbSeries->Pointer->Style = psCircle;
	ProbSeries->SlopePen->Color = clWhite;

	ubSeries = new TLineSeries(Chart1);
	ubSeries->ParentChart = Chart1;
	ubSeries->Color = clRed;
	ubSeries->Title = "95% CI";
	lbSeries = new TLineSeries(Chart1);
	lbSeries->ParentChart = Chart1;
	lbSeries->Color = clRed;
	lbSeries->ShowInLegend = false;

	ButtonPen1->LinkPen(ProbSeries->SlopePen);
	Memo1->Lines->Add("Normal probability plot");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("The TStatSpecialSeries can be used to plot the Normal probability Chart. "
			"Most properties can be customized (click the \"Edit\" button)");
	Data->Size(100);
	Data->RandGauss(3.5,0.1);
	Recalc();
}
//---------------------------------------------------------------------------
void __fastcall TfrmNormalProb::Button2Click(TObject *Sender)
{
	EditSeries(this,ProbSeries);	
}
//---------------------------------------------------------------------------
void __fastcall TfrmNormalProb::Button1Click(TObject *Sender)
{
	AnsiString ResStr;
	TSample Mu,Sigma;

	ResStr = InputBox("Data size","Number of points to be generated : ","100");
	try {
		Data->Size(StrToInt(ResStr));
	} catch (...) {
		Data->Size(100);
	}
	ResStr = InputBox("Mu","Mu (average) : ",FormatFloat("0.00",3.5));
	try {
		Mu = StrToFloat(ResStr);
	} catch (...) {
		Mu = 3.5;
	}
	ResStr = InputBox("Sigma","Sigma (Std.dev.) : ",FormatFloat("0.00",0.1));
	try {
		Sigma = StrToFloat(ResStr);
	} catch (...) {
		Sigma = 0.1;
	}
	Data->RandGauss(Mu,Sigma);
	Recalc();

}
//---------------------------------------------------------------------------
void __fastcall TfrmNormalProb::Recalc()
{
  StatNormalPlot(Data,X,Y,MinX,MaxX,MinY,MaxY,StdErrs,false);
	TSample zVal = NormalCDFInv(0.975,0,1);
	StdErrs->Mul(zVal);
	ub->Add(Y,StdErrs);
	lb->Sub(Y,StdErrs);
	ProbSeries->MinX = MinX;
	ProbSeries->MaxX = MaxX;
	ProbSeries->MinY = MinY;
	ProbSeries->MaxY = MaxY;
	DrawValues(X,Y,ProbSeries);
	DrawValues(X,ub,ubSeries);
	DrawValues(X,lb,lbSeries);
}
