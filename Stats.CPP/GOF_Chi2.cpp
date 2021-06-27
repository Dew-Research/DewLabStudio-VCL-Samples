//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "GOF_Chi2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Chart"
#pragma link "MtxBaseComp"
#pragma link "StatTools"
#pragma link "StatSeries"
#pragma resource "*.dfm"
TfrmGOFChi2 *frmGOFChi2;
//---------------------------------------------------------------------------
__fastcall TfrmGOFChi2::TfrmGOFChi2(TComponent* Owner)
	: TfrmBasicChart(Owner)
{
	Button1->Visible = false;
	Memo1->Lines->Add("The chi-square test (Snedecor and Cochran, 1989) is used to test if a "
		"sample of data came from a population with a specific distribution.");
	Memo1->Lines->Add("An attractive feature of the chi-square goodness-of-fit test is that it "
		"can be applied to any univariate distribution for which you can calculate "
		"the cumulative distribution function (CDF). The chi-square goodness-of-"
		"fit test is applied to binned data (i.e., data put into classes). This "
		"is actually not a restriction since for non-binned data you can simply "
		"calculate a histogram or frequency table before generating the chi-square "
		"test. However, the value of the chi-square test statistic are dependent "
		"on how the data is binned. Another disadvantage of the chi-square test "
		"is that it requires a sufficient sample size in order for the chi-square "
		"approximation to be valid.");
	Memo1->Lines->Add("If you press the \"GENERATE\" button, a new set of random values for specific "
		"distribution will be generated. Pressing the \"GOF TEST\" button will trigger "
		"Chi-Squared GOF test for any of supported distributions.");
	Memo1->Lines->Add("NOTE: Data validity is not checked for specific distribution so for example, "
		"do not test for exponential distribution if values are negative!");
	  // setup initial values
	numBins = 25;
	UpDown1->Position = numBins;
	Alpha = 0.05;
	Edit2->Text = SampleToStr(Alpha);
	ComboBox1->ItemIndex = 4; // Normal
	ComboBox1Change(this);

	ComboBox2->ItemIndex = 4; // Normal
	ComboBox2Change(this);

	Button2Click(this); // Generate data


}
//---------------------------------------------------------------------------
// This procedure generates observed and expected frequencies for specific distribution
// You could also use Statistics.pas GOFChi2Test oveload to do all this in one routine call,
// but since we have to plot observed and expected frequency histograms, we're
// doing it "manually" in this unit.
void __fastcall GOFChiFreqs(TVec *Data, TDistribution Distribution, int NumBins,
	TVec *Bins,TVec *Freq, TVec *OFreq, int &dF)
{
	TSample Pars[2];
	int intPar;
	switch (Distribution)
	{
		case distCHISQUARE: {
			ChiSquareFit(Data,intPar);
			Pars[0] = intPar;
		};break;
		case distERLANG: {
			ErlangFit(Data,intPar,Pars[1]);
			Pars[0] = intPar;
		};break;
		case distLAPLACE: LaplaceFit(Data,Pars[0],Pars[1]); break;
		case distNORMAL : NormalFit(Data,Pars[0],Pars[1]);break;
		case distEXP : ExponentFit(Data,Pars[0]);break;
		case distGAMMA : GammaFit(Data,Pars[0],Pars[1]);break;
		case distWEIBULL : WeibullFit(Data,Pars[0],Pars[1]);break;
		case distBETA : BetaFit(Data,Pars[0],Pars[1]);break;
		case distRAYLEIGH : RayleighFit(Data,Pars[0]);break;
		case distLOGNORMAL : LogNormalFit(Data,Pars[0],Pars[1]);break;
		case distUNIFORM : UniformFit(Data,Pars[0],Pars[1]);break;
	}

	Histogram(Data,NumBins,OFreq,Bins);

	switch (Distribution)
	{
		case distNORMAL: {
				  NormalCDF(Bins,Pars[0],Pars[1],Freq);
				  dF = -3;
		};break;
		case distCHISQUARE : {
				ChiSquareCDF(Bins,int(Pars[0]),Freq);
				dF = -2;
		};break;
		case distERLANG : {
				ErlangCDF(Bins,int(Pars[0]),Pars[1],Freq);
				dF = -3;
		};break;
		case distEXP : {
					ExpCDF(Bins,Pars[0],Freq);
					dF = -2;
		}; break;
		case distGAMMA :{
					GammaCDF(Bins,Pars[0],Pars[1],Freq);
					dF = -3;
		};break;
		case distLAPLACE: {
					LaplaceCDF(Bins,Pars[0],Pars[1],Freq);
					dF = -3;

		}
		case distWEIBULL: {
					WeibullCDF(Bins,Pars[0],Pars[1],Freq);
					dF = -3;
		};break;
		case distBETA : {
				BetaCDF(Bins,Pars[0],Pars[1],Freq);
				dF = -3;
		};break;
		case distRAYLEIGH: {
					RayleighCDF(Bins,Pars[0],Freq);
					dF = -2;
		}; break;
		case distLOGNORMAL : {
					LogNormalCDF(Bins,Pars[0],Pars[1],Freq);
					dF = -2;
		}; break;
		case distUNIFORM : {
					UniformCDF(Bins,Pars[0],Pars[1],Freq);
					dF = -2;
		}; break;
	}
	Freq->Difference();
	Freq->Scale(Data->Length);

	// calculate Chi2 distribution degrees of freedom
	// Nu = NumBins - NumberofParameters - 1
	dF+= OFreq->Length;
}

