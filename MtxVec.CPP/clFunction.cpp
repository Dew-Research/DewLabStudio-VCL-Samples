//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "clFunction.h"
#include "clMtxVec.hpp"
#include "clMtxExpr.hpp"
#include "StringVar.hpp"
#include "SysUtils.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TclFunctionForm *clFunctionForm;
//---------------------------------------------------------------------------
__fastcall TclFunctionForm::TclFunctionForm(TComponent* Owner)
  : TForm(Owner)
{
	RichEdit1->Lines->Clear();
}
//---------------------------------------------------------------------------

void __fastcall TclFunctionForm::FormCreate(TObject *Sender)
{
	int i;

	AnsiString str;
	RichEdit1->Lines->Clear();
	str = "The platform list shows the Open CL drivers";
	str += "available on your computer. If you dont have a AMD or Nvidia GPU ";
	str += "you can still install Intel or Open CL drivers which ";
	str += "run on the CPU alone.  ";
	RichEdit1->Lines->Add(str);
	str = "Intel drivers require at least SSE4.x (Core 2) capable hardware. ";
	str += "Presence of Intel drivers also slows down the start of the ";
	str += "application by minutes-> That is why clPlatform.IgnoreIntel is set to true by default. ";
	str += "Select various functions and see how they perform in compare to ";
	str += "intel IPP (MtxVec) and native Delphi code. Dont forget however ";
	str += "that data also needs to be copied to GPU and back and this is ";
	str += "fairly slow.";
	RichEdit1->Lines->Add(str);
	str = "If the same graphics card is used also for display next to its OpenCL purpose ";
	str += "the performance degradation of Open CL code can be substantial. This depends largely also ";
	str += "on the amount of total memory allocated on the GPU by the Open CL library. ";
    RichEdit1->Lines->Add(str);

	FloatPrecisionBox->ItemIndex = 0;
	CPUFloatPrecisionLabel->Caption = "CPU (MtxVec) float precision: " + IntToStr((int) sizeof(TSample)*8) + "bit";
//    ReportMemoryLeaksOnShutDown = True;

	for (i = 0; i < clPlatform()->Count; i++)
	{
		 PlatformListBox->Items->Add(clPlatform()->Platforms[i]->Name);
	}

	PlatformListBox->ItemIndex = 0;

	for (i = 0; i < clPlatform()->Platforms[0]->Count; i++)
	{
		 DeviceListBox->Items->Add(clPlatform()->Platforms[0]->Device[i]->Name);
	}

	DeviceListBox->ItemIndex = 0;

	str = "When loading the first time, the Open CL drivers need to recompile the source code.";
	str+= "This may take a minute or longer-> If you have Intel Open CL drivers installed they ";
	str+= "add 20s delay regardless, if the program is precompiled.";
	ShowMessage(str);

	Screen->Cursor = crHourGlass;
//    clPlatform->SaveDefaultToRC('C:\CommonObjects\Dew MtxVec->NET\');

//    clPlatform->ClearPrecompiledBinaries;
//	clPlatform()->IgnoreIntel = True;
	clPlatform()->LoadProgramsForDevices( false, false, true, true, false);
	Screen->Cursor = crDefault;
	FunctionBox->ItemIndex = 0;

	VectorLen = Round(Exp2(19));
	VectorLengthBox->Text = IntToStr(VectorLen);
}
//---------------------------------------------------------------------------
void __fastcall TclFunctionForm::DoCompute()
{
	sVector B,C, R;
	int i, k, ItemIndex, IterCount;
	double aTime, bTime;
	double ScalarB;
	clVector clB, clC;
	double a;
	float sa;
	TCplx ac;
	TSCplx sac;

	float * pcs;
	float * pbs;
	double * pc;
	double * pb;

	TMtxFloatPrecision  FloatPrecision;

	IterCount = 1;
	ItemIndex = FunctionBox->ItemIndex;
	switch (FunctionBox->ItemIndex) {
	case 0: IterCount = 4096;
			break;
	case 1: IterCount = 256;
			break;
	case 2: IterCount = 128;
			break;
	case 3: IterCount = 128;
			break;
	}

	clC.FloatPrecision = TclFloatPrecision(FloatPrecisionBox->ItemIndex);
	clB.FloatPrecision = TclFloatPrecision(FloatPrecisionBox->ItemIndex);


	FloatPrecision = mvSingle;
	switch (clC.FloatPrecision)  {
	case clFloat:  if (ComplexBox->Checked) { FloatPrecision = mvSingleComplex; } else { FloatPrecision = mvSingle; }
				   break;
	case clDouble: if (ComplexBox->Checked) { FloatPrecision = mvDoubleComplex; } else { FloatPrecision = mvDouble; }
				   break;
	}

	Screen->Cursor = crHourGlass;
	try
	{
		a = 1;
		ScalarB = 1.02;
		Memo->Lines->Clear();

		Memo->Lines->Add("Vector length = " + IntToStr(VectorLen));
		switch (FloatPrecision) {
		case mvSingle:
		case mvSingleComplex: Memo->Lines->Add("Float size = " + IntToStr((int) sizeof(float)) + " bytes");
					 break;

		case mvDouble:
		case mvDoubleComplex: Memo->Lines->Add("Float size = " + IntToStr((int) sizeof(double)) + " bytes");
                     break;
		}

		B.Size(VectorLen, FloatPrecision);
		B.SetVal(ScalarB);
		C.Size(VectorLen, FloatPrecision);
		C.SetVal(1);

//		{ warm up the cache }
		B.Copy(C);
		C.Copy(B);

		StartTimer();
		B.Copy(C);
		C.Copy(B);
		aTime = StopTimer();
		Memo->Lines->Add("Copy CPU->CPU (2x) = " + FormatSample("0.00us",aTime*1000*1000));

		B.SetVal(ScalarB);
		C.SetVal(1);

		StartTimer();
		clC.Copy(C);
		clB.Copy(B);
		aTime = StopTimer();
		Memo->Lines->Add("Copy CPU->GPU (2x) = " + FormatSample("0.00us",aTime*1000*1000));

		ItemIndex = FunctionBox->ItemIndex;

		StartTimer();

		for (i = 0; i < IterCount; i++)
		{
			 switch (ItemIndex) {
			 case 0: clC = clC * clB;
					 break;
			 case 1: clC = Sin(clC)  + Sin(clB);
					 break;
			 case 2: clC = sqrt(4 * a /(2*PI)) * a * Sqr(clB) * Exp(-0.5 * a * Sqr(clB));
					 break;
			 case 3: if (!clB.Complex) {ScalarB = clB.Mean();} else {ScalarB = clB.Meanc().Re;};
					 break;
			 }
		}
		clC.CopyTo(R); //{ from GPU to CPU }

		aTime = StopTimer();
		Memo->Lines->Add("");
		Memo->Lines->Add("Open CL timings:");
		Memo->Lines->Add("");
		Memo->Lines->Add("Function kernel (1x)  = " + FormatSample("0.00us",aTime*1000*1000/IterCount) + ", TotalTime = " + FormatSample("0.000s", aTime));

		B.SetVal(ScalarB);
		C.SetVal(1);

		StartTimer();
		for (i = 0; i < IterCount; i++)
		{
			 switch (ItemIndex) {
			 case 0: C *= B;
					 break;
			 case 1: C = Sin(C) + Sin(B);
					 break;
			 case 2: C = sqrt(4 * a /(2*PI)) * a * Sqr(B) * Exp(-0.5 * a * Sqr(B));
					 break;
			 case 3: if (!B.Complex) {a = B.Mean();} else {a = B.Meanc().Re;};
					 break;
			 }
		}
		bTime = StopTimer();

		Memo->Lines->Add("");
		Memo->Lines->Add("Intel IPP timings:");
		Memo->Lines->Add("");
		Memo->Lines->Add("IPP (1x) = " + FormatSample("0.00us",bTime*1000*1000/IterCount) + ", TotalTime = " + FormatSample("0.000s", bTime));
		Memo->Lines->Add("Ratio OpenCL/IPP = " + FormatSample("0.00x",bTime/aTime));
		Memo->Lines->Add("Ratio OpenCL/(Threaded IPP) = " + FormatSample("0.00x",bTime/(aTime*Controller->CpuCores*0.9)));
		Memo->Lines->Add("Time/element = " + FormatSample("0.000ns",bTime*(1000000.0/IterCount)*(1000.0/VectorLen)));

		switch (FunctionBox->ItemIndex) {
		case 0:
		case 1:
		case 2: if (!R.IsEqual(C, 0.01, cmpRelative)) ERaise("CPU and GPU results not equal!");
				break;
		}


		B.SetVal(ScalarB);
		C.SetVal(1);

		StartTimer();
		for (i = 0; i < (IterCount/4); i++)  //run C++ code timings
		{
			 a = 0;
			 ac = Cplx(0);
			 int cLen = C.Length;

			 switch (C.FloatPrecision) {
			 case mvSingle: {

				 pcs = C.PSValues1D(0);
				 pbs = B.PSValues1D(0);

				 switch (ItemIndex) {
				 case 0: for (k = 0; k < cLen; k++) pcs[k] = pcs[k] * pbs[k]; //C[k] = C[k] * B[k];
						 break;
				 case 1: for (k = 0; k < cLen; k++) pcs[k] = sin(pcs[k]) + sin(pbs[k]);
						 break;
				 case 2: for (k = 0; k < cLen; k++) pcs[k] = sqrt(4 * a /(2*PI)) * a * Sqr(pbs[k]) * exp(-0.5 * a * Sqr(pbs[k]));
						 break;
				 case 3: for (k = 0; k < cLen; k++) a = a  + pcs[k];
						 break;
				 }
				 }
				 break;
			 case mvSingleComplex: {
				 switch (ItemIndex) {
				 case 0: for (k = 0; k < cLen; k++) C.SCValues(k) = C.SCValues(k) * C.SCValues(k);
						 break;
				 case 1: for (k = 0; k < cLen; k++) C.SCValues(k) = Sin(C.SCValues(k)) + Sin(B.SCValues(k));
						 break;
				 case 2: for (k = 0; k < cLen; k++) C.SCValues(k) = sqrt(4 * sa /(2*PI)) * sa * CSqr(B.SCValues(k)) * Exp(-0.5 * sa * CSqr(B.SCValues(k)));
						 break;
				 case 3: for (k = 0; k < cLen; k++) sac = sac + C.SCValues(k);
						 break;
				 }
				 }
				 break;
			 case mvDoubleComplex:  {
				 switch (ItemIndex) {
				 case 0: for (k = 0; k < cLen; k++) C.CValues(k) = C.CValues(k) * C.CValues(k);
						 break;
				 case 1: for (k = 0; k < cLen; k++) C.CValues(k) = Sin(C.CValues(k)) + Sin(B.CValues(k));
						 break;
				 case 2: for (k = 0; k < cLen; k++) C.CValues(k) = sqrt(4 * a /(2*PI)) * a * CSqr(B.CValues(k)) * Exp(-0.5 * a * CSqr(B.CValues(k)));
						 break;
				 case 3: for (k = 0; k < cLen; k++) ac = ac + C.CValues(k);
						 break;
				 }
				 }
				 break;
			 case mvDouble: {

				 pc = &C[0];
				 pb = &B[0];

				 switch (ItemIndex) {
				 case 0: for (k = 0; k < cLen; k++)  pc[k] = pc[k] * pb[k]; //C[k] = C[k] * B[k];
						 break;
				 case 1: for (k = 0; k < cLen; k++) pc[k] = sin(pc[k]) + sin(pb[k]);
						 break;
				 case 2: for (k = 0; k < cLen; k++) pc[k] = sqrt(4 * a /(2*PI)) * a * Sqr(pb[k]) * exp(-0.5 * a * Sqr(pb[k]));
						 break;
				 case 3: for (k = 0; k < cLen; k++) a = a  + pc[k];
						 break;
				 }
                 }
				 break;
			 }
		}
		bTime = StopTimer()*4; // simulate longer running time, by using 4x less iters

		Memo->Lines->Add("");
		Memo->Lines->Add("C++ timings:");
		Memo->Lines->Add("");
		Memo->Lines->Add("C++ (1x) = " + FormatSample("0.00us",bTime*1000*1000/IterCount) + ", TotalTime = " + FormatSample("0.000s", bTime));
		Memo->Lines->Add("Ratio OpenCL/C++ = " + FormatSample("0.00x",bTime/aTime));
		Memo->Lines->Add("Ratio OpenCL/(Threaded C++) = " + FormatSample("0.00x",bTime/(aTime*Controller->CpuCores*0.9)));
		Memo->Lines->Add("Time/element = " + FormatSample("0.000ns",bTime*(1000000.0/IterCount)*(1000.0/VectorLen)));
	}
	__finally
	{
		Screen->Cursor = crDefault;
	}
}
//---------------------------------------------------------------------------
void __fastcall TclFunctionForm::Button1Click(TObject *Sender)
{
	int CacheLength;

	VectorLen = StrToInt(VectorLengthBox->Text);
	CacheLength = VectorLen;
	if (ComplexBox->Checked) CacheLength = CacheLength*2;
	if (FloatPrecisionBox->ItemIndex > 0) CacheLength = CacheLength*2;

	clPlatform()->UnMarkThreads();
	selectedDevice = clPlatform()->Platforms[PlatformListBox->ItemIndex]->Device[DeviceListBox->ItemIndex];
	if ((AnsiCompareStr(selectedDevice->DevicePlatform->Name,INTEL_PLATFORM) == 0)  & (clPlatform()->IgnoreIntel))
	{
		ShowMessage("clPlatform->IgnoreIntel = True. If you want to run benchmark for Intel platform set this flag to false first!");
	}
	else
	{
		selectedDevice->Cache->SetCacheSize(12, CacheLength, 12, 12);
		selectedDevice->CommandQueue->Item[0]->MarkThread(); //{ UserThread := GetCurrentThreadID; }
		DoCompute();
	};
}
//---------------------------------------------------------------------------

void __fastcall TclFunctionForm::PlatformListBoxClick(TObject *Sender)
{
	int i;
	StringList DeviceList;

	for (i = 0; i < clPlatform()->Platforms[PlatformListBox->ItemIndex]->Count; i++)
	{
		 DeviceList.Add(clPlatform()->Platforms[PlatformListBox->ItemIndex]->Device[i]->Name);
    }

	DeviceListBox->Items->Assign(DeviceList);
	DeviceListBox->ItemIndex = 0;
}
//---------------------------------------------------------------------------

