//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "NLin_Tests.h"
#include "LogMemo.h"
#include "MtxIntDiff.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic_Form"
#pragma resource "*.dfm"
TfrmNonLinTest *frmNonLinTest;
//---------------------------------------------------------------------------
__fastcall TfrmNonLinTest::TfrmNonLinTest(TComponent* Owner)
	: TfrmBasic(Owner)
{
	MtxNonLinReg = new TMtxNonLinReg(NULL);
	frmLogForm = new TfrmLogForm(this);
	Memo1->Lines->Add("NIST non-linear regression tests : ");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Eckerle4 : These data are the result of a NIST study involving"
			" circular interference transmittance.  The response"
			" variable is transmittance, and the predictor variable"
			" is wavelength. (Higher level of difficulty)");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Thurber : These data are the result of a NIST study involving"
			" semiconductor electron mobility.  The response variable is a measure"
			" of electron mobility, and the predictor variable is the natural log"
			" of the density (Higher level of diffuculty).");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Rat42 : This model and data are an example of fitting sigmoidal growth"
			" curves taken from Ratkowsky (1983). The response variable is pasture"
			" yield, and the predictor variable is growing time (Average level of difficulty).");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Misra1C : These data are the result of a NIST study regarding dental research"
			" in monomolecular adsorption. The response variable is volume, and the predictor"
			" variable is pressure (Average level of difficulty).");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("MHG09 : This problem was found to be difficult for some very good algorithms."
			" There is a local minimum at (+inf,-14.07..., -inf, -inf) with final sum of"
			" squares 0.00102734... (Higher level of difficulty).");
	Memo1->Lines->Add("");
	 Memo1->Lines->Add("Chiwrut2: These data are the result of a NIST study involving ultrasonic calibration."
				 " The response variable is ultrasonic response, and the predictor variable is"
				 " metal distance.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("MHG10: This problem was found to be difficult for some very good algorithms.");
	Memo1->Lines->Add("");
	Memo1->Lines->Add("Roszman1: These data are the result of a NIST study involving "
			"quantum defects in iodine atoms.  The response"
			"variable is the number of quantum defects, and the"
			"predictor variable is the excited energy state. ");
	Edit2->Text = FormatFloat("0.00e+00",1.0e-5);
	Edit3->Text = FormatFloat("0.00e+00",Sqrt(EPS));
	Edit4->Text = FormatFloat("0.00e+00",1.0e-6);
}
//---------------------------------------------------------------------------
TSample __fastcall Eckerle4(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return B[0]/B[1] * Exp(-0.5 * ((X-B[2])/B[1]) * ((X-B[2])/B[1]) );
}

TSample __fastcall Thurber(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return (B[0] + B[1]*X + B[2]*X*X + B[3]*Math387::IntPower(X,3)) /
						(1.0 + B[4]*X + B[5]*X*X + B[6]*Math387::IntPower(X,3));
}

TSample __fastcall Rat42(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return B[0] / (1.0 + Exp(B[1]-B[2]*X));
}

TSample __fastcall Misra1c(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return B[0]*(1-Math387::Power(1+2*B[1]*X,-0.5));
}

TSample __fastcall MGH09(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return B[0]*(X*X + X*B[1]) / (X*X + X*B[2]+B[3]);
}

TSample __fastcall Chwirut2(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return Exp(-B[0]*X)/(B[1]+B[2]*X);
}

TSample __fastcall MGH10(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return B[0]*Exp(B[1]/(X+B[2]));
}

TSample __fastcall Roszman1(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return B[0]-B[1]*X - ArcTan(B[2]/(X-B[3]))/PI;
}

TSample __fastcall Rat43(

	  #if  (__BORLANDC__ >= 0x0650)
	  TVec* const Bv,
	  #else
	  const TVec* Bv,
	  #endif

	  double X)

{
	Mtxvec::TVec* aBv = const_cast<Mtxvec::TVec*> (Bv);
	double* B = aBv->PValues1D(0);

	return B[0] / Math387::Power((1.0 + Exp(B[1]-B[2]*X)),1/B[3]);
}