void __fastcall TfrmGOFChi2::ComboBox1Change(TObject *Sender)
{
	switch (ComboBox1->ItemIndex)
	{
		case 0 : DistName = "Beta";break;
		case 1 : DistName = "Chi2";break;
		case 2 : DistName =  "Erlang";break;
		case 3 : DistName = "Exponential";break;
		case 4 : DistName = "Gamma";break;
		case 5 : DistName = "Laplace";break;
		case 6 : DistName = "Log-Normal";break;
		case 7 : DistName = "Normal";break;
		case 8 : DistName = "Rayleigh";break;
		case 9 : DistName = "Uniform";break;
		case 10 : DistName = "Weibull";break;
	}
	Chart1->Title->Text->Clear();
	Chart1->Title->Text->Add("Goodness of fit for "+DistName+" distribution.");
}
//---------------------------------------------------------------------------

void __fastcall TfrmGOFChi2::Edit1Change(TObject *Sender)
{
	try
	{
		numBins = StrToInt(Edit1->Text);
	}
	catch (...)
	{
		numBins = 25;
		Edit1->Text = IntToStr(numBins);
	}
	Series2->Clear();
	DrawDataHistogram();
}
//---------------------------------------------------------------------------

void __fastcall TfrmGOFChi2::Button2Click(TObject *Sender)
{
	TSample par1,par2; 
	DataVec->Size(1000);
	switch (ComboBox2->ItemIndex)
	{
		case 0 : {
					try {
						par1 = StrToFloat(EditPar1->Text);
					} catch(...) {
						par1 = 1.3;
						EditPar1->Text = FormatFloat("0.00",par1);
					}
					try {
						par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
						par2 = 0.7;
						EditPar2->Text = FormatFloat("0.00",par2);
					}
					RandomBeta(par1,par2,DataVec);
				};break;
		case 1 : {
					try {
						par1 = StrToFloat(EditPar1->Text);
					} catch(...) {
						par1 = 2;
						EditPar1->Text = "2";
					}
					RandomChiSquare(int(par1),DataVec);
				};break;
		case 2 : {
					try {
						par1 = StrToFloat(EditPar1->Text);
					} catch(...) {
						par1 = 2;
						EditPar1->Text = "2";
					}
					try {
						par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
						par2 = 0.7;
						EditPar2->Text = FormatFloat("0.00",par2);
					}
					RandomErlang(int(par1),par2,DataVec);
				};break;
		case 3 : {
					try {
						par1 = StrToFloat(EditPar1->Text);
					} catch(...) {
						par1 = 0.2;
						EditPar1->Text = FormatFloat("0.00",par1);
					}
					RandomExponent(par1,DataVec);
				};break;
		case 4 : {
					try {
						par1 = StrToFloat(EditPar1->Text);
					} catch(...) {
						par1 = 1.9;
						EditPar1->Text = FormatFloat("0.00",par1);
					}
					try {
						par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
						par2 = 0.7;
						EditPar2->Text = FormatFloat("0.00",par2);
					}
					RandomGamma(par1,par2,DataVec);
				};break;
		case 5 : {
		  try {
			par1 = StrToFloat(EditPar1->Text);
		  } catch(...) {
			par1 = 1.8;
			EditPar1->Text = FormatFloat("0.00",par1);
		  }
					try {
			par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
			par2 = 0.7;
			EditPar2->Text = FormatFloat("0.00",par2);
		  }
		  RandomLaplace(par1,par2,DataVec);
				};break;
		case 6 : {
		  try {
			par1 = StrToFloat(EditPar1->Text);
		  } catch(...) {
			par1 = 7.2;
			EditPar1->Text = FormatFloat("0.00",par1);
		  }
					try {
			par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
			par2 = 1.3;
			EditPar2->Text = FormatFloat("0.00",par2);
		  }
		  RandomLogNormal(par1,par2,DataVec);
				};break;
		case 7 : {
		  try {
			par1 = StrToFloat(EditPar1->Text);
		  } catch(...) {
			par1 = 7.2;
			EditPar1->Text = FormatFloat("0.00",par1);
		  }
					try {
			par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
			par2 = 1.3;
			EditPar2->Text = FormatFloat("0.00",par2);
		  }
		  RandomNormal(par1,par2,DataVec);
				};break;
		case 8 : {
		  try {
			par1 = StrToFloat(EditPar1->Text);
		  } catch(...) {
			par1 = 2.2;
			EditPar1->Text = FormatFloat("0.00",par1);
					}
					RandomRayleigh(par1,DataVec);
				};break;
		case 9 : {
					try {
						par1 = StrToFloat(EditPar1->Text);
					} catch(...) {
						par1 = -2.3;
						EditPar1->Text = FormatFloat("0.00",par1);
					}
					try {
						par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
						par2 = 1.5;
						EditPar2->Text = FormatFloat("0.00",par2);
					}
					RandomUniform(par1,par2,DataVec);
				};break;
		case 10 : {
					try {
						par1 = StrToFloat(EditPar1->Text);
					} catch(...) {
						par1 = 0.7;
						EditPar1->Text = FormatFloat("0.00",par1);
					}
					try {
						par2 = StrToFloat(EditPar2->Text);
					} catch(...) {
						par2 = 1.3;
						EditPar2->Text = FormatFloat("0.00",par2);
					}
					RandomWeibull(par1,par2,DataVec);
				};break;
	}
	Series2->Clear();
	DrawDataHistogram();

}
//---------------------------------------------------------------------------
void __fastcall TfrmGOFChi2::DrawDataHistogram()
{
	sVector F,B;
	Histogram(DataVec,numBins,F,B,true);
	DrawValues(B,F,Series1);
}

