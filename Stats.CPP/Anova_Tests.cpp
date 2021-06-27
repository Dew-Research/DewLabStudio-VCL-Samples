//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Anova_Tests.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma link "MtxBaseComp"
#pragma resource "*.dfm"
TfrmANOVATest *frmANOVATest;
//---------------------------------------------------------------------------
__fastcall TfrmANOVATest::TfrmANOVATest(TComponent* Owner)
	: TfrmBasic(Owner)
{
    Memo1->Lines->Add("NIST ANOVA tests : ");
		Memo1->Lines->Add("");
		Memo1->Lines->Add("");
		Memo1->Lines->Add("SmLs01 : Simon, Stephen D. and Lesage, James P. (1989)."
				" \"Assessing the Accuracy of ANOVA Calculations in Statistical Software\"."
				" Computational Statistics & Data Analysis, 8, pp. 325-332."
				" (Lower level of difficulty)");
		Memo1->Lines->Add("");

		Memo1->Lines->Add("AtmWtAg : Powell, L.J., Murphy, T.J. and Gramlich, J.W. (1982)."
				" \"The Absolute Isotopic Abundance & Atomic Weight of a Reference"
				" Sample of Silver\". NBS Journal of Research, 87, pp. 9-19."
				" (Average level of difficulty)");
		Memo1->Lines->Add("");
		Memo1->Lines->Add("SmLs07 : Simon, Stephen D. and Lesage, James P. (1989)."
				" \"Assessing the Accuracy of ANOVA Calculations in Statistical Software\"."
				" Computational Statistics & Data Analysis, 8, pp. 325-332."
				" (Higher level of difficulty)");
		Memo1->Lines->Add("");
}
//---------------------------------------------------------------------------
void __fastcall TfrmANOVATest::FillData()
{
	if (ComboBox1->ItemIndex == 0)
	{
		MtxAnova->FmtString = "0.000000E+00";
		double Data[] = {1.4, 1.3, 1.5, 1.3, 1.5, 1.3, 1.5, 1.3, 1.5,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6,
										1.3, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4, 1.2, 1.4,
										1.5, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6, 1.4, 1.6};
		MtxAnova->Data->SetIt(21,9,false,Data,sizeof(Data)/sizeof(double)-1);
	}
	else
	if (ComboBox1->ItemIndex == 1)
	{
		MtxAnova->FmtString = "0.000000E+00";
		double Data[] = {107.8681568, 107.8681079,
										107.8681465, 107.8681344,
										107.8681572, 107.8681513,
										107.8681785, 107.8681197,
										107.8681446, 107.8681604,
										107.8681903, 107.8681385,
										107.8681526, 107.8681642,
										107.8681494, 107.8681365,
										107.8681616, 107.8681151,
										107.8681587, 107.8681082,
										107.8681519, 107.8681517,
										107.8681486, 107.8681448,
										107.8681419, 107.8681198,
										107.8681569, 107.8681482,
										107.8681508, 107.8681334,
										107.8681672, 107.8681609,
										107.8681385, 107.8681101,
										107.8681518, 107.8681512,
										107.8681662, 107.8681469,
										107.8681424, 107.8681360,
										107.8681360, 107.8681254,
										107.8681333, 107.8681261,
										107.8681610, 107.8681450,
										107.8681477, 107.8681368};
		MtxAnova->Data->SetIt(24,2,false,Data,sizeof(Data)/sizeof(double)-1);
	} else
	if (ComboBox1->ItemIndex == 2)
	{
		MtxAnova->FmtString = "0.000000E+00";
		double Data[] = {1000000000000.4, 1000000000000.3, 1000000000000.5, 1000000000000.3, 1000000000000.5, 1000000000000.3, 1000000000000.5, 1000000000000.3, 1000000000000.5,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6,
										1000000000000.3, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4, 1000000000000.2, 1000000000000.4,
										1000000000000.5, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6, 1000000000000.4, 1000000000000.6};
		MtxAnova->Data->SetIt(21,9,false,Data,sizeof(Data)/sizeof(double)-1);
	}
}
void __fastcall TfrmANOVATest::FormShow(TObject *Sender)
{
	ComboBox1->ItemIndex = 0;
	ComboBox1Change(this);
}
//---------------------------------------------------------------------------

void __fastcall TfrmANOVATest::SpeedButton1Click(TObject *Sender)
{
	FillData();
	MtxAnova->Recalc();
}
//---------------------------------------------------------------------------

