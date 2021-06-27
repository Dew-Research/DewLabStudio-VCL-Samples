//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
//---------------------------------------------------------------------------
USEFORM("QQPlot.cpp", frmQQPlot);
USEFORM("QC_XR.cpp", frmQCXR);
USEFORM("Quick_Start.cpp", frmQuickStart);
USEFORM("Random_Generator.cpp", frmRandomGen);
USEFORM("QC_Pareto.cpp", frmParetoChart);
USEFORM("Order_Form.cpp", frmOrder);
USEFORM("NormalProbPlot.cpp", frmNormalProb);
USEFORM("PCAWizard.cpp", frmPCAWiz);
USEFORM("QC_CP.cpp", frmQCCP);
USEFORM("QC_Attr.cpp", frmQCAttr);
USEFORM("Wizard_ARIMA.cpp", frmWizardARIMA);
USEFORM("WhatsNew.cpp", frmWhatsNew);
USEFORM("Wizard_Decomp.cpp", frmDecompDemo);
USEFORM("Wizard_PCA.cpp", frmShowPCAWizard);
USEFORM("Wizard_MLReg.cpp", frmShowMLRWizard);
USEFORM("Welcome_Stat.cpp", frmWelcome);
USEFORM("TS_ARIMASim.cpp", frmARIMASim);
USEFORM("TS_ARAR.cpp", frmARAR);
USEFORM("TS_ExpSmooth.cpp", frmExpSmooth);
USEFORM("WeibullProbPlot.cpp", frmWeibullProb);
USEFORM("TS_PACF.cpp", frmTSPACF);
USEFORM("NLin_Tests.cpp", frmNonLinTest);
USEFORM("Basic_Wizard.cpp", frmBasicWizard);
USEFORM("Basic_REdit.cpp", frmBaseRichEdit);
USEFORM("Changes11.cpp", frmChanges11);
USEFORM("DecompWizard.cpp", frmDecompositionWizard);
USEFORM("Changes21.cpp", frmChanges21);
USEFORM("Basic_QC.cpp", frmBasicQC);
USEFORM("Anova_Tests.cpp", frmANOVATest);
USEFORM("ANOVA1_Box.cpp", frmANOVA1Box);
USEFORM("ARIMAWizard.cpp", frmARIMAWizard);
USEFORM("Basic_Form.cpp", frmBasic);
USEFORM("Basic_Chart.cpp", frmBasicChart);
USEFORM("EWMA_Demo.cpp", frmEWMA);
USEFORM("Main.cpp", frmMain);
USEFORM("LogReg_Demo.cpp", frmLogReg);
USEFORM("MLRegWizard.cpp", frmMulLinRegWiz);
USEFORM("NIST_Introduction.cpp", frmNISTIntro);
USEFORM("MLR_Editor.cpp", frmMLREditor);
USEFORM("LogMemo.cpp", frmLogForm);
USEFORM("GOF_Chi2.cpp", frmGOFChi2);
USEFORM("Fit_Model.cpp", frmModels);
USEFORM("GOF_KS.cpp", frmGOFKS);
USEFORM("List_Func.cpp", frmListFunc);
USEFORM("Hypothesis_Test.cpp", frmHypTest);
//---------------------------------------------------------------------------
int WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
	try
	{
		Application->Initialize();
		Application->MainFormOnTaskBar = true;
		RegisterClass(__classid(TfrmWelcome));
		RegisterClass(__classid(TfrmWhatsNew));
		RegisterClass(__classid(TfrmListFunc));
		RegisterClass(__classid(TfrmRandomGen));
		RegisterClass(__classid(TfrmModels));
		RegisterClass(__classid(TfrmHypTest));
		RegisterClass(__classid(TfrmGOFChi2));
		RegisterClass(__classid(TfrmGOFKS));
		RegisterClass(__classid(TfrmGOFKS));
		RegisterClass(__classid(TfrmShowPCAWizard));
		RegisterClass(__classid(TfrmANOVA1Box));
		RegisterClass(__classid(TfrmShowMLRWizard));
		RegisterClass(__classid(TfrmMLREditor));
		RegisterClass(__classid(TfrmNonLinTest));
		RegisterClass(__classid(TfrmLogReg));
		RegisterClass(__classid(TfrmNISTIntro));
		RegisterClass(__classid(TfrmANOVATest));
		RegisterClass(__classid(TfrmTSPACF));
		RegisterClass(__classid(TfrmExpSmooth));
		RegisterClass(__classid(TfrmDecompDemo));
		RegisterClass(__classid(TfrmARIMASim));
		RegisterClass(__classid(TfrmWizardARIMA));
		RegisterClass(__classid(TfrmARAR));
		RegisterClass(__classid(TfrmQCXR));
		RegisterClass(__classid(TfrmQCAttr));
		RegisterClass(__classid(TfrmQCCP));
		RegisterClass(__classid(TfrmParetoChart));
		RegisterClass(__classid(TfrmEWMA));
		RegisterClass(__classid(TfrmQQPlot));
		RegisterClass(__classid(TfrmNormalProb));
		RegisterClass(__classid(TfrmWeibullProb));
		RegisterClass(__classid(TfrmChanges21));
		RegisterClass(__classid(TfrmChanges11));
		RegisterClass(__classid(TfrmOrder));
		RegisterClass(__classid(TfrmQuickStart));

		Application->Title = "Stats Master W32 BCB Demo";
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
