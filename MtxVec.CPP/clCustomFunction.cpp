//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "clCustomFunction.h"
#include <MtxVecEdit.hpp>
#include <MtxVec.hpp>
#include <MtxExpr.hpp>
#include <clMtxExpr.hpp>
#include <MtxVecInt.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TclCustomFunctionForm *clCustomFunctionForm;
int VectorLen;
//---------------------------------------------------------------------------
__fastcall TclCustomFunctionForm::TclCustomFunctionForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TclCustomFunctionForm::CreateCustom()
{
  if (SelectedDevice->Programs->Count > 1) SelectedDevice->Programs->Delete(1);
  TOpenCLProgram *aProgram = SelectedDevice->Programs->Add();

  TStringList *SourceCode = new TStringList();
  try {
    SourceCode->Add("__kernel void vec_sin_f (__global const float *a, const int aIdx,");
    SourceCode->Add("  	               __global const float *b, const int bIdx,      ");
    SourceCode->Add("		             __global float *c, const int cIdx,              ");
    SourceCode->Add("                             const int Length)                   ");
    SourceCode->Add("{                                                                ");
    SourceCode->Add("	size_t i = get_global_id(0);                                   ");
    SourceCode->Add("                                                                 ");
    SourceCode->Add("	c[i + cIdx] = sin(a[i + aIdx]) + b[i + bIdx];                  ");
    SourceCode->Add("                                                                 ");
    SourceCode->Add("}                                                                ");

    AnsiString aBinFileName = aProgram->BinaryFileName("MySource.cl");
    aProgram->LoadProgram(aBinFileName, SourceCode, "", "", true);
  } __finally {
    delete SourceCode;
  }
}
//---------------------------------------------------------------------------
static clVector vec_sin_f(TOpenCLVector *a, TOpenCLVector *b)
{
  if (a->Length != b->Length) throw Exception("a.Length <> b.Length");
  clVector Result;
  Result.Size(a);

  TOpenCLKernel *aKernel = a->Device->Kernels->Locate("vec_sin_f");
  aKernel->SetArgBuffer(0, a->SData);
  aKernel->SetArgInt32(1, a->SDataIndex(0));
  aKernel->SetArgBuffer(2, b->SData);
  aKernel->SetArgInt32(3, b->SDataIndex(0));
  aKernel->SetArgBuffer(4, ((TOpenCLVector*)Result)->SData);
  aKernel->SetArgInt32(5, ((TOpenCLVector*)Result)->SDataIndex(0));
  aKernel->SetArgInt32(6, a->Length);
  aKernel->Enqueue(a->CmdQueue, a->Length, false);
  return Result;
}
//---------------------------------------------------------------------------
void __fastcall TclCustomFunctionForm::DoCompute()
{
  sVector A, B, C, R;
  clVector clA, clB, clC;
  A.Size(VectorLen);
  A.SetVal(2);
  B.Size(VectorLen);
  B.SetVal(1);
  clA.Copy(A);
  clB.Copy(B);
  clC = vec_sin_f(clA, clB);
  C = Sin(A) + B;

  clC.CopyTo(R);
  if (!C.IsEqual(R, 1E-4)) ERaise("Not equal"); else ShowMessage("Function works!");
}
//---------------------------------------------------------------------------
void __fastcall TclCustomFunctionForm::Button1Click(TObject *Sender)
{
  VectorLen = StrToInt(VectorLengthBox->Text);

  clPlatform()->UnMarkThreads();
  SelectedDevice = (*clPlatform())[PlatformListBox->ItemIndex]->Device[DeviceListBox->ItemIndex];
  SelectedDevice->Cache->SetCacheSize(50, VectorLen, 50, 50);
  (*SelectedDevice->CommandQueue)[0]->MarkThread();

  CreateCustom();
  DoCompute();
}
//---------------------------------------------------------------------------
void __fastcall TclCustomFunctionForm::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "The platform list shows the Open CL drivers available on your computer. Note that GPU device speed is sensitive "
    "to vector lengths which are not divisable by 4. ");
  RichEdit1->Lines->Add("Press run to execute the custom function on the selected platform.");

  for (int i = 0; i < clPlatform()->Count; i++)
    PlatformListBox->Items->Add((*clPlatform())[i]->Name);
  PlatformListBox->ItemIndex = 0;

  for (int i = 0; i < (*clPlatform())[0]->Count; i++)
    DeviceListBox->Items->Add((*clPlatform())[0]->Device[i]->Name);
  DeviceListBox->ItemIndex = 0;

  int kernelSum = 0;
  for (int i = 0; i < clPlatform()->Count; i++)
    for (int k = 0; k < (*clPlatform())[i]->Count; k++)
      kernelSum += (*clPlatform())[i]->Device[k]->Kernels->Count;

  if (kernelSum == 0)
  {
    Screen->Cursor = crHourGlass;
    ShowMessage("When loading the first time, the Open CL drivers need to recompile the source code."
                "This may take minutes.");
    clPlatform()->LoadProgramsForDevices(false, false, true, false, false);
    Screen->Cursor = crDefault;
  }

  VectorLen = Math387::RoundToInt(Exp2(19));
  VectorLengthBox->Text = IntToStr(VectorLen);
}
//---------------------------------------------------------------------------
void __fastcall TclCustomFunctionForm::PlatformListBoxClick(TObject *Sender)
{
  DeviceListBox->Items->Clear();
  for (int i = 0; i < (*clPlatform())[PlatformListBox->ItemIndex]->Count; i++)
    DeviceListBox->Items->Add((*clPlatform())[PlatformListBox->ItemIndex]->Device[i]->Name);
  DeviceListBox->ItemIndex = 0;
}
//---------------------------------------------------------------------------
void __fastcall TclCustomFunctionForm::AutoDeviceButtonClick(TObject *Sender)
{
  VectorLen = StrToInt(VectorLengthBox->Text);
  Screen->Cursor = crHourGlass;
  TOpenCLDevice *aDevice = clPlatform()->AutoDeviceSelect(LoadTest, 10, VectorLen);
  PlatformListBox->ItemIndex = aDevice->PlatformIndex;
  PlatformListBoxClick(NULL);
  DeviceListBox->ItemIndex = aDevice->DeviceIndex;
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------
void __fastcall TclCustomFunctionForm::LoadTest(TObject *Sender)
{
  clVector clA, clB, clC;
  clA.Size(VectorLen, clFloat, false);
  clA.SetVal(1);
  clB.Size(VectorLen, clFloat, false);
  clB.SetVal(2);
  for (int i = 0; i < 300; i++)
    clC = Sin(clA) + clB;
  ((TOpenCLVector*)clC)->Finish();
}
//---------------------------------------------------------------------------
