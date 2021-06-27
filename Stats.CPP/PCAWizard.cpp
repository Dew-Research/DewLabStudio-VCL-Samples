//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PCAWizard.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Wizard"
#pragma link "VCLTee.TeeComma"
#pragma link "MtxBaseComp"
#pragma link "StatTools"
#pragma resource "*.dfm"
TfrmPCAWiz *frmPCAWiz;

#define firstchartindex 3
#define lastchartindex 4
//---------------------------------------------------------------------------
void __fastcall TfrmPCAWiz::RefreshWizardControls()
{
   TfrmBasicWizard::RefreshWizardControls();

   if (PageControl->ActivePage == tsInputData) btnNext->Enabled = MtxPCA->Data->Length > 0;
   else if (PageControl->ActivePage == tsChart) btnNext->Enabled = chartindex < lastchartindex;
}
//---------------------------------------------------------------------------
void __fastcall TfrmPCAWiz::DoMoveForward()
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
	   MtxPCA->Recalc();
	   TextReport();
   }
   else if (PageControl->ActivePage == tsChart) ChartReport(chartindex);
}

void __fastcall TfrmPCAWiz::DoMoveBackward()
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
__fastcall TfrmPCAWiz::TfrmPCAWiz(TComponent* Owner): TfrmBasicWizard(Owner)
{
	chartindex = firstchartindex;
}
//---------------------------------------------------------------------------
void __fastcall TfrmPCAWiz::FormShow(TObject *Sender)
{
	TeeCommander1->ButtonPrint->Visible = false;
	TeeCommander1->ButtonSave->Visible = false;
	// initialize page
	PageControl->ActivePage = tsInputData;
	EditRows->Text = IntToStr(MtxPCA->Data->Rows);
	EditCols->Text = IntToStr(MtxPCA->Data->Cols);
	EditFmtString->Text = FormatString;
	CBoxPCAMode->ItemIndex = (int) (MtxPCA->PCAMode);
}
//---------------------------------------------------------------------------
void __fastcall TfrmPCAWiz::BtnEditDataClick(TObject *Sender)
{
	ViewValues(MtxPCA->Data,"Editinig data...",true,true);
	EditCols->Text = IntToStr(MtxPCA->Data->Cols);
	EditRows->Text = IntToStr(MtxPCA->Data->Rows);
	RefreshWizardControls();
}
//---------------------------------------------------------------------------

void __fastcall TfrmPCAWiz::EditColsChange(TObject *Sender)
{
	try
	{
		int i = StrToInt(((TEdit*)Sender)->Text);
		if (Sender == EditCols)
			MtxPCA->Data->Cols = i;
		else if (Sender == EditRows)
			MtxPCA->Data->Rows = i;
	} catch(...) {}
	RefreshWizardControls();
}
//---------------------------------------------------------------------------

void __fastcall TfrmPCAWiz::TextReport()
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
		RichEdit->Lines->Add("Principal Components Analysis");
		RichEdit->Lines->Add("");
		RichEdit->Lines->Add("");
		if (ChkBoxDescStat->Checked)  DescStatReport();
		if (ChkBoxCorrMtx->Checked)  CorrMtxReport();
		if (ChkBoxBarlett->Checked)  BarlettReport();
		if (ChkBoxEigValues->Checked)  EigValuesReport();
		if (ChkBoxPrinComp->Checked)  PrinCompReport();
		if (ChkBoxZScores->Checked)  ZScoresReport();
	}
	__finally
	{
		RichEdit->Enabled = true;
	}
}

