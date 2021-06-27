//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MLRegWizard.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Wizard"
#pragma resource "*.dfm"
TfrmMulLinRegWiz *frmMulLinRegWiz;

// input data
#define firstchartindex 3
#define lastchartindex 6

//---------------------------------------------------------------------------
__fastcall TfrmMulLinRegWiz::TfrmMulLinRegWiz(TComponent* Owner)
	: TfrmBasicWizard(Owner)
{
	MtxAnova = new TMtxAnova(this);
	MtxMulLinReg = new TMtxMulLinReg(this);
	TeeCommander1->ButtonSave->Visible = false;
	TeeCommander1->ButtonPrint->Visible = false;
  chartindex = firstchartindex;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMulLinRegWiz::DoMoveForward()
{
  if ((PageControl->ActivePage == tsChart) && (chartindex<lastchartindex))
	{
  	chartindex ++;
    moveforward = false;
  }
  else moveforward = true;

  TfrmBasicWizard::DoMoveForward();

  if (PageControl->ActivePage == tsTextReport)
  {
    MtxMulLinReg->Recalc();
    TextReport();
  }
  else if (PageControl->ActivePage == tsChart) ChartReport(chartindex);
}
//---------------------------------------------------------------------------
void __fastcall TfrmMulLinRegWiz::DoMoveBackward()
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
void __fastcall TfrmMulLinRegWiz::RefreshWizardControls()
{
	TfrmBasicWizard::RefreshWizardControls();
  if (PageControl->ActivePage == tsInputData) btnNext->Enabled = MtxMulLinReg->ValidSystem();
  else if (PageControl->ActivePage == tsChart) btnNext->Enabled = chartindex < lastchartindex;
}
//---------------------------------------------------------------------------
void __fastcall TfrmMulLinRegWiz::BasicRegStatReport()
{
	RichEdit->Paragraph->TabCount = 1;
	RichEdit->Paragraph->Tab[0] = 100;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Basic regression statistics");
	RichEdit->Lines->Add("Residuals variance : \t" + FormatFloat(FormatString,MtxMulLinReg->RegressStatistics->ResidualVar));
	RichEdit->Lines->Add("R squared : \t"+ FormatFloat(FormatString,MtxMulLinReg->RegressStatistics->R2));
	RichEdit->Lines->Add("Adjusted R squared :\t"+ FormatFloat(FormatString,MtxMulLinReg->RegressStatistics->AdjustedR2));
	RichEdit->Lines->Add("F value : \t"+ FormatFloat(FormatString,MtxMulLinReg->RegressStatistics->F));
	RichEdit->Lines->Add("Probability of F : \t"+ FormatFloat(FormatString,MtxMulLinReg->RegressStatistics->SignifProb));
	RichEdit->Lines->Add("");
}

void __fastcall TfrmMulLinRegWiz::CorrMtxReport()
{
	sMatrix AdjCorrMtx;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Correlation matrix");
	AdjCorrMtx->Size(MtxMulLinReg->A->Rows,MtxMulLinReg->A->Cols + 1);
	RichEdit->Paragraph->TabCount = AdjCorrMtx->Cols;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	AdjCorrMtx->Copy(MtxMulLinReg->A,0,0,0,0,MtxMulLinReg->A->Rows,MtxMulLinReg->A->Cols,false);
	AdjCorrMtx->SetCol(MtxMulLinReg->Y,MtxMulLinReg->A->Cols);
	CorrCoef(AdjCorrMtx,tmpMtx);
	tmpMtx->ValuesToStrings(RichEdit->Lines, "\t",TFixedTextAlign::ftaNone, FormatString);
	RichEdit->Lines->Add("");
}

void __fastcall TfrmMulLinRegWiz::DescStatReport()
{
	RichEdit->Paragraph->TabCount = 5;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Descriptive Statistics");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Variable\tMean\tStd.Dev.\t"
											"Min\tMax");
	TSample tmpMin,tmpMean,tmpStdDev,tmpMax;
	// basic descriptive statistics
	for (int i = 0;i<MtxMulLinReg->A->Cols;i++)
	{
		tmpVec->GetCol(MtxMulLinReg->A,0,i,MtxMulLinReg->A->Rows);
		tmpMean = tmpVec->Mean();
		tmpStdDev = tmpVec->StdDev(tmpMean);
		tmpMax = tmpVec->Max();
		tmpMin = tmpVec->Min();
		AnsiString LineText ="A column "+IntToStr(i)+"\t";
		LineText = LineText + FormatFloat(FormatString,tmpMean)+"\t";
		LineText = LineText + FormatFloat(FormatString,tmpStdDev) + "\t";
		LineText = LineText + FormatFloat(FormatString,tmpMin) + "\t";
		LineText = LineText + FormatFloat(FormatString,tmpMax);
		RichEdit->Lines->Add(LineText);
	}
	tmpMean = MtxMulLinReg->Y->Mean();
	tmpStdDev = MtxMulLinReg->Y->StdDev(tmpMean);
	tmpMax = MtxMulLinReg->Y->Max();
	tmpMin = MtxMulLinReg->Y->Min();
	AnsiString LineText = "Y column\t";
	LineText = LineText + FormatFloat(FormatString,tmpMean) + "\t";
	LineText = LineText + FormatFloat(FormatString,tmpStdDev) + "\t";
	LineText = LineText + FormatFloat(FormatString,tmpMin) + "\t";
	LineText = LineText + FormatFloat(FormatString,tmpMax);
	RichEdit->Lines->Add(LineText);
	RichEdit->Lines->Add("");
}