void __fastcall TfrmNonLinTest::FormShow(TObject *Sender)
{
  ComboBox1->ItemIndex = 1; // Default = Marquardt method
	ComboBox2->ItemIndex = 0;
	ComboBox2Change(this);
}
//---------------------------------------------------------------------------

void __fastcall TfrmNonLinTest::ComboBox1Change(TObject *Sender)
{
  MtxNonLinReg->OptMethod = (TOptMethod)ComboBox1->ItemIndex;
	SpeedButton1->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TfrmNonLinTest::ComboBox2Change(TObject *Sender)
{
	switch (ComboBox2->ItemIndex)
	{
		case 0: MtxNonLinReg->RegressFunction = Eckerle4;break;
		case 1: MtxNonLinReg->RegressFunction = Thurber;break;
		case 2: MtxNonLinReg->RegressFunction = Rat42;break;
		case 3: MtxNonLinReg->RegressFunction = Misra1c;break;
		case 4: MtxNonLinReg->RegressFunction = MGH09;break;
		case 5: MtxNonLinReg->RegressFunction = Chwirut2;break;
		case 6: MtxNonLinReg->RegressFunction = MGH10;break;
		case 7: MtxNonLinReg->RegressFunction = Roszman1;break;
		case 8: MtxNonLinReg->RegressFunction = Rat43;break;
	}
	SpeedButton1->Enabled = true;
	DisplayInfo(ComboBox2->ItemIndex);
	FillData(ComboBox2->ItemIndex);
	Series1->Clear();
	Series2->Clear();
	DrawValues(MtxNonLinReg->X, MtxNonLinReg->Y,Series1,false); // original data
}
//---------------------------------------------------------------------------
void __fastcall TfrmNonLinTest::FillData(int Index)
{
	if (Index == 0) // Eckerle4
	{
		double A[] = { 400.0, 405.0, 410.0, 415.0,
                   420.0, 425.0, 430.0, 435.0,
                   436.5, 438.0, 439.5, 441.0,
                   442.5, 444.0, 445.5, 447.0,
                   448.5, 450.0, 451.5, 453.0,
                   454.5, 456.0, 457.5, 459.0,
                   460.5, 462.0, 463.5, 465.0,
                   470.0, 475.0, 480.0, 485.0,
                   490.0, 495.0, 500.0};
		MtxNonLinReg->X->SetIt(false,A,sizeof(A)/sizeof(double)-1);
		double B[] = { 0.0001575, 0.0001699, 0.0002350, 0.0003102,
                   0.0004917, 0.0008710, 0.0017418, 0.0046400,
                   0.0065895, 0.0097302, 0.0149002, 0.0237310,
                   0.0401683, 0.0712559, 0.1264458, 0.2073413,
                   0.2902366, 0.3445623, 0.3698049, 0.3668534,
                   0.3106727, 0.2078154, 0.1164354, 0.0616764,
                   0.0337200, 0.0194023, 0.0117831, 0.0074357,
                   0.0022732, 0.0008800, 0.0004579, 0.0002345,
                   0.0001586, 0.0001143, 0.0000710};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);

	} else if (Index == 1) { //Thurber
		double A[] = {	-3.067, -2.981, -2.921, -2.912,
										-2.840, -2.797, -2.702, -2.699,
										-2.633, -2.481, -2.363, -2.322,
										-1.501, -1.460, -1.274, -1.212,
										-1.100, -1.046, -0.915, -0.714,
										-0.566, -0.545, -0.400, -0.309,
										-0.109, -0.103, 0.010, 0.119,
										0.377, 0.790, 0.963, 1.006,
										1.115, 1.572, 1.841, 2.047,
										2.200};
		MtxNonLinReg->X->SetIt(false,A,sizeof(A)/sizeof(double)-1);
		double B[] = { 80.574, 84.248, 87.264, 87.195,
									 89.076, 89.608, 89.868, 90.101,
									 92.405, 95.854, 100.696, 101.060,
									 401.672, 390.724, 567.534, 635.316,
									 733.054, 759.087, 894.206, 990.785,
									 1090.109, 1080.914, 1122.643, 1178.351,
									 1260.531, 1273.514, 1288.339, 1327.543,
									 1353.863, 1414.509, 1425.208, 1421.384,
									 1442.962, 1464.350, 1468.705, 1447.894,
									 1457.628};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);

	} else if (Index == 2) {  // Rat42
		double A[] = { 9.000, 14.000, 21.000, 28.000,
									 42.000, 57.000, 63.000, 70.000,
									 79.000};
		MtxNonLinReg->X->SetIt(false,A,sizeof(A)/sizeof(double)-1);
		double B[] = { 8.930, 10.800, 18.590, 22.330,
									 39.350, 56.110, 61.730, 64.620,
									 67.080};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);
	} else if (Index == 3) { // Misra1c 
		double A[] = { 77.6, 114.9, 141.1, 190.8, 239.9,
									 289.0, 332.8, 378.4, 434.8, 477.3,
									 536.8, 593.1, 689.1, 760.0};
		MtxNonLinReg->X->SetIt(false,A,sizeof(A)/sizeof(double)-1);
		double B[] = { 10.07, 14.73, 17.94, 23.93, 29.61,
									 35.18, 40.02, 44.82, 50.76, 55.05,
									 61.01, 66.40, 75.47, 81.78};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);
	} else if (Index == 4) { // MGH09
		double A[] = { 4.000000E+00, 2.000000E+00, 1.000000E+00,
									 5.000000E-01, 2.500000E-01, 1.670000E-01,
									 1.250000E-01, 1.000000E-01, 8.330000E-02,
									 7.140000E-02, 6.250000E-02};
		MtxNonLinReg->X->SetIt(false,A,sizeof(A)/sizeof(double)-1);
		double B[] = { 1.957000E-01, 1.947000E-01, 1.735000E-01,
									 1.600000E-01, 8.440000E-02, 6.270000E-02,
									 4.560000E-02, 3.420000E-02, 3.230000E-02,
									 2.350000E-02, 2.460000E-02};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);
	} else if (Index == 5) { // Chiwrut2
		double A[] = { 0.50, 1.00, 1.75, 3.75, 5.75, 0.875, 2.25,
									 3.25, 5.25, 0.75, 1.75, 2.75, 4.75, 0.625,
									 1.25, 2.25, 4.25, 0.50, 3.00, 0.75, 3.00,
									 1.50, 6.00, 3.00, 6.00, 1.50, 3.00, 0.50,
									 2.00, 4.00, 0.75, 2.00, 5.00, 0.75, 2.25,
									 3.75, 5.75, 3.00, 0.75, 2.50, 4.00, 0.75,
									 2.50, 4.00, 0.75, 2.50, 4.00, 0.50, 6.00,
									 3.00, 0.50, 2.75, 0.50, 1.75};
		MtxNonLinReg->X->SetIt(false,A,sizeof(A)/sizeof(double)-1);
		double B[] = { 92.90,57.1, 31.05, 11.5875, 8.025, 63.6,
									 21.40, 14.25, 8.475, 63.80, 26.8, 16.4625,
									 7.125, 67.30, 41.00, 21.15, 8.175, 81.50, 13.12,
									 59.90, 14.62, 32.90, 5.44, 12.56, 5.44,
									 32.00, 13.95, 75.80, 20.00, 10.42, 59.50, 21.67,
									 8.55, 62.00, 20.20, 7.76, 3.75, 11.81, 54.70,
									 23.70, 11.55, 61.30, 17.70, 8.74, 59.20, 16.30,
									 8.62, 81.00, 4.87, 14.62, 81.70, 17.17, 81.30,
									 28.90};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);
	} else if (Index == 6) { // MGH10
		MtxNonLinReg->X->Size(16);
		MtxNonLinReg->X->Ramp(50,5);
		double B[] = { 3.478000E+04, 2.861000E+04, 2.365000E+04, 1.963000E+04,
									 1.637000E+04, 1.372000E+04, 1.154000E+04, 9.744000E+03,
									 8.261000E+03, 7.030000E+03, 6.005000E+03, 5.147000E+03,
									 4.427000E+03, 3.820000E+03, 3.307000E+03, 2.872000E+03};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);
	} else if (Index == 7) { // Roszman1
		double A[] = { -4868.68,-4868.09,-4867.41,-3375.19,-3373.14,-3372.03,
									 -2473.74,-2472.35,-2469.45,-1894.65,-1893.40,-1497.24,
									 -1495.85,-1493.41,-1208.68,-1206.18,-1206.04,-997.92,
									 -996.61,-996.31,-834.94,-834.66,-710.03,-530.16,-464.17};
		MtxNonLinReg->X->SetIt(false,A,sizeof(A)/sizeof(double)-1);
		double B[] = { 0.252429,0.252141,0.251809,0.297989,0.296257,0.295319,
									 0.339603,0.337731,0.333820,0.389510,0.386998,0.438864,
									 0.434887,0.427893,0.471568,0.461699,0.461144,0.513532,
									 0.506641,0.505062,0.535648,0.533726,0.568064,0.612886,0.624169};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);
	} else if (Index == 8) { // Rat43
		MtxNonLinReg->X->Size(15);
		MtxNonLinReg->X->Ramp(1,1);
		double B[] = { 16.08,33.83,65.80,97.20,191.55,326.20,386.87,520.53,590.03,
									651.92,724.93,699.56,689.96,637.56,717.41};
		MtxNonLinReg->Y->SetIt(false,B,sizeof(B)/sizeof(double)-1);
	}
}

