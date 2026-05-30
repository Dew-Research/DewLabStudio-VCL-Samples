//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
//---------------------------------------------------------------------------
USEFORM("Basic1.cpp", BasicForm1);
USEFORM("Basic2.cpp", BasicForm2);
USEFORM("Basic3.cpp", BasicForm3);
USEFORM("BenchmarkX.cpp", BenchmarkXForm);
USEFORM("BlockProcessing.cpp", frmBlockProc);
USEFORM("CalcSqrtMtx.cpp", frmSqrtMtx);
USEFORM("Changes15.cpp", frmChanges15);
USEFORM("Changes30.cpp", frmChanges30);
USEFORM("clFunction.cpp", clFunctionForm);
USEFORM("ClipboardMSOffice.cpp", MSOffice);
USEFORM("CopyCompare.cpp", CopyComp);
USEFORM("DefaultArray.cpp", DefArray);
USEFORM("DirichletTest.cpp", frmDirichlet);
USEFORM("EigenVectors1.cpp", EigVec1);
USEFORM("FileHandling1.cpp", FileH1);
USEFORM("Find_Form.cpp", frmFind);
USEFORM("FloatEdit1.cpp", frmFloatEdit1);
USEFORM("Interp1.cpp", Interpolating1);
USEFORM("Intro.cpp", Introduction);
USEFORM("IntroExport.cpp", IntroExpImp);
USEFORM("IntroFunctionList.cpp", IntroFunList);
USEFORM("IntroMatrices.cpp", IntroMtx);
USEFORM("IntroMemoryMan.cpp", IntroMemMan);
USEFORM("IntroPolynoms.cpp", IntroPoly);
USEFORM("IntroSparse.cpp", IntroSparseForm);
USEFORM("IntroVectors.cpp", IntroVec);
USEFORM("IntroWhyMtxVec.cpp", IntroWhyMtxVecForm);
USEFORM("InverseMtx.cpp", InvMtx);
USEFORM("List_Func.cpp", frmListFunc);
USEFORM("LQR1.cpp", LQRDemo);
USEFORM("Main.cpp", frmMain);
USEFORM("MemoryCompare1.cpp", MemComp1);
USEFORM("MtxGridSeries_Demo.cpp", frmMtxGridSeries);
USEFORM("MtxOptim.cpp", frmMtxOptim);
USEFORM("Multiply1.cpp", Mult1);
USEFORM("ParserDemo.cpp", frmParser);
USEFORM("PixelDownS.cpp", DownS);
USEFORM("ProbCalc.cpp", Prob1);
USEFORM("ProgDialog.cpp", frmProgDialog);
USEFORM("QRPoly1.cpp", LQRPoly);
USEFORM("QuickS.cpp", QStart);
USEFORM("RegisterMtxVec.cpp", RegisterM);
USEFORM("Save_Precision.cpp", frmSavePrec);
USEFORM("SparseTest.cpp", frmSparseTest);
USEFORM("SysLinear1.cpp", LinearSystem1);
USEFORM("YuleLevinson.cpp", YuleLev);
USEFORM("DemoHowTo.cpp", frmDemoHowTo);
USEFORM("IntroParser.cpp", IntroParserForm);
USEFORM("IntroOpenCL.cpp", IntroOpenCLForm);
USEFORM("MtxFastLineDemo.cpp", MtxFastLineForm);
USEFORM("MtxVecGridDemo.cpp", frmGridDemo);
USEFORM("Changes101.cpp", frmChanges101);
USEFORM("Changes102.cpp", frmChanges102);
USEFORM("ProbEditor.cpp", FrameDist); /* TFrame: DesignClass=TFrame */
USEFORM("DewProbCalc.cpp", frmProbCalc);
USEFORM("ForLoopUnit.cpp", ForLoopForm);
USEFORM("NumaUnit.cpp", NumaForm);
USEFORM("ForLoopExample.cpp", ForLoopExampleForm);
USEFORM("IfThenUnit.cpp", IfThenForm);
USEFORM("MtxVecThreading.cpp", MtxVecThreadingForm);
USEFORM("ParserPerformance.cpp", frmParserPerformance);
USEFORM("Optim_LP.cpp", frmLP);
USEFORM("Optim_Bounded.cpp", frmOptimBounded);
USEFORM("NumInt1D.cpp", frmInt1D);
USEFORM("SmallMatrixMul.cpp", frmSmallMatrix);
USEFORM("Optim_TR.cpp", frmTRDemo);
USEFORM("SuperConductive.cpp", SuperConductiveForm);
USEFORM("clCustomFunction.cpp", clCustomFunctionForm);
USEFORM("clMultiDeviceFunction.cpp", clMultiDeviceFunctionForm);
USEFORM("Scripting.cpp", ScriptingForm);
USEFORM("ParserUsage.cpp", frmParserUsage);
USEFORM("ExprToolTipUnit.cpp", ExprToolTipForm);
USEFORM("ScriptingGrid.cpp", ScriptingGridForm);
USEFORM("CompoundExpressions.cpp", CompoundExpressionsForm);
//---------------------------------------------------------------------------
int WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
	try
	{
		Application->Initialize();
		Application->MainFormOnTaskBar = true;

		RegisterClass(__classid(TIntroWhyMtxVecForm));
		RegisterClass(__classid(TIntroduction));
		RegisterClass(__classid(TIntroExpImp));
		RegisterClass(__classid(TIntroFunList));
		RegisterClass(__classid(TIntroMtx));
		RegisterClass(__classid(TIntroMemMan));
		RegisterClass(__classid(TIntroPoly));
		RegisterClass(__classid(TIntroSparseForm));
		RegisterClass(__classid(TIntroVec));

		RegisterClass(__classid(TBenchmarkXForm));
		RegisterClass(__classid(TfrmBlockProc));
		RegisterClass(__classid(TfrmSqrtMtx));
		RegisterClass(__classid(TfrmChanges30));
		RegisterClass(__classid(TMSOffice));
		RegisterClass(__classid(TCopyComp));
		RegisterClass(__classid(TDefArray));
		RegisterClass(__classid(TfrmDirichlet));
		RegisterClass(__classid(TEigVec1));
		RegisterClass(__classid(TFileH1));
		RegisterClass(__classid(TfrmFind));
		RegisterClass(__classid(TfrmFloatEdit1));
		RegisterClass(__classid(TInterpolating1));

		RegisterClass(__classid(TDownS));
		RegisterClass(__classid(TInvMtx));
		RegisterClass(__classid(TfrmListFunc));
		RegisterClass(__classid(TLQRDemo));
		RegisterClass(__classid(TMemComp1));
		RegisterClass(__classid(TfrmMtxGridSeries));
		RegisterClass(__classid(TfrmMtxOptim));
		RegisterClass(__classid(TMult1));
		RegisterClass(__classid(TfrmParser));

		RegisterClass(__classid(TProb1));
		RegisterClass(__classid(TfrmProgDialog));

//		Application->CreateForm(__classid(TfrmMtxOptim), &frmMtxOptim);
//		Application->CreateForm(__classid(TfrmProgDialog), &frmProgDialog);

		RegisterClass(__classid(TLQRPoly));
		RegisterClass(__classid(TQStart));

		RegisterClass(__classid(TRegisterM));
		RegisterClass(__classid(TfrmSavePrec));
		RegisterClass(__classid(TfrmSparseTest));
		RegisterClass(__classid(TLinearSystem1));
		RegisterClass(__classid(TYuleLev));
		RegisterClass(__classid(TfrmChanges15));
		RegisterClass(__classid(TclFunctionForm));

		// Phase 4 BCB parity back-port additions (matches D37 VCL InitTreeItems).
		RegisterClass(__classid(TfrmDemoHowTo));
		RegisterClass(__classid(TIntroParserForm));
		RegisterClass(__classid(TIntroOpenCLForm));
		RegisterClass(__classid(TMtxFastLineForm));
		RegisterClass(__classid(TfrmGridDemo));
		RegisterClass(__classid(TfrmChanges101));
		RegisterClass(__classid(TfrmChanges102));
		RegisterClass(__classid(TfrmProbCalc));
		RegisterClass(__classid(TForLoopForm));
		RegisterClass(__classid(TNumaForm));
		RegisterClass(__classid(TForLoopExampleForm));
		RegisterClass(__classid(TIfThenForm));
		RegisterClass(__classid(TMtxVecThreadingForm));
		RegisterClass(__classid(TfrmParserPerformance));
		RegisterClass(__classid(TfrmLP));
		RegisterClass(__classid(TfrmOptimBounded));
		RegisterClass(__classid(TfrmInt1D));
		RegisterClass(__classid(TfrmSmallMatrix));
		RegisterClass(__classid(TfrmTRDemo));
		RegisterClass(__classid(TSuperConductiveForm));
		RegisterClass(__classid(TclCustomFunctionForm));
		RegisterClass(__classid(TclMultiDeviceFunctionForm));
		RegisterClass(__classid(TScriptingForm));
		RegisterClass(__classid(TfrmParserUsage));
		RegisterClass(__classid(TScriptingGridForm));
		RegisterClass(__classid(TCompoundExpressionsForm));

		Application->Title = "MtxVec C++ Builder demo";
		Application->CreateForm(__classid(TfrmMain), &frmMain);
		Application->Run();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	catch (...)
	{
		try
		{
			throw Exception("");
		}
		catch (Exception &exception)
		{
			Application->ShowException(&exception);
		}
	}
	return 0;
}
//---------------------------------------------------------------------------
