//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "TS_PACF.h"
#include "StatTimeSerAnalysis.hpp"
#include "Math387.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Chart"
#pragma resource "*.dfm"
TfrmTSPACF *frmTSPACF;
//---------------------------------------------------------------------------
__fastcall TfrmTSPACF::TfrmTSPACF(TComponent* Owner)
	: TfrmBasicChart(Owner)
{
	Memo1->Lines->Add("Data set in this example was collected by H. S. Lew of NIST in 1969 to measure "
			 "steel-concrete beam deflections. The response variable is the deflection of a "
			 "beam from the center point.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("In this example several plot techniques are used to chec if sample data is "
			 "randomly distributed.");
	Memo1->Lines->Add("[1] Data plot indicates indicates that the data do not have any significant shifts "
			 "in location or scale over time.");
	Memo1->Lines->Add("[2] The lag plot shows that the data are not random. The lag plot further "
			 "indicates the presence of a few outliers.");
	Memo1->Lines->Add("[3] When the randomness assumption is thus seriously violated, the histogram "
			 "can be ignored since determining the distribution of the data is only meaningful "
			 "when the data are random.");
	Memo1->Lines->Add("[4] The autocorrelation plot shows a distinct cyclic pattern. As with the lag plot, "
			 "this suggests a sinusoidal model.");
  // load prepared data 

	Data->LoadFromFile(CodePath() + "beam_deflection.vec");
	UpDown1->Max = Data->Length;

	EditLagsChange(this); // recalc and display
}
//---------------------------------------------------------------------------
void __fastcall TfrmTSPACF::ToVolumeSeries()
{
	TChartSeries* tmp = Series1;
	ChangeSeriesType(tmp,__classid(TVolumeSeries));
	((TVolumeSeries*)tmp)->YOrigin = 0.0;
	((TVolumeSeries*)tmp)->UseYOrigin = true;
	((TVolumeSeries*)tmp)->Pen->Width = 2;
}
void __fastcall TfrmTSPACF::ToLineSeries()
{
	TChartSeries* tmp = Series1;
	ChangeSeriesType(tmp,__classid(TLineSeries));
	((TLineSeries*)tmp)->Pointer->Visible = false;
	((TLineSeries*)tmp)->Pen->Width = 1;
}
void __fastcall TfrmTSPACF::ToPointSeries()
{
	TChartSeries* tmp = Series1;
	tmp->Pen->Width = 1;
	ChangeSeriesType(tmp,__classid(TPointSeries));
	((TPointSeries*)tmp)->Pointer->Style = psStar;
	((TPointSeries*)tmp)->Pointer->VertSize = 3;
	((TPointSeries*)tmp)->Pointer->HorizSize = 3;
	((TPointSeries*)tmp)->Pointer->Visible = true;
}
void __fastcall TfrmTSPACF::ToHistogramSeries()
{
	TChartSeries* tmp = Series1;
	ChangeSeriesType(tmp,__classid(THistogramSeries));
	((THistogramSeries*)tmp)->Pen->Width = 1;
}
void __fastcall TfrmTSPACF::RadioGroupPTClick(TObject *Sender)
{
	TVec *dX = NULL;
	TVec *dY = NULL;
	switch (RadioGroupPT->ItemIndex)
	{
		case 0:  { // Data set
					Chart1->Title->Text->Clear();
					Chart1->Title->Text->Add("Data set");
					Chart1->Axes->Left->Title->Caption = "Y";
					Chart1->Axes->Bottom->Title->Caption = "";
					Chart1->Axes->Left->Automatic = true;
					ToLineSeries();
					dY = Data;
				};break;
		case 1:  { // Lag plot
					Chart1->Title->Text->Clear();
					Chart1->Title->Text->Add("Lag plot");
					Chart1->Axes->Left->Title->Caption = "Y[i]";
					Chart1->Axes->Bottom->Title->Caption = "Y[i-1]";
					Chart1->Axes->Left->Automatic = true;
					ToPointSeries();
					// LAG = 1
					vACF->Length = Data->Length -1;
					vPACF->Length = Data->Length -1;
					vACF->Copy(Data,0,0,vACF->Length);
					vPACF->Copy(Data,1,0,vPACF->Length);
					dX = vACF;
					dY = vPACF;
				};break;
		case 2:  {  // ACF plot
					ACF(Data,vACF,Lags);
					Chart1->Title->Text->Clear();
					Chart1->Title->Text->Add("Autocorellation function");
					Chart1->Axes->Left->Title->Caption = "Autocorellation";
					Chart1->Axes->Bottom->Title->Caption = "lag";
					Chart1->Axes->Left->Automatic = false;
					Chart1->Axes->Left->SetMinMax(-1,1);
					ToVolumeSeries();
					dY = vACF;
				};break;
		case 3:  {  // PACF plot
					ACF(Data,vACF,Lags);
					PACF(vACF,vPACF);
					Chart1->Title->Text->Clear();
					Chart1->Title->Text->Add("Partial autocorellation function");
					Chart1->Axes->Left->Automatic = false;
					Chart1->Axes->Left->SetMinMax(-1,1);
					Chart1->Axes->Left->Title->Caption = "Partial autocorellation";
					Chart1->Axes->Bottom->Title->Caption = "lag";
					ToVolumeSeries();
					dY = vPACF;
				};break;
		case 4:  { // Histogram
					Chart1->Title->Text->Clear();
					Chart1->Title->Text->Add("Histogram");
					Chart1->Axes->Left->Title->Caption = "Count";
					Chart1->Axes->Bottom->Title->Caption = "Y";
					Chart1->Axes->Left->Automatic = true;
					ToHistogramSeries();
					Histogram(Data,20,vACF,vPACF,true);
					dX = vPACF;
					dY = vACF;
				};break;
	}
	if (dY) {
		if (dX) DrawValues(dX,dY,Series1);
		else DrawValues(dY,Series1);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmTSPACF::Button2Click(TObject *Sender)
{
	ViewValues(Data,"Sample data",true,false,true);
	UpDown1->Max = Data->Length;
}
//---------------------------------------------------------------------------

void __fastcall TfrmTSPACF::Chart1BeforeDrawSeries(TObject *Sender)
{
	int ypos = Chart1->Axes->Left->CalcYPosValue(0.0);
	Chart1->Axes->Bottom->CustomDraw(ypos+5,ypos+15,ypos,true);
}
//---------------------------------------------------------------------------

void __fastcall TfrmTSPACF::EditLagsChange(TObject *Sender)
{
	Lags = StrToInt(EditLags->Text);
  RadioGroupPTClick(this);  // Refresh chart 	
}
//---------------------------------------------------------------------------

void __fastcall TfrmTSPACF::Chart1AfterDraw(TObject *Sender)
{
	if (RadioGroupPT->ItemIndex == 2 || RadioGroupPT->ItemIndex == 3)
	{
		int ub, lb;
		if (RadioGroupPT->ItemIndex == 2) // ACF
		{
			ub = Chart1->Axes->Left->CalcYPosValue(NormalCDF(0.95,0,1.0));
			lb = Chart1->Axes->Left->CalcYPosValue(-NormalCDF(0.95,0,1.0));
		} else // PACF
		{
			ub = Chart1->Axes->Left->CalcYPosValue(2/System::Sqrt((double) Data->Length));
			lb = Chart1->Axes->Left->CalcYPosValue(-2/System::Sqrt((double) Data->Length));
		}
		Chart1->Canvas->ClipRectangle(Chart1->ChartRect);
		Chart1->Canvas->Pen->Color = clBlue;
		Chart1->Canvas->Font->Color = clWhite;
		Chart1->Canvas->Line(Chart1->ChartRect.Left,ub,Chart1->ChartRect.Right,ub);
		Chart1->Canvas->TextOut(Chart1->ChartRect.Left+100,ub+2,"95% confidence interval");
		Chart1->Canvas->Line(Chart1->ChartRect.Left,lb,Chart1->ChartRect.Right,lb);
		Chart1->Canvas->TextOut(Chart1->ChartRect.Left+100,lb-12,"95% confidence interval");
		Chart1->Canvas->UnClipRectangle();
	}
}
//---------------------------------------------------------------------------