void __fastcall TfrmNonLinTest::SpeedButton1Click(TObject *Sender)
{
	Screen->Cursor = crHourGlass;
	try
	{
		Edit1Change(this); // check if we have to calc more
		Edit3Change(this); // check if we have to calc more
		Edit4Change(this); // check if we have to calc more
		ResetEstimates(ComboBox2->ItemIndex); // reset parameter estimates
		DWord Elapsed = GetTickCount();
		MtxNonLinReg->Recalc(); // main calculation
		Elapsed = GetTickCount() - Elapsed;
		WriteToLog(Elapsed);
		DrawValues(MtxNonLinReg->X, MtxNonLinReg->YCalc,Series2,false);
	} __finally {
		SpeedButton1->Enabled = false;
		CheckBox1Click(this);
		Screen->Cursor = crDefault;
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmNonLinTest::DisplayInfo(int Index)
{
	if (Index == 0)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("These data are the result of a NIST study involving circular interference"
				" transmittance.  The response variable is transmittance, and the predictor"
				" variable is wavelength.");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response Variable  (y = transmittance)");
		Memo2->Lines->Add("               1 Predictor Variable (x = wavelength)");
		Memo2->Lines->Add("               35 Observations");
		Memo2->Lines->Add("               Higher Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Exponential Class");
		Memo2->Lines->Add("               3 Parameters (b[0] to b[2])");
		Memo2->Lines->Add("               Y = B[0]/B[1] * Exp(-0.5*Sqr((X-B[2])/B[1]))");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 1.5543827178");
		Memo2->Lines->Add("               b[1] = 4.0888321754");
		Memo2->Lines->Add("               b[2] = 451.54121844");
	}
	else if (Index == 1)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("These data are the result of a NIST study involving semiconductor"
				" electron mobility.  The response variable is a measure of electron"
				" mobility, and the predictor variable is the natural log of the density.");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response Variable  (y = electron mobility)");
		Memo2->Lines->Add("               1 Predictor Variable (x = ln[density])");
		Memo2->Lines->Add("               37 Observations");
		Memo2->Lines->Add("               Higher Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Rational Class (cubic/cubic)");
		Memo2->Lines->Add("               7 Parameters (b[0] to b[6])");
		Memo2->Lines->Add("               Y = (B[0] + B[1]*X + B[2]*Sqr(X) + B[3]*IntPower(X,3)) / ");
		Memo2->Lines->Add("                   (1.0 + B[4]*X + B[5]*Sqr(X) + B[6]*IntPower(X,3))");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 1288.1396800");
		Memo2->Lines->Add("               b[1] = 1491.0792535");
		Memo2->Lines->Add("               b[2] = 583.23836877");
		Memo2->Lines->Add("               b[3] = 75.416644291");
		Memo2->Lines->Add("               b[4] = 0.96629502864");
		Memo2->Lines->Add("               b[5] = 0.39797285797");
		Memo2->Lines->Add("               b[6] = 0.049727297349");
	}
	else if (Index == 2)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("This model and data are an example of fitting sigmoidal growth curves taken from Ratkowsky (1983)."
			"The response variable is pasture yield, and the predictor variable is growing time.");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response Variable  (y = pasture yield)");
		Memo2->Lines->Add("               1 Predictor Variable (x = growing time)");
		Memo2->Lines->Add("               9 Observations");
		Memo2->Lines->Add("               Higher Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Rational Class (cubic/cubic)");
		Memo2->Lines->Add("               3 Parameters (b[0] to b[2])");
		Memo2->Lines->Add("               Y = B[0] / (1.0 + Exp(B[1]-B[2]*X))");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 72.462237576");
		Memo2->Lines->Add("               b[1] = 2.6180768402");
		Memo2->Lines->Add("               b[2] = 0.067359200066");
	}
	else if (Index == 3)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("These data are the result of a NIST study regarding dental research in monomolecular"
				" adsorption. The response variable is volume, and the predictor variable is pressure");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response Variable  (y = volume)");
		Memo2->Lines->Add("               1 Predictor Variable (x = pressure)");
		Memo2->Lines->Add("               14 Observations");
		Memo2->Lines->Add("               Average Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Miscellaneous Class");
		Memo2->Lines->Add("               2 Parameters (b[0] and b[1])");
		Memo2->Lines->Add("               Y = B[0]*(1-Power(1+2*B[1]*X,-0.5))");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 636.42725809");
		Memo2->Lines->Add("               b[1] = 0.00020813627256");
	}
	else if (Index == 4)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("This problem was found to be difficult for some very good algorithms. There"
			" is a local minimum at (+inf,-14.07..., -inf, -inf) with final sum of squares 0.00102734....");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response Variable  (y)");
		Memo2->Lines->Add("               1 Predictor Variable (x)");
		Memo2->Lines->Add("               11 Observations");
		Memo2->Lines->Add("               Generated data");
		Memo2->Lines->Add("               Higher Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Rational Class (linear/quadratic)");
		Memo2->Lines->Add("               4 Parameters (b[0] to b[3])");
		Memo2->Lines->Add("               Y = B[0]*(Sqr(X) + X*B[1]) / (Sqr(X) + X*B[2]+B[3])");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 0.19280693458");
		Memo2->Lines->Add("               b[1] = 0.19128232873");
		Memo2->Lines->Add("               b[2] = 0.12305650693");
		Memo2->Lines->Add("               b[3] = 0.13606233068");
	}
	else if (Index == 5)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("These data are the result of a NIST study involving ultrasonic calibration."
			" The response variable is ultrasonic response, and the predictor variable is"
			" metal distance.");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response Variable  (y = ultrasonic response)");
		Memo2->Lines->Add("               1 Predictor Variable (x = metal distance)");
		Memo2->Lines->Add("               54 Observations");
		Memo2->Lines->Add("               Observed Data");
		Memo2->Lines->Add("               Lower Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Exponential Class");
		Memo2->Lines->Add("               3 Parameters (b[0] to b[2])");
		Memo2->Lines->Add("               Y = Exp(-B[0]*X)/(B[1]) + X*B[2])");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 0.16657666537");
		Memo2->Lines->Add("               b[1] = 0.0051653291286");
		Memo2->Lines->Add("               b[2] = 0.012150007096");
	}
	else if (Index == 6)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("This problem was found to be difficult for some very good algorithms.");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response Variable  (y)");
		Memo2->Lines->Add("               1 Predictor Variable (x)");
		Memo2->Lines->Add("               16 Observations");
		Memo2->Lines->Add("               Generated Data");
		Memo2->Lines->Add("               Higher Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Exponential Class");
		Memo2->Lines->Add("               3 Parameters (b[0] to b[2])");
		Memo2->Lines->Add("               Y = B[0]*Exp(B[1]/(B[2]+X))");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 0.0056096364710");
		Memo2->Lines->Add("               b[1] = 6181.3463463");
		Memo2->Lines->Add("               b[2] = 345.22363462");
	}
	else if (Index == 7)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("These data are the result of a NIST study involving "
				"quantum defects in iodine atoms.  The response"
				"variable is the number of quantum defects, and the"
				"predictor variable is the excited energy state. "
				"The argument to the ArcTan function is in radians.");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response  (y = quantum defect)");
		Memo2->Lines->Add("               1 Predictor (x = excited state energy)");
		Memo2->Lines->Add("               25 Observations");
		Memo2->Lines->Add("               Observed Data");
		Memo2->Lines->Add("               Average Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Miscellaneous Class");
		Memo2->Lines->Add("               4 Parameters (b[0] to b[3])");
		Memo2->Lines->Add("               Y =  B[0]-B[1]*X - ArcTan(B[2]/(X-B[3]))/PI");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 0.20196866396");
		Memo2->Lines->Add("               b[1] = -6.1953516256E-06");
		Memo2->Lines->Add("               b[2] = 1204.4556708");
		Memo2->Lines->Add("               b[3] = -181.34269537");
	}
	else if (Index == 8)
	{
		Memo2->Lines->Add("Description :");
		Memo2->Lines->Add("This model and data are an example of fitting "
				"sigmoidal growth curves taken from Ratkowsky (1983). "
				"The response variable is the dry weight of onion bulbs "
				"and tops, and the predictor variable is growing time.");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Data :");
		Memo2->Lines->Add("               1 Response  (y = onion bulb dry weight)");
		Memo2->Lines->Add("               1 Predictor (x = growing time)");
		Memo2->Lines->Add("               15 Observations");
		Memo2->Lines->Add("               Observed Data");
		Memo2->Lines->Add("               Higher Level of Difficulty");
		Memo2->Lines->Add("Model:");
		Memo2->Lines->Add("               Exponential Class");
		Memo2->Lines->Add("               4 Parameters (b[0] to b[3])");
		Memo2->Lines->Add("               Y =  B[0] / Power((1.0 + Exp(B[1]-B[2]*X)),1/B[3])");
		Memo2->Lines->Add("");
		Memo2->Lines->Add("Certified values :");
		Memo2->Lines->Add("               b[0] = 699.6415127");
		Memo2->Lines->Add("               b[1] = 5.2771253025");
		Memo2->Lines->Add("               b[2] = 0.75962938329");
		Memo2->Lines->Add("               b[3] = 1.2792483859");
	}
}
void __fastcall TfrmNonLinTest::Edit3Change(TObject *Sender)
{
	try
	{
		MtxNonLinReg->GradTolerance = StrToFloat(Edit3->Text);
		SpeedButton1->Enabled = true;
  }
	catch (...) {}
}
//---------------------------------------------------------------------------

