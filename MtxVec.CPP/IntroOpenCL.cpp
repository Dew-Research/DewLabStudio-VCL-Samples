//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "IntroOpenCL.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TIntroOpenCLForm *IntroOpenCLForm;
//---------------------------------------------------------------------------
__fastcall TIntroOpenCLForm::TIntroOpenCLForm(TComponent* Owner)
  : TBasicForm3(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TIntroOpenCLForm::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Open CL features:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Open CL is a standard designed to make it easier to write high-performance code for GPU/CPU devices and make that code portable across different GPU and CPU devices");
  RichEdit1->Lines->Add("Cross-platform support. Same code is to run on embedded devices (like mobile phones), desktop PCs and super computers across a wide range of operating systems.");
  RichEdit1->Lines->Add("Support for both ATI and Nvidia GPUs.");
  RichEdit1->Lines->Add("Support for CPU devices. There exists a great opportunity that an extended Open CL will become the main target for accelerated code running on CPUs. Both Intel and AMD currently offer their own drivers for Open CL code to run on CPUs.");
  RichEdit1->Lines->Add("Dynamic code compilation. The compiler is included with the drivers and the code is compiled only for the target device. End users running applications have the possibility to specify expressions which (through the Open CL) can run on GPU or be compiled in to native CPU code.");
  RichEdit1->Lines->Add("Open CL drivers are free for all supported platforms and included with drivers for the hardware.");
  RichEdit1->Lines->Add("End user application can be distributed without any dlls.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Features of Cougar Open CL:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Open CL based numerical library for Delphi and C++Builder users.");
  RichEdit1->Lines->Add("Uses dynamic Open CL dll loading and can be included in end user applications possibly running on machines without Open CL drivers.");
  RichEdit1->Lines->Add("Automatically detects all platforms (Intel, AMD, NVidia) and devices and loads their parameters.");
  RichEdit1->Lines->Add("Provides routines to store encrypted source code in to .res resource files that are embedded in to the final application.");
  RichEdit1->Lines->Add("Caches binaries compiled on the first run for subsequent faster load times.");
  RichEdit1->Lines->Add("Automatically detects changes to the hardware or Open CL driver versions and rebuilds the cached binaries.");
  RichEdit1->Lines->Add("Loads all the kernels (functions) present in the Open CL source code, including their properties.");
  RichEdit1->Lines->Add("Implements a shared context between CPU and GPU devices for more efficient heterogeneous computing. (one context per platform)");
  RichEdit1->Lines->Add("Allows build options and source headers to be specified at program load time optionally requesting unconditional recompile.");
  RichEdit1->Lines->Add("Can automatically detect the fastest device in the system and have the code running on it.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("MtxVec for Open CL:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Implements all standard math functions");
  RichEdit1->Lines->Add("Support for real and complex numbers across all functions (where applicable)");
  RichEdit1->Lines->Add("Makes use of object cache concept known from MtxVec for faster memory handling and higher performance.");
  RichEdit1->Lines->Add("Implements separate kernels for CPU and GPU devices to achieve best performance on both architectures.");
  RichEdit1->Lines->Add("Can run in single and double precision concurrently.");
  RichEdit1->Lines->Add("Integrated debugger support for debugger visualizers allows GPU code debugging as if it would be running on the CPU.");
  RichEdit1->Lines->Add("Delivers over 500 unique kernels. When considering also single/double and CPU/GPU variants, it is well over 2000.");
  RichEdit1->Lines->Add("Full support for operator overloading.");
  RichEdit1->Lines->Add("Supports multiple automatic code fall-back scenarios. Even when no Open CL driver is detected, the code will still run. When not using Open CL it can run with Delphi code only without external dlls or with native MtxVec using Intel IPP and MKL performance libraries. When native MtxVec is found to be faster than Open CL, it will automatically default to it.");
  RichEdit1->Lines->Add("Supports execution of \"micro\" kernels. Micro kernels are short functions which could normally not be accelerated with Open CL.");
  RichEdit1->Lines->Add("The performance penalty for micro-kernels is estimated at 50% of peak performance for GPU devices. This comes however with the benefit of utter simplicity of code writing and debugging with programmers productivity matching the work on CPU.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
}
//---------------------------------------------------------------------------
