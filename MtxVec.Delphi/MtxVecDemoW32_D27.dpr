program MtxVecDemoW32_D27;

uses
  Vcl.Forms,
  Basic1 in 'Basic1.pas' {BasicForm1},
  Basic2 in 'Basic2.pas' {BasicForm2},
  Basic3 in 'Basic3.pas' {BasicForm3},
  BenchmarkFramework in 'BenchmarkFramework.pas',
  BenchmarkResults in 'BenchmarkResults.pas',
  BenchmarkX in 'BenchmarkX.pas' {BenchmarkXForm},
  BlockProcessing in 'BlockProcessing.pas' {frmBlockProc},
  CalcSqrtMtx in 'CalcSqrtMtx.pas' {frmSqrtMtx},
  Changes15 in 'Changes15.pas' {frmChanges15},
  Changes30 in 'Changes30.pas' {frmChanges30},
  Changes101 in 'Changes101.pas' {frmChanges101},
  Changes102 in 'Changes102.pas' {frmChanges102},
  clCustomFunction in 'clCustomFunction.pas' {clCustomFunctionForm},
  clFunction in 'clFunction.pas' {clFunctionForm},
  ClipboardMSOffice in 'ClipboardMSOffice.pas' {MSOffice},
  clMultiDeviceFunction in 'clMultiDeviceFunction.pas' {clMultiDeviceFunctionForm},
  CopyCompare in 'CopyCompare.pas' {CopyComp},
  DefaultArray in 'DefaultArray.pas' {DefArray},
  DemoHowTo in 'DemoHowTo.pas' {frmDemoHowTo},
  DewProbCalc in 'DewProbCalc.pas',
  DewProbWrapper in 'DewProbWrapper.pas',
  DirichletTest in 'DirichletTest.pas' {frmDirichlet},
  EigenVectors1 in 'EigenVectors1.pas' {EigVec1},
  FileHandling1 in 'FileHandling1.pas' {FileH1},
  Find_Form in 'Find_Form.pas' {frmFind},
  FloatEdit1 in 'FloatEdit1.pas' {frmFloatEdit1},
  ForLoopExample in 'ForLoopExample.pas' {ForLoopExampleForm},
  ForLoopUnit in 'ForLoopUnit.pas' {ForLoopForm},
  Interp1 in 'Interp1.pas' {Interpolating1},
  Intro in 'Intro.pas' {Introduction},
  IntroExport in 'IntroExport.pas' {IntroExpImp},
  IntroFunctionList in 'IntroFunctionList.pas' {IntroFunList},
  IntroMatrices in 'IntroMatrices.pas' {IntroMtx},
  IntroMemoryMan in 'IntroMemoryMan.pas' {IntroMemMan},
  IntroOpenCL in 'IntroOpenCL.pas' {IntroOpenCLForm},
  IntroParser in 'IntroParser.pas' {IntroParserForm},
  IntroPolynoms in 'IntroPolynoms.pas' {IntroPoly},
  IntroSparse in 'IntroSparse.pas' {IntroSparseMtx},
  IntroVectors in 'IntroVectors.pas' {IntroVec},
  IntroWhyMtxVec in 'IntroWhyMtxVec.pas' {IntroWhyMtxVecForm},
  InverseMtx in 'InverseMtx.pas' {InvMtx},
  List_Func in 'List_Func.pas' {frmListFunc},
  LQR1 in 'LQR1.pas' {LQRDemo},
  Main in 'Main.pas' {frmMain},
  MemoryCompare1 in 'MemoryCompare1.pas' {MemComp1},
  MtxFastLineDemo in 'MtxFastLineDemo.pas' {MtxFastLineForm},
  MtxGridSeries_Demo in 'MtxGridSeries_Demo.pas' {frmMtxGridSeries},
  MtxOptim in 'MtxOptim.pas' {frmMtxOptim},
  Multiply1 in 'Multiply1.pas' {Mult1},
  NumInt1D in 'NumInt1D.pas' {frmInt1D},
  Optim_Bounded in 'Optim_Bounded.pas' {frmOptimBounded},
  Optim_LP in 'Optim_LP.pas' {frmLP},
  Optim_TR in 'Optim_TR.pas' {frmTRDemo},
  ParserDemo in 'ParserDemo.pas' {frmParser},
  ParserPerformance in 'ParserPerformance.pas' {frmParserPerformance},
  ParserUsage in 'ParserUsage.pas' {frmParserUsage},
  PersistentStreamer in 'PersistentStreamer.pas',
  PixelDownS in 'PixelDownS.pas' {DownS},
  ProbCalc in 'ProbCalc.pas' {Prob1},
  ProbEditor in 'ProbEditor.pas' {FrameDist: TFrame},
  ProgDialog in 'ProgDialog.pas' {frmProgDialog},
  QRPoly1 in 'QRPoly1.pas' {LQRPoly},
  QuickS in 'QuickS.pas' {QStart},
  RegisterMtxVec in 'RegisterMtxVec.pas' {RegisterM},
  Save_Precision in 'Save_Precision.pas' {frmSavePrec},
  Scripting in 'Scripting.pas' {ScriptingForm},
  SparseTest in 'SparseTest.pas' {frmSparseTest},
  SuperConductive in 'SuperConductive.pas' {SuperConductiveForm},
  SysLinear1 in 'SysLinear1.pas' {LinearSystem1},
  YuleLevinson in 'YuleLevinson.pas' {YuleLev},
  MtxVecGridDemo in 'MtxVecGridDemo.pas' {frmGridDemo},
  MtxVecThreading in 'MtxVecThreading.pas' {MtxVecThreadingForm},
  ScriptingGrid in 'ScriptingGrid.pas' {ScriptingGridForm},
  IfThenUnit in 'IfThenUnit.pas' {IfThenForm},
  NumaUnit in 'NumaUnit.pas' {NumaForm},
  CompoundExpressions in 'CompoundExpressions.pas' {CompoundExpressionsForm},
  SmallMatrixMul in 'SmallMatrixMul.pas' {frmSmallMatrix};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Dew Lab Studio for Delphi - MtxVec demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