void __fastcall TfrmMulLinRegWiz::RegCoeffReport()
{
	sVector TVals, PVals;
	TVals->Divide(MtxMulLinReg->RegressResult->B,MtxMulLinReg->RegressResult->BStdDev);

	/* calculate p values */
	/* The p-value is the probability that above T-statistic will take on a value
		at least as extreme as the actually observed value, assuming that the null hypothesis
		is true (i.e., the regression estimate is equal to zero). If the p-value is less than
		alpha, say 0.05, the null hypothesis is rejected.
		This p-value is for a two-tail test.
	*/
	StudentCDF(TVals,MtxMulLinReg->A->Rows - MtxMulLinReg->A->Cols -1,PVals);
	for (int i = 0;i<PVals->Length;i++)
		PVals->Values[i] = 2.0*Math387::Min(PVals->Values[i],1.0 - PVals->Values[i]);

	AnsiString CIText = FormatFloat("0.00 %",100*(1-MtxMulLinReg->Alpha));
	RichEdit->Paragraph->TabCount = 7;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Regression coefficients");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Independent\tRegression\tStandard"
		"\tT Value\tP Value\tLower\tUpper");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("variable\tcoefficient\tdeviation\tHo: B=0"
		"\t\t"+CIText+" CI\t"+CIText+" CI");
	// regression coefficients
	for (int i = 0;i<MtxMulLinReg->RegressResult->B->Length;i++)
	{
		AnsiString LineText = "Variable " + IntToStr(i)+"\t";
		LineText = LineText + FormatFloat(FormatString,MtxMulLinReg->RegressResult->B->Values[i])+"\t";
		LineText = LineText + FormatFloat(FormatString,MtxMulLinReg->RegressResult->BStdDev->Values[i])+"\t";
		LineText = LineText + FormatFloat(FormatString,TVals->Values[i])+"\t";
		LineText = LineText + FormatFloat(FormatString,PVals->Values[i])+"\t";
		LineText = LineText + FormatFloat(FormatString,MtxMulLinReg->RegressResult->BConfInt->Values[i][0])+"\t";
		LineText = LineText + FormatFloat(FormatString,MtxMulLinReg->RegressResult->BConfInt->Values[i][1]);
		RichEdit->Lines->Add(LineText);
	}
	RichEdit->Lines->Add("");
}

void __fastcall TfrmMulLinRegWiz::ResidualReport()
{
	RichEdit->Paragraph->TabCount = 3;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Residuals");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Actual\tPredicted\tResidual");
	// regression coefficients
	for (int i = 0;i<MtxMulLinReg->Y->Length;i++)
	{
		AnsiString LineText = FormatFloat(FormatString,MtxMulLinReg->Y->Values[i])+"\t";
		LineText = LineText + FormatFloat(FormatString,MtxMulLinReg->RegressResult->YCalc->Values[i])+"\t";
		LineText = LineText + FormatFloat(FormatString,MtxMulLinReg->RegressResult->Residuals->Values[i]);
		RichEdit->Lines->Add(LineText);
	}
	RichEdit->Lines->Add("");
}

AnsiString __fastcall HypResult(THypothesisResult hypres)
{
	if (hypres == hrNotReject) return "Accept";
	else if (hypres == hrReject) return "Reject";
	else return "";
}

