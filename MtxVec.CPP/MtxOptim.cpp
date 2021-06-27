//---------------------------------------------------------------------------

#include <vcl.h>

#pragma hdrstop

#include "MtxOptim.h"
#include "MtxVecEdit.hpp"
#include "Optimization.hpp"
#include "Math387.hpp"
#include "MtxVec.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma link "MtxBaseComp"
#pragma link "MtxVecTools"
#pragma resource "*.dfm"
TfrmMtxOptim *frmMtxOptim;

#pragma warn -8057

//---------------------------------------------------------------------------
/* Definition for "banana" function
  This function is used to evaluate "banana" function in all optimization methods */
double __fastcall Banana(
	 #if  (__BORLANDC__ >= 0x0650)
	 TVec* const Parameters,
	 #else
	 const TVec* Parameters,
	 #endif

	 #if  (__BORLANDC__ >= 0x0650)
	 TVec* const Constants,
	 #else
	 const TVec* Constants,
	 #endif

	 #if  (__BORLANDC__ >= 0x0580)
	 System::TObject* const * ObjConst,
	 #else
	 const System::TObject* * ObjConst,
	 #endif

	 const int ObjConst_Size)
{
	 Mtxvec::TVec* aPars = const_cast<Mtxvec::TVec*> (Parameters);

	 double tmp = 100.0*IntPower((*aPars)[1]-IntPower((*aPars)[0],2),2)+IntPower(1.0-(*aPars)[0],2);
	 return tmp;
}
//---------------------------------------------------------------------------
/* the exact calculation of gradient  for "banana" function
  this procedure is used by BFGS method to evaluate grad */
void __fastcall GradBanana(TRealFunction Fun,
	 #if  (__BORLANDC__ >= 0x0650)
	 TVec* const Pars,
	 #else
	 const TVec* Pars,
	 #endif

	 #if  (__BORLANDC__ >= 0x0650)
	 TVec* const Consts,
	 #else
	 const TVec* Consts,
	 #endif

	 #if  (__BORLANDC__ >= 0x0580)
	 System::TObject* const * ObjConst,
	 #else
	 const System::TObject* * PConsts,
	 #endif

	 const int PConsts_Size,

	 #if  (__BORLANDC__ >= 0x0650)
	 Mtxvec::TVec* const Grad
	 #else
	 const Mtxvec::TVec* Grad
	 #endif
	 )
{
  Mtxvec::TVec* aGrad = const_cast<Mtxvec::TVec*> (Grad);
  Mtxvec::TVec* aPars = const_cast<Mtxvec::TVec*> (Pars);

  //DefaultArray would work both single and double precision storage
  if (aGrad->IsDouble) {

	  aGrad->Values[0] = -400*((*aPars)[1]-IntPower((*aPars)[0],2))*(*aPars)[0] - 2*(1-(*aPars)[0]);
	  aGrad->Values[1] = 200*((*aPars)[1]-IntPower((*aPars)[0],2));

  } else {

	  aGrad->SValues[0] = -400*((*aPars)[1]-IntPower((*aPars)[0],2))*(*aPars)[0] - 2*(1-(*aPars)[0]);
	  aGrad->SValues[1] = 200*((*aPars)[1]-IntPower((*aPars)[0],2));
  }

}
/* the exact calculation of gradient and Hessian matrix for "banana" function
  this procedure is used by Marquardt method to evaluate grad and Hessian matrix */