void __fastcall TfrmGOFChi2::DoChi2Test()
{
	TDistribution dist;
	TSample Signif;
	THypothesisResult hRes;
	int Nu;

	sVector OFreq, PredFreq, Bins, SOS;


	Screen->Cursor = crHourGlass;
	try
	{
			switch (ComboBox1->ItemIndex)
			{
				case 0 : dist = distBETA; break;
				case 1 : dist = distCHISQUARE; break;
				case 2 : dist = distERLANG; break;
				case 3 : dist = distEXP; break;
				case 4 : dist = distGAMMA; break;
				case 5 : dist = distLAPLACE; break;
				case 6 : dist = distLOGNORMAL; break;
				case 7 : dist = distNORMAL; break;
				case 8 : dist = distRAYLEIGH; break;
				case 9 : dist = distUNIFORM; break;
				case 10 : dist = distWEIBULL; break;

			}
			// Step 1: Generate necessary frequency lists,
		  GOFChiFreqs(DataVec,dist,numBins,Bins,PredFreq,OFreq,Nu);
		  // Step 2: Plot theoretical frequency
		  SOS->Length = Bins->Length-1;
		  SOS->Add(Bins,Bins,0,1,0,Bins->Length-1);
		  SOS->Scale(0.5);
		  DrawValues(SOS,PredFreq,Series2);
		  // Step 3: Do a Chi2 GOF test
		  GOFChi2Test(OFreq,PredFreq,DataVec->Length,Nu,hRes,Signif,htTwoTailed,Alpha);


		Memo2->Lines->Clear();
		Memo2->Lines->Add("CHI-SQUARED GOODNESS-OF-FIT TEST");
		Memo2->Lines->Add("-------------------------------");
		Memo2->Lines->Add("Ho: Distribution fits the data");
		Memo2->Lines->Add("Ha: Distribution does not fit the data");
		Memo2->Lines->Add("-------------------------------");
		Memo2->Lines->Add("Test:");
		Memo2->Lines->Add("Tested significance:  "+SampleToStr(Signif,4,5));
		Memo2->Lines->Add("Alpha: "+SampleToStr(100*Alpha,2,4)+"%");

		if (hRes == hrNotReject) Memo2->Lines->Add("Data comes from tested distribution");
		else Memo2->Lines->Add("Data does not come from tested distribution");
	}
	__finally
	{
		Screen->Cursor = crDefault;
	}
}
void __fastcall TfrmGOFChi2::ComboBox2Change(TObject *Sender)
{
	switch (ComboBox2->ItemIndex)
	{
		case 0 : {
					lblDistName->Caption = "Beta";
					lblPar2->Visible = true;
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",1.3);
					EditPar2->Text = FormatFloat("0.00",0.7);
				};break;
		case 1 : {
					lblDistName->Caption = "Chi-Squared";
					lblPar2->Visible = false;
					lblPar1->Caption = "Nu";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = "3";
				};break;
		case 2 : {
					lblDistName->Caption = "Erlang";
					lblPar2->Visible = true;
					lblPar1->Caption = "k";
					lblPar2->Caption = "lambda";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = "2";
					EditPar2->Text = FormatFloat("0.00",0.7);
				};break;
		case 3 : {
					lblDistName->Caption = "Exponential";
					lblPar2->Visible = false;
					lblPar1->Caption = "Mu";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",0.2);
				};break;
		case 4 : {
					lblDistName->Caption = "Gamma";
					lblPar2->Visible = true;
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",1.8);
					EditPar2->Text = FormatFloat("0.00",0.7);
				};break;
		case 5 : {
					lblDistName->Caption = "Laplace";
					lblPar2->Visible = true;
					lblPar1->Caption = "m";
					lblPar2->Caption = "b";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",1.8);
					EditPar2->Text = FormatFloat("0.00",0.7);
				};break;
		case 6 : {
					lblDistName->Caption = "Log-Normal";
					lblPar2->Visible = true;
					lblPar1->Caption = "mu";
					lblPar2->Caption = "sigma";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",7.2);
					EditPar2->Text = FormatFloat("0.00",1.0);
				};break;
		case 7 : {
					lblDistName->Caption = "Normal";
					lblPar2->Visible = true;
					lblPar1->Caption = "mu";
					lblPar2->Caption = "sigma";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",7.2);
					EditPar2->Text = FormatFloat("0.00",1.0);
				};break;
		case 8 : {
					lblDistName->Caption = "Rayleigh";
					lblPar2->Visible = false;
					lblPar1->Caption = "b";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",2.2);
				};break;
		case 9 : {
					lblDistName->Caption = "Uniform";
					lblPar2->Visible = true;
					lblPar1->Caption = "low";
					lblPar2->Caption = "high";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",-2.3);
					EditPar2->Text = FormatFloat("0.00",1.5);
				};break;
		case 10 : {
					lblDistName->Caption = "Weibull";
					lblPar2->Visible = true;
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					EditPar2->Visible = lblPar2->Visible;
					EditPar1->Text = FormatFloat("0.00",0.7);
					EditPar2->Text = FormatFloat("0.00",1.3);
				};break;
		}
}
//---------------------------------------------------------------------------

void __fastcall TfrmGOFChi2::Button3Click(TObject *Sender)
{
	DoChi2Test();	
}
//---------------------------------------------------------------------------

void __fastcall TfrmGOFChi2::Edit2Change(TObject *Sender)
{
	try {
		Alpha = StrToSample(Edit2->Text);
	} catch(...) {
		Alpha = 0.05;
		Edit2->Text = SampleToStr(Alpha);
	}
}
//---------------------------------------------------------------------------