void __fastcall TfrmNonLinTest::Edit1Change(TObject *Sender)
{
	try
	{
		MtxNonLinReg->MaxIteration = StrToInt(Edit1->Text);
		SpeedButton1->Enabled = true;
	}
	catch (...) {
		MtxNonLinReg->MaxIteration = 500;
	}
}
//---------------------------------------------------------------------------
void __fastcall TfrmNonLinTest::WriteToLog(DWord Elapsed)
{
	AnsiString tmpStr;
	switch (ComboBox2->ItemIndex)
	{
		case 0 : tmpStr = "Problem : Eckerle4";break;
		case 1 : tmpStr = "Problem : Thurber";break;
		case 2 : tmpStr = "Problem : Rat42";break;
		case 3 : tmpStr = "Problem : Misra1c";break;
		case 4 : tmpStr = "Problem : MGH09";break;
		case 5 : tmpStr = "Problem : Chiwrut2";break;
		case 6 : tmpStr = "Problem : MGH10";break;
		case 7 : tmpStr = "Problem : Roszman1";break;
		case 8 : tmpStr = "Problem : Rat43";break;
	}
	frmLogForm->Memo1->Lines->Add(tmpStr);
	tmpStr = "Method : ";
	switch (MtxNonLinReg->OptMethod)
	{
		case optSimplex : tmpStr = tmpStr + "Simplex  - ";break;
		case optMarquardt : tmpStr = tmpStr + "Marquardt - ";break;
		case optBFGS : tmpStr = tmpStr + "Quasi-Newton (BFGS) - ";break;
		case optDFP : tmpStr = tmpStr + "Quasi-Newton (DFP) - ";break;
		case optConjGradFR : tmpStr = tmpStr + "Conjugate Gradient (Fletcher) - ";break;
		case optConjGradPR : tmpStr = tmpStr + "Conjugate Gradient (Polak) - ";break;
	}
	tmpStr = tmpStr + IntToStr(MtxNonLinReg->Iterations)+" iterations";
	frmLogForm->Memo1->Lines->Add(tmpStr);
	frmLogForm->Memo1->Lines->Add("Elapsed time : "+FormatFloat("0.000",Elapsed*0.001)+" s");
	tmpStr = "Stop reason : ";
	switch (MtxNonLinReg->StopReason) {
		case OptResNotFound: tmpStr = tmpStr + "Failed to converge";break;
		case OptResMaxIter: tmpStr = tmpStr + "Iterations > Max. iterations";break;
		case OptResSmallGrad: tmpStr = tmpStr + "Too small gradient";break;
		case OptResSingular: tmpStr = tmpStr + "Singular Hessian matrix";break;
		case OptResBigLambda: tmpStr = tmpStr + "Marquardt : Big lambda";break;
		case OptResZeroStep: tmpStr = tmpStr + "Zero x step";break;
		case OptResSmallStep: tmpStr = tmpStr + "Too small x step";break;
		case OptResConverged: tmpStr = tmpStr + "Converged within given tolerance";break;
	}
	frmLogForm->Memo1->Lines->Add(tmpStr);
	frmLogForm->Memo1->Lines->Add("Calculated values:");
	for (int i = 0;i<MtxNonLinReg->B->Length;i++)
		frmLogForm->Memo1->Lines->Add("               b["+IntToStr(i)+"] = "+FormatFloat("0.0000000000",(*MtxNonLinReg->B)[i]));
	frmLogForm->Memo1->Lines->Add("+++++++++++++++++++++++++++");
}
void __fastcall TfrmNonLinTest::FormDestroy(TObject *Sender)
{
	delete MtxNonLinReg;
	delete frmLogForm;
}
//---------------------------------------------------------------------------

