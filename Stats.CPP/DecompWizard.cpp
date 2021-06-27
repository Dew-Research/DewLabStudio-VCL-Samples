//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "DecompWizard.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Wizard"
#pragma resource "*.dfm"
TfrmDecompositionWizard *frmDecompositionWizard;
#define	firstchartindex  2
#define	lastchartindex  7

//---------------------------------------------------------------------------
__fastcall TfrmDecompositionWizard::TfrmDecompositionWizard(TComponent* Owner)
	: TfrmBasicWizard(Owner)
{
	L = 1;
	ForNum = 10;
	ForCycle = 1.0;
	editCycle->Text = FormatSample("0.00",ForCycle);
  chartindex = firstchartindex;
}
//---------------------------------------------------------------------------
void __fastcall TfrmDecompositionWizard::btnLoadClick(TObject *Sender)
{
	TStringList* sl;
	if (OpenDialog->Execute())
	try
	{
		// 1 = native format, 2=column text file
		if (OpenDialog->FilterIndex == 1) TimeSeries->LoadFromFile(OpenDialog->FileName);
		else if (OpenDialog->FilterIndex == 2)
		{
			sl = new TStringList();
			try
			{
				sl->LoadFromFile(OpenDialog->FileName);
				TimeSeries->StringsToValues(sl);
			}
			__finally
			{
				delete sl;
			}
		}
		TimeSeries->Caption = OpenDialog->FileName;
	}
	__finally
	{
		TransformTimeSeries();
		RefreshChart();
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmDecompositionWizard::TransformTimeSeries()
{
  Data->Copy(TimeSeries);
	udSeasons->Max = TimeSeries->Length;
}

void __fastcall TfrmDecompositionWizard::MovAve()
{
	int MInd;
	if (L <=2) MovingAverage(Yv,L,Mv,MInd);
	else
	{
		sVector v1;
		int eind = (Yv->Length-1)+l2+1;
		v1->Size(Yv->Length+l2*2);
		v1->Copy(Yv,0,l2+1,Yv->Length);
		for (int i=0;i<=l2;i++)
		{
			v1->Values[i] = v1->Values[i+L];
			v1->Values[eind+i-1] = v1->Values[eind-L+i];
		}
		MovingAverage(v1,L,Mv,MInd);
	}
}

void __fastcall TfrmDecompositionWizard::Trend()
{
	sVector x;
	sVector bv;
	x->Size(Mv);
	x->Ramp();
	// perform fit on truncated MA because first l2+1 and last l2+1  problem (see NIST pages)
	x->SetSubRange(l2,x->Length-2*l2);
	Mv->SetSubRange(l2,Mv->Length-2*l2);
	LineFit(bv,x,Mv);
	// but evaluate on whole interval
	x->SetSubRange();
	Mv->SetSubRange();
	a = bv->Values[0];
	b = bv->Values[1];
	double tmp[] = {a,b};
	LineEval(tmp,1,x,Tv);
}

void __fastcall TfrmDecompositionWizard::Seasonality()
{
  Kv->Divide(Yv,Mv);
	Sv->Size(L);
	for (int i = 0;i<L;i++)
	{
		TSample sum = 0;
		int j = 0;
		int n = 0;
		while (j+i<Kv->Length)
		{
			sum = sum + Kv->Values[j+i];
			j = j + L;
			n = n+1;
		}
		if (n>1) Sv->Values[i] = sum/n;
		else Sv->Values[i] = 0.0;
	}
}

void __fastcall TfrmDecompositionWizard::Randomness()
{
	int plen = Sv->Length;
	Rv->Size(Kv);
	for (int i = 0;i<Rv->Length;i++) Rv->Values[i] = Kv->Values[i]/Sv->Values[i % plen];
}

void __fastcall TfrmDecompositionWizard::DoForecasts()
{
	sVector xv;
	Forecasts->Size(Data->Length + ForNum);
	// Mean
	Forecasts->SetVal(dmean);

	// Trend component
	xv->Size(Forecasts);
	xv->Ramp();
	double tmp[] = {a,b};
	LineEval(tmp,1,xv,Tv);
	Forecasts->Mul(Tv);

	// Seasonality
	Sv->Resize(Forecasts->Length);
	for (int i=L;i<Sv->Length;i++) Sv->Values[i] = Sv->Values[i % L];
	Forecasts->Mul(Sv);

	// add cycle factor, if specified
	if (chkCycle->Checked)
	{
		Cv->Resize(Forecasts->Length);
		Cv->SetVal(StrToFloat(editCycle->Text),Data->Length,ForNum);
		Forecasts->Mul(Cv);
	}

	// define R factor as 1->0 for forecasts
	Rv->Resize(Forecasts->Length);
	Rv->SetVal(1.0,Data->Length,ForNum);

	// calculate residuals
	Residuals->Size(Data);
	Residuals->Sub(Data,Forecasts,0,0,0,Data->Length);
}

void __fastcall TfrmDecompositionWizard::DoCalc()
{
  // read parameters 
	L = StrToInt(editSeasons->Text);
	l2 = (L-1) / 2; //l/2 period end index
	ForNum = StrToInt(editForecasts->Text);

	// #1 : Remove mean
	dmean = Data->Mean();
	Yv->Copy(Data);
	Yv->Mul(1.0/dmean);
	DrawValues(Yv,chartData->Series[0]);

	// #2 : Moving average on Y
	MovAve();
	DrawValues(Mv,chartData->Series[1]);

	// #3 : Trend on M
	Trend();
	DrawValues(Tv,chartData->Series[2]);

	// #4 : Cycle
	Cv->Divide(Mv,Tv);

	// #5 :  Seasonality
	Seasonality();

	// #6 : Randomness
	Randomness();
}

void __fastcall TfrmDecompositionWizard::RefreshChart()
{
	DrawValues(TimeSeries,chartData->Series[0],0,1,false);
	DoCalc();
}

void __fastcall TfrmDecompositionWizard::TextReport()
{
	DoCalc();
	DoForecasts();
	RichEdit->Lines->Clear();
	RichEdit->Paragraph->TabCount = 8;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);

	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Forecast summary");
	AnsiString st = "Mean x (Trend) x ";
	if (chkCycle->Checked) st = st + "(Cycle) x ";
	st = st + "(Season)";
	RichEdit->Lines->Add("Model:\t"+st);
	RichEdit->Lines->Add("Rows:\t"+IntToStr(Data->Length));
	RichEdit->Lines->Add("Mean:\t"+FormatSample(FormatString,TimeSeries->Mean()));
	RichEdit->Lines->Add("Residuals RMS:\t"+FormatSample(FormatString,Residuals->RMS()));


	RichEdit->Lines->Add("Trend\t("+FormatSample(FormatString,a) + ") +("+
		FormatSample(FormatString,b)+") x Time");
	RichEdit->Lines->Add("Seasons:\t"+IntToStr(L));
	RichEdit->Lines->Add("Seasonal component ratio:");
	RichEdit->Lines->Add("No\tRatio");
	for (int i=0;i<L;i++)
		RichEdit->Lines->Add(IntToStr(i+1)+"\t"+FormatSample(FormatString,Sv->Values[i]));
	RichEdit->Lines->Add("");

	// forecasts section 
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Forecast");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Time\tForeast\tActual\tResiduals\tTrend factor\tCycle\tSeason\tRandomness");
	for (int i = 0;i<Forecasts->Length;i++)
	{
		st = IntToStr(i)+"\t"+FormatSample(FormatString,Forecasts->Values[i])+"\t";
		if (i<Data->Length) st = st + FormatSample(FormatString,Data->Values[i])+"\t"+FormatSample(FormatString,Residuals->Values[i])+"\t";
		else st = st+"\t\t";
		st = st + FormatSample(FormatString,Tv->Values[i]) + "\t";
		if (chkCycle->Checked) st = st + FormatSample(FormatString,Cv->Values[i])+"\t"; else st = st + "\t";
		st = st + FormatSample(FormatString,Sv->Values[i])+"\t";
		st = st + FormatSample(FormatString,Rv->Values[i]);
		RichEdit->Lines->Add(st);
	}
}