void __fastcall TfrmPCAWiz::DescStatReport()
{
  RichEdit->Paragraph->TabCount = 5;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Descriptive Statistics");
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Variable\tMean\tStd.Dev."
											"\tMin\tMax");
	// basic descriptive statistics 
	for (int i = 0;i<MtxPCA->Data->Cols;i++)
	{
		tmpVec->GetCol(MtxPCA->Data,0,i,MtxPCA->Data->Rows);
		TSample tmpMean = tmpVec->Mean();
		TSample tmpStdDev = tmpVec->StdDev(tmpMean);
		TSample tmpMax = tmpVec->Max();
		TSample tmpMin = tmpVec->Min();
		AnsiString LineText = "A column "+IntToStr(i)+"\t";
		LineText = LineText + FormatFloat(FormatString,tmpMean)+"\t";
		LineText = LineText + FormatFloat(FormatString,tmpStdDev) + "\t";
		LineText = LineText + FormatFloat(FormatString,tmpMin) + "\t";
		LineText = LineText + FormatFloat(FormatString,tmpMax);
		RichEdit->Lines->Add(LineText);
	}
	RichEdit->Lines->Add("");

}
void __fastcall TfrmPCAWiz::EditFmtStringChange(TObject *Sender)
{
	FormatString = EditFmtString->Text;
	try
	{
		FormatFloat(FormatString,1.22);  // dummy test
	} catch (...) {}
}
//---------------------------------------------------------------------------
void __fastcall TfrmPCAWiz::CorrMtxReport()
{
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Paragraph->TabCount = MtxPCA->Data->Cols;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	switch (MtxPCA->PCAMode)
	{
		case PCACovMat:  {
							RichEdit->Lines->Add("Covariance matrix");
							Covariance(MtxPCA->Data,tmpMtx,false);

							tmpMtx->ValuesToStrings(RichEdit->Lines,"\t",TFixedTextAlign::ftaNone,FormatString);
							RichEdit->Lines->Add("");
							// Ln(R)
							RichEdit->Lines->Add("Ln(R) = "+ FormatFloat(FormatString,Ln(tmpMtx->Determinant())));
							RichEdit->Lines->Add("");
						 };
						 break;
		case PCACorrMat: {
							RichEdit->Lines->Add("Correlation matrix");
							CorrCoef(MtxPCA->Data,tmpMtx);

							tmpMtx->ValuesToStrings(RichEdit->Lines,"\t",TFixedTextAlign::ftaNone,FormatString);
							RichEdit->Lines->Add("");
							// Ln(R)
							RichEdit->Lines->Add("Ln(R) = "+ FormatFloat(FormatString,Ln(tmpMtx->Determinant())));
							RichEdit->Lines->Add("");
						 };
						 break;
		case PCARawData: {
							RichEdit->Lines->Add("Covariance matrix");
							Covariance(MtxPCA->Data,tmpMtx,false);

							tmpMtx->ValuesToStrings(RichEdit->Lines,"\t",TFixedTextAlign::ftaNone,FormatString);
							RichEdit->Lines->Add("");
							// Ln(R)
							RichEdit->Lines->Add("Ln(R) = "+ FormatFloat(FormatString,Ln(tmpMtx->Determinant())));
							RichEdit->Lines->Add("");

							RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
							RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
							RichEdit->Lines->Add("Correlation matrix");
							CorrCoef(MtxPCA->Data,tmpMtx);

							tmpMtx->ValuesToStrings(RichEdit->Lines,"\t",TFixedTextAlign::ftaNone,FormatString);
							RichEdit->Lines->Add("");
							// Ln(R)
							RichEdit->Lines->Add("Ln(R) = "+ FormatFloat(FormatString,Ln(tmpMtx->Determinant())));
							RichEdit->Lines->Add("");

						 };
						 break;
	}
}

