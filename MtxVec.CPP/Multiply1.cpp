//---------------------------------------------------------------------------
// Direct port of C:\CommonObjects\Dew MtxVec.NET\Examples\Multiply1.pas
// to C++ Builder. Naive C++ scalar loop on raw double[][] (Series1: "C++")
// vs MtxVec C.Mul(A,B) (Series2: "MtxVec").

#include <vcl.h>
#pragma hdrstop
#include "Multiply1.h"
#include <stdlib.h>
#include <time.h>
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
	str += "machine multi-threading is automatically enabled.  ";
	RichEdit1->Lines->Add(str);

	DA = NULL;
	DB = NULL;
	DC = NULL;
	DAllocated = 0;
	Factor = 1;

	TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------
__fastcall TMult1::~TMult1()
{
	FreeRawArrays();
}
//---------------------------------------------------------------------------
void __fastcall TMult1::FreeRawArrays()
{
	if (DA != NULL) {
		for (int i = 0; i < DAllocated; i++) {
			delete[] DA[i];
			delete[] DB[i];
			delete[] DC[i];
		}
		delete[] DA;
		delete[] DB;
		delete[] DC;
		DA = NULL;
		DB = NULL;
		DC = NULL;
		DAllocated = 0;
	}
}
//---------------------------------------------------------------------------
// Port of Delphi TMult1.MulDelphi: scalar triple-loop on raw double[][].
void __fastcall TMult1::MulBCB(const int ADim)
{
	for (int i = 0; i < ADim; i++)
		for (int k = 0; k < ADim; k++) {
			double ac = DA[i][k];
			for (int j = 0; j < ADim; j++)
				DC[i][j] = DC[i][j] + ac * DB[k][j];
		}
}
//---------------------------------------------------------------------------
// Port of Delphi TMult1.GenerateData.
void __fastcall TMult1::GenerateData(const int ADim)
{
	// resize MtxVec matrices
	A.Size(ADim, ADim);
	B.Size(A);

	// resize raw 2D arrays (Delphi: SetLength)
	FreeRawArrays();
	DA = new double*[ADim];
	DB = new double*[ADim];
	DC = new double*[ADim];
	for (int i = 0; i < ADim; i++) {
		DA[i] = new double[ADim];
		DB[i] = new double[ADim];
		DC[i] = new double[ADim];
	}
	DAllocated = ADim;

	// fill sample data (Delphi: Randomize + random(10))
	srand((unsigned)time(NULL));
	for (int i = 0; i < ADim; i++)
		for (int j = 0; j < ADim; j++) {
			DA[i][j] = (double)(rand() % 10);
			DB[i][j] = (double)(rand() % 10);
			DC[i][j] = 0.0;
			A.Values(i, j) = DA[i][j];
			B.Values(i, j) = DB[i][j];
		}
}
//---------------------------------------------------------------------------
void __fastcall TMult1::TrackBar1Change(TObject *Sender)
{
	MtxDim = ((TTrackBar*)Sender)->Position;
	StaticText1->Caption = IntToStr(MtxDim);
}
//---------------------------------------------------------------------------
void __fastcall TMult1::Button4Click(TObject *Sender)
{
	Controller->ThreadWaitBeforeSleep = 1;   // Enable
	GenerateData(MtxDim);
	int i = 2;
	Screen->Cursor = crHourGlass;
	Series1->Clear();
	Series2->Clear();
	int ADim, j;
	do {
		ADim = i;
		GenerateData(ADim);
		StartTimer();
		if (MtxDim <= 30)
			for (j = 0; j < 99 * Factor * 4; j++) MulBCB(ADim);
		else if (MtxDim <= 60)
			for (j = 0; j < 9 * Factor; j++) MulBCB(ADim);
		else
			MulBCB(ADim);
		Series1->AddXY(i, StopTimer() * 1000, "", clTeeColor);

		StartTimer();
		if (MtxDim <= 30)
			for (j = 0; j < Factor * 99 * 4; j++) C.Mul(A, B);
		else if (MtxDim <= 60)
			for (j = 0; j < Factor * 9; j++) C.Mul(A, B);
		else
			C.Mul(A, B);
		Series2->AddXY(i, StopTimer() * 1000, "", clTeeColor);

		if (i < 50) i = i + 2;
		else i = i + 25;
	} while (i < MtxDim);    // Pascal: until i >= MtxDim
	Screen->Cursor = crDefault;
	Controller->ThreadWaitBeforeSleep = 0;   // Disable
}
//---------------------------------------------------------------------------
void __fastcall TMult1::RadioGroup1Click(TObject *Sender)
{
	switch (((TRadioGroup*)Sender)->ItemIndex) {
		case 0: TrackBar1->Position = 25;  break;
		case 1: TrackBar1->Position = 60;  break;
		case 2: TrackBar1->Position = 400; break;
	}
	TrackBar1Change(TrackBar1);
}
//---------------------------------------------------------------------------