void __fastcall TfrmDecompositionWizard::ChartReport(int AIndex)
{
	reportChart->FreeAllSeries(NULL);
	reportChart->Title->Text->Clear();
	reportChart->Legend->Visible = false;
	switch (AIndex)
	{
		case firstchartindex: // forecasts
		{
			reportChart->Legend->Visible = True;
			reportChart->Title->Text->Add("Forecasts");
			reportChart->AddSeries(new TPointSeries(reportChart));
			reportChart->AddSeries(new TLineSeries(reportChart));
			((TPointSeries*)reportChart->Series[0])->Title = "Time series";
			((TPointSeries*)reportChart->Series[0])->Pointer->VertSize = 2;
			((TPointSeries*)reportChart->Series[0])->Pointer->HorizSize = 2;
			reportChart->Series[1]->Title = "Forecasts";
			DrawValues(TimeSeries,reportChart->Series[0]);
			DrawValues(Forecasts,reportChart->Series[1]);
		};break;
		case firstchartindex+1: // residuals
		{
			reportChart->Title->Text->Add("Residuals");
			reportChart->AddSeries(new TLineSeries(reportChart));
			DrawValues(Residuals,reportChart->Series[0]);
		};break;
		case firstchartindex+2: // Trend factor plot
		{
			reportChart->Title->Text->Add("Trend factor (T)");
			reportChart->AddSeries(new TBarSeries(reportChart));
			((TBarSeries*)reportChart->Series[0])->Marks->Visible = false;
			((TBarSeries*)reportChart->Series[0])->YOrigin = 1.0;
			((TBarSeries*)reportChart->Series[0])->UseYOrigin = true;
			DrawValues(Tv,reportChart->Series[0]);
		};break;
		case firstchartindex+3: // Cycle
		{
			reportChart->Title->Text->Add("Cycle factor (C)");
			reportChart->AddSeries(new TBarSeries(reportChart));
			((TBarSeries*)reportChart->Series[0])->Marks->Visible = false;
			((TBarSeries*)reportChart->Series[0])->YOrigin = 1.0;
			((TBarSeries*)reportChart->Series[0])->UseYOrigin = true;
			DrawValues(Cv,reportChart->Series[0]);
		};break;
		case firstchartindex+4: // Seasonality
		{
			reportChart->Title->Text->Add("Seasonality factor (S)");
			reportChart->AddSeries(new TLineSeries(reportChart));
			DrawValues(Sv,reportChart->Series[0]);
		};break;
		case firstchartindex+5: // Randomness
		{
			reportChart->Title->Text->Add("Randomness factor (R)");
			reportChart->AddSeries(new TLineSeries(reportChart));
			DrawValues(Rv,reportChart->Series[0]);
		};break;
 }

}

