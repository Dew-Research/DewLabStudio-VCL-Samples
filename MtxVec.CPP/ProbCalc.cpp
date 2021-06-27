//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ProbCalc.h"
#include "Probabilities.hpp"
#include "MtxVecTee.hpp"
#include "MtxVecInt.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TProb1 *Prob1;
//---------------------------------------------------------------------------
__fastcall TProb1::TProb1(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str = "The Probabilities unit introduces 36 most commonly ";
  str+= "used distributions. You can calculate ""Probability ";
  str+= "density function"" (PDF), ""Cumulative distribution function"" ";
  str+= "(CDF) and inverse ""Cumulative distribution function"" ";
  str+= "(InvCDF) for 6 discrete and 15 continuous distributions. ";
  str+= "Try changing distribution, distribution parameters and/or resulting CDF.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("NOTE :");
  str = """Calc  probability"" button will use distribution parameters ";
  str+= "to calculate PDF and CDF. The ""Calc x"" button will use CDF ";
  str+=  "(must lie in the interval [0,1]) to calculate the x value of a ";
  str+=  "given distribution. ";
  RichEdit1->Lines->Add(str);

  XVec = new Mtxvec::TVector;
  XVecInt = new Mtxvecint::TVecInt;
  YVec = new Mtxvec::TVector;
  XVec->Size(100,false);
  TrackBar1Change(TrackBar1);
  RadioGroup1Click(RadioGroup1);
}
//---------------------------------------------------------------------------

void __fastcall TProb1::FormDestroy(TObject *Sender)
{
  delete XVec;
  delete YVec;
  delete XVecInt;
}
//---------------------------------------------------------------------------

void __fastcall TProb1::RadioGroup1Click(TObject *Sender)
{
  Edit1->Text = "";
  Edit2->Text = "";
  Edit3->Text = "";
  Edit4->Text = "";
  Edit5->Text = "";
  Edit6->Text = "";
  switch (RadioGroup1->ItemIndex)
  {
    case 0 :
            { // BETA distribution
              Label1->Caption = "a; a > 0";
              Label2->Caption = "b; b > 0";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(0.25,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(0.75,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(0.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 1 :
            { // BINOMIAL distribution
              Label1->Caption = "n; n > 0";
              Label2->Caption = "p; p = [0,1]";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(4,ffFixed,0,0);
              Edit2->Text = FloatToStrF(0.75,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(3,ffFixed,0,0);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 2 :
            { // Cauchy distribution
              Label1->Caption = "m; m <> x";
              Label2->Caption = "b; b <> 0";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(1.5,ffFixed,0,0);
              Edit2->Text = FloatToStrF(2.12,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(3,ffFixed,0,0);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 3 :
            { // Chi-squared distribution
              Label1->Caption = "Nu; Nu > 0";
              Label2->Caption = "x";
              Edit1->Text = FloatToStrF(5,ffFixed,0,0);
              Edit2->Text = FloatToStrF(1.2,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 4 :
            { // Exponential distribution
              Label1->Caption = "Mu; Mu > 0";
              Label2->Caption = "x";
              Edit1->Text = FloatToStrF(0.95,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(3.25,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 5 :
            { // F distribution
              Label1->Caption = "Nu1; Nu1 > 0";
              Label2->Caption = "Nu2; Nu2 > 0";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(7,ffFixed,0,0);
              Edit2->Text = FloatToStrF(3,ffFixed,0,0);
              Edit3->Text = FloatToStrF(0.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 6 :
            { // Gamma distribution
              Label1->Caption = "a; a > 0";
              Label2->Caption = "b; b > 0";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(1.95,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(5,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(0.32,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 7 :
            { // Geometric distribution
              Label1->Caption = "p; p =[0,1]";
              Label2->Caption = "x";
              Edit1->Text = FloatToStrF(0.15,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(2.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 8 :
            { // Hypergeometric distribution
              Label1->Caption = "M; M >= K,N";
              Label2->Caption = "K;K >= x";
              Label3->Caption = "N; N >= x";
              Label4->Caption = "x";
              Edit1->Text = FloatToStrF(10,ffFixed,0,0);
              Edit2->Text = FloatToStrF(6,ffFixed,0,0);
              Edit3->Text = FloatToStrF(5,ffFixed,0,0);
              Edit4->Text = FloatToStrF(2.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = true;
              Edit4->Visible = true;
            }; break;
    case 9 :
            { // Logistic
              Label1->Caption = "m";
              Label2->Caption = "b";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(3.0,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(1.0,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(0.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 10 :
            { // Log-normal
              Label1->Caption = "Mu";
              Label2->Caption = "Sigma; Sigma > 0";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(3,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(1,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(0.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 11 :
            { // Maxwell distribution
              Label1->Caption = "a; a > 0";
              Label2->Caption = "x";
              Edit1->Text = FloatToStrF(0.95,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(1.2,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 12 :
            { // Negative binomial distribution
              Label1->Caption = "R; R > 1";
              Label2->Caption = "p; P =[0,1]";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(5,ffFixed,0,0);
              Edit2->Text = FloatToStrF(0.75,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(2,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 13 :
            { // Normal distribution
              Label1->Caption = "Mu";
              Label2->Caption = "Sigma; Sigma > 0";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(0,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(1,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(1,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 14 :
            { // Pareto distribution
              Label1->Caption = "a";
              Label2->Caption = "b; b < x";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(1.1,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(0.3,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(2.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 15 :
            { // Poisson distribution
              Label1->Caption = "Lambda; Lambda > 0";
              Label2->Caption = "x";
              Label1->Visible = true;
              Edit1->Text = FloatToStrF(13.2,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(7,ffFixed,0,0);
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 16 :
            { // Student distribution
              Label1->Caption = "Nu; Nu > 1";
              Label2->Caption = "x";
              Edit1->Text = FloatToStrF(3,ffFixed,0,0);
              Edit2->Text = FloatToStrF(5.5,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 17 :
            { // Rayleigh distribution
              Label1->Caption = "b; b > 0";
              Label2->Caption = "x; x >= 0";
              Label1->Visible = true;
              Edit1->Text = FloatToStrF(1.0,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(3.2,ffFixed,0,0);
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 18 :
            { // Triangular
              Label1->Caption = "a; a<=x<=b";
              Label2->Caption = "b";
              Label3->Caption = "c; a<=c<=b";
              Label4->Caption = "x";
              Edit1->Text = FloatToStrF(1.3,ffFixed,0,0);
              Edit2->Text = FloatToStrF(5.4,ffFixed,0,0);
              Edit3->Text = FloatToStrF(3.3,ffFixed,0,0);
              Edit4->Text = FloatToStrF(4.2,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = true;
              Edit4->Visible = true;
            }; break;
    case 19 :
            { // Uniform distribution
              Label1->Caption = "a; a < b";
              Label2->Caption = "b; b > a";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(-3,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(5,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(1,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            }; break;
    case 20 :
            { // Discrete uniform distribution
              Label1->Caption = "N; N > 1";
              Label2->Caption = "x";
              Edit1->Text = FloatToStrF(5,ffFixed,0,0);
              Edit2->Text = FloatToStrF(3.1,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = false;
              Edit3->Visible = false;
              Label4->Visible = false;
              Edit4->Visible = false;
            };break;
    case 21 :
            { // Weibull distribution
			  Label1->Caption = "a; a > 0";
              Label2->Caption = "b; b > 0";
              Label3->Caption = "x";
              Edit1->Text = FloatToStrF(0.75,ffFixed,Decimals,Decimals);
              Edit2->Text = FloatToStrF(2.5,ffFixed,Decimals,Decimals);
              Edit3->Text = FloatToStrF(1.25,ffFixed,Decimals,Decimals);
              Label1->Visible = true;
              Edit1->Visible = true;
              Label2->Visible = true;
              Edit2->Visible = true;
              Label3->Visible = true;
              Edit3->Visible = true;
              Label4->Visible = false;
              Edit4->Visible = false;
            };break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TProb1::Button1Click(TObject *Sender)
{
  double s1,s2,s3, s4;
  double RPDF,RCDF;
  int i1,i2,i3;

  RPDF = 0.0;
  RCDF = 0.0;
  switch (RadioGroup1->ItemIndex)
  {
    case 0:
          { // BETA
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = BetaPDF(s3,s1,s2);
            RCDF = BetaCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(0.01,0.0099);
              BetaPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 1:
          { // BINOMIAL
            i1 = StrToInt(Edit1->Text); // N
            s2 = StrToFloat(Edit2->Text); // p
            s3 = StrToFloat(Edit3->Text); // x
			RPDF = BinomPDF(s3,i1,s2);
            RCDF = BinomCDF(s3,i1,s2);
            if (CheckBox1->Checked)
            {
			  XVec->Ramp(0,i1*0.01);
			  XVec->CopyTo(XVecInt, TRounding::rnRound);
              BinomPDF(XVecInt,i1,s2,YVec);
            }
          };break;
    case 2:
          { // Cauchy
            s1 = StrToFloat(Edit1->Text); // b
            s2 = StrToFloat(Edit2->Text); // m
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = CauchyPDF(s3,s1,s2);
            RCDF = CauchyCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(0,0.1);
              CauchyPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 3:
          { //CHI2
            s1 = StrToFloat(Edit1->Text); // Nu
            s2 = StrToFloat(Edit2->Text); // x
            RPDF = ChiSquarePDF(s2,s1);
            RCDF = ChiSquareCDF(s2,(s1));
            if (CheckBox1->Checked)
            {
              XVec->Ramp(1*0.02,s1*0.05);
              ChiSquarePDF(XVec,s1,YVec);
            }
          };break;
    case 4:
          { // Exponential
            s1 = StrToFloat(Edit1->Text); // Mu
            s2 = StrToFloat(Edit2->Text); // x
            RPDF = ExpPDF(s2,s1);
            RCDF = ExpCDF(s2,s1);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(0,s1*0.05);
              ExpPDF(XVec,s1,YVec);
            }
          };break;
    case 5:
		  { // F - Fisher
            i1 = StrToInt(Edit1->Text); // Nu1
            i2 = StrToInt(Edit2->Text); // Nu2
            s1 = StrToFloat(Edit3->Text); // x
            RPDF = FPDF(s1,i1,i2);
            RCDF = FCDF(s1,i1,i2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp();
              FPDF(XVec,i1,i2,YVec);
            }
          };break;
    case 6:
          { // GAMMA
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = GammaPDF(s3,s1,s2);
            RCDF =GammaCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(0.02,0.2);
              GammaPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 7:
          { // Geometric
            s1 = StrToFloat(Edit1->Text); // p
            s2 = StrToFloat(Edit2->Text); // x
            RPDF = GeometricPDF(s2,s1);
            RCDF = GeometricCDF(s2,s1);
            if (CheckBox1->Checked)
            {
			  XVec->Ramp();
			  XVec->CopyTo(XVecInt, TRounding::rnRound);
              GeometricPDF(XVecInt,s1,YVec);
            }
          };break;
    case 8:
          { // Hypergeometric
            i1 = StrToInt(Edit1->Text); //M
            i2 = StrToInt(Edit2->Text); //K
            i3 = StrToInt(Edit3->Text); //N
            s1 = StrToFloat(Edit4->Text); // x
            RPDF = HypGeometricPDF(s1,i1,i2,i3);
            RCDF = HypGeometricCDF(s1,i1,i2,i3);
            if (CheckBox1->Checked)
			{
			   XVec->Ramp(0,Math387::Min(i2,i3)*0.01);
  			   XVec->CopyTo(XVecInt, TRounding::rnRound);
               HypGeometricPDF(XVecInt,i1,i2,i3,YVec);
            }
          };break;
    case 9:
          { // Logistic
            s1 = StrToFloat(Edit1->Text); // m
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = LogisticPDF(s3,s1,s2);
            RCDF = LogisticCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
			   XVec->Ramp(0.01,s2*0.1);
    		   XVec->CopyTo(XVecInt, TRounding::rnRound);
               LogisticPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 10:
          { // Log-normal
            s1 = StrToFloat(Edit1->Text); // mu
            s2 = StrToFloat(Edit2->Text); // sigma
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = LogNormalPDF(s3,s1,s2);
            RCDF = LogNormalCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
			   XVec->Ramp(0.01,s2*0.1);
               LogNormalPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 11:
          { // Maxwell
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // x
            RPDF = MaxwellPDF(s2,s1);
            RCDF = MaxwellCDF(s2,s1);
            if (CheckBox1->Checked)
            {
               XVec->Ramp(0,s2*0.05);
               MaxwellPDF(XVec,s1,YVec);
            }
          };break;
    case 12:
          { // Negative binomial
			i1 = StrToInt(Edit1->Text); //R
            s1 = StrToFloat(Edit2->Text); // p
            s2 = StrToFloat(Edit3->Text); // x
            RPDF = NegBinomPDF(s2,i1,s1);
            RCDF = NegBinomCDF(s2,i1,s1);
            if (CheckBox1->Checked)
            {
			  XVec->Ramp(0,0.02*i1);
			  XVec->CopyTo(XVecInt, TRounding::rnRound);
			  NegBinomPDF(XVecInt,i1,s1,YVec);
            }
          };break;
    case 13:
          { // Normal
            s1 = StrToFloat(Edit1->Text); // mu
            s2 = StrToFloat(Edit2->Text); // sigma
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = NormalPDF(s3,s1,s2);
            RCDF = NormalCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(s1-10*s2,0.2*s2);
              NormalPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 14:
          { // Pareto
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = ParetoPDF(s3,s1,s2);
            RCDF = ParetoCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(s2+0.1,0.1);
              ParetoPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 15:
          { // Poisson
            s1 = StrToFloat(Edit1->Text); // lambda
            i1 = StrToInt(Edit2->Text); // x
            RPDF = PoissonPDF(i1,s1);
            RCDF = PoissonCDF(i1,s1);
            if (CheckBox1->Checked)
            {
			  XVecInt->Ramp();
			  PoissonPDF(XVecInt,s1,YVec);
            }
          };break;
    case 16:
          { // Student
            i1 = StrToInt(Edit1->Text); // NU
            s1 = StrToFloat(Edit2->Text); // x
            RPDF = StudentPDF(s1,i1);
            RCDF = StudentCDF(s1,i1);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(-3*i1,0.06*i1);
              StudentPDF(XVec,i1,YVec);
            }
          };break;
    case 17:
          { // Rayleigh
            s1 = StrToFloat(Edit1->Text); // b
            s2 = StrToFloat(Edit2->Text); // x
            RPDF = RayleighPDF(s2,s1);
            RCDF = RayleighCDF(s2,s1);
            if (CheckBox1->Checked)
            {
               XVec->Ramp(0.1,s2*0.05);
               RayleighPDF(XVec,s1,YVec);
            }
          };break;
    case 18:
          { // Triangular
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // c
            s4 = StrToFloat(Edit4->Text); // x
            RPDF = TriangularPDF(s4,s1,s2,s3);
            RCDF = TriangularCDF(s4,s1,s2,s3);
            if (CheckBox1->Checked)
            {
               XVec->Ramp(s1-1.0,(s2-s1+2)*0.01);
               TriangularPDF(XVec,s1,s2,s3,YVec);
            }
          };break;
    case 19:
          { // Uniform - continous
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = UniformPDF(s3,s1,s2);
            RCDF = UniformCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(s1,(s2-s1)*0.01);
              UniformPDF(XVec,s1,s2,YVec);
            }
          };break;
    case 20:
          { // Uniform - discrete
            i1 = StrToInt(Edit1->Text); // N
            s1 = StrToFloat(Edit2->Text); // x
            RPDF = UniformDPDF(s1,i1);
            RCDF = UniformDCDF(s1,i1);
            if (CheckBox1->Checked)
            {
			  XVec->Ramp(1,i1*0.01);
			  XVec->CopyTo(XVecInt, TRounding::rnRound);
              UniformDPDF(XVecInt,i1,YVec);
            }
          };break;
    case 21:
          { // Weibull
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // x
            RPDF = WeibullPDF(s3,s1,s2);
            RCDF = WeibullCDF(s3,s1,s2);
            if (CheckBox1->Checked)
            {
              XVec->Ramp(0.02,0.1);
              WeibullPDF(XVec,s1,s2,YVec);
            }
          };break;
  }

  Edit5->Text = FloatToStrF(RPDF,ffFixed,Decimals,Decimals);
  Edit6->Text = FloatToStrF(RCDF,ffFixed,Decimals,Decimals);
  Set8087CW(MtxVec8087CW); // no exceptions
  if (CheckBox1->Checked)
  {
    YVec->ThreshBottom(EPS);
    DrawValues(XVec,YVec,Series1,false);
  }
}
//---------------------------------------------------------------------------

void __fastcall TProb1::TrackBar1Change(TObject *Sender)
{
  Decimals = TrackBar1->Position;
  Label8->Caption = IntToStr(Decimals);
}
//---------------------------------------------------------------------------


void __fastcall TProb1::Button2Click(TObject *Sender)
{
  double p = StrToFloat(Edit6->Text);
  int i1,i2,i3;
  double s1,s2,s3,x;

  switch (RadioGroup1->ItemIndex)
  {
    case 0:
          { // BETA
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            x = BetaCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 1:
          { // Binomial
            i1 = StrToInt(Edit1->Text); // N
            s1 = StrToFloat(Edit2->Text); // p
            x = BinomCDFInv(p,i1,s1);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 2:
          { // Cauchy
            s1 = StrToFloat(Edit1->Text); // b
            s2 = StrToFloat(Edit2->Text); // m
            x = CauchyCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 3:
          { // CHI2
            s1 = StrToFloat(Edit1->Text); // Nu
            x = ChiSquareCDFInv(p,s1);
            Edit2->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 4:
          { // Exponential
            s1 = StrToFloat(Edit1->Text); // Mu
            x = ExpCDFInv(p,s1);
            Edit2->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 5:
          { // F - Fisher
            i1 = StrToInt(Edit1->Text); // Nu1
            i2 = StrToInt(Edit2->Text); // Nu2
            x = FCDFInv(p,i1,i2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 6:
          { // GAMMA
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            x = GammaCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 7:
          { // Geometric
            s1 = StrToFloat(Edit1->Text); // p
            x = GeometricCDFInv(p,s1);
            Edit2->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 8:
          { // Hypergeometric
            i1 = StrToInt(Edit1->Text); //M
            i2 = StrToInt(Edit2->Text); //K
            i3 = StrToInt(Edit3->Text); //N
            x = HypGeometricCDFInv(p,i1,i2,i3);
            Edit4->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 9:
          { // Logistic
            s1 = StrToFloat(Edit1->Text); // m
            s2 = StrToFloat(Edit2->Text); // b
            x = LogisticCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 10:
          { // Log-normal
            s1 = StrToFloat(Edit1->Text); // mu
            s2 = StrToFloat(Edit2->Text); // sigma
            x = LogNormalCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 11:
          { // Maxwell
            s1 = StrToFloat(Edit1->Text); // a
            x = MaxwellCDFInv(p,s1);
            Edit2->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 12:
          { // Negative binomial
            i1 = StrToInt(Edit1->Text); //R
            s1 = StrToFloat(Edit2->Text); // p
            x = NegBinomCDFInv(p,i1,s1);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 13:
          { // Normal
            s1 = StrToFloat(Edit1->Text); // mu
            s2 = StrToFloat(Edit2->Text); // sigma
            x = NormalCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 14:
          { // Pareto
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            x = ParetoCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 15:
          { // Poisson
            s1 = StrToFloat(Edit1->Text); // lambda
            x = PoissonCDFInv(p,s1);
            Edit2->Text = FloatToStrF(x,ffFixed,0,0);
          };break;
    case 16:
          { // Student
            i1 = StrToInt(Edit1->Text); // NU
            x = StudentCDFInv(p,i1);
            Edit2->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 17:
          { // Rayleigh
            s1 = StrToFloat(Edit1->Text); // lambda
            x = RayleighCDFInv(p,s1);
            Edit2->Text = FloatToStrF(x,ffFixed, Decimals,Decimals);
          };break;
    case 18:
          { // Triangular
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            s3 = StrToFloat(Edit3->Text); // c
            x = TriangularCDFInv(p,s1,s2,s3);
            Edit4->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 19:
          { // Uniform - continous
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            x = UniformCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 20:
          { // Uniform - discrete
            i1 = StrToInt(Edit1->Text); // N
            x = UniformDCDFInv(p,i1);
            Edit2->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    case 21:
          { // Weibull
            s1 = StrToFloat(Edit1->Text); // a
            s2 = StrToFloat(Edit2->Text); // b
            x = WeibullCDFInv(p,s1,s2);
            Edit3->Text = FloatToStrF(x,ffFixed,Decimals,Decimals);
          };break;
    }
}
//---------------------------------------------------------------------------

void __fastcall TProb1::Edit1Enter(TObject *Sender)
{
  Button1->Enabled = true;
  Button2->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TProb1::Edit6Enter(TObject *Sender)
{
  Button1->Enabled = false;
  Button2->Enabled = true;
}
//---------------------------------------------------------------------------