void __fastcall TfrmPCAWiz::EigValuesReport()
{
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Eigenvalues");
	RichEdit->Paragraph->TabCount = 3;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Variable\tEigenvalue\tPercentage");
	for (int i = 0;i<MtxPCA->EigValues->Length;i++)
	{
		AnsiString LineText = IntToStr(i)+"\t"+FormatFloat(FormatString,MtxPCA->EigValues->Values[i]);
		LineText = LineText + "\t"+ FormatFloat(FormatString,MtxPCA->TotalVarPct->Values[i]);
		RichEdit->Lines->Add(LineText);
	}
	RichEdit->Lines->Add("");
}
void __fastcall TfrmPCAWiz::CBoxPCAModeChange(TObject *Sender)
{
	MtxPCA->PCAMode = (TPCAMode)CBoxPCAMode->ItemIndex;
	if (CBoxPCAMode->ItemIndex < 1)
	{
		MtxPCA->PCAMode = PCACorrMat;
	}
	else
	{
		MtxPCA->PCAMode = PCARawData;
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmPCAWiz::PrinCompReport()
{
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Principal components (Eigenvectors)");
	RichEdit->Paragraph->TabCount = MtxPCA->Data->Cols;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	MtxPCA->PC->ValuesToStrings(RichEdit->Lines);
	RichEdit->Lines->Add("");
}

void __fastcall TfrmPCAWiz::ZScoresReport()
{
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Z Scores");
	RichEdit->Paragraph->TabCount = MtxPCA->ZScores->Cols;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	MtxPCA->ZScores->ValuesToStrings(RichEdit->Lines);
	RichEdit->Lines->Add("");
}

void __fastcall TfrmPCAWiz::ChartReport(int AIndex)
{
	Chart->FreeAllSeries();
	// Box plot
	if (AIndex == firstchartindex)
	{
		// setup chart title and axes
		Chart->Title->Text->Clear();
		Chart->Legend->Visible = false;
		Chart->Title->Text->Add("Box plot");
		Chart->LeftAxis->Title->Caption = "Values";
		Chart->LeftAxis->Automatic = true;
		Chart->BottomAxis->Title->Caption = "Group (Column)";
		sVector tmpVec1;
		// add BoxPlot series
		for (int i = 0;i<MtxPCA->Data->Cols;i++)
		{
			Chart->AddSeries(new TBoxSeries(Chart));
			tmpVec1->GetCol(MtxPCA->Data,i);
			Chart->Series[i]->Title = "Column" + IntToStr(i);
			((TBoxSeries*)Chart->Series[i])->Position = i;
			((TBoxSeries*)Chart->Series[i])->Box->Brush->Color = clYellow;
			((TBoxSeries*)Chart->Series[i])->Pen->Color = clRed;
			((TBoxSeries*)Chart->Series[i])->SeriesColor = clRed;
			tmpVec1->SortAscend();
			DrawValues(tmpVec1,Chart->Series[i]);
		}
	} else {
		// Scree plot
		if (AIndex == firstchartindex+1)
		{
			// setup chart title and axes
			Chart->Title->Text->Clear();
			Chart->Legend->Visible = true;
			Chart->Title->Text->Add("Scree plot");
			Chart->LeftAxis->Title->Caption = "Percentage";
			Chart->LeftAxis->Automatic = false;
			Chart->LeftAxis->SetMinMax(0,101);
			Chart->BottomAxis->Title->Caption = "Eigenvalue";
			sVector tmpVec1;
			// add Line + bar series
			Chart->AddSeries(new TBarSeries(Chart));
			Chart->AddSeries(new TLineSeries(Chart));
			((TLineSeries*)Chart->Series[1])->LinePen->Width = 2;
			Chart->Series[0]->Title = "Eigenvalue" ;
			Chart->Series[1]->Title = "Cumulative value" ;
			tmpVec1->CumSum(MtxPCA->TotalVarPct);
			DrawValues(MtxPCA->TotalVarPct,Chart->Series[0]);
			DrawValues(tmpVec1,Chart->Series[1]);
		}
  }
}

void __fastcall TfrmPCAWiz::BarlettReport()
{
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsBold;
	RichEdit->SelAttributes->Style = RichEdit->SelAttributes->Style << TFontStyle::fsUnderline;
	RichEdit->Lines->Add("Barlett test for dimensionality of data");
	// Barlett test for dimensionality
	sVector SignifVec;
	int NumDim;
	BartlettTest(MtxPCA->Data,NumDim,SignifVec,MtxPCA->PCAMode); // Alpha = 5 %
	RichEdit->Lines->Add("Barlett test (Alpha = 0.05 ) = "+ IntToStr(NumDim));
	RichEdit->Paragraph->TabCount = 2;
	SetupTabs(RichEdit->Paragraph->TabCount, RichEdit);
	RichEdit->SelAttributes->Color = clBlue;
	RichEdit->Lines->Add("Variable\tSignif. probability");
	for (int i = 0;i<SignifVec->Length;i++)
	{
		AnsiString LineText = IntToStr(i)+"\t"+FormatFloat(FormatString,SignifVec->Values[i]);
		RichEdit->Lines->Add(LineText);
	}
	RichEdit->Lines->Add("");
}