void __fastcall TfrmNonLinTest::CheckBox1Click(TObject *Sender)
{
  if (CheckBox1->Checked) frmLogForm->Show();
	else frmLogForm->Hide();
}
//---------------------------------------------------------------------------

void __fastcall TfrmNonLinTest::Edit4Change(TObject *Sender)
{
	try
	{
		MtxNonLinReg->Tolerance= StrToFloat(Edit4->Text);
		SpeedButton1->Enabled = true;
	}
	catch (...) {}
}
//---------------------------------------------------------------------------

void __fastcall TfrmNonLinTest::Edit2Change(TObject *Sender)
{
	try
	{
		GradStepSize = StrToFloat(Edit2->Text);
		SpeedButton1->Enabled = true;
	}
	catch (...) {}
}
//---------------------------------------------------------------------------
void __fastcall TfrmNonLinTest::ResetEstimates(int Index)
{
	if (Index == 0 ) // Eckerle4
	{
		double B[] = {1.0, 10.0, 500.0};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 1 ) //Thurber
	{
		double B[] = {1000, 1000, 400, 40, 0.7, 0.3, 0.03};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 2 ) // Rat42
	{
		double B[] = {100.0, 1.0, 0.1};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 3 ) // Misra1c
	{
		double B[] = {500.0, 0.0001};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 4 ) // MGH09
	{
		double B[] = {25.0, 39.0, 41.5, 39};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 5 ) // Chiwrut2
	{
		double B[] = {0.1, 0.01, 0.02};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 6 ) // MGH10
	{
		double B[] = {2, 400000, 25000};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 7 ) // Roszman1
	{
		double B[] = {0.1, -0.00001, 1000, -100};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
	else if (Index == 8 ) // Rat43
	{
		double B[] = {100,10,1,1};
		MtxNonLinReg->B->SetIt(false,B,sizeof(B)/sizeof(double)-1); // initial estimates
	}
}
