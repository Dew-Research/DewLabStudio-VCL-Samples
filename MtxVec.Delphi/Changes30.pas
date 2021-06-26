unit Changes30;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Basic3, StdCtrls, ComCtrls;

type
  TfrmChanges30 = class(TBasicForm3)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChanges30: TfrmChanges30;

implementation

{$IFDEF CLR}
  {$R *.NFM}
{$ELSE}
  {$R *.DFM}
{$ENDIF}

procedure TfrmChanges30.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines, RichEdit1 do
  begin
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v6.0.1:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Support for Sydney 10.4.');
    Add('FireMonkey support for iOS and Android without ARC.');
    Add('High speed dlls updated for Intel MKL/IPP/C++ (release 2020 Update 1).');
    Add('Bug fix addressing C++Builder linker when using single precision functions from external dlls.');
    Add('The build tool can now also build packages for OSX64, which uses external linker.');
    Add('Added TMtxVecInt.CountIntRange function');
    Add('Added TVecInt.GroupCountIteration function');
    Add('Added TVecInt.GroupCount function');
    Add('Added TVec.GroupSum function');
    Add('Added TVec.GroupSumIteration function');
    Add('Enhanced TMtxVec.Replace uses IPP version of ReplaceNAN');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Probabilities.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added StudentRangeCDF for Studentized Range cumulative distribution.');
    Add('Added StudentRangeCDFInv for inverse Studentized Range cumulative distribution.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v6.0:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVec.pas, AbstractMtxVec, MtxVecBase, MtxVecUtils,...:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('TVec and TMtx have a new FloatPrecision property which defines run-time floating point precision (single 32bit or double 64bit). ' +
        'Ideally, you can write code once and have it then executed in either double or single precision. Additionally it is possible to use ' +
        'the most suitable precision for math anywhere in the same application.');
    Add('New "Capacity" property for TVec and TMtx. Similar to TStringList.Capacity reduces the need for memory re-allocations up to ' +
        'user specified size. Usefull for multi-threaded algorithms where TVec and TMtx are not from object cache.');
    Add('Most units and routines updated to support user selectable floating point precision at run-time.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v5.4:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVec.pas and MtxVecInt.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added support for Delphi RIO (XE 10.3).');
    Add('Updated to latest version of Intel MKL, Intel IPP (release 2019).');
    Add('Vectorized version for FindIndexes, FindMask and FindAndGather for TVec/TMtx and TVecInt/TMtxInt. Especially ' +
        'when using FindMask, speed improvement of 10x or more is possible when vectorizing if-then clauses.');
    Add('Added example to MtxVec demo: "Vectorizing if-then with masks" to show how to use vectorized FindMask and FindIndexes.');
    Add('Dll API has changed. To prevent version conflicts, the library names have new version number: 6. VC runtime library is no longer needed.');
    Add('MtxVec.Sparse6.dll has been joined in to MtxVec.Lapack6d.dll due to relatively much smaller size.');
    Add('Installer (Build Tool) support for all Delphi platforms.');
    Add('CPU Affinity support added to DoForLoop on Windows.');
    Add('Added new example to MtxVec demo: "Memory channels" exploring options to speed up code that cant be vectorized at all or only partially.');
    Add('Optimization methods can now respond to a "stop" signal when running in its own thread. This can be helpfull, ' +
        'if the optimization process would deadlock or run too long.');
    Add('Added single precision support to Pardiso sparse solver.');
    Add('Added single precision support to Trust-Region optimization method.');
    Add('Various FireMonkey related fixes and refinments.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v5.3:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVec.pas and MtxVecInt.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added support for Apple Acccelerate framework on iOS and macOS. Includes accelerated versions of FFT, BLAS 1,2,3 and Lapack.');
    Add('Support for complex-number Lapack on iOS and OSX for MtxVec Core Edition.');
    Add('Substantial improvement of speed of Math functions: sin, cos, log, exp,.. on Android, ' +
        'iOS and OS X. Math387 now bypasses default Delphi System unit math functions. ' +
        'Vectorized versions use the Accelerate framework on the iOS and OS X. Average speedup is about 20x.');
    Add('Added support for TMtxInt and Matrix to the Debugger Visualizer.');
    Add('Debugger Visualizer bug fix, which helps more variables to be successfully evaluted.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxParseExpr.pas: (scripting)');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added support for [1,2;3,4] for vector/matrix concatenation/initialization.');
    Add('Added support for "if-else", "while" and "for-loop" clauses. ');
    Add('Added support for "break" and "continue" clauses. ');
    Add('Added support for strings and custom objects.');
    Add('Added string grid adaptor, which enables reading and writing from an arbitrary string grid like object.');
    Add('Added support for empty lines and comments.');
    Add('Command line printout can be surpressed by specifying ";" at the end of the line.');
    Add('Further performance optimization for single line and multi-line expression evaluation by about 2x.');
    Add('Expressions are now case-sensitive, but function aliases are allowed (Tan() for tan() for example).');
    Add('Added one new demo for demonstrating the new features of the parser.  ');
    Add('More automated tests have been implemented.');
    Add('All features are available on Windows, macOS, Android and iOS.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v5.2:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVec.pas and MtxVecInt.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added integer matrix (TMtxInt and MatrixInt) covering 108+ overloaded functions ');
    Add('Added TVec.BinarySearch and TMtx.BinarySearch for exact and nearest index on sorted data.');
    Add('Added 80 new optimized functions for integer math used by TVecInt and TMtxInt.');
    Add('Added ThreadIndex parameter to the MtxForLoop threaded function type');
    Add('Support for Rad Studio Tokyo XE 10.2, VCL and FMX');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('MtxParseExpr.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added integer, integer vector, integer matrix, boolean, boolean vector and boolean matrix types. ');
    Add('Support for funtions with multiple results: (a,b,c....) = fun(d)');
    Add('Added all functions from Probabilities.pas to the expression parser.');
    Add('Added large set of functions from MtxVec.pas to the expression parser, like FFT, FFT2D, SVD, etc.. ');
    Add('Total of 300+ functions and operators now available to the expression parser.');
    Add('Fixed a number of defects and improved error reporting. Performance optimization.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    //
    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v5.1.1:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVec.pas and MtxVecInt.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added TVecInt.ThresholdGT_LT.');
    Add('Added ThreshAbsGt and ThreshAbsLt to TVecInt, TVec and TMtx.');
    Add('Added TVecInt.BinarySearch, TVecInt.Find');
    Add('Updated Intel MKL and Intel IPP related code to latest revision.');
    Add('Fixed a problem with MKL VML user side multi-threading. (MtxVec.Vmld.dll)');
    Add('Fix for TMtxComponentList.Count when reducing value. ');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');
    SelAttributes.Style := [fsUnderline];
    Add('MtxVecTee.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Increased color count from 3 to 5. Greatly increased the possibility of possible color combinations palette designs. ');
    Add('Improved support for fixed user-specified scale.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v5.1:');
    Paragraph.FirstIndent := 0;           
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Cross platform support including OS X, iOS and Android.');
    Add('Improved performance of Lapack routines via latest Intel MKL update.');
    Add('Improved performance of math routines via Intel IPP v9 update. ' +
        'Important: MtxVec.Spld5.dll replaced with MtxVec.Dsp5d.dll. ');
    Add('Support for Rad Studio 10.1 Berlin.');
    Add('Added TMtx.Filter2D usefull for 2D convolution of images.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v5.02:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Internal memory access optimization giving performance improvements on both 32bit and 64bit code (on Windows) '+
        'from 10 to 100% depending on algorithm. The greatest improvement can been seen for algorithms using long vectors '+
        'and smallest for algorithms which are using block processing.');
    Add('Certified support for Android. New Chapter added to MtxVec Users Guide about Delphi mobile compiler support.');
    Add('Update to MtxVec demo for FireMonkey to run also on Android tablets.');
    Add('Various performance enhancements affecting automatic reference counting on Delphi mobile compilers.');
    Add('Fixes to debugger visualizer affecting VectorInt and TVecInt. Additional simplifications will keep all visualizers working in more demanding debug cases.');
    Add('Fixed NormL1 and NormL2 functions on 64bit, complex number and single precision.');
    Add('Fixes for TMtx.Eig() on 64bit and single precision.');
    Add('Support for XE8 and related TeeChart updates.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v5.0:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Optional build parameter (MtxVec Core Edition) results in 100% full source code in pascal. (allows for portability to Android, iOS, OSx)');
    Add('Added support for annoynmous methods to TMtxForLoop.');
    Add('New example (MtxVecThreading.pas) with description about efficient multi-threading in MtxVec Users Guide.pdf.');
    Add('Enhanced string formating and automatic column sizing in Debugger Visualizers.');
    Add('Adapted TMtxGridSeries to support latest TeeChart version (released sept. 2014).');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v4.51:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added support for RAD Studio XE7 FireMonkey and VCL.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsUnderline];
    Add('Sparse matrices:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Bug fix for TMtxSparse.Add when dealing with zeros in the sparse matrix.');
    Add('Bug fix for TMtxSparse.Copy when dealing with zero in the sparse matrix.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v4.5:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Update to MKL and IPP. Performance improvements for eigenvalue calculations');
    Add('Added support for RAD Studio XE6 FireMonkey and VCL.');
    Add('Added TMtx.Eig overload with optional condition number estimation.');
    Add('Added generalized eigenvalue method TMtx.EigGen.');
    Add('Added calculation of Schure vectors. TMtx.EigSchure');
    Add('Added calculation of generalized Schure vectors. TMtx.EigSchureGen');
    Add('Updated calculation of eigenvalues for symmetric matrices. TMtx.EigSym');
    Add('Added calculation of generalized eigenvalues for symmetric matrices. TMtx.EigSymGen');
    Add('Updated TMtx.LQRSolve. Least square solutions with support for for rank deficient matrices.');
    Add('Added generalized SVD decomposition. TMtx.SVDGen.');
    Add('Added Gauss Markov Linear Model solver with TMtx.GLMSolve');
    Add('Important: Old TMtx.EigGen has become TMtx.EigSymGen and TMtx.EigGen has new meaning.');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Debugger visualizer:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Fixed debugger visualizer package installation for FireMonkey.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Sparse matrices:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added eigenvalue calculation for symmetric matrices TSparseMtx.EigSym.');
    Add('Added generalized eigenvalue calculation for symmetric matrices TSparseMtx.EigSymGen.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');





    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v4.4:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added BitPack, BitUnpack methods and Bits property to TVecInt.');
    Add('Added help for Median filter functions.');
    Add('Added support for FireMonkey from including XE5 and forward. This covers all UI components, debugger visualizer and demo.');
    Add('Prerelease of MtxVec Core: ability to run MtxVec without dependancy on external dlls. Large parts of StatsMaster and DSP Master are already functional.');
    Add('Optional custom search path for TeeChart added to the BuildTool.');
    Add('Update to IPP dlls and a dll bug fix.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v4.3:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Support for Delphi and C++Builder XE5.');
    Add('Fixed performance issues with debugger visualizers in big applications.');
    Add('Added support for GDI+ Canvas of TeeChart 2013.');
    Add('Concurrent use of double and single precision version of the library in the same unit throug Dew.Double and Dew.Single namespaces. Introduced VectorSingle, VectorDouble and MatrixSingle, MatrixDouble type aliases.');
    Add('Updated debugger visualizers to support concurrent precision use.');
    Add('Added TMtx.LUSolve overload, which makes use of a precomputed factorization.');
    Add('    New set of dlls with support for Intel 4th Generation Core CPUs and Intel Xeon Phi.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v4.22:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Support for Delphi and C++Builder XE4.');
    Add('Support for Steema TeeChart 2013.');
    Add('Cougar Open CL support for VS.NET');
    Add('Several minor bug fixes.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;

    Add('List of new features in v4.21:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Support for Delphi and C++Builder XE3.');
    Add('Cougar Open CL now works with non unicode Delphi versions (2006 and 2007)');
    Add('Cougar Open CL now detects also MtxVec version change and automatically rebuilds Open CL source.');
    Add('Fixed C++ function operator for sVector.');
    Add('Fixed memory allocation for 64bit TMtx, which only allowed 32bit range.');
    Add('Bug fix for complex version of the TMtx.SVD function.');
    Add('Recreated and updated C++ Demo for many C++Builder versions.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;


    Add('List of new features in v4.2:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Introduction of Cougar Open CL parallel reduction based algorithms. ' +
        'Support for sum, norms, average, min, max, dot product, etc... known ' +
        'from MtxVec supported for all precisions and platforms. Parallel reduction ' +
        'allows non-destructive summation process and makes it possible for single ' +
        'precision math to achieve same or higher accuracy than double precision for ' +
        'algorithms relying on summation of long arrays.');
    Add('Performance of Cougar Open CL is now completely invariant to the ' +
        'length of the vector or size of the matrix. The programmer needs not ' +
        'to worry about memory alignment or vector size.');
    Add('Updated help and tested with XE2 Update 4 and TeeChart 2012.');
    Add('Multiple enhancements regarding C++.');
    Add('Updated code related to Intel IPP and MKL libraries to the ' +
        'latest version. Note that the minimum CPU requirement has been ' +
        'raised by Intel to SSE2 capable CPU (P4, released in year 2000). ' +
        'AMD was still selling new CPUs without SSE2 in 2006. This limitation ' +
        'was first introduced by Intel in 2009. MtxVec v4.1 was the last ' +
        'version with the capability to support older CPUs (generic x86 code). ' +
        'The new dlls improve performance mostly for the new generation ' +
        'of CPUs, capable of SSE4.2 and Intel AVX instruction sets. ' +
        'According to Intel these can sometimes reach cca 60%. Old dlls ' +
        'may cause "instruction not recognized" exception on the latest ' +
        'generation of Intel CPUs.');
    Add('Debugger visualizers have been enhanced for Delphi to support '+
        'Open CL vector and matrix types: clVector and clMatrix.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;


    Add('List of new features in v4.1:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Cougar Open CL opens the world of GPU processing to Delphi developers. Two new units clMtxVec and clMtxExpr ' +
        'add two new types clVector and clMatrix which can run their functions on the GPU.');
    Add('Cougar Open CL substantially simplifies custom Open CL algorithm development, integration and deployment.');
    Add('Support for TeeChart 2011.');
    Add('Support for Delphi XE2 and its 64bit compiler.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v4.0:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Multi-precision integer vector math with TVecInt and VectorInt with ' +
        'full support for object cache and math expressions.');
    Add('Support for TeeChart 2010.');
    Add('Updated dlls for latest version of MKL and IPP with support for Intel AVX.');
    Add('Reduced distribution size with FFT core cross-platform fallback code providing FFT ' +
        'functions (1D and 2D) with reasonable performance without external dlls.');
    Add('Reduced distribution size with IPP core cross-platform fallback code providing signal processing ' +
        'functions with reasonable performance without external dlls.');
//    Add(' .');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Visualizers:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Debugger for Delphi 2010 and later supports formated tooltips for Vector/Matrix/TVec/TMtx.');
    Add('TCplx type will display as a + bi on the tooltip and in the evaluator.');
    Add('Fixed a bug for string lists where empty lines were left out.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Threading:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Fixed a bug with TMtxForLoop when ResponseTime was set to zero and ' +
        'improved responsivness of the thread pool to just 2us which allows ' +
        'threading of very short sections of code.');
    Add('Added new overloads to TMtxForLoop supporting code vectorization ' +
        'within launched threads.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Polynoms:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Fixed a bug for unsorted linear interpolation.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v3.52:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New and enhanced debugger visualizer allows charting/viewing of arrays, ' +
        'vectors (TVec/Vector) and matrices (TMtx/Matrix) while debugging. ');
    Add('Multiple visualizer windows can remain open concurrently while stepping through code with F8. ' +
        'Expressions and scripting allow manipulation of debugger data. ');
    Add('New strings and stringlist visualizer. Added support for 2D arrays.' +
        'Docked windows persist between debugging sessions. ');
    Add('New threaded for-loop component joins simplicity of use ' +
        'with excellent performance. ');
    Add('New super-conductive object cache implementation features ' +
        'linear scaling with number of threads and enables concurrency ' +
        'of math expressions which can now be threaded. MtxVec now allows ' +
        'perfect scaling of its code across any number of cores via TMtxThread.');
    Add('Support for Delphi 2010 and integration of debugger visualizers in to the new IDE features.');
//    Add(' .');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v3.5:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Debugger visualizer allows charting/viewing of arrays, ' +
        'vectors (TVec/Vector) and matrices (TMtx/Matrix) while debugging. ' +
        'It is possible to examine huge structures (hundreds of Mbytes) ' +
        'in real time both for viewing and charting. ' +
        'Delphi default debugger only shows arrays up to 132 000 elements. ');
    Add('New code optimizations and multithreaded functions.');
    Add('Support for SSE4.1 for Intel Core 2 Wolfdale from Intel MKL v10 and IPP v6.');
    Add('Substantially updated help file system.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVecTee.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New TeeChart series TMtxFastLineSeries allows zoom in/out with pixeldownsample ' +
        'enabled internally. Applicable also to the DrawIt method and debugger Visualizer.');
    Add('TMtxFastLineSeries is 3x faster than TFastLineSeries when not using pixeldownsample.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsUnderline];
    Add('Expression parser/scripter:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Function overloading allowed based on parameter count.');
    Add('Custom functions can be object methods.');
    Add('Vectors and matrices can be accessed by elements a(i) or m(r,c).');
    Add('Colon operator allows selection of ranges of rows and colums m(:), m(1,:), v(2:3).');
    Add('Assign operator supports colon operator: m(2:3) = 4.');
    Add('Colon operator supports step <> 1 and allows: m(10:-1:3) = 4');
    Add('Vectors and matrices can return elements from conditions: a = m(m > 4)');
    Add('Functions accept strings as parameters and can return string as result.');    
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Optimization.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added several linear programming algorithms, including Dual Simplex, Two Phase Simplex ordinary Simplex LP and Gomory''s Cutting Plane (CPA) algorithms.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVecTools.pas:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New TMtxLP component for easy usage of all LP algorithms.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v3.0.1:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New code optimizations for Intel Penryn, SSE4a.');
    Add('Support for Intel MKL v10.');
    Add('Bug fixes for single precision and Delphi.NET.');
    Add('Improvements to help files (see also links, more examples');
    Add('Installers and recompile tools have been improved to work well on Vista 32 and Vista x64.');
    Add('More in-depth multi-core tested dlls.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Sparse.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Out of core solver support for Pardiso sparse solvers.');
    Add('Better support (more settings) for ill-conditioned sparse matrices for Pardiso.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsBold];
    SelAttributes.Color := RGB(51,104,196);
    SelAttributes.Size := 11;
    Add('List of new features in v3.0:');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Core product:');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New code optimizations and support for Intel Core 2 Duo product familiy.');
    Add('New multithreaded VML function support. Simple functions like Sin, Cos.. ' +
        'are threaded when vector length exceeds about 10 000 elements. No MtxVec code change ' +
        'required to have your code run on multiple cores.');
    Add('Together with Vector/Matrix classes it is possible to write math expressions in its ' +
        'natural format and have the code at the same time executed on multiple cores!');
    Add('LAPACK v3.1 delivers increased precision and performance.');
    Add('Reduced distribution size with "Compact MtxVec". In case of the Stats Master by 50%. '
      + 'There are now more and more specialized dll''s. ');
    Add('Intel MKL 9.1 and Intel IPP 5.2 updated with the Intel v10 C++ and Fortran compilers. ');
    Add('Sparse solver: UMFPACK support updated to v5.1');
    Add('Pardiso sparse solver support updated to latest version of MKL.');
    Add('New HTML Help 2 format of the help file.');
    Add('Support for Delphi 2007 and C++Builder 2007.');
    Add('New set of true color 24x24 and 16x16 icons for components to support ' +
        'newer IDE tool palette.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Optimization.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Simplex algorithm now supports lower and/or upper bounds for parameters.');
    Add('Added Trust Region (TR) algorithm. Now it''s possible to find unbounded '
      + 'or bounded minimum of vector function of several variables.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');


    SelAttributes.Style := [fsUnderline];
    Add('Probabilities.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Added 8 new distributions: Gumbel (minimum), Gumbel (maximum), Erlang, Power, '
      + 'Inverse Gaussian, Fatigue Life, Johnson SB, Johnson UB. Probabilities unit now includes 34 different distributions.');
    Add('Moved distribution statistical parameter calculation from Statistics.pas to Probabilities.pas. Basic '
      + 'statistics now includes estimates for distribution mean, variance, skewness and kurtosis.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxExpr.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('All TVec/TMtx methods are now also available from Vector/Matrix. '
      + 'It is now possible to completely replace TVec/TMtx with Vector/Matrix.');
    Add('Many new functions have been added where previously methods were needed, '
      + 'because Vector and Matrix are now value objects and can return a value.');
    Add('Vector/Matrix syntax is now the default syntax. (Biggest change!) '
      + 'Old style TVec/TMtx code will still compile.');
    Add('Loads of new syntax options and simplifications with support for operator overloading.'
      + 'Vector can passed as a parameter to functions accepting TVec, TMtxVec or double dynamic array as a paramter.');
    Add('World class performance when evaluating Vector/Matrix expressions. ' +
        'Nealy no performance loss in compare to using CreateIt/FreeIt.');
    Add('Help updated to the new Vector/Matrix syntax.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxGrid.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New TMtxVecGrid control (derived from TCustomGrid) allows '
      + 'easy viewing and editing of real or complex vector or matrix. The '
      + 'same control is now used in MtxVecEdit.pas unit. It now allows real-time '
      + 'browsing of matrices with milions and bilions of elements.' );
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxIntDiff.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('New unit introduces several routines for numerical integration (1D, 2D, n-D).');
    Add('All numerical gradient estimation routines moved from Optimization.pas unit.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('MtxVecTee.pas :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Many enhancements to the TMtxGridSeries include support for rainbow palette '
      + 'and up to three levels of color mixing with top and bottom clip-off.' );
    Add('Updated with support for TeeChart v8.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

    SelAttributes.Style := [fsUnderline];
    Add('Help file :');
    Paragraph.FirstIndent := 10;
    Paragraph.Numbering := nsBullet;
    Add('Help file has received a major upgrade to Html Help 2 format.');
    Add('Nearly all examples have been extended with C++ and C# examples.');
    Add('New easier to read and navigate look and feel.');
    Add('Code examples have been updated to relfect the new default ' +
        'syntax with Vector and Matrix objects.');
    Add('Html Help 2 format integrates in to the IDE and F1 is again functional ' +
        'across all products.');
    Add('Demo updated with Vector/Matrix syntax.');
    Paragraph.FirstIndent := 0;
    Paragraph.Numbering := nsNone;
    Add('');

  end;

end;

initialization
  RegisterClass(TfrmChanges30);

end.
