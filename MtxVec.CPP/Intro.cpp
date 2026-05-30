//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Intro.h"
#include <Math387.hpp>
#include <MtxVec.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TIntroduction *Introduction;
//---------------------------------------------------------------------------
__fastcall TIntroduction::TIntroduction(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TIntroduction::FormCreate(TObject *Sender)
{
  Label1->Caption = "Welcome to MtxVec v" + FormatSample("0.00", MtxVecVersion / 100.0);

  RichEdit1->Lines->Clear();
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51, 104, 196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Welcome to MtxVec, an object oriented threaded and vectorized numerical library "
                        "for Delphi and C++Builder");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("MtxVec adds the following capabilities to your development environment:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Lines->Add("Comprehensive set of mathematical and statistical functions");
  RichEdit1->Lines->Add("Substantial performance improvements of floating point math by exploiting the SSE3, SSE4.x, AVX, AVX2 and AVX512 instruction sets.");
  RichEdit1->Lines->Add("Support for 64bit applications.");
  RichEdit1->Lines->Add("Certified support for 4GB address range on 64bit OS for 32bit applications.");
  RichEdit1->Lines->Add("Open CL support allows high performance cross platform portable code and gives you access to the power of GPUs.");
  RichEdit1->Lines->Add("Improved compactness and readability of code.");
  RichEdit1->Lines->Add("Significantly shorter development times by protecting the developer from a wide range of possible errors.");
  RichEdit1->Lines->Add("Same API interface in Delphi and C++Builder for W32 and W64");
  RichEdit1->Lines->Add("Support for 64bit in C++Builder");
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Typical performance improvements observed by most users are 4-6 times for "
                        "vector functions, but speed ups up to 20 times are not rare. The matrix "
                        "multiplication for example is faster up to 50 times.");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Navigate through the demo application, to learn "
                        "more about MtxVec and experience it's unmatched "
                        "performance and ease of use.");
  RichEdit1->Lines->Add("");

  // System info section
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51, 104, 196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("System info");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Lines->Add("CPU Logical Core Count = " + IntToStr((__int64)Controller->CpuCoresLogical));
  RichEdit1->Lines->Add("CPU Physical Core Count = " + IntToStr((__int64)Controller->CpuCoresPhysical));
  RichEdit1->Lines->Add("CPU NUMA Node Count = " + IntToStr((__int64)Controller->CpuNumaNodes));
  RichEdit1->Lines->Add("CPU L1 Cache size per Core = " + IntToStr((__int64)(Controller->CpuCacheL1SizeInBytes / 1024)) + " KB");
  RichEdit1->Lines->Add("CPU L2 Cache size per Core = " + IntToStr((__int64)(Controller->CpuCacheL2SizeInBytes / 1024)) + " KB");
  if (Controller->CpuCacheL3SizeInBytes > 0)
    RichEdit1->Lines->Add("CPU L3 Cache Size = " + IntToStr((__int64)(Controller->CpuCacheL3SizeInBytes / 1024)) + " KB");
  RichEdit1->Lines->Add("CPU Vendor: " + Controller->CPUVendor);

  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Lines->Add("");

  // MtxVec config section
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51, 104, 196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("MtxVec config");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Lines->Add("CPU/Thread Count = " + IntToStr((__int64)Controller->CpuCores));
  RichEdit1->Lines->Add("Thread Dimension = " + IntToStr((__int64)Controller->ThreadDimension));
  RichEdit1->Lines->Add("Blas internal threads = " + IntToStr((__int64)Controller->BlasThreadCount));
  RichEdit1->Lines->Add("Lapack internal threads = " + IntToStr((__int64)Controller->LapackThreadCount));
  RichEdit1->Lines->Add("FFT internal threads = " + IntToStr((__int64)Controller->FftThreadCount));
  RichEdit1->Lines->Add("VML internal threads = " + IntToStr((__int64)Controller->VmlThreadCount));
  // IPP/MKL/FFT/VML/Random Gen acceleration flags mirror the Pascal source's
  // {$IFDEF IPPDLL_DOUBLE} etc. conditional defines. The BCB cbproj does not
  // ship these defines by default; add them to <Defines> per build to flip
  // the bullet to "ON". When undefined the build links the same DLLs via the
  // runtime packages, so a project-side define is the right toggle, not a
  // runtime probe.
  RichEdit1->Lines->Add(AnsiString("IPP acceleration (double) = ") +
                        #ifdef IPPDLL_DOUBLE
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add(AnsiString("IPP acceleration (single) = ") +
                        #ifdef IPPDLL_SINGLE
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add(AnsiString("LAPACK acceleration (double) = ") +
                        #ifdef MKLDLL_DOUBLE
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add(AnsiString("LAPACK acceleration (single) = ") +
                        #ifdef MKLDLL_SINGLE
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add(AnsiString("FFT acceleration (single and double) = ") +
                        #ifdef FFTDLL
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add(AnsiString("VML acceleration (double) = ") +
                        #ifdef VMLDLL_DOUBLE
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add(AnsiString("VML acceleration (single) = ") +
                        #ifdef VMLDLL_SINGLE
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add(AnsiString("Random Gen acceleration (single and double) = ") +
                        #ifdef RNDDLL
                        "ON"
                        #else
                        "OFF"
                        #endif
                        );
  RichEdit1->Lines->Add("MtxVec Block Size (double) = " + IntToStr((__int64)Math387::MtxVecBlockSize));

	TMtxVecPoolItem *p = Controller->Pool[0];
	RichEdit1->Lines->Add(AnsiString("sVector object cache: ") +
	  IntToStr((__int64)(p->Vec ? p->Vec->CacheSize : 0)) + " objects x " +
	  IntToStr((__int64)(p->Vec ? p->Vec->CacheElements : 0)) + " elements/obj");
	RichEdit1->Lines->Add(AnsiString("sVectorInt object cache: ") +
	  IntToStr((__int64)(p->VecInt ? p->VecInt->CacheSize : 0)) + " objects x " +
	  IntToStr((__int64)(p->VecInt ? p->VecInt->CacheElements : 0)) + " elements/obj");
	RichEdit1->Lines->Add(AnsiString("sMatrix object cache: ") +
	  IntToStr((__int64)(p->Mtx ? p->Mtx->CacheSize : 0)) + " objects x " +
	  IntToStr((__int64)(p->Mtx ? p->Mtx->CacheElements : 0)) + " elements/obj");
	RichEdit1->Lines->Add(AnsiString("sMatrixInt object cache: ") +
	  IntToStr((__int64)(p->MtxInt ? p->MtxInt->CacheSize : 0)) + " objects x " +
	  IntToStr((__int64)(p->MtxInt ? p->MtxInt->CacheElements : 0)) + " elements/obj");

  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Paragraph->FirstIndent = 0;

  RichEdit1->Lines->Add("");

  // Enabled CPU support
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51, 104, 196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Enabled CPU support");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Paragraph->FirstIndent = 10;

  if (Controller->CpuSSSE3) RichEdit1->Lines->Add("SSSE3");
  if (Controller->CpuSSE42) RichEdit1->Lines->Add("SSE42");
  if (Controller->CpuAVX) RichEdit1->Lines->Add("AVX");
  if (Controller->CpuAVX2) RichEdit1->Lines->Add("AVX2");
  if (Controller->CpuAVX512F) RichEdit1->Lines->Add("AVX512F");
  if (Controller->CpuAVX512CD) RichEdit1->Lines->Add("AVX512CD");
  if (Controller->CpuAVX512BW) RichEdit1->Lines->Add("AVX512BW");
  if (Controller->CpuAVX512DQ) RichEdit1->Lines->Add("AVX512DQ");

  if (!Controller->CpuFeaturesEnabledMatchAvailable())
    ShowMessage("Warning: The CPU features enabled do not match the CPU features available!");

  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Lines->Add("");
}
//---------------------------------------------------------------------------