void __fastcall GradHessBanana(TRealFunction Fun,

	 #if  (__BORLANDC__ >= 0x0650)
	 TVec* const Pars,
	 #else
	 const TVec* Pars,
	 #endif

	 #if  (__BORLANDC__ >= 0x0650)
	 TVec* const Consts,
	 #else
	 const TVec* Consts,
	 #endif

	 #if  (__BORLANDC__ >= 0x0580)
	 System::TObject* const * ObjConst,
	 #else
	 const System::TObject* * PConsts,
	 #endif
	 const int ObjConst_Size,

	 #if  (__BORLANDC__ >= 0x0650)
	 Mtxvec::TVec* const Grad, Mtxvec::TMtx* const Hess)
	 #else
	 const Mtxvec::TVec* Grad, const Mtxvec::TMtx* Hess)
	 #endif
{

	if (Pars->IsDouble) {

		 double *aPars = Pars->PValues1D(0);
		 double *aGrad = Grad->PValues1D(0);
		 double *aHess = Hess->PValues1D(0);

		 aGrad[0] = -400*(aPars[1] - IntPower(aPars[0], 2))*aPars[0] - 2*(1 - aPars[0]);
		 aGrad[1] = 200*(aPars[1] - IntPower(aPars[0], 2));

		 aHess[0] = -400*aPars[1] + 1200*IntPower(aPars[0], 2) + 2;
		 aHess[1] = -400*aPars[0];
		 aHess[2] = -400*aPars[0];
		 aHess[3] =  200;
	}
	else
	{
		 float *aPars = Pars->PSValues1D(0);
		 float *aGrad = Grad->PSValues1D(0);
		 float *aHess = Hess->PSValues1D(0);

		 aGrad[0] = -400*(aPars[1] - IntPower(aPars[0], 2))*aPars[0] - 2*(1 - aPars[0]);
		 aGrad[1] = 200*(aPars[1] - IntPower(aPars[0], 2));

		 aHess[0] = -400*aPars[1] + 1200*IntPower(aPars[0], 2) + 2;
		 aHess[1] = -400*aPars[0];
		 aHess[2] = -400*aPars[0];
		 aHess[3] =  200;
	}

// 2.) alternative for matrix using 2D array, DefaultArray can accept both single and double precision

//  Mtxvec::TVec* aGrad = const_cast<Mtxvec::TVec*> (Grad);
//  Mtxvec::TVec* aPars = const_cast<Mtxvec::TVec*> (Pars);
//  Mtxvec::TVec* aHess = const_cast<Mtxvec::TVec*> (Hess);

//	 aGrad->DefaultArray[0] = -400*(aPars[1] - IntPower(aPars[0], 2))*aPars[0] - 2*(1 - aPars[0]);
//	 aGrad->DefaultArray[1] = 200*(aPars[1] - IntPower(aPars[0], 2));

//	 aHess->DefaultArray2D[0][0] = -400*(*aPars)[1]+1200*IntPower((*aPars)[0],2)+2;
//	 aHess->DefaultArray2D[0][1] = -400*(*aPars)[0];
//	 aHess->DefaultArray2D[1][0] = -400*(*aPars)[0];
//	 aHess->DefaultArray2D[1][1] =  200;

// 3.) Another version

//	 if (aGrad->IsDouble) {
//
//		 aGrad->Values[0] = -400*((*aPars)[1]-IntPower((*aPars)[0],2))*(*aPars)[0] - 2*(1-(*aPars)[0]);
//		 aGrad->Values[1] = 200*((*aPars)[1]-IntPower((*aPars)[0],2));
//
//		 aHess->Values1D[0] = -400*(*aPars)[1]+1200*IntPower((*aPars)[0],2)+2;
//		 aHess->Values1D[1] = -400*(*aPars)[0];
//		 aHess->Values1D[2] = -400*(*aPars)[0];
//		 aHess->Values1D[3] =  200;
//
//	 } else {
//
//		 aGrad->SValues[0] = -400*((*aPars)[1]-IntPower((*aPars)[0],2))*(*aPars)[0] - 2*(1-(*aPars)[0]);
//		 aGrad->SValues[1] = 200*((*aPars)[1]-IntPower((*aPars)[0],2));
//
//		 aHess->SValues1D[0] = -400*(*aPars)[1]+1200*IntPower((*aPars)[0],2)+2;
//		 aHess->SValues1D[1] = -400*(*aPars)[0];
//		 aHess->SValues1D[2] = -400*(*aPars)[0];
//		 aHess->SValues1D[3] =  200;
//	 }
}
//---------------------------------------------------------------------------
__fastcall TfrmMtxOptim::TfrmMtxOptim(TComponent* Owner)
  : TBasicForm2(Owner)
{
  AnsiString str;

  RichEdit1->Lines->Clear();
  str  = "Optimization unit offers you several algorithms for ";
  str += "finding unconstrained minimum of a function of several variables. ";
  str += "TMtxOptimization component offers the same functionality as Optimization ";
  str += "routines but simplifies the user interface. ";
  str += "In this example the algorithms are tested against the ";
  str += "\"banana\" function:";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsItalic;
  RichEdit1->Lines->Add("f(a,b) = 100*Sqr(b-Sqr(a)) + Sqr(1-a)");
  RichEdit1->Lines->Add("");
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsUnderline;
  RichEdit1->Lines->Add("Parameters in this demo:");
  RichEdit1->Lines->Add("Method:\t optimization method used");
  RichEdit1->Lines->Add("Log:\t write every optimization step to log");
  RichEdit1->Lines->Add("Numerical derivative\t use numerical approximation of grad and Hess");
  RichEdit1->Lines->Add("Max. number of iter.:\t maximum number of iterations");
  RichEdit1->Lines->Add("GradTolerance:\t minimum gradient C-Norm");
  RichEdit1->Lines->Add("Initial lambda:\t initial lambda used in Marquardt method");
  RichEdit1->Lines->Add("a,b:\t initial values for \"banana\" function parameters");
  RichEdit1->Lines->Add("");
  str = "The Quasi-Newton (BFGS, DFP), Marquardt and Conjugate Gradient ";
  str += "(Fletcher and Polak algorithm) require exact or numerical ";
  str += "gradient/Hessian matrix. On the other hand, Simplex ";
  str += "algorithm does not require gradient nor Hessian matrix.";
  RichEdit1->Lines->Add(str);
  // assign function
  MtxOptimization1->RealFunction = Banana;
  // define two variable parameters
  MtxOptimization1->VariableParameters->Length = 2;
  TrackBar2->Max = 16; // tolerance
  TrackBar6->Max = 16; // GradEPS
  TrackBar7->Max = 16; // GradStepSize
  TrackBar5->Max = 9; // Lambda
  TrackBar2->Position = 6;
  TrackBar5->Position = 5;
  TrackBar6->Position = 10;
  TrackBar7->Position = 4;

  TrackBar1Change(TrackBar1);
  TrackBar2Change(TrackBar2);
  TrackBar3Change(TrackBar3);
  TrackBar4Change(TrackBar4);
  CheckBox1Click(CheckBox1);
  CheckBox2Click(CheckBox2);
  TrackBar5Change(TrackBar5);
  TrackBar6Change(TrackBar6);
  TrackBar7Change(TrackBar7);
}
//---------------------------------------------------------------------------
void __fastcall TfrmMtxOptim::CheckBox1Click(TObject *Sender)
{
  if (CheckBox1->Checked) MtxOptimization1->Verbose = Memo2->Lines;
  else MtxOptimization1->Verbose = NULL;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::CheckBox2Click(TObject *Sender)
{
  // if numerical derivative, do the "soft" line search
  MtxOptimization1->SoftSearch = CheckBox2->Checked;
  if (CheckBox2->Checked)
  {
    // numerical approximation
    MtxOptimization1->GradProcedure = 0;
    MtxOptimization1->GradHessProcedure = 0;
  }
  else
  {
    // exact grad and grad hess
	MtxOptimization1->GradProcedure = GradBanana;
	MtxOptimization1->GradHessProcedure = GradHessBanana;
  }
}
//---------------------------------------------------------------------------


void __fastcall TfrmMtxOptim::RadioGroup1Click(TObject *Sender)
{
  MtxOptimization1->OptimizationMethod = TOptMethod(RadioGroup1->ItemIndex);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::TrackBar1Change(TObject *Sender)
{
  MtxOptimization1->MaxIterations = TrackBar1->Position;
  Label2->Caption =IntToStr(MtxOptimization1->MaxIterations);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::TrackBar2Change(TObject *Sender)
{
  MtxOptimization1->Tolerance = IntPower(10, -TrackBar2->Position);
  Label4->Caption = FloatToStrF(MtxOptimization1->Tolerance,ffExponent,2,2);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::TrackBar6Change(TObject *Sender)
{
  MtxOptimization1->GradTolerance = IntPower(10, -TrackBar6->Position);
  Label13->Caption = FloatToStrF(MtxOptimization1->GradTolerance,ffExponent,2,2);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::TrackBar5Change(TObject *Sender)
{
  // define initial Lambda for Marquardt method
  MtxOptimization1->Lambda0 = IntPower(10, -TrackBar5->Position);
  Label11->Caption = FloatToStrF(MtxOptimization1->Lambda0,ffExponent,2,2);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::TrackBar3Change(TObject *Sender)
{
  // change the intial value of parameter a
  if (MtxOptimization1->VariableParameters->IsDouble)
  {
	  MtxOptimization1->VariableParameters->Values[0] = TrackBar3->Position*0.02;
	  Label7->Caption = FormatFloat("0.00",MtxOptimization1->VariableParameters->Values[0]);
  }
  else
  {
	  MtxOptimization1->VariableParameters->SValues[0] = TrackBar3->Position*0.02;
	  Label7->Caption = FormatFloat("0.00",MtxOptimization1->VariableParameters->SValues[0]);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::TrackBar4Change(TObject *Sender)
{
  if (MtxOptimization1->VariableParameters->IsDouble)
  {
	  MtxOptimization1->VariableParameters->Values[1] = TrackBar4->Position*0.02;
	  Label8->Caption = FormatFloat("0.00",MtxOptimization1->VariableParameters->Values[1]);

  } else {

	  MtxOptimization1->VariableParameters->SValues[1] = TrackBar4->Position*0.02;
	  Label8->Caption = FormatFloat("0.00",MtxOptimization1->VariableParameters->SValues[1]);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::Button2Click(TObject *Sender)
{
  // show inverse Hessian matrix
  ViewValues(MtxOptimization1->InverseHess,"Inverse Hessian",true,false);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::TrackBar7Change(TObject *Sender)
{
  Math387::GradStepSize = IntPower(10, -TrackBar7->Position);
  Label15->Caption = FloatToStrF(Math387::GradStepSize,ffExponent,2,2);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMtxOptim::Button1Click(TObject *Sender)
{
  TrackBar3Change(TrackBar3);
  TrackBar4Change(TrackBar4);
  Memo2->Lines->Clear();
  MtxOptimization1->Recalculate();      
  Memo2->Lines->Add("----------------------------");
  if (MtxOptimization1->VariableParameters->IsDouble) {

	  Memo2->Lines->Add("a = "+FloatToStrF(MtxOptimization1->VariableParameters->Values[0],ffFixed,1,TrackBar2->Position));
	  Memo2->Lines->Add("b = "+FloatToStrF(MtxOptimization1->VariableParameters->Values[1],ffFixed,1,TrackBar2->Position));
  } else {

	  Memo2->Lines->Add("a = "+FloatToStrF(MtxOptimization1->VariableParameters->SValues[0],ffFixed,1,TrackBar2->Position));
	  Memo2->Lines->Add("b = "+FloatToStrF(MtxOptimization1->VariableParameters->SValues[1],ffFixed,1,TrackBar2->Position));
  }

  Memo2->Lines->Add("F(min) = "+FloatToStrF(MtxOptimization1->MinValue,ffFixed,1,TrackBar2->Position));
  AnsiString tmpStr = "Stop Reason = ";
  switch (MtxOptimization1->StopReason)
  {
    case OptResConverged : tmpStr += "Converged"; break;
    case OptResMaxIter : tmpStr += "Iterations > Max. Iterations"; break;
    case OptResSmallStep : tmpStr += "X step < Tolerance"; break;
    case OptResZeroStep : tmpStr += "Zero x step"; break;
    case OptResSmallGrad : tmpStr += "C Norm(Grad) < gradient tolerance"; break;
    case OptResBigLambda : tmpStr += "Big Lambda"; break;
  }
  Memo2->Lines->Add(tmpStr);
}
//---------------------------------------------------------------------------

