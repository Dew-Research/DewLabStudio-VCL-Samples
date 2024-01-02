//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ARIMAWizard.h"
#include "Math387.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Wizard"
#pragma resource "*.dfm"
TfrmARIMAWizard *frmARIMAWizard;
// input data
#define firstchartindex 4
#define lastchartindex 4

//---------------------------------------------------------------------------
__fastcall TfrmARIMAWizard::TfrmARIMAWizard(TComponent* Owner)
	: TfrmBasicWizard(Owner)
{
	chartData->AddSeries(new TLineSeries(chartData));
	// initial values for different parameters 
	MaxLag = -1;
	ForecastPer = 40;
	ACFLag = -1;
	p = 0;
	q = 0;
	d = 0;
	InitM = cfInitFixed;
	Alpha = 0.05;
  chartindex = firstchartindex;

	// update visual controls
	EditInnoLag->Text = IntToStr(MaxLag);
	editForecastNo->Text = IntToStr(ForecastPer);
	editAlpha->Text = FormatSample(FormatString,Alpha);
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::RefreshWizardControls()
{
	TfrmBasicWizard::RefreshWizardControls();


}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::DoMoveBackward()
{
  if ((PageControl->ActivePage == tsChart) && (chartindex>firstchartindex))
  {
    chartindex --;
    ChartReport(chartindex);
    movebackward = false;
  }
  else movebackward = true;

  TfrmBasicWizard::DoMoveBackward();
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::DoMoveForward()
{
  if ((PageControl->ActivePage == tsChart) && (chartindex<lastchartindex))
  {
    chartindex ++;
    moveforward = false;
  }
  else moveforward = true;

  TfrmBasicWizard::DoMoveForward();

  if (PageControl->ActivePage == tsTextReport) TextReports();
  else if (PageControl->ActivePage == tsChart) ChartReport(chartindex);
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::FormShow(TObject *Sender)
{
	PageControl->ActivePage = tsInputData;
	lblHeader->Caption = "Step 1 : Define time series";
	EditFmtString->Text = FormatString;
	RefreshWizardControls();
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::EditFmtStringChange(TObject *Sender)
{
	FormatString = EditFmtString->Text;
	try {
		FormatFloat(FormatString,1.22);  // dummy test 
	} catch (...) {
	}
	InfoReport();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::btnLoadClick(TObject *Sender)
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
		InfoReport();
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::InfoReport()
{
	TSample sd = TimeSeries->StdDev();
	lblLength->Caption = "size : "+IntToStr(TimeSeries->Length);
	lblMean->Caption = "mean : "+FormatSample(TimeSeries->Mean(),FormatString);
	lblStdDev->Caption = "std.dev. : "+FormatSample(sd,FormatString);
	lblVariance->Caption = "variance : "+FormatSample(sd*sd,FormatString);
	TransformTimeSeries();
	// transformed series ....
	sd = Data->StdDev();
	lblTrSize->Caption = "size : "+IntToStr(Data->Length);
	lblTrMean->Caption = "mean : "+FormatSample(Data->Mean(),FormatString);
	lblTrStdDev->Caption = "std.dev. : "+FormatSample(sd,FormatString);
	lblTrVar->Caption = "variance : "+FormatSample(sd*sd,FormatString);
	// draw transformed time series 
	RefreshChart();

}


void __fastcall TfrmARIMAWizard::editAROrderChange(TObject *Sender)
{
	p = StrToInt(editAROrder->Text);
	phi->Length = p;
	UpdateModelInfo();
	RefreshWizardControls();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::editMAOrderChange(TObject *Sender)
{
	q = StrToInt(editMAOrder->Text);
	theta->Length = q;
	UpdateModelInfo();
	RefreshWizardControls();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::editDChange(TObject *Sender)
{
  d = StrToInt(editD->Text);
	chkIntegrate->Enabled = (d>0);
	UpdateModelInfo();
	InfoReport();
}
//---------------------------------------------------------------------------
AnsiString __fastcall TfrmARIMAWizard::ModelText()
{
	if (d == 0)
	{
		if (q==0 && p!=0)  return "AR ("+IntToStr(p)+")";
		else if (p==0 && q!=0)  return "MA ("+IntToStr(q)+")";
		else if (p!=0 && q!=0)  return "ARMA ("+IntToStr(p)+","+IntToStr(q)+")";
	}
	else if (p!=0 || q!=0)  return "ARIMA ("+IntToStr(p)+","+IntToStr(q)+","+IntToStr(d)+")";
	return "";
}

void __fastcall TfrmARIMAWizard::UpdateModelInfo()
{
	lblModel->Caption = "Model : "+ModelText();
	rgARInit->Visible = (p!=0 && q==0);
	rgARMAInit->Visible = !(rgARInit->Visible);
	gbPhiThetaEdit->Visible = (InitM == cfInitFixed);
	gbInnovationsLag->Visible = (InitM == cfInitInno);
}
void __fastcall TfrmARIMAWizard::rgARInitClick(TObject *Sender)
{
	switch (rgARInit->ItemIndex)
	{
		case 0: InitM = cfInitYW;break;
		case 1: InitM = cfInitBurg;break;
		case 2: InitM = cfInitFixed;break;
	}
	UpdateModelInfo();
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::rgARMAInitClick(TObject *Sender)
{
	switch (rgARMAInit->ItemIndex)
	{
		case 0: InitM = cfInitInno;break;
		case 1: InitM = cfInitHannah;break;
		case 2: InitM = cfInitFixed;break;
	}
	UpdateModelInfo();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::btnEditPhiClick(TObject *Sender)
{
	ViewValues(phi,"Editing phi coeffs.",true,true,true);	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::btnEditThetaClick(TObject *Sender)
{
	ViewValues(theta,"Editing theta coeffs.",true,true,true);
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::EditInnoLagChange(TObject *Sender)
{
	MaxLag = StrToInt(EditInnoLag->Text);	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::editForecastNoChange(TObject *Sender)
{
	ForecastPer = StrToInt(editForecastNo->Text);	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::editACFLagChange(TObject *Sender)
{
	ACFLag = StrToInt(editACFLag->Text);	
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::TextReports()
{
	//this is the actual ts used in calculations 
	TransformTimeSeries();
	RichEdit->Enabled = false;
	RichEdit->Lines->Clear();
	Screen->Cursor = crHourGlass;
	try
	{
		RichEdit->DefAttributes->Color = clBlack;
		RichEdit->DefAttributes->Pitch = TFontPitch::fpFixed;
		RichEdit->DefAttributes->Style.Clear();
		RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
		RichEdit->SelAttributes->Size = 10;
		RichEdit->Lines->Add("Analyzing " +TimeSeries->Caption);
		RichEdit->Lines->Add("");
		RichEdit->Lines->Add("");
		InitEstReport();
		if (chkDoMLE->Checked) MLEReport();
		ForecastReport();
	}
	__finally
	{
		RichEdit->Enabled = true;
		Screen->Cursor = crDefault;
	}
}

void __fastcall TfrmARIMAWizard::InitEstReport()
{
	sVector d1,d2;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Preliminary estimates for "+ModelText()+ " process coefficients");
	int innolag;
	if (MaxLag<0) innolag = Math387::Ceil(10*Math387::Log10(Data->Length)); else innolag = MaxLag;
	TSample estVar = 1.0;
	if (p>0) 
	{
		d1->Size(p);
		d1->SetZero();
	}
	if (q>0) 
	{
		d2->Size(q);
		d2->SetZero();
	}

		// Retrieve coefficients
		switch (InitM)
		{
			cfInitYW:
				{
					ARYuleWalkerFit(Data,phi,estVar,d1);
					RichEdit->Lines->Add("Method used: Yule-Walker");
				};break;
			cfInitBurg:
				{
					ARBurgFit(Data,phi,estVar,d1);
					RichEdit->Lines->Add("Method used: Burg");
				};break;
			cfInitInno:
				{
					if (p==0) ARMAInnovationsFit(Data,theta,estVar,d2,innolag);
					else ARMAInnovationsFit(Data,phi,theta,estVar,d1,d2,innolag);
					RichEdit->Lines->Add("Method used: Innovations");
				};break;
		}

		if (InitM != cfInitFixed) RichEdit->Lines->Add("Estimated WN variance: " + FormatSample(FormatString,estVar));

		CausalReport();
		RichEdit->Lines->Add("");
		RichEdit->Lines->Add("Model coefficients:");
		RichEdit->Paragraph->TabCount = 5;
		SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
		RichEdit->SelAttributes->Color = clBlue;
		RichEdit->Lines->Add("Coefficient\tCoefficient\tStandard\tT-value\tP-value");
		RichEdit->SelAttributes->Color = clBlue;
		RichEdit->Lines->Add("name\testimate\terror\tHo:Coef.=0\t");
		if (p>0) RichEdit->Lines->Add(CoeffReport(phi,d1,"AR"));
		if (q>0) RichEdit->Lines->Add(CoeffReport(theta,d2,"MA"));
}

void __fastcall TfrmARIMAWizard::CausalReport()
{
	if (p>0)
	{
		if (CheckARMACoeffs(phi,true)) RichEdit->Lines->Add("Model causal"); else RichEdit->Lines->Add("Model not causal");
    }
	if (q>0)
	{
		if (CheckARMACoeffs(theta,false)) RichEdit->Lines->Add("Model invertible"); else RichEdit->Lines->Add("Model not invertible");
	}
}
void __fastcall TfrmARIMAWizard::editAlphaChange(TObject *Sender)
{
	try
	{
		Alpha = StrToFloat(editAlpha->Text);
		if (Alpha >1 || Alpha <0) 
		{
			Alpha = 0.05;
			editAlpha->Text = FormatSample(FormatString,Alpha);
		}
	}
	catch (...)
	{
		Alpha = 0.05;
		editAlpha->Text = FormatSample(FormatString,Alpha);
	}
	RefreshChart();
	
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::MLEReport()
{
	TSample mle;
	int iters = ARMAMLE(Data,phi,theta,Residuals,mle, dMean);
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Finding optimal coefficients (MLE)");
	RichEdit->Lines->Add("Number of iterations needed : "+IntToStr(iters));
	RichEdit->Lines->Add("-2log(likelihood) :"+FormatSample(FormatString,mle));
	CausalReport();
	RichEdit->Lines->Add("");
	RichEdit->Lines->Add("Model coefficients:");
	RichEdit->Paragraph->TabCount = 5;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Coefficient\tCoefficient\tStandard\tT-value\tP-value");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("name\testimate\terror\tHo:Coef.=0\t");
	if (p>0) RichEdit->Lines->Add(CoeffReport(phi,Residuals,"AR"));
	if (q>0) RichEdit->Lines->Add(CoeffReport(theta,Residuals,"MA"));
}

void __fastcall TfrmARIMAWizard::ForecastReport()
{
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Forecasting "+IntToStr(ForecastPer)+" points");
	Screen->Cursor = crHourGlass;
	try
	{
		int endperiod;
		ARMAForecast(Data,phi,theta,Residuals,ForecastPer,dMean,Forecasts,FStdDev);
		// add mean, if required 
		if (chkBoxRemoveMean->Checked && chkAddMean->Checked) Forecasts->Add(dMean);

		// integrate, if required 
		if (d>0 && chkIntegrate->Checked) 
		{
			sVector v0;
			// setup initial values for integration 
			TimeSeriesIntInit(TimeSeries,v0,d);
			// integrate d times
			Forecasts->Integrate(v0);
			endperiod = Data->Length + d-1;
		} else endperiod = Data->Length-1;

		RichEdit->Paragraph->TabCount = 3;
		SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
		RichEdit->SelAttributes->Color = clBlue;
		RichEdit->Lines->Add("Period\tForecast\tForecast std.dev.");
		for (int i = 1;i<=ForecastPer;i++)
			RichEdit->Lines->Add(IntToStr(i+endperiod)+"\t"+FormatSample(FormatString,Forecasts->Values[i-1])+"\t"
												+FormatSample(FormatString,FStdDev->Values[i-1]));

		RichEdit->Lines->Add("");
	}
	__finally
	{
		Screen->Cursor = crDefault;
	}

}

void __fastcall TfrmARIMAWizard::ChartReport(int Ind)
{
	Chart->FreeAllSeries(NULL);
	Chart->Title->Text->Clear();
	Chart->Legend->Visible = false;
	Chart->Axes->Bottom->Visible = false;
	Chart->Axes->Left->Automatic = true;
	sVector v1,v2;
	int offset;
	switch (Ind)
	{
		case firstchartindex: // forecasts 
			{
				Chart->Axes->Bottom->Visible = true;
				Chart->Legend->Visible = true;
				Chart->AddSeries(new TLineSeries(Chart));
				// forecasts 
				Chart->AddSeries(new TLineSeries(Chart));
				// upper and lower ci 
				Chart->AddSeries(new TLineSeries(Chart));
				Chart->AddSeries(new TLineSeries(Chart));
				Chart->Series[0]->Title = "Time series";
				Chart->Series[1]->Color = clWhite;
				Chart->Series[1]->Title = "Forecasts";
				Chart->Series[2]->Color = clYellow;
				Chart->Series[2]->Title = "CI";
				Chart->Series[3]->Color = clYellow;
				Chart->Series[3]->ShowInLegend = false;
				v1->Copy(Data);
				// add mean, if required 
				if (chkBoxRemoveMean->Checked && chkAddMean->Checked) v1->Add(dMean);
				// integrate
				if (d>0 && chkIntegrate->Checked) 
				{
					TimeSeriesIntInit(TimeSeries,v2,d,false);
					v1->Integrate(v2);
					DrawValues(v1,Chart->Series[0],d);
					offset = v1->Length+d;
				} else
				{
					DrawValues(v1,Chart->Series[0]);
					offset = v1->Length;
				}

				// forecasts 
				DrawValues(Forecasts,Chart->Series[1],offset);
				v1->Size(Forecasts);
				v2->Size(Forecasts);
				for (int i = 0;i<v1->Length;i++)
				{
					v1->Values[i] = NormalCDFInv(0.5*Alpha,Forecasts->Values[i],FStdDev->Values[i]);
					v2->Values[i] = NormalCDFInv(1.0 - 0.5*Alpha,Forecasts->Values[i],FStdDev->Values[i]);
				}
				DrawValues(v1,Chart->Series[2],offset);
				DrawValues(v2,Chart->Series[3],offset);
				Chart->Title->Text->Add(ModelText()+": Forecasting up to "+IntToStr(Forecasts->Length) + " points");
			}
		}
}
void __fastcall TfrmARIMAWizard::chkBoxRemoveMeanClick(TObject *Sender)
{
	InfoReport();
	chkAddMean->Enabled = chkBoxRemoveMean->Checked;	
}
//---------------------------------------------------------------------------
void __fastcall TfrmARIMAWizard::TransformTimeSeries()
{
	Data->Copy(TimeSeries);
	// differenciate, if needed 
	if (d>0) for (int i=1;i<=d;i++) Data->Difference();
	dMean = Data->Mean();
	// remove mean, if needed 
	if (chkBoxRemoveMean->Checked) Data->Add(-dMean);
}

void __fastcall TfrmARIMAWizard::RefreshChart()
{
	// recalculate lb and ub for acf and pacf chart 
	if (rgPlot->ItemIndex != 0)
	{
		chartUCL = NormalCDFInv(1.0-0.5*Alpha,0.0,1.0)/Sqrt((double) Data->Length);
		chartLCL = - chartUCL;
	}
	chartData->FreeAllSeries(NULL);
	chartData->Title->Text->Clear();
	chartData->Legend->Visible = false;
	chartData->Axes->Bottom->Visible = false;
	chartData->Axes->Left->Automatic = true;
	chartData->Axes->Bottom->Automatic = true;
	sVector v1,v2,v3;
	switch (rgPlot->ItemIndex)
	{
		 case	0: // dataset 
				{
					chartData->Axes->Bottom->Visible = true;
					chartData->AddSeries(new TLineSeries(chartData));
					chartData->Title->Text->Add("Transformed time series");
					DrawValues(Data,chartData->Series[0]);
				};break;
		 case	1: // acf 
				{
					chartData->Axes->Left->SetMinMax(-1.0,1.0);
					chartData->Axes->Bottom->AutomaticMinimum = false;
					chartData->Axes->Bottom->Minimum = -1.0;
					chartData->AddSeries(new TVolumeSeries(chartData));
					((TVolumeSeries*)chartData->Series[0])->UseYOrigin = true;
					((TVolumeSeries*)chartData->Series[0])->Pen->Width = 2;
					((TVolumeSeries*)chartData->Series[0])->YOrigin = 0.0;
					chartData->Title->Text->Add("Transformed time series ACF");
					ACF(Data,v1);
					DrawValues(v1,chartData->Series[0]);
				};break;
		 case 2: // pacf 
				{
					chartData->Axes->Left->SetMinMax(-1.0,1.0);
					chartData->Axes->Bottom->AutomaticMinimum = false;
					chartData->Axes->Bottom->Minimum = -1.0;
					chartData->AddSeries(new TVolumeSeries(chartData));
					((TVolumeSeries*)chartData->Series[0])->UseYOrigin = true;
					((TVolumeSeries*)chartData->Series[0])->Pen->Width = 2;
					((TVolumeSeries*)chartData->Series[0])->YOrigin = 0.0;
					chartData->Title->Text->Add("Transformed time series PACF");
					ACF(Data,v1);
					PACF(v1,v2);
					DrawValues(v2,chartData->Series[0]);
				};break;
	}
}
void __fastcall TfrmARIMAWizard::rgPlotClick(TObject *Sender)
{
	RefreshChart();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::chartDataBeforeDrawSeries(TObject *Sender)
{
  if (rgPlot->ItemIndex != 0 )
	{
		int ypos = chartData->Axes->Left->CalcYPosValue(0.0);
		chartData->Axes->Bottom->CustomDraw(ypos+10,ypos+15,ypos,false);
	}
}
//---------------------------------------------------------------------------

void __fastcall TfrmARIMAWizard::chartDataAfterDraw(TObject *Sender)
{
	if (rgPlot->ItemIndex != 0 ) // acf, pacf
	{
			int ypos = chartData->Axes->Left->CalcYPosValue(chartUCL);
			chartData->Canvas->Pen->Style = psSolid;
			chartData->Canvas->Pen->Width = 1;
			chartData->Canvas->Pen->Color = clBlue;
			chartData->Canvas->ClipRectangle(chartData->ChartRect);
			chartData->Canvas->MoveTo(chartData->ChartRect.Left,ypos);
			chartData->Canvas->LineTo(chartData->ChartRect.Right,ypos);
			chartData->Canvas->Font->Style = chartData->Canvas->Font->Style << TFontStyle::fsBold;
			chartData->Canvas->Font->Color = clBlue;
			chartData->Canvas->TextOut(chartData->ChartRect.Right-80,ypos-15,FormatSample("0.00%",100*(1-Alpha))+" CI");
			ypos = chartData->Axes->Left->CalcYPosValue(chartLCL);
			chartData->Canvas->MoveTo(chartData->ChartRect.Left,ypos);
			chartData->Canvas->LineTo(chartData->ChartRect.Right,ypos);
			chartData->Canvas->UnClipRectangle();
	}
}
//---------------------------------------------------------------------------
AnsiString __fastcall TfrmARIMAWizard::CoeffReport(TVec *coeff,TVec *cstderrs, AnsiString coefCaption)
{
	sVector tVals;
	sVector pVals;
	AnsiString Result;
	// Calculate t values
	// This is the t-test value for testing the hypothesis that j = 0 versus
	// the alternative that after removing the influence of all other X's.
	// The degrees of freedom is equal to the N minus the number of model parameters and differences.
	tVals->Divide(coeff, cstderrs);

	// calculate p values
	// The p-value is the probability that above T-statistic will take on a value
	// at least as extreme as the actually observed value, assuming that the null hypothesis
	// is true (i->e->, the regression estimate is equal to zero)-> If the p-value is less than
	// alpha, say 0->05, the null hypothesis is rejected->
	// This p-value is for a two-tail test->
	int df = Data->Length - p - q - d;
	StudentCDF(tVals,df,pVals);
	for (int i = 0;i<pVals->Length;i++) 
		pVals->Values[i] = 2.0*Math387::Min(pVals->Values[i],1.0-pVals->Values[i]);
	for (int i = 0;i<coeff->Length;i++)
	{
		Result = Result + coefCaption+"["+IntToStr(i+1)+"]\t"+FormatSample(FormatString,coeff->Values[i])+"\t";
		Result = Result + FormatSample(FormatString,cstderrs->Values[i])+"\t";
		Result = Result + FormatSample(FormatString,tVals->Values[i])+"\t";
		Result = Result + FormatSample(FormatString,pVals->Values[i])+"\n";
	}
	return Result;
}
