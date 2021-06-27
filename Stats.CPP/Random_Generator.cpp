//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Mtxexpr.hpp"
#include "Mtxexprint.hpp"
#include "Random_Generator.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma link "VCLTee.StatChar"
#pragma resource "*.dfm"
TfrmRandomGen *frmRandomGen;
//---------------------------------------------------------------------------
__fastcall TfrmRandomGen::TfrmRandomGen(TComponent* Owner)
	: TfrmBasic(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmRandomGen::FormShow(TObject *Sender)
{
	CBRandomG->ItemIndex = 6; // Gamma distribution
	CBRandomGChange(this);
	SpeedButton1Click(this); // show data 
}
//---------------------------------------------------------------------------
void __fastcall TfrmRandomGen::SpeedButton1Click(TObject *Sender)
{
	v1.Size(UpDown1->Position);
	xInt.Size(v1);

	TSample s1,s2,s3;
	int i1,i2,i3;
	switch (CBRandomG->ItemIndex)
	{
		case 0 : { // Beta
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomBeta(s1,s2,v1);
				};break;
		case 1 : { // Binomial
					i1 = StrToInt(Edit1->Text);
					s1 = StrToFloat(Edit2->Text);
					RandomBinom(i1,s1,xInt);
					v1.Copy(xInt);
				};break;
		case 2 : { // Cauchy
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomCauchy(s1,s2,v1);
				};break;
		case 3 : { // ChiSquared
					i1 = StrToInt(Edit1->Text);
					RandomChiSquare(i1,v1);
				};break;
		case 4 : { // Erlang
					i1 = StrToInt(Edit1->Text);
					s1 = StrToFloat(Edit2->Text);
					RandomErlang(i1,s1,v1);
				};break;
		case 5 : { // Exponential
					s1 = StrToFloat(Edit1->Text);
					RandomExponent(s1,v1);
				};break;
		case 6 : { // F
					i1 = StrToInt(Edit1->Text);
					i2 = StrToInt(Edit2->Text);
					RandomF(i1,i2,v1);
				};break;
		case 7 : { // Gamma
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomGamma(s1,s2,v1);
				};break;
		case 8 : { // Geometric
					s1 = StrToFloat(Edit1->Text);
					RandomGeometric(s1,v1);
				};break;
		case 9 : { // Hypergeometric
					i1 = StrToInt(Edit1->Text);
					i2 = StrToInt(Edit2->Text);
					i3 = StrToInt(Edit3->Text);
					RandomHypGeometric(i1,i2,i3,xInt);
					v1.Copy(xInt);
				};break;
		case 10 : { // Laplace
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomLaplace(s1,s2,v1);
				};break;
		case 11 : { // Log Normal
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomLogNormal(s1,s2,v1);
				};break;
		case 12 : { // Negative binomial
					i1 = StrToInt(Edit1->Text);
					s1 = StrToFloat(Edit2->Text);
					RandomNegBinom(i1,s1,xInt);
                    v1.Copy(xInt);
				};break;
		case 13 : { // Normal
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomNormal(s1,s2,v1);
				};break;
		case 14 : { // Poisson
					s1 = StrToFloat(Edit1->Text);
					RandomPoisson(s1,xInt);
                    v1.Copy(xInt);
				};break;
		case 15 : { // Rayleigh
					s1 = StrToFloat(Edit1->Text);
					RandomRayleigh(s1,v1);
				};break;
		case 16 : { // Student
					i1 = StrToInt(Edit1->Text);
					RandomStudent(i1,v1);
				};break;
		case 17 : { // Triangular
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					s3 = StrToFloat(Edit2->Text);
					RandomTriangular(s1,s2,s3,v1);
				};break;
		case 18 : { // continuous uniform
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomUniform(s1,s2,v1);
				};break;
		case 19 : { // Discrete uniform
					i1 = StrToInt(Edit1->Text);
					RandomUniformD(i1,v1);
				};break;
		case 20 : { // Weibull
					s1 = StrToFloat(Edit1->Text);
					s2 = StrToFloat(Edit2->Text);
					RandomWeibull(s1,s2,v1);
				};break;
	}

	Histogram(v1,UpDown2->Position,VecCount,VecBins,true);
	Series2->Active = CheckBox1->Checked;
	Chart1->SubTitle->Text->Clear();
	// do this only if you want to calculate parameters
	if (CheckBox1->Checked)
	{
		if (Estimate(VecBins))
		{
			DrawValues(VecBins,v2,Series2,False);
			Chart1->SubTitle->Text->Add(MsgText);
		}
	}
	// draw dataset
	DrawValues(VecBins,VecCount,Series1,false);
}
//---------------------------------------------------------------------------
void __fastcall TfrmRandomGen::CBRandomGChange(TObject *Sender)
{
  Series1->Clear();
	Series2->Clear();
	Chart1->SubTitle->Text->Clear();
	switch (CBRandomG->ItemIndex)
	{
		case 0:  { // Beta
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",1.5);
					Edit2->Text = FormatFloat("0.00",0.9);
				};break;
		case 1:  { // Binomial
					lblPar1->Caption = "N";
					lblPar2->Caption = "p";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = "10";
					Edit2->Text = FormatFloat("0.00",0.4);
				};break;
		case 2:  { // Cauchy
					lblPar1->Caption = "m";
					lblPar2->Caption = "b";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",0);
					Edit2->Text = FormatFloat("0.00",0.5);
				};break;
		case 3:  { // ChiSquared
					lblPar1->Caption = "Nu";
					lblPar2->Visible = false;
					lblPar3->Visible = false;
					Edit1->Text = "4";
				};break;
		case 4:  { // Erlang
					lblPar1->Caption = "k";
					lblPar1->Caption = "lambda";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = "2";
					Edit2->Text = FormatFloat("0.00", 0.37);
				};break;
		case 5:  { // Exponential
					lblPar1->Caption = "Mu";
					lblPar2->Visible = false;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00", 1.8);
				};break;
		case 6:  { // F
					lblPar1->Caption = "Nu1";
					lblPar2->Caption = "Nu2";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = "3";
					Edit2->Text = "8";
				};break;
		case 7:  { // Gamma
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",2.1);
					Edit2->Text = FormatFloat("0.00",0.3);
				};break;
		case 8:  { // Geometric
					lblPar1->Caption = "P";
					lblPar2->Visible = false;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",0.7);
				};break;
		case 9:  { // HyperGeometric
					lblPar1->Caption = "M";
					lblPar2->Caption = "K";
					lblPar3->Caption = "N";
					lblPar2->Visible = true;
					lblPar3->Visible = true;
					Edit1->Text = "50";
					Edit2->Text = "30";
					Edit3->Text = "20";
				};break;
		case 10:  { // Laplace
					lblPar1->Caption = "m";
					lblPar2->Caption = "b";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",1.5);
					Edit2->Text = FormatFloat("0.00",0.8);
				};break;
		case 11:  { // LogNormal
					lblPar1->Caption = "mu";
					lblPar2->Caption = "sigma";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",5.0);
					Edit2->Text = FormatFloat("0.00",0.2);
				};break;
		case 12:  { // Negative binomial
					lblPar1->Caption = "R";
					lblPar2->Caption = "p";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = "15";
					Edit2->Text = FormatFloat("0.00",0.65);
				};break;
		case 13:  { // Normal-Gauss
					lblPar1->Caption = "mu";
					lblPar2->Caption = "sigma";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",5.0);
					Edit2->Text = FormatFloat("0.00",0.2);
				};break;
		case 14:  { // Poisson
					lblPar1->Caption = "Lambda";
					lblPar2->Visible = false;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",7.2);
				};break;
		case 15:  { // Rayleigh
					lblPar1->Caption = "b";
					lblPar2->Visible = false;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",0.2);
				};break;
		case 16:  { // Student
					lblPar1->Caption = "Nu";
					lblPar2->Visible = false;
					lblPar3->Visible = false;
					Edit1->Text = "4";
				};break;
		case 17:  { // Triangular
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					lblPar3->Caption = "c";
					lblPar2->Visible = true;
					lblPar3->Visible = true;
					Edit1->Text = FormatFloat("0.00",1.2);
					Edit2->Text = "5";
					Edit3->Text = "4";
				};break;
		case 18:  { // Continuous Uniform
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",-2.5);
					Edit2->Text = FormatFloat("0.00",3.9);
				};break;
		case 19:  { // Discrete Uniform
					lblPar1->Caption = "N";
					lblPar2->Visible = false;
					lblPar3->Visible = false;
					Edit1->Text = "20";
				};break;
		case 20:  { // Weibull
					lblPar1->Caption = "a";
					lblPar2->Caption = "b";
					lblPar2->Visible = true;
					lblPar3->Visible = false;
					Edit1->Text = FormatFloat("0.00",1.5);
					Edit2->Text = FormatFloat("0.00",2.3);
				};break;
		}
		Edit2->Visible = lblPar2->Visible;
		Edit3->Visible = lblPar3->Visible;
}
//---------------------------------------------------------------------------
void __fastcall TfrmRandomGen::Chart1UndoZoom(TObject *Sender)
{
  Chart1->LeftAxis->AutomaticMaximum = true;
}
//---------------------------------------------------------------------------
void __fastcall TfrmRandomGen::CheckBox1Click(TObject *Sender)
{
  Series2->Active = CheckBox1->Checked;
	Chart1->Legend->Visible = Series2->Active;
}
//---------------------------------------------------------------------------
bool __fastcall TfrmRandomGen::Estimate(TVec* X)
{
	TSample Par0, Par1, Par2;
	int Int0, Int1;
	Screen->Cursor = crHourGlass;
	Series2->Active = true;
	bool result = true;

	switch (CBRandomG->ItemIndex)
	{
		case 0:  {
					BetaFit(v1,Par0,Par1);
					BetaPDF(X,Par0,Par1,v2);
					MsgText = "a = "+FormatFloat("0.0000",Par0)+" ; "+ "b = "+FormatFloat("0.0000",Par1);
				};break;
		case 1: {
					BinomFit(v1,Int0,Par0);
					X->CopyTo(xInt, TRounding::rnRound);
					BinomPDF(xInt,Int0,Par0,v2);
					MsgText = "N = "+IntToStr(Int0)+" ; "+ "p = "+FormatFloat("0.0000",Par0);
				}; break;
		case 2:  {
					CauchyFit(v1,Par0,Par1,100,1.0e-6);
					CauchyPDF(X,Par0,Par1,v2);
					MsgText = "m = "+FormatFloat("0.0000",Par0)+" ; "+ "b = "+FormatFloat("0.0000",Par1);
				};break;
		case 3:  {
					ChiSquareFit(v1,Int0);
					ChiSquarePDF(X,Int0,v2);
					MsgText = "Nu = "+IntToStr(Int0);
				};break;
		case 4: {
					ErlangFit(v1,Int0,Par0);
					ErlangPDF(X,Int0,Par0,v2);
					MsgText = "k = "+IntToStr(Int0)+" ; "+ "lambda = "+FormatFloat("0.0000",Par0);
				};break;
		case 5: {
					ExponentFit(v1,Par0);
					ExpPDF(X,Par0,v2);
					MsgText = "mu = "+FormatFloat("0.0000",Par0);
				};break;
		case 6: {
					FFit(v1,Int0,Int1);
					FPDF(X,Int0,Int1,v2);
					MsgText = "Nu1 = " + IntToStr(Int0) + " ; "+ "Nu2 = "+IntToStr(Int1);
				};break;
		case 7:  {
					GammaFit(v1,Par0,Par1);
					GammaPDF(X,Par0,Par1,v2);
					MsgText = "a = "+FormatFloat("0.0000",Par0)+" ; "+ "b = "+FormatFloat("0.0000",Par1);
				};break;
		case 8:  {
					GeometricFit(v1,Par0);
					X->CopyTo(xInt, TRounding::rnRound);
					GeometricPDF(xInt,Par0,v2);
					MsgText = "P = "+FormatFloat("0.0000",Par0);
		};break;
		case 10:  {
					LaplaceFit(v1,Par0,Par1);
					LaplacePDF(X,Par0,Par1,v2);
					MsgText = "mu = "+FormatFloat("0.0000",Par0)+" ; "+ "b = "+FormatFloat("0.0000",Par1);
		};break;
		case 11:  {
					LogNormalFit(v1,Par0,Par1);
					LogNormalPDF(X,Par0,Par1,v2);
					MsgText = "mu = "+FormatFloat("0.0000",Par0)+" ; "+ "sigma = "+FormatFloat("0.0000",Par1);
		};break;
		case 12:  {
					NegBinomFit(v1,Par0,Par1);
					X->CopyTo(xInt, TRounding::rnRound);
					NegBinomPDF(xInt,Par0,Par1,v2);
					MsgText = "r = "+FormatFloat("0.0000",Par0)+" ; p = "+FormatFloat("0.0000",Par1);
		};break;
		case 13:  {
					NormalFit(v1,Par0,Par1);
					NormalPDF(X,Par0,Par1,v2);
					MsgText = "mu = "+FormatFloat("0.0000",Par0)+" ; "+ "sigma = "+FormatFloat("0.0000",Par1);
		};break;
		case 14: {
					PoissonFit(v1,Par0);
					PoissonPDF(xInt,Par0,v2);
					MsgText = "lambda = "+FormatFloat("0.0000",Par0);
				};break;
		case 15: {
					RayleighFit(v1,Par0);
					RayleighPDF(X,Par0,v2);
					MsgText = "b = "+FormatFloat("0.0000",Par0);
		};break;
		case 16: {
    					StudentFit(v1,Int0);
					StudentPDF(X,Int0,v2);
					MsgText = "Nu = "+ IntToStr(Int0);
		};break;
		case 17: {
					TriangularFit(v1,Par0,Par1,Par2);
					TriangularPDF(X,Par0,Par1,Par2,v2);
					MsgText = "a = "+FormatFloat("0.0000",Par0)+" ; b = "+FormatFloat("0.0000",Par1)+ " ; "
						+"c = "+FormatFloat("0.0000",Par2);
		};break;
		case 18: {
					UniformFit(v1,Par0,Par1);
					UniformPDF(X,Par0,Par1,v2);
					MsgText = "a = "+FormatFloat("0.0000",Par0)+" ; "+ "b = "+FormatFloat("0.0000",Par1);
		};break;
		case 19: {
					UniformDFit(v1,Int0);
					X->CopyTo(xInt, TRounding::rnRound);
					UniformDPDF(xInt,Int0,v2);
					MsgText = "N = "+IntToStr(Int0);
				};break;
		case 20: {
					WeibullFit(v1,Par0,Par1);
					WeibullPDF(X,Par0,Par1,v2);
					MsgText = "a = "+FormatFloat("0.0000",Par0)+" ; "+ "b = "+FormatFloat("0.0000",Par1);
				};break;
		default: {
						Series2->Active = false;
						MsgText = "Not supported";
						result = false;
					};break;
	}
	Chart1->Legend->Visible = Series2->Active;
	MsgText = "Estimates: " + MsgText;
	Screen->Cursor = crDefault;
	return result;
}
