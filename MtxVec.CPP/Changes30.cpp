//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Changes30.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Basic3"
#pragma resource "*.dfm"
TfrmChanges30 *frmChanges30;
//---------------------------------------------------------------------------
__fastcall TfrmChanges30::TfrmChanges30(TComponent* Owner): TBasicForm3(Owner)
{
  AnsiString str;
  RichEdit1->Lines->Clear();

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v6.0 (March 2020)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Updated for Rio 10.3 Update 3 and added support for Android64 bit.");
  RichEdit1->Lines->Add("Introduced  TMtxVec.FloatPrecision, which allows computational precision to be specified at run-time. (major new feature of MtxVec v6). The same algorithm written once, can be executed either in double or single precision, where it makes sense. Single precision variant can run up to 2x faster and use up to 2x less memory.");
  RichEdit1->Lines->Add("Enhanced SetSubRange routines and added SetSubRangeLevel, which now support nesting.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.4.1 (September 2019)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Updated for Rio 10.3 Update 2 and added support for OSX64 bit.");
  RichEdit1->Lines->Add("Introduced additional property to reduce memory allocation frequency: TMtxVec.Capacity, with similar behaviour as TList.Capacity ");
  RichEdit1->Lines->Add("Bug fix for TMtxGridSeries on FireMonkey in the TeeChart editor.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.4 (January 2019)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Updated to latest version of Intel MKL, Intel IPP (release 2019).");
  RichEdit1->Lines->Add("Vectorized version for FindIndexes, FindMask and FindAndGather for TVec/TMtx and TVecInt/TMtxInt. Especially when using FindMask, speed improvement of 10x or more is possible when vectorizing if-then clauses.");
  RichEdit1->Lines->Add("Added example to MtxVec demo: ""Vectorizing if-then with masks"" to show how to use vectorized FindMask and FindIndexes.");
  RichEdit1->Lines->Add("Dll API has changed. To prevent version conflicts, the library names have new version number: 6. VC runtime library (msvcrt120.dll) is no longer needed.");
  RichEdit1->Lines->Add("MtxVec.Sparse6.dll has been joined in to MtxVec.Lapack6d.dll due to relatively much smaller size.");
  RichEdit1->Lines->Add("Added new example to MtxVec demo: ""Memory channels"" exploring options to speed up code that cant be vectorized at all or only partially.");
  RichEdit1->Lines->Add("Added single precision support to Pardiso sparse solver.");
  RichEdit1->Lines->Add("Added single precision support to Trust-Region optimization method.");
  RichEdit1->Lines->Add("Minimum Windows version increased to Windows 7 32bit.");
  RichEdit1->Lines->Add("Minimum instruction set increased to SSE3 (from SSE2).");
  RichEdit1->Lines->Add("Further increased number of routines with AVX-512 code path (by several dozens).");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("RndGenerators.pas");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added ability to save and load state of TRandomGenerator including the state of all the specified streams.");
  RichEdit1->Lines->Add("Added Uniform 32bit chunk and 64bit chunk random generators.");
  RichEdit1->Lines->Add("Added RandomMultinomial random generator");
  RichEdit1->Lines->Add("Greatly enhanced error checking and reporting for random generators.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.3.2 (December 2018)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Support for Rad Studio Rio 10.3.");
  RichEdit1->Lines->Add("Installer (Build Tool) support for all Delphi platforms.");
  RichEdit1->Lines->Add("CPU Affinity support for DoForLoop on Windows.");
  RichEdit1->Lines->Add("Optimization methods can now respond to a ""stop"" signal when running in its own thread. This can be helpfull, if the optimization process would deadlock or run too long.");
  RichEdit1->Lines->Add("Various FireMonkey related fixes and refinments.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.3.1 (January 2018)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Support for Linux on Rad Studio Tokyo 10.2. (Update 2) with MtxVec Core. The following units are supported on Linux: Math387, MtxVecBase, MtxParseClass, MtxParseExpr, MtxParseOperator, MtxParseProbabilities, Blas, Lapack, lapack_dfti, MtxExpr, MtxExprInt, MtxForLoop, MtxVecInt, MtxVecTools, Optimization, Polynoms, Probabilities.");
  RichEdit1->Lines->Add("Bug fix for concurrent precision build (double and single precision), where RegisterClass was called twice with the same type.");
  RichEdit1->Lines->Add("Bug fix for TVecInt.BitUnpack when bit count was less than 32.");
  RichEdit1->Lines->Add("Modifed SumOfSquares and Standard Deviation for greater numerical accuracy and about 50% higher speed.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Expression parser:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Enabled ""Integer overflow"" and ""Integer Division By Zero"" error messages.");
  RichEdit1->Lines->Add("Integer math is now based on Int64.");
  RichEdit1->Lines->Add("Bug fixes for sqr and sqrt when param was integer.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.3 (November 2017)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("TVec/TVecInt and TMtx/TMtx received upgrade of ValueToStrings for fixed width font output with headers. Usefull for command line printout of small matrices.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Expression Parser");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added ability for ""colon range"" autocomplete: a(2:) = b; //short for a(2:(2+Length(b)) = b;");
  RichEdit1->Lines->Add("Added ""Edit and Continue"" type of debugging support for the script");
  RichEdit1->Lines->Add("Added ""Tooltips"" for variable evaluation during debugging of the script.");
  RichEdit1->Lines->Add("File read/write and some string management routines added to the expression parser.");
  RichEdit1->Lines->Add("Much improved example code how to handle spreadsheet like data.");
  RichEdit1->Lines->Add("Several bugs fixed.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.3 (October 2017)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added support for Apple Acccelerate framework on iOS and macOS. Includes accelerated versions of FFT, BLAS 1,2,3 and Lapack.");
  RichEdit1->Lines->Add("Support for complex-number Lapack on iOS and OSX for MtxVec Core Edition.");
  RichEdit1->Lines->Add("Substantial improvement of speed of Math functions: sin, cos, log, exp,.. on Android, iOS and OS X. Math387 now bypasses default Delphi System unit math functions. Vectorized versions use the Accelerate framework on the iOSand OS X. Average speedup is about 20x.");
  RichEdit1->Lines->Add("Added support for TMtxInt and Matrix to the Debugger Visualizer.");
  RichEdit1->Lines->Add("Debugger Visualizer bug fix, which helps more variables to be successfully evaluated.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Expression Parser");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added support for [1, 2 ; 3, 4] for vector/matrix concatenation/initialization.");
  RichEdit1->Lines->Add("Added support for 'if-else', 'while' and 'for-loop' clauses.");
  RichEdit1->Lines->Add("Added support for 'break' and 'continue' clauses.");
  RichEdit1->Lines->Add("Added support for strings and custom objects.");
  RichEdit1->Lines->Add("Added string grid adaptor, which enables reading and writing from an arbitrary string grid like object.");
  RichEdit1->Lines->Add("Added support for empty lines and comments.");
  RichEdit1->Lines->Add("Command line printout can be surpressed by specifying "";"" at the end of the line.");
  RichEdit1->Lines->Add("Further performance optimization for single line and multi-line expression evaluation by about 2x.");
  RichEdit1->Lines->Add("Expressions are now case-sensitive, but function aliases are allowed (Tan() for tan() for example).");
  RichEdit1->Lines->Add("Added one new demo for demonstrating the new features of the parser.");
  RichEdit1->Lines->Add("More automated tests have been implemented");
  RichEdit1->Lines->Add("All features are available on Windows, macOS, Android and iOS.");
  RichEdit1->Lines->Add("End user summary can be found here");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.2 (May 2017)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added integer matrix (TMtxInt and MatrixInt) covering 108+ overloaded functions");
  RichEdit1->Lines->Add("Added TVec.BinarySearch and TMtx.BinarySearch for exact and nearest index on sorted data");
  RichEdit1->Lines->Add("Added 80 new optimized functions for integer math used by TVecInt and TMtxInt");
  RichEdit1->Lines->Add("Added ThreadIndex parameter to the MtxForLoop threaded function type");
  RichEdit1->Lines->Add("Support for Rad Studio Tokyo XE 10.2, VCL and FMX");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Expression Parser");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added integer, integer vector, integer matrix, boolean, boolean vector and boolean matrix types.");
  RichEdit1->Lines->Add("Support for funtions with multiple results: (a,b,c....) = fun(d)");
  RichEdit1->Lines->Add("Added all functions from Probabilities.pas to the expression parser.");
  RichEdit1->Lines->Add("Added large set of functions from MtxVec.pas to the expression parser, like FFT, FFT2D, SVD, etc..");
  RichEdit1->Lines->Add("Total of 300+ functions and operators now available to the expression parser.");
  RichEdit1->Lines->Add("Fixed a number of defects and improved error reporting. Performance optimization.");
  RichEdit1->Lines->Add("Total code base for the parser increased by about 3x.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.1.1 (September 2016)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added TVecInt.ThresholdGT_LT");
  RichEdit1->Lines->Add("Added ThreshAbsGt and ThreshAbsLt to TVecInt, TVec and TMtx");
  RichEdit1->Lines->Add("Added TVecInt.BinarySearch,TVecInt.Find");
  RichEdit1->Lines->Add("Added TVecInt.ThresholdLT/TVecInt.ThresholdGT");
  RichEdit1->Lines->Add("Updated Intel MKL and Intel IPP related code to latest revision.");
  RichEdit1->Lines->Add("Fixed a problem with MKL VML user side multi-threading. (MtxVec.Vmld.dll)");
  RichEdit1->Lines->Add("Fix for TMtxComponentList.Count when reducing value.");
  RichEdit1->Lines->Add("TMtxGridSeries. Increased color count from 3 to 5. Greatly increased the possibility of possible color combinations palette designs.");
  RichEdit1->Lines->Add("TMtxGridSeries. Improved support for fixed user-specified scale.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.1 (May 2016)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Support for Delphi and C++Builder Berlin 10.1");
  RichEdit1->Lines->Add("Added TMtx.Filter2D usefull for 2D convolution of images.");
  RichEdit1->Lines->Add("Improved performance of math routines via Intel IPP v9 update.");
  RichEdit1->Lines->Add("Improved performance of Lapack routines via latest Intel MKL update.");
  RichEdit1->Lines->Add("Support for old and new 32bit and 64bit C++Builder compilers. With RAD Studio 10.1 Berlin the C++ code performance is much improved.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.03 (September 2015)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Support for Delphi and C++Builder Seattle 10.");
  RichEdit1->Lines->Add("Added support for OS X and iOS with Delphi 10 to MtxVec Core edition.");
  RichEdit1->Lines->Add("Update to MtxVec demo for FireMonkey to run also on iOS based tablets.");
  RichEdit1->Lines->Add("IDE help file integration added for XE8 and Delphi 10.");
  RichEdit1->Lines->Add("Updates related to TeeChart.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("Changes and new features of MtxVec v5.02 (April 2015)");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Internal memory access optimization giving performance improvements on both 32bit and 64bit code (on Windows) from 10 to 100% depending on algorithm. The greatest improvement can been seen for algorithms using long vectors and smallest for algorithms which are using block processing.");
  RichEdit1->Lines->Add("Certified support for Android. New Chapter added to MtxVec Users Guide about Delphi mobile compiler support.");
  RichEdit1->Lines->Add("Update to MtxVec demo for FireMonkey to run also on Android tablets.");
  RichEdit1->Lines->Add("Various performance enhancements affecting automatic reference counting on Delphi mobile compilers.");
  RichEdit1->Lines->Add("Fixes to debugger visualizer affecting VectorInt and TVecInt. Additional simplifications will keep all visualizers working in more demanding debug scenarios.");
  RichEdit1->Lines->Add("Fixed NormL1 and NormL2 functions on 64bit, complex number and single precision.");
  RichEdit1->Lines->Add("Fixes for TMtx.Eig() on 64bit and single precision.");
  RichEdit1->Lines->Add("Support for XE8 and related TeeChart updates.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v5:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Optional build parameter (MtxVec Core Edition) results in 100% full source code in pascal. (allows for portability to Android, iOS, OSx when used together with FireMonkey.");
  RichEdit1->Lines->Add("Added support for annoynmous methods to TMtxForLoop.");
  RichEdit1->Lines->Add("New example (MtxVecThreading.pas) with description about efficient multi-threading in MtxVec Users Guid.pdf.");
  RichEdit1->Lines->Add("Enhanced string formating and automatic column sizing in Debugger Visualizers.");
  RichEdit1->Lines->Add("Adapted TMtxGridSeries to support latest TeeChart version (released sept. 2014).");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.51:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Added support for RAD Studio XE7 FireMonkey and VCL.");
  RichEdit1->Lines->Add("Updated Intel MKL and IPP libraries.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->Lines->Add("Sparse matrices:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Bug fix for TMtxSparse.Add when dealing with zeros in the sparse matrix.");
  RichEdit1->Lines->Add("Bug fix for TMtxSparse.Copy when dealing with zero in the sparse matrix.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.5:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Update to MKL and IPP. Performance improvements for eigenvalue calculations");
  RichEdit1->Lines->Add("Added support for RAD Studio XE6 FireMonkey and VCL.");
  RichEdit1->Lines->Add("Added TMtx.Eig overload with optional condition number estimation.");
  RichEdit1->Lines->Add("Added generalized eigenvalue method TMtx.EigGen.");
  RichEdit1->Lines->Add("Added calculation of Schure vectors. TMtx.EigSchure");
  RichEdit1->Lines->Add("Added calculation of generalized Schure vectors. TMtx.EigSchureGen");
  RichEdit1->Lines->Add("Updated calculation of eigenvalues for symmetric matrices. TMtx.EigSym");
  RichEdit1->Lines->Add("Added calculation of generalized eigenvalues for symmetric matrices. TMtx.EigSymGen");
  RichEdit1->Lines->Add("Updated TMtx.LQRSolve. Least square solutions with support for for rank deficient matrices.");
  RichEdit1->Lines->Add("Added generalized SVD decomposition. TMtx.SVDGen.");
  RichEdit1->Lines->Add("Added Gauss Markov Linear Model solver with TMtx.GLMSolve");
  RichEdit1->Lines->Add("Important: Old TMtx.EigGen has become TMtx.EigSymGen and TMtx.EigGen has new meaning.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->Lines->Add("Debugger visualizer:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Fixed debugger visualizer package installation for FireMonkey.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->Lines->Add("Sparse matrices:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Added eigenvalue calculation for symmetric matrices TSparseMtx.EigSym.");
  RichEdit1->Lines->Add("Added generalized eigenvalue calculation for symmetric matrices TSparseMtx.EigSymGen.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.4:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Added BitPack, BitUnpack methods and Bits property to TVecInt.");
  RichEdit1->Lines->Add("Added help for Median filter functions.");
  RichEdit1->Lines->Add("Added support for FireMonkey from including XE5 and forward. This covers all UI components, debugger visualizer and demo.");
  RichEdit1->Lines->Add("Prerelease of MtxVec Core: ability to run MtxVec without dependancy on external dlls. Large parts of StatsMaster and DSP Master are already functional.");
  RichEdit1->Lines->Add("Optional custom search path for TeeChart added to the BuildTool.");
  RichEdit1->Lines->Add("Update to IPP dlls and a dll bug fix.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.3:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Support for Delphi and C++Builder XE5.");
  RichEdit1->Lines->Add("Fixed performance issues with debugger visualizers in big applications.");
  RichEdit1->Lines->Add("Added support for GDI+ Canvas of TeeChart 2013.");
  RichEdit1->Lines->Add("Concurrent use of double and single precision version of the library in the same unit throug Dew.Double and Dew.Single namespaces. Introduced VectorSingle, VectorDouble and MatrixSingle, MatrixDouble type aliases.");
  RichEdit1->Lines->Add("Updated debugger visualizers to support concurrent precision use.");
  RichEdit1->Lines->Add("Added TMtx.LUSolve overload, which makes use of a precomputed factorization.");
  RichEdit1->Lines->Add("New set of dlls with support for Intel 4th Generation Core CPUs and Intel Xeon Phi.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.22:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Support for Delphi and C++Builder XE4.");
  RichEdit1->Lines->Add("Support for Steema TeeChart 2013.");
  RichEdit1->Lines->Add("Cougar Open CL support for VS.NET");
  RichEdit1->Lines->Add("Several minor bug fixes.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.21:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Support for Delphi and C++Builder XE3.");
  RichEdit1->Lines->Add("Cougar Open CL now works with non unicode Delphi versions (2006 and 2007)");
  RichEdit1->Lines->Add("Cougar Open CL now detects also MtxVec version change and automatically rebuilds Open CL source.");
  RichEdit1->Lines->Add("Fixed C++ function operator for sVector.");
  RichEdit1->Lines->Add("Fixed memory allocation for 64bit TMtx, which only allowed 32bit range.");
  RichEdit1->Lines->Add("Bug fix for complex version of the TMtx.SVD function.");
  RichEdit1->Lines->Add("Recreated and updated C++ Demo for many C++Builder versions.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.2:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Redesigned C++ language interface while keeping the option to use old syntax for backward compatibility.");
  RichEdit1->Lines->Add("New C++ syntax supported for C++Builder XE1, XE2 and newer.");
  RichEdit1->Lines->Add("Enabled support for C++ to call and link directly against functions from external MtxVec dlls.");
  RichEdit1->Lines->Add("New MtxVec C++Builder demo for version XE2 featuring new syntax.");
  RichEdit1->Lines->Add("Simplified linking of MtxVec with the C++ project.");
  RichEdit1->Lines->Add("Debugger visualizers for C++ Builder have been implemented to support a range of MtxVec types including: TVec, TMtx, sVector, cVector, sMatrix, cMatrix, oclVector, oclMatrix, VectorInt, TOpenCLVector, TOpenCLMatrix, TVecInt,");
  RichEdit1->Lines->Add("Cougar Open CL bug fix within clPlatform initialization (ResetLength)");
  RichEdit1->Lines->Add("Cougar Open CL support for SetSubRange and working with subvectors and submatrices including function operator overload in C++");
  RichEdit1->Lines->Add("Introduction of Cougar Open CL parallel reduction based algorithms. Support for sum, norms, average, min, max, dot product, etc... known from MtxVec supported for all precisions and platforms. Parallel reduction allows non-destructive summation process and makes it possible for single precision math to achieve same or higher accuracy than double precision for algorithms relying on summation of long arrays.");
  RichEdit1->Lines->Add("Performance of Cougar Open CL is now completely invariant to the length of the vector or size of the matrix. The programmer needs not to worry about memory alignment or vector size.");
  RichEdit1->Lines->Add("Updated help and tested with XE2 Update 4 and TeeChart 2012.");
  RichEdit1->Lines->Add("Updated code related to Intel IPP and MKL libraries to the latest version. Note that the minimum CPU requirement has been raised by Intel to SSE2 capable CPU (P4, released in year 2000). AMD was still selling new CPUs without SSE2 in 2006. This limitation was first introduced by Intel in 2009. MtxVec v4.1 was the last version with the capability to support older CPUs (generic x86 code). The move by Intel is also the reason for 3 years of delay in the Intel related code update. The new dlls improve performance mostly for the new generation of CPUs, capable of SSE4.2 and Intel AVX instruction sets. According to Intel these can sometimes reach cca 60%. Old dlls may cause 'instruction not recognized' exception on the latest generation of Intel CPUs.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.1:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  str = "Cougar Open CL opens the world of GPU processing to C++Builder developers. Two new units clMtxVec and clMtxExpr ";
  str += "add two new types clVector and clMatrix which can run their functions on the GPU.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("Cougar Open CL substantially simplifies custom Open CL algorithm development, integration and deployment.");
  RichEdit1->Lines->Add("Support for TeeChart 2011.");
  RichEdit1->Lines->Add("Support for C++Builder XE2.");
  RichEdit1->Lines->Add("Fixed a bug affecting C++Builder users which was causing an exception when resizing the matrix.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v4.0:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;


  RichEdit1->Lines->Add("Multi-precision integer vector math with TVecInt and VectorInt with full support for object cache and math expressions.");
  RichEdit1->Lines->Add("Updated dlls for latest version of MKL and IPP with support for Intel AVX.");
  RichEdit1->Lines->Add("Reduced distribution size with FFT core cross-platform fallback code providing FFT functions (1D and 2D) with reasonable performance without external dlls.");
  RichEdit1->Lines->Add("Reduced distribution size with IPP core cross-platform fallback code providing signal processing functions with reasonable performance without external dlls.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Visualizers:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Debugger for Delphi 2010 and later supports formated tooltips for Vector/Matrix/TVec/TMtx.");
  RichEdit1->Lines->Add("TCplx type will display as a + bi on the tooltip and in the evaluator.");
  RichEdit1->Lines->Add("Fixed a bug for string lists where empty lines were left out.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Threading:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Fixed a bug with TMtxForLoop when ResponseTime was set to zero and improved responsivness of the thread pool to just 2us which allows threading of very short sections of code.");
  RichEdit1->Lines->Add("Added new overloads to TMtxForLoop supporting code vectorization within launched threads.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("Polynoms:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Fixed a bug for unsorted linear interpolation.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");


  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v3.52:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  str =	"New and enhanced debugger visualizer allows charting/viewing ";
  str += "of arrays, vectors (TVec/Vector) and matrices (TMtx/Matrix) while debugging.";
  RichEdit1->Lines->Add(str);

  str = "Multiple visualizer windows can remain open concurrently while stepping ";
  str += "through code with F8. Expressions and scripting allow manipulation of debugger data.";
  RichEdit1->Lines->Add(str);

  RichEdit1->Lines->Add("New threaded for-loop component joins simplicity of use with excellent performance. ");
  str = "New super-conductive object cache implementation features linear scaling with ";
  str += "number of threads and enables concurrency of math expressions which can now ";
  str += "be threaded. MtxVec now allows perfect scaling of its code across any number ";
  str += "of cores via TMtxThread.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("Support for Delphi 2010/2011 and integration of debugger visualizers in to the new IDE features.");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v3.5:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  str =	"Debugger visualizer allows charting/viewing of arrays, ";
  str += "vectors (TVec/Vector) and matrices (TMtx/Matrix) while debugging.";
  str += "It is possible to examine huge structures (hundreds of Mbytes) ";
  str += "in real time both for viewing and charting. ";
  str += "Delphi default debugger only shows arrays up to 132 000 elements. ";
  RichEdit1->Lines->Add(str);

  RichEdit1->Lines->Add("New code optimizations and multithreaded functions. ");
  RichEdit1->Lines->Add("Support for SSE4.1 for Intel Core 2 Wolfdale from Intel MKL v10 and IPP v6.");
  RichEdit1->Lines->Add("Substantially updated help file system.");
  RichEdit1->Lines->Add("");  

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("MtxVecTee:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("New TeeChart series TMtxFastLineSeries allows zoom in/out with pixeldownsample enabled internally. Applicable also to the DrawIt method and debugger Visualizer.");
  RichEdit1->Lines->Add("TMtxFastLineSeries is 3x faster than TFastLineSeries when not using pixeldownsample.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Expression parser/scripter:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Function overloading allowed based on parameter count.");
  RichEdit1->Lines->Add("Custom functions can be object methods.");

  RichEdit1->Lines->Add("Vectors and matrices can be accessed by elements a(i) or m(r,c).");
  RichEdit1->Lines->Add("Colon operator allows selection of ranges of rows and colums m(:), m(1,:), v(2:3).");

  RichEdit1->Lines->Add("Assign operator supports colon operator: m(2:3) = 4.");
  RichEdit1->Lines->Add("Colon operator supports step <> 1 and allows: m(10:-1:3) = 4");

  RichEdit1->Lines->Add("Vectors and matrices can return elements from conditions: a = m(m > 4)");
  RichEdit1->Lines->Add("Functions accept strings as parameters and can return string as result.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Optimization:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added several linear programming algorithms, including Dual Simplex, Two Phase Simplex ordinary Simplex LP and Gomory''s Cutting Plane (CPA) algorithms.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("MtxVecTools:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("New TMtxLP component for easy usage of all LP algorithms.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v3:");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Core product:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("New code optimizations and support for Intel Core 2 Duo product familiy.");
  str =  "New multithreaded VML function support. Simple functions like Sin, Cos.. ";
  str += "are threaded when vector length exceeds about 10 000 ";
  str += "elements. No MtxVec code change required to have your code run on multiple cores.";
  RichEdit1->Lines->Add(str);
  str =  "Together with Vector/Matrix classes it is possible to write math expressions in ";
  str += "its natural format and have the code at the same time executed on multiple cores!";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("LAPACK v3.1 delivers increased precision and performance.");
  str = "Reduced distribution size with ""Compact MtxVec"". In case of the Stats Master ";
  str += "by 50 percent. There are now more and more specialized dll's.";
  RichEdit1->Lines->Add(str);
  str =  "Intel MKL 9.1 and Intel IPP 5.2 updated with the Intel v10 C++ ";
  str += "and Fortran compilers.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("Sparse solver: UMFPACK support updated to v5.1.");
  str = "Extensive tests written to interface DUnit test framework. ";
  str+= "Tests execute under .NET and W32 and ensure that code gives the same result.";
  RichEdit1->Lines->Add(str);
  RichEdit1->Lines->Add("Pardiso sparse solver support updated to latest version of MKL.");
  RichEdit1->Lines->Add("New HTML Help 2 format of the help file.");
  RichEdit1->Lines->Add("Support for Delphi 2007 and C++Builder 2007.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Optimization:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Simplex algorithm now supports lower and/or upper bounds for parameters.");
  RichEdit1->Lines->Add("Added Trust Region (TR) algorithm. Now it's possible to find unbounded or bounded minimum of vector function of several variables.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Probabilities:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Added 8 new distributions: Gumbel (minimum), Gumbel (maximum), Erlang, Power, Inverse Gaussian, Fatigue Life, Johnson SB, Johnson UB. Probabilities unit now includes 34 different distributions.");
  RichEdit1->Lines->Add("Moved distribution statistical parameter calculation from Statistics.pas to Probabilities.pas. Basic statistics now includes estimates for distribution mean, variance, skewness and kurtosis.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("MtxVecCPP.h:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Help updated to the new Vector/Matrix syntax.");
  RichEdit1->Lines->Add("World class performance when evaluating Vector/Matrix expressions. Nealy no performance loss in compare to using CreateIt/FreeIt.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("MtxGrid:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("New TMtxVecGrid control (derived from TCustomGrid) allows easy viewing and editing of real or complex vector or matrix. The same control is now used in MtxVecEdit.pas unit. It now allows real-time browsing of matrices with milions and bilions of elements.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("MtxIntDiff:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("New unit introduces several routines for numerical integration (1D, 2D, n-D).");
  RichEdit1->Lines->Add("All numerical gradient estimation routines moved from Optimization.pas unit");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("MtxVecTee:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Many enhancements to the TMtxGridSeries include support for rainbow palette and up to three levels of color mixing with top and bottom clipp-off.");
  RichEdit1->Lines->Add("Updated with support for TeeChart v8.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
//  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("Help:");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;
  RichEdit1->Lines->Add("Help file has received a major upgrade to Html Help 2 format.");
  RichEdit1->Lines->Add("Nearly all examples have been extended with C++ and C# examples.");
  RichEdit1->Lines->Add("Code examples have been updated to relfect the new default syntax with Vector and Matrix objects.");
  RichEdit1->Lines->Add("Html Help 2 format integrates in to the IDE and F1 is again functional across all products.");
  RichEdit1->Lines->Add("");

  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v2.1:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Operator overloading for Delphi 2006 with support for Vectors, Matrices and complex numbers!");
  RichEdit1->Lines->Add("Enhanced support for .NET platform.");
  RichEdit1->Lines->Add("Updated Intel MKL 8.0.1 and IPP 5.0");
  RichEdit1->Lines->Add("New Vectorized expression parser gives you the fastest expression evaluation.");
  RichEdit1->Lines->Add("Fixed a bug for object cache resize.");
  RichEdit1->Lines->Add("Fixed a bug in TPiecePoly when assigning Breaks before Coefficients.");
  RichEdit1->Lines->Add("TMtxComponent has been upgraded with VCL independent FreeNotification system.");
  RichEdit1->Lines->Add("ViewValues editor now comes with MS Office style menus.");
  RichEdit1->Lines->Add("ViewValues editor now correctly copies columns to clipboard.");
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");

  RichEdit1->SelAttributes->Style = RichEdit1->SelAttributes->Style << TFontStyle::fsBold;
  RichEdit1->SelAttributes->Color = (TColor) RGB(51,104,196);
  RichEdit1->SelAttributes->Size = 11;
  RichEdit1->Lines->Add("List of new features in v2.0:");
  RichEdit1->Lines->Add("");
  RichEdit1->Paragraph->FirstIndent = 10;
  RichEdit1->Paragraph->Numbering = nsBullet;

  RichEdit1->Lines->Add("Support for .NET platform. Single source code compiles on .NET and W32.");
  RichEdit1->Lines->Add("Sparse matrices: Umfpack v4.3 and Pardiso solver.");
  RichEdit1->Lines->Add("All C/C++ (umfpack) code compiled with Intel C/C++ compiler with support for SSE2/SSE3.");
  RichEdit1->Lines->Add("All Fortran code compiled with Intel Fortran compiler with support for SSE2/SSE3.");
  RichEdit1->Lines->Add("Sparse solvers for complex sparse matrices.");
  RichEdit1->Lines->Add("New random generators via MKL 7.0");
  RichEdit1->Lines->Add("New FFT engine with support for arbitrary length FFTs including arbitrary 2D FFT sizes) and symmetric multiprocessing.");
  str = "Extensive tests written to interface DUnit test framework. ";
  str+= "Tests execute under .NET and W32 and ensure that code gives the same result.";
  RichEdit1->Lines->Add(str);

  str = "New memory allocation bypassing Delphi memory manager and allowing ";
  str+= "to better exploit available system memory";
  RichEdit1->Lines->Add(str);

  RichEdit1->Lines->Add("Intel SPL calls replaced with Intel IPP 4.0.");
  RichEdit1->Lines->Add("New dll interfaces allow support of C++Builder and Kylix.");
  str = "Common abstract class between for TVec, TMtx ";
  str+= "and TSparseMtx shares common functions. New syntax options allowing much more flexibility ";
  str+= "when exchanging data between TVec, TMtx and TSparseMtx. Only the ""view"" of memory is changed. ";
  str+= "It is possible to write single source code which can take vector ";
  str+= ",matrix and sparse matrix objects as parameters.";
  RichEdit1->Lines->Add(str);

  RichEdit1->Lines->Add("Vastly improved error checking, mostly due to in-depth tests. ");
  RichEdit1->Lines->Add("Prescot CPU support exploiting the features of the new (SSE3) instruction set. ");
  RichEdit1->Lines->Add("Extensive performance optimizations across the entire library.");
  RichEdit1->Lines->Add("Operator overloading under .NET for complex numbers. ");
  str = "It should be possible to write single source code ";
  str+= "that would execute on W32 and .NET with the same ";
  str+= "or very similar performance even for short vectors and small matrices. ";
  RichEdit1->Lines->Add(str);
  RichEdit1->Paragraph->FirstIndent = 0;
  RichEdit1->Paragraph->Numbering = nsNone;
  RichEdit1->Lines->Add("");
}
//---------------------------------------------------------------------------