void __fastcall TfrmANOVATest::ComboBox1Change(TObject *Sender)
{
	RichEdit1->Lines->Clear();
	if (ComboBox1->ItemIndex == 0)
	{
			RichEdit1->Lines->Add("Reference:");
			RichEdit1->Lines->Add("Simon, Stephen D. and Lesage, James P. (1989).\"Assessing the Accuracy\""
					" of ANOVA Calculations in Statistical Software\"."
					" Computational Statistics & Data Analysis, 8, pp. 325-332.");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Data:");
			RichEdit1->Lines->Add("1 Factor");
			RichEdit1->Lines->Add("9 Treatments");
			RichEdit1->Lines->Add("21 Replicates/Cell");
			RichEdit1->Lines->Add("189 Observations");
			RichEdit1->Lines->Add("1 Constant Leading Digits");
			RichEdit1->Lines->Add("Lower Level of Difficulty");
			RichEdit1->Lines->Add("Generated Data");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Model:");
      RichEdit1->Lines->Add("10 Parameters (mu, tau_1, ..., tau_9)");
      RichEdit1->Lines->Add("y_{ij} = mu + tau_i + epsilon_{ij}");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Certified values:");
			RichEdit1->Paragraph->TabCount = 5;
			RichEdit1->Paragraph->Tab[0] = 0;
			RichEdit1->Paragraph->Tab[1] = 40;
			RichEdit1->Paragraph->Tab[2] = 60;
			RichEdit1->Paragraph->Tab[3] = 120;
			RichEdit1->Paragraph->Tab[4] = 180;
			RichEdit1->Lines->Add("Source of\t \tSums of\tMean");
      RichEdit1->Lines->Add("Variation\tdf\tSquares\tSquares\tF Statistic");
      RichEdit1->Lines->Add("Bewteen\t8\t1.68\t2.1E-01\t2.1E+01");
      RichEdit1->Lines->Add("Within\t180\t1.8\t1.0E-02");
	} else if (ComboBox1->ItemIndex == 1)
	{
			RichEdit1->Lines->Add("Reference:");
			RichEdit1->Lines->Add("Powell, L.J., Murphy, T.J. and Gramlich, J.W. (1982).\"The Absolute Isotopic"
					" Abundance & Atomic Weight of a Reference Sample of Silver\". NBS Journal of Research, 87, pp. 9-19.");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Data:");
			RichEdit1->Lines->Add("1 Factor");
			RichEdit1->Lines->Add("2 Treatments");
			RichEdit1->Lines->Add("24 Replicates/Cell");
			RichEdit1->Lines->Add("48 Observations");
			RichEdit1->Lines->Add("7 Constant Leading Digits");
			RichEdit1->Lines->Add("Average Level of Difficulty");
			RichEdit1->Lines->Add("Observed Data");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Model:");
			RichEdit1->Lines->Add("3 Parameters (mu, tau_1, tau_2)");
			RichEdit1->Lines->Add("y_{ij} = mu + tau_i + epsilon_{ij}");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Certified values:");
			RichEdit1->Paragraph->TabCount = 5;
			RichEdit1->Paragraph->Tab[0] = 0;
			RichEdit1->Paragraph->Tab[1] = 40;
			RichEdit1->Paragraph->Tab[2] = 60;
			RichEdit1->Paragraph->Tab[3] = 160;
			RichEdit1->Paragraph->Tab[4] = 260;
			RichEdit1->Lines->Add("Source of\t \tSums of\tMean");
			RichEdit1->Lines->Add("Variation\tdf\tSquares\tSquares\tF Statistic");
			RichEdit1->Lines->Add("Bewteen\t1\t3.63834187500000E-09\t3.63834187500000E-09\t1.59467335677930E+01");
			RichEdit1->Lines->Add("Within\t46\t1.04951729166667E-08\t2.28155932971014E-10");
	} else if (ComboBox1->ItemIndex == 2)
	{
			RichEdit1->Lines->Add("Reference:");
			RichEdit1->Lines->Add("Simon, Stephen D. and Lesage, James P. (1989).\"Assessing the Accuracy\""
					" of ANOVA Calculations in Statistical Software\"."
					" Computational Statistics & Data Analysis, 8, pp. 325-332.");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Data:");
			RichEdit1->Lines->Add("1 Factor");
			RichEdit1->Lines->Add("9 Treatments");
			RichEdit1->Lines->Add("21 Replicates/Cell");
			RichEdit1->Lines->Add("189 Observations");
			RichEdit1->Lines->Add("13 Constant Leading Digits");
			RichEdit1->Lines->Add("Higher Level of Difficulty");
			RichEdit1->Lines->Add("Generated Data");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Model:");
			RichEdit1->Lines->Add("10 Parameters (mu, tau_1, ..., tau_9)");
			RichEdit1->Lines->Add("y_{ij} = mu + tau_i + epsilon_{ij}");
			RichEdit1->Lines->Add("");
			RichEdit1->Lines->Add("Certified values:");
			RichEdit1->Paragraph->TabCount = 5;
			RichEdit1->Paragraph->Tab[0] = 0;
			RichEdit1->Paragraph->Tab[1] = 40;
			RichEdit1->Paragraph->Tab[2] = 60;
			RichEdit1->Paragraph->Tab[3] = 120;
			RichEdit1->Paragraph->Tab[4] = 180;
			RichEdit1->Lines->Add("Source of\t \tSums of\tMean");
			RichEdit1->Lines->Add("Variation\tdf\tSquares\tSquares\tF Statistic");
			RichEdit1->Lines->Add("Bewteen\t8\t1.68\t2.1E-01\t2.1E+01");
			RichEdit1->Lines->Add("Within\t180\t1.8\t1.0E-02");
	}

}
//---------------------------------------------------------------------------