void __fastcall TfrmMulLinRegWiz::NormalityReport()
{
	THypothesisResult hres; 
	RichEdit->Paragraph->TabCount = 4;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Normality tests on residuals");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Test\tTest\tProbability\tReject Ho");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("name\tvalue\tlevel\talpha="+FormatSample("0.00 %",100*(1-MtxMulLinReg->Alpha)));

	TSample signif, statval;
	// Shapiro-Wilks
	// Input values must be ordered and unique
	Unique(MtxMulLinReg->RegressResult->Residuals,tmpVec);
	statval = ShapiroWilks(tmpVec,hres,signif,htTwoTailed,MtxMulLinReg->Alpha);
	RichEdit->Lines->Add("Shapiro-Wilks\t"+FormatSample(FormatString,statval)+"\t"+FormatSample(FormatString,signif)+"\t"+HypResult(hres));

	// Shapiro-Francia
	statval = ShapiroFrancia(tmpVec,hres,signif,htTwoTailed,MtxMulLinReg->Alpha);
	RichEdit->Lines->Add("Shapiro-Francia\t"+FormatSample(FormatString,statval)+"\t"+FormatSample(FormatString,signif)+"\t"+HypResult(hres));

	// Anderson-Darling
	tmpVec->Copy(MtxMulLinReg->RegressResult->Residuals);
	tmpVec->SortAscend();
	statval = AndersonDarling(tmpVec,distNORMAL,hres,signif,MtxMulLinReg->Alpha);
	RichEdit->Lines->Add("Anderson-D->\t"+FormatSample(FormatString,statval)+"\t"+FormatSample(FormatString,signif)+"\t"+HypResult(hres));

	// Kolmogorov-Smirnov
	statval = GOFKolmogorov(MtxMulLinReg->RegressResult->Residuals,hres,signif,NULL,NULL,htTwoTailed,MtxMulLinReg->Alpha);
	RichEdit->Lines->Add("K-S\t"+FormatSample(FormatString,statval)+"\t"+FormatSample(FormatString,signif)+"\t"+HypResult(hres));

	// Bera-Jarque
	statval = GOFBeraJarqueTest(MtxMulLinReg->RegressResult->Residuals,hres,signif,MtxMulLinReg->Alpha);
	RichEdit->Lines->Add("Bera-Jarque\t"+FormatSample(FormatString,statval)+"\t"+FormatSample(FormatString,signif)+"\t"+HypResult(hres));

	RichEdit->Lines->Add("");
}

void __fastcall TfrmMulLinRegWiz::SerCorrReport()
{
	 RichEdit->Paragraph->TabCount = 2;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Serial correlation (up to 10th lag)");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Lag\tCorrelation");
	int Lags = Math387::Min(MtxMulLinReg->RegressResult->Residuals->Length,11); // max 10 lags
	TSample SS = Math387::Power(MtxMulLinReg->RegressResult->Residuals->NormL2(),2); // sum of squares
	tmpVec->AutoCorrNormal(MtxMulLinReg->RegressResult->Residuals,Lags);
	tmpVec->Scale(1.0/SS);
	// regression coefficients 
	for (int i = 1;i<tmpVec->Length;i++)
	{
		AnsiString LineText = IntToStr(i)+"\t";
		LineText = LineText + FormatFloat(FormatString,tmpVec->Values[i]);
		RichEdit->Lines->Add(LineText);
	}
	/*RichEdit->Lines->Add("Serial correlations are significant if their "
										" absolute values are greater than : " + FormatFloat(FormatString,Power(2,Sqrt(tmpVec->Length))));
	*/
	if (tmpVec->Length >= 2)
	{
		RichEdit->Lines->Add("");
		RichEdit->Lines->Add("Durbin-Watson value : " + FormatFloat(FormatString,2.0*(1.0-tmpVec->Values[1])));
	}
	RichEdit->Lines->Add("");
}


