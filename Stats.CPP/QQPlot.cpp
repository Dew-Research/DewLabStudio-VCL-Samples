//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "QQPlot.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmQQPlot *frmQQPlot;
//---------------------------------------------------------------------------
__fastcall TfrmQQPlot::TfrmQQPlot(TComponent* Owner)
	: TfrmBasic(Owner)
{
	Chart1->FreeAllSeries(NULL);
	ProbSeries = new TStatProbSeries(Chart1);
	ProbSeries->Title = "Probability";
	ProbSeries->ParentChart = Chart1;
	ProbSeries->ProbSeriesType = stQQSeries;
	ProbSeries->SeriesColor = clYellow;
	ProbSeries->SlopePen->Color = clWhite;

	Memo1->Lines->Add("The Quantile-Quantile plot");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("The TStatSpecialSeries can be used to plot the Quantile-Quantile Chart-> "
			"Most properties can be customized (click the \"Edit\" button)");
	ButtonPen1->LinkPen(ProbSeries->SlopePen);
	XData->Size(100);
	XData->RandGauss(5,0.1);
	YData->Size(100);
	YData->RandGauss(3,0.3);
	Recalc();
}
//---------------------------------------------------------------------------
void __fastcall TfrmQQPlot::Button1Click(TObject *Sender)
{
	EditSeries(this,ProbSeries);
}
//---------------------------------------------------------------------------
void __fastcall TfrmQQPlot::Recalc()
{
  StatQQPlot(XData,YData,X,Y,MinX,MaxX,MinY,MaxY,false,false);
	ProbSeries->MinX = MinX;
	ProbSeries->MaxX = MaxX;
	ProbSeries->MinY = MinY;
	ProbSeries->MaxY = MaxY;
	DrawValues(X,Y,ProbSeries);
}

void __fastcall TfrmQQPlot::Button2Click(TObject *Sender)
{
	AnsiString ResStr;
	TSample Mu,Sigma;

	ResStr = InputBox("Data size","Number of points to be generated : ","100");
	try
	{
		XData->Size(StrToInt(ResStr));
	}
	catch (...) {
		XData->Size(100);
	}
	YData->Size(XData);
	ResStr = InputBox("Mu","Mu (average) : ",FormatFloat("0.00",3.5));
	try
	{
		Mu = StrToFloat(ResStr);
	}
	catch (...) {
		Mu = 3.5;
	}
	ResStr = InputBox("Sigma","Sigma (Std->dev->) : ",FormatFloat("0.00",0.1));
	try
	{
		Sigma = StrToFloat(ResStr);
	}
	catch (...) {
		Sigma = 0.1;
	}
	XData->RandGauss(Mu,Sigma);
	YData->RandGauss(Mu,Sigma);
	Recalc();
}
//---------------------------------------------------------------------------

