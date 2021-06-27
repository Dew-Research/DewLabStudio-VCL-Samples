//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "Multiply1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic2"
#pragma resource "*.dfm"
TMult1 *Mult1;
//---------------------------------------------------------------------------
__fastcall TMult1::TMult1(TComponent* Owner)
  : TBasicForm2(Owner)
{
	  AnsiString str;
	  RichEdit1->Lines->Clear();
	  str  = "Matrix multiplication performance gives you ";
	  str += "an impression of the performance of MtxVec. You ";
	  str += "will be able to experience these performance ";
	  str += "gains with all MtxVec packages, when dealing ";
	  str += "with vectors or matrices. If you have a multi-CPU ";
	  str += "multi-core processing is automatically enabled ";

	  RichEdit1->Lines->Add(str);

	  TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
void __fastcall TMult1::MulBCB(const int ADim)
{
		int i,j,k;
		double ac;

		if (C.IsDouble) {

			for (int i = 0; i < ADim; i++)
			  for (int k = 0; k < ADim; k++)
			  {
				  ac = A.Values(i,k);
				  for (int j = 0; j < ADim; j++)
						C.Values(i,j) = C.Values(i,j) + ac*B.Values(k,j);
			  }
		}
		else
		{
			for (int i = 0; i < ADim; i++)
			  for (int k = 0; k < ADim; k++)
			  {
				  ac = A.SValues(i,k);
				  for (int j = 0; j < ADim; j++)
						C.SValues(i,j) = C.SValues(i,j) + ac*B.SValues(k,j);
			  }
        }
}
//---------------------------------------------------------------------------
void __fastcall TMult1::GenerateData(const int ADim)
{
        // resize matrices
		A.Size(ADim,ADim);
		B.Size(A);
		C.Size(A);
        // fill sample data }
		A.RandGauss(3.0,2.0);
		B.RandGauss(-1,0.2);
		C.SetZero();
}
//---------------------------------------------------------------------------


void __fastcall TMult1::TrackBar1Change(TObject *Sender)
{
  MtxDim = TrackBar1->Position;
  StaticText1->Caption = IntToStr(MtxDim);
}
//---------------------------------------------------------------------------

void __fastcall TMult1::Button4Click(TObject *Sender)
{
		int ADim,i;
		int Factor = 1;
		GenerateData(MtxDim);
		i = 2;
		Screen->Cursor = crHourGlass;
		Series1->Clear();
		Series2->Clear();
		Controller->ThreadWaitBeforeSleep = 1; //boost performance
		do
		{
				ADim = i;
				GenerateData(ADim);
				StartTimer();
				if (MtxDim <= 30)
				{
						for (int j = 0; j< (99*4*Factor);j++) MulBCB(ADim);
				}
				else if (MtxDim <= 60)
				{
						for (int j = 0; j<(9*Factor);j++) MulBCB(ADim);
				}
				else MulBCB(ADim);

				Series1->AddXY(i,StopTimer()*1000.0,"",clTeeColor);

				StartTimer();
				if (MtxDim <= 30)
				{
						for (int j = 0; j<(99*Factor*4);j++) C.Mul(A,B);
				}
				else if (MtxDim <= 60)
				{
					for (int j = 0; j<(9*Factor);j++) C.Mul(A,B);
				}
				else C.Mul(A,B);

				Series2->AddXY(i,StopTimer()*1000.0,"",clTeeColor);

				if (i<50)
				{
					i = i+2;
				}
				else
				{
					i = i+25;
				}

		} while (i <= MtxDim);

		Controller->ThreadWaitBeforeSleep = 0; //disable multithreading boost
		Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TMult1::RadioGroup1Click(TObject *Sender)
{
  switch (dynamic_cast<TRadioGroup*>(Sender)->ItemIndex)
  {
	case 0 : { TrackBar1->Position = 25; break;}
    case 1 : { TrackBar1->Position = 60; break;}
    case 2 : { TrackBar1->Position = 400; break;}
  }
  TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------