void __fastcall TfrmMulLinRegWiz::TextReport()
{
	RichEdit->Enabled = false;
	RichEdit->Lines->Clear();
	try
	{
		RichEdit->DefAttributes->Color = clBlack;
		RichEdit->DefAttributes->Pitch = TFontPitch::fpFixed;
		RichEdit->DefAttributes->Style.Clear();
		RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
		RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
		RichEdit->SelAttributes->Size = 16;
		RichEdit->Lines->Add("Multiple linear regression");
		RichEdit->Lines->Add("");
		RichEdit->Lines->Add("");
		if (ChkBoxRegCoeff->Checked) RegCoeffReport();
		if (ChkBoxRes->Checked) ResidualReport();
		if (ChkBoxNormality->Checked) NormalityReport();
		if (ChkBoxRegStats->Checked) BasicRegStatReport();
		if (ChkBoxDescStat->Checked) DescStatReport();
		if (ChkBoxCorr->Checked) CorrMtxReport();
		if (ChkBoxSerCorr->Checked) SerCorrReport();
	}
	__finally
	{
		RichEdit->Enabled = true;
	}
}

void __fastcall TfrmMulLinRegWiz::ChartReport(int AIndex)
{
	TSample MinX,MaxX,MinY,MaxY;
	Chart1->FreeAllSeries();
	TSample zVal = NormalCDFInv(1.0-0.5*MtxMulLinReg->Alpha,0,1.0);
	if (AIndex == firstchartindex)
	{
		// setup chart title and axes
		Chart1->Title->Text->Clear();
		Chart1->Title->Text->Add("Histogram of residuals");
		Chart1->LeftAxis->Title->Caption = "Count";
		Chart1->BottomAxis->Title->Caption = "Residuals";
		Chart1->LeftAxis->AutomaticMinimum = false;
		Chart1->LeftAxis->Minimum = 0.0;
		// add histogram series
		Chart1->AddSeries(new THistogramSeries(this));
		Chart1->Series[0]->SeriesColor = clBlue;
		((THistogramSeries*)Chart1->Series[0])->LinesPen->Visible = true;
		// draw histogram
		sVector tmpVec1, tmpVec2;
		Histogram(MtxMulLinReg->RegressResult->Residuals,10,tmpVec1,tmpVec2,true);
		DrawValues(tmpVec2,tmpVec1,Chart1->Series[0]);
	}
	else if (AIndex == firstchartindex+1)
	{
		// setup chart title and axes
		Chart1->Title->Text->Clear();
		Chart1->AddSeries(new TStatProbSeries(this));
		Chart1->AddSeries(new TLineSeries(this));
		Chart1->AddSeries(new TLineSeries(this));
		Chart1->Series[0]->SeriesColor = clBlue;
		((TStatProbSeries*)Chart1->Series[0])->Pointer->Style = psCircle;
		Chart1->Title->Text->Add("Residuals normal probability plot");
		Chart1->LeftAxis->Title->Caption = "Expected normals";
		Chart1->LeftAxis->Automatic = true;
		Chart1->BottomAxis->Title->Caption = "Residuals";

		sVector tmpVec1, tmpVec2, tmpVec3, tmpVec4;
		StatNormalPlot(MtxMulLinReg->RegressResult->Residuals,tmpVec1,tmpVec2,MinX,MaxX,MinY,MaxY,tmpVec3,False);
		tmpVec3 *= zVal; // 1-alpha ci levels
		((TStatProbSeries*)Chart1->Series[0])->MinX= MinX;
		((TStatProbSeries*)Chart1->Series[0])->MaxX= MaxX;
		((TStatProbSeries*)Chart1->Series[0])->MinY= MinY;
		((TStatProbSeries*)Chart1->Series[0])->MaxY= MaxY;
		DrawValues(tmpVec1,tmpVec2,Chart1->Series[0]);

		tmpVec4 = tmpVec2  + tmpVec3;
		DrawValues(tmpVec1,tmpVec4,Chart1->Series[1]);

		tmpVec4 = tmpVec2 - tmpVec3;
		DrawValues(tmpVec1,tmpVec4,Chart1->Series[2]);
  }
	else if (AIndex == firstchartindex+2)
	{
		// setup chart title and axes
		Chart1->Title->Text->Clear();
		Chart1->Title->Text->Add("Residuals Serial Correlation");
		Chart1->LeftAxis->Title->Caption = "Residuals";
		Chart1->LeftAxis->Automatic = true;
		Chart1->BottomAxis->Title->Caption = "Residuals Lagged Once";
		Chart1->AddSeries(new TPointSeries(this));
		Chart1->Series[0]->SeriesColor = clBlue;
		((TPointSeries*)Chart1->Series[0])->Pointer->Style = psCircle;
		((TPointSeries*)Chart1->Series[0])->Pointer->InflateMargins = true;

		sVector tmpVec1, tmpVec2;
		tmpVec1->Size(MtxMulLinReg->RegressResult->Residuals->Length -1);
		tmpVec2->Size(MtxMulLinReg->RegressResult->Residuals->Length -1);
		tmpVec1->Copy(MtxMulLinReg->RegressResult->Residuals,1,0,tmpVec1->Length);
		tmpVec2->Copy(MtxMulLinReg->RegressResult->Residuals,0,0,tmpVec2->Length);
		DrawValues(tmpVec2,tmpVec1,Chart1->Series[0]);
	}
	else if (AIndex == firstchartindex+3)
	{
		// setup chart title and axes
		Chart1->Title->Text->Clear();
		Chart1->Title->Text->Add("Residuals versus predicted values");
		Chart1->LeftAxis->Title->Caption = "Residuals";
		Chart1->BottomAxis->Title->Caption = "Predicted";
		Chart1->LeftAxis->Automatic = true;
		// add point series
		Chart1->AddSeries(new TPointSeries(this));
		Chart1->Series[0]->SeriesColor = clBlue;
		((TPointSeries*)Chart1->Series[0])->Pointer->Style = psCircle;
		((TPointSeries*)Chart1->Series[0])->Pointer->InflateMargins = true;
		DrawValues(MtxMulLinReg->RegressResult->YCalc,MtxMulLinReg->RegressResult->Residuals,Chart1->Series[0]);
	}
}
void __fastcall TfrmMulLinRegWiz::BitBtnAClick(TObject *Sender)
{
	if (Sender == BitBtnA)
	{
		ViewValues(MtxMulLinReg->A,"Independent variables",true,true);
		Edit1->Text = IntToStr(MtxMulLinReg->A->Rows);
		Edit2->Text = IntToStr(MtxMulLinReg->A->Cols);
		MtxMulLinReg->Y->Length = MtxMulLinReg->A->Rows;
		MtxMulLinReg->Weights->Length = MtxMulLinReg->A->Rows;
	}
	else if (Sender == BitBtnY)  ViewValues(MtxMulLinReg->Y,"Dependent variable",true,true);
	else if (Sender == BitBtnW)  ViewValues(MtxMulLinReg->Weights,"Weights",true,true);
	RefreshWizardControls();
}
//---------------------------------------------------------------------------

