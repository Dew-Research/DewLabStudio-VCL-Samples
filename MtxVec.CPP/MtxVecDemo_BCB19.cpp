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
