//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "clMultiDeviceFunction.h"
#include <MtxVecEdit.hpp>
#include <MtxVec.hpp>
#include <MtxExpr.hpp>
#include <clMtxExpr.hpp>
#include <MtxVecInt.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TclMultiDeviceFunctionForm *clMultiDeviceFunctionForm;
//---------------------------------------------------------------------------
static int MDVectorLen;
//---------------------------------------------------------------------------
__fastcall TclMultiDeviceFunctionForm::TclMultiDeviceFunctionForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TclMultiDeviceFunctionForm::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "The platform list shows the Open CL drivers available on your computer. Select the platform of your choice and press Run."
    "Then you can observe how long it takes before the specified Job Count is computed "
    "on all devices available on the platform. This benchmarks uses both CPU and GPU.");
  RichEdit1->Lines->Add("Select various functions and see how they perform on different platforms.");

  FloatPrecisionBox->ItemIndex = 0;
  CPUFloatPrecisionLabel->Caption = "CPU (MtxVec) float precision: " + IntToStr((int)(sizeof(double) * 8)) + "bit";

  for (int i = 0; i < clPlatform()->Count; i++)
    PlatformListBox->Items->Add((*clPlatform())[i]->Name);
  PlatformListBox->ItemIndex = 0;

  for (int i = 0; i < (*clPlatform())[0]->Count; i++)
    DeviceListBox->Items->Add((*clPlatform())[0]->Device[i]->Name);
  DeviceListBox->ItemIndex = 0;

  for (int i = 0; i < DeviceListBox->Items->Count; i++)
    DeviceListBox->Selected[i] = true;

  MaximumJobCountEdit->Text = "2";

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

  FunctionBox->ItemIndex = 0;
  MDVectorLen = Math387::RoundToInt(Exp2(19));
  VectorLengthBox->Text = IntToStr(MDVectorLen);
  Finished = true;
}
//---------------------------------------------------------------------------
void __fastcall TclMultiDeviceFunctionForm::FormShow(TObject *Sender)
{
  for (int i = 0; i < (*clPlatform())[PlatformListBox->ItemIndex]->Count; i++)
    DeviceListBox->Selected[i] = true;
}
//---------------------------------------------------------------------------
void __fastcall TclMultiDeviceFunctionForm::PlatformListBoxClick(TObject *Sender)
{
  DeviceListBox->Items->Clear();
  for (int i = 0; i < (*clPlatform())[PlatformListBox->ItemIndex]->Count; i++)
    DeviceListBox->Items->Add((*clPlatform())[PlatformListBox->ItemIndex]->Device[i]->Name);
  DeviceListBox->ItemIndex = 0;
  for (int i = 0; i < (*clPlatform())[PlatformListBox->ItemIndex]->Count; i++)
    DeviceListBox->Selected[i] = true;
}
//---------------------------------------------------------------------------
void __fastcall TclMultiDeviceFunctionForm::Button1Click(TObject *Sender)
{
  if (!Finished) return;

  MDVectorLen = StrToInt(VectorLengthBox->Text);
  int CacheLength = MDVectorLen;
  if (ComplexBox->Checked) CacheLength *= 2;
  if (FloatPrecisionBox->ItemIndex > 0) CacheLength *= 2;

  for (int i = 0; i < DeviceListBox->Count; i++)
  {
    TOpenCLDevice *aDevice = (*clPlatform())[PlatformListBox->ItemIndex]->Device[i];
    (*aDevice->CommandQueue)[0]->JobThread->OnExecute = DoOnExecute;
    aDevice->Cache->SetCacheSize(12, CacheLength, 12, 12);
  }

  Finished = false;
  GlobalJobIndex = 0;
  PlatformListBox->Enabled = false;
  DeviceListBox->Enabled = false;
  FunctionBox->Enabled = false;
  FloatPrecisionBox->Enabled = false;
  SchedulerTimer->Enabled = true;
  StartTime = Now();
}
//---------------------------------------------------------------------------
void __fastcall TclMultiDeviceFunctionForm::SchedulerTimerTimer(TObject *Sender)
{
  int MaxJobCount = StrToInt(MaximumJobCountEdit->Text);
  Finished = true;

  for (int i = 0; i < DeviceListBox->Count; i++)
  {
    if (DeviceListBox->Selected[i])
    {
      TOpenCLCommandQueue *aCmd = (*(*clPlatform())[PlatformListBox->ItemIndex]->Device[i]->CommandQueue)[0];
      if (aCmd->JobThread->Sleeping() && (GlobalJobIndex < MaxJobCount))
      {
        GlobalJobIndex++;
        aCmd->JobThread->JobIndex = GlobalJobIndex;
        aCmd->JobThread->Start();
      }
      Finished = Finished && aCmd->JobThread->Sleeping() && (GlobalJobIndex >= MaxJobCount);
    }
  }

  if (!Finished)
  {
    CurrentJobCountLabel->Caption = "Current job count = " + IntToStr(GlobalJobIndex);
    TDateTime deltaTime = Now() - StartTime;
    Word Hour, Min, Sec, MSec;
    DecodeTime(deltaTime, Hour, Min, Sec, MSec);
    TotalRunningTimeLabel->Caption = "Total running time = " +
                                      FormatFloat("00", Hour) + ":" +
                                      FormatFloat("00", Min) + ":" +
                                      FormatFloat("00", Sec) + ":" +
                                      FormatFloat("000", MSec);
  }
  else
  {
    ErrorsLabel->Caption = "";
    for (int i = 0; i < DeviceListBox->Count; i++)
    {
      if (DeviceListBox->Selected[i])
      {
        TOpenCLCommandQueue *aCmd = (*(*clPlatform())[PlatformListBox->ItemIndex]->Device[i]->CommandQueue)[0];
        if (aCmd->JobThread->ExceptionMessage != "")
          ErrorsLabel->Caption = ErrorsLabel->Caption + aCmd->JobThread->ExceptionMessage;
      }
    }
    if (ErrorsLabel->Caption == "") ErrorsLabel->Caption = "Errors: None";

    PlatformListBox->Enabled = true;
    DeviceListBox->Enabled = true;
    FunctionBox->Enabled = true;
    FloatPrecisionBox->Enabled = true;
    SchedulerTimer->Enabled = false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TclMultiDeviceFunctionForm::DoOnExecute(TOpenCLCommandQueue * const cmdQueue, int JobIndex)
{
  double a = 1;
  double ScalarB = 1.002;
  int IterCount = 1;
  switch (FunctionBox->ItemIndex)
  {
    case 0: IterCount = 8192; break;
    case 1: IterCount = 8192; break;
    case 2: IterCount = 8192; break;
  }

  clVector clB, clC;
  clB.Size(MDVectorLen, (TclFloatPrecision)FloatPrecisionBox->ItemIndex, ComplexBox->Checked);
  clB.SetVal(ScalarB);
  clC.Size(MDVectorLen, (TclFloatPrecision)FloatPrecisionBox->ItemIndex, ComplexBox->Checked);
  clC.SetVal(1);

  for (int i = 0; i < IterCount; i++)
  {
    switch (FunctionBox->ItemIndex)
    {
      case 0: clC = clC * clB; break;
      case 1: clC = Sin(clC) + Sin(clB); break;
      case 2: clC = Math387::Sqrt(4 * a / (2 * PI)) * a * Sqr(clB) * Exp(-0.5 * a * Sqr(clB)); break;
    }
  }
  sVector R;
  clC.CopyTo(R);
  if ((R.Find(NAN) != -1) || (R.Find(INF) != -1)) ERaise("NAN or INF detected!");
}
//---------------------------------------------------------------------------