void __fastcall TfrmMulLinRegWiz::ChkBoxUseWeightsClick(TObject *Sender)
{
	MtxMulLinReg->UseWeights = ChkBoxUseWeights->Checked;
	RefreshWizardControls();

}
//---------------------------------------------------------------------------

void __fastcall TfrmMulLinRegWiz::ChkBoxRemoveIntClick(TObject *Sender)
{
	MtxMulLinReg->Constant = !ChkBoxRemoveInt->Checked;	
}
//---------------------------------------------------------------------------

void __fastcall TfrmMulLinRegWiz::FormDestroy(TObject *Sender)
{
	delete MtxAnova;
	delete MtxMulLinReg;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMulLinRegWiz::Edit4Change(TObject *Sender)
{
	FormatString = Edit4->Text;
	try {
		FormatFloat(FormatString,1.22);  // dummy test
	} catch (...) {
	}
}
//---------------------------------------------------------------------------

void __fastcall TfrmMulLinRegWiz::Edit1Change(TObject *Sender)
{
	try
	{
		int i = StrToInt(((TEdit*)Sender)->Text);
		if (Sender == Edit1)
		{
			MtxMulLinReg->A->Rows = i;
			MtxMulLinReg->Y->Length = i;
			MtxMulLinReg->Weights->Length = i;
		}
		else if (Sender == Edit2) MtxMulLinReg->A->Cols = i;
	}
	catch(...) {}
	RefreshWizardControls();
}
//---------------------------------------------------------------------------

void __fastcall TfrmMulLinRegWiz::Edit3Change(TObject *Sender)
{
	try {
		MtxMulLinReg->Alpha = StrToFloat(Edit3->Text);
	} catch (...) {
	}
}
//---------------------------------------------------------------------------

void __fastcall TfrmMulLinRegWiz::FormShow(TObject *Sender)
{
  PageControl->ActivePage = tsInputData;
	Edit1->Text = IntToStr(MtxMulLinReg->A->Rows);
	Edit2->Text = IntToStr(MtxMulLinReg->A->Cols);
	Edit3->Text = FormatFloat("0.00",MtxMulLinReg->Alpha);
	Edit4->Text = FormatString;
	FormatString = Edit4->Text;
}
//---------------------------------------------------------------------------




