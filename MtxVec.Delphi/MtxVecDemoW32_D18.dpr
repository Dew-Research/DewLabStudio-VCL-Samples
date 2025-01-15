program MtxVecDemoW32_D18;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Intro in 'Intro.pas' {Introduction},
  Basic1 in 'Basic1.pas' {BasicForm1},
  Basic2 in 'Basic2.pas' {BasicForm2},
  Basic3 in 'Basic3.pas' {BasicForm3},
  BlockProcessing in 'BlockProcessing.pas' {frmBlockProc},
  CalcSqrtMtx in 'CalcSqrtMtx.pas' {frmSqrtMtx},
  Changes15 in 'Changes15.pas' {frmChanges15},
  Changes101 in 'Changes101.pas' {frmChanges101},
  Changes102 in 'Changes102.pas' {frmChanges102},
  ForLoopUnit in 'ForLoopUnit.pas' {ForLoopForm},
  CopyCompare in 'CopyCompare.pas' {CopyComp},
  DefaultArray in 'DefaultArray.pas' {DefArray},
  DirichletTest in 'DirichletTest.pas' {frmDirichlet},
  EigenVectors1 in 'EigenVectors1.pas' {EigVec1},
  FileHandling1 in 'FileHandling1.pas' {FileH1},
  Find_Form in 'Find_Form.pas' {frmFind},
  Interp1 in 'Interp1.pas' {Interpolating1},
  IntroOpenCL in 'IntroOpenCL.pas' {IntroOpenCLForm},
  IntroFunctionList in 'IntroFunctionList.pas' {IntroFunList},
  IntroMatrices in 'IntroMatrices.pas' {IntroMtx},
  IntroMemoryMan in 'IntroMemoryMan.pas' {IntroMemMan},
  IntroPolynoms in 'IntroPolynoms.pas' {IntroPoly},
  IntroVectors in 'IntroVectors.pas' {IntroVec},
  InverseMtx in 'InverseMtx.pas' {InvMtx},
  List_Func in 'List_Func.pas' {frmListFunc},
  LQR1 in 'LQR1.pas' {LQRDemo},
  MemoryCompare1 in 'MemoryCompare1.pas' {MemComp1},
  MtxGridSeries_Demo in 'MtxGridSeries_Demo.pas' {frmMtxGridSeries},
  MtxOptim in 'MtxOptim.pas' {frmMtxOptim},
  Multiply1 in 'Multiply1.pas' {Mult1},
  ParserDemo in 'ParserDemo.pas' {frmParser},
  PixelDownS in 'PixelDownS.pas' {DownS},
  QRPoly1 in 'QRPoly1.pas' {LQRPoly},
  QuickS in 'QuickS.pas' {QStart},
  RegisterMtxVec in 'RegisterMtxVec.pas' {RegisterM},
  Save_Precision in 'Save_Precision.pas' {frmSavePrec},
  SparseTest in 'SparseTest.pas' {frmSparseTest},
  SysLinear1 in 'SysLinear1.pas' {LinearSystem1},
  YuleLevinson in 'YuleLevinson.pas' {YuleLev},
  FloatEdit1 in 'FloatEdit1.pas' {frmFloatEdit1},
  ProgDialog in 'ProgDialog.pas' {frmProgDialog},
  IntroParser in 'IntroParser.pas' {IntroParserForm},
  IntroWhyMtxVec in 'IntroWhyMtxVec.pas' {IntroWhyMtxVecForm},
  BenchmarkX in 'BenchmarkX.pas' {BenchmarkXForm},
  BenchmarkFramework in 'BenchmarkFramework.pas',
  ParserUsage in 'ParserUsage.pas' {frmParserUsage},
  ParserPerformance in 'ParserPerformance.pas' {frmParserPerformance},
  IntroSparse in 'IntroSparse.pas' {IntroSparseMtx},
  DewProbWrapper in 'DewProbWrapper.pas',
  ProbEditor in 'ProbEditor.pas' {FrameDist: TFrame},
  DewProbCalc in 'DewProbCalc.pas' {frmProbCalc},
  MtxVecGridDemo in 'MtxVecGridDemo.pas' {frmGridDemo},
  Changes30 in 'Changes30.pas' {frmChanges30},
  NumInt1D in 'NumInt1D.pas' {frmInt1D},
  Optim_Bounded in 'Optim_Bounded.pas' {frmOptimBounded},
  Optim_TR in 'Optim_TR.pas' {frmTRDemo},
  DemoHowTo in 'DemoHowTo.pas' {frmDemoHowTo},
  MtxFastLineDemo in 'MtxFastLineDemo.pas' {MtxFastLineForm},
  Optim_LP in 'Optim_LP.pas' {frmLP},
  Scripting in 'Scripting.pas' {ScriptingForm},
  SuperConductive in 'SuperConductive.pas' {SuperConductiveForm},
  ForLoopExample in 'ForLoopExample.pas' {ForLoopExampleForm},
  ClipboardMSOffice in 'ClipboardMSOffice.pas' {MSOffice},
  IntroExport in 'IntroExport.pas' {IntroExpImp},
  clFunction in 'clFunction.pas' {clFunctionForm},
  clCustomFunction in 'clCustomFunction.pas' {clCustomFunctionForm},
  clMultiDeviceFunction in 'clMultiDeviceFunction.pas' {clMultiDeviceFunctionForm},
  MtxVecThreading in 'MtxVecThreading.pas' {MtxVecThreadingForm},
  IfThenUnit in 'IfThenUnit.pas' {IfThenForm},
  NumaUnit in 'NumaUnit.pas' {NumaForm},
  ScriptingGrid in 'ScriptingGrid.pas' {ScriptingGridForm},
  CompoundExpressions in 'CompoundExpressions.pas' {CompoundExpressionsForm};

{$R *.res}

//Enable support for 4GB address space on 64bit OS
//FastMM allows allocating only about 3.5GBytes

const IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  Application.Initialize;
  {$IFDEF CLR}
  Application.Title := 'Dew Research MtxVec 4.3 .NET VCL demo';
  {$ELSE}
  Application.Title := 'Dew Research MtxVec 4.3 W32 demo';
  {$ENDIF}
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