void __fastcall TfrmDecompositionWizard::editSeasonsChange(TObject *Sender)
{
	try
	{
		L = StrToInt(editSeasons->Text);
	}
	catch (...) {
		L = 1;
		editSeasons->Text = "1";
	}
	TransformTimeSeries();
	RefreshChart();
}
//---------------------------------------------------------------------------
void __fastcall TfrmDecompositionWizard::RefreshWizardControls()
{
	TfrmBasicWizard::RefreshWizardControls();
  if (PageControl->ActivePage == tsInputData) btnNext->Enabled = (TimeSeries->Length > 0);
  else if (PageControl->ActivePage == tsChartReport) btnNext->Enabled = chartindex < lastchartindex;
}
void __fastcall TfrmDecompositionWizard::FormShow(TObject *Sender)
{
	PageControl->ActivePage = tsInputData;
	lblHeader->Caption = "Step 1 : Decomposition forecasting parameters";
	EditFmtString->Text = FormatString;
	RefreshWizardControls();
}
//---------------------------------------------------------------------------
void __fastcall TfrmDecompositionWizard::DoMoveBackward()
{
  if ((PageControl->ActivePage == tsChartReport) && (chartindex>firstchartindex))
	{
    chartindex --;
    ChartReport(chartindex);
    movebackward = false;
  }
  else movebackward = true;

  TfrmBasicWizard::DoMoveBackward();
}
//---------------------------------------------------------------------------
void __fastcall TfrmDecompositionWizard::DoMoveForward()
{
  if ((PageControl->ActivePage == tsChartReport) && (chartindex<lastchartindex))
  {
    chartindex ++;
    moveforward = false;
  }
  else moveforward = true;

  TfrmBasicWizard::DoMoveForward();

  if (PageControl->ActivePage == tsTextReport) TextReport();
  else if (PageControl->ActivePage == tsChartReport) ChartReport(chartindex);
}
//---------------------------------------------------------------------------
void __fastcall TfrmDecompositionWizard::EditFmtStringChange(TObject *Sender)
{
	FormatString = EditFmtString->Text;
	try
	{
		FormatFloat(FormatString,1.22);  // dummy test
	}
	catch (...) {}
}
//---------------------------------------------------------------------------


void __fastcall TfrmDecompositionWizard::editForecastsChange(TObject *Sender)
{
	try {
		ForNum = StrToInt(editForecasts->Text);
	}
	catch (...) {
		ForNum = 10;
		editForecasts->Text = "10";
	}
}
//---------------------------------------------------------------------------

void __fastcall TfrmDecompositionWizard::chkCycleClick(TObject *Sender)
{
  Label3->Enabled = chkCycle->Checked;
	editCycle->Enabled = chkCycle->Checked;
}
//---------------------------------------------------------------------------

