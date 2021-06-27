program StatDemoW32_D21;

uses
  Forms,
  Basic_Form in 'Basic_Form.pas' {frmBasic},
  Random_Generator in 'Random_Generator.pas' {frmRandomGen},
  NLin_Tests in 'NLin_Tests.pas' {frmNonLinTest},
  Wizard_MLReg in 'Wizard_MLReg.pas' {frmShowMLRWizard},
  Anova_Tests in 'Anova_Tests.pas' {frmANOVATest},
  NIST_Introduction in 'NIST_Introduction.pas' {frmNISTIntro},
  NormalProbPlot in 'NormalProbPlot.pas' {frmNormalProb},
  QQPlot in 'QQPlot.pas' {frmQQPlot},
  Hypothesis_Test in 'Hypothesis_Test.pas' {frmHypTest},
  Wizard_PCA in 'Wizard_PCA.pas' {frmShowPCAWizard},
  MLR_Editor in 'MLR_Editor.pas' {frmMLREditor},
  ANOVA1_Box in 'ANOVA1_Box.pas' {frmANOVA1Box},
  Main in 'Main.pas' {frmMain},
  Basic_QC in 'Basic_QC.pas' {frmBasicQC},
  QC_XR in 'QC_XR.pas' {frmQCXR},
  QC_CP in 'QC_CP.pas' {frmQCCP},
  QC_Attr in 'QC_Attr.pas' {frmQCAttr},
  List_Func in 'List_Func.pas' {frmListFunc},
  Quick_Start in 'Quick_Start.pas' {frmQuickStart},
  WeibullProbPlot in 'WeibullProbPlot.pas' {frmWeibullProb},
  Basic_Chart in 'Basic_Chart.pas' {frmBasicChart},
  QC_Pareto in 'QC_Pareto.pas' {frmParetoChart},
  Fit_Model in 'Fit_Model.pas' {frmModels},
  LogMemo in 'LogMemo.pas' {frmLogForm},
  EWMA_Demo in 'EWMA_Demo.pas' {frmEWMA},
  LogReg_Demo in 'LogReg_Demo.pas' {frmLogReg},
  GOF_Chi2 in 'GOF_Chi2.pas' {frmGOFChi2},
  Basic_REdit in 'Basic_REdit.pas' {frmBaseRichEdit},
  WhatsNew in 'WhatsNew.pas' {frmWhatsNew},
  Welcome_Stat in 'Welcome_Stat.pas' {frmWelcome},
  Oder_Form in 'Oder_Form.pas' {frmOrder},
  Changes11 in 'Changes11.pas' {frmChanges11},
  Basic_Wizard in 'Basic_Wizard.pas' {frmBasicWizard},
  MLRegWizard in 'MLRegWizard.pas' {frmMulLinRegWiz},
  GOF_KS in 'GOF_KS.pas' {frmGOFKS},
  Changes21 in 'Changes21.pas' {frmChanges21},
  TS_PACF in 'TS_PACF.pas' {frmTSPACF},
  TS_ExpSmooth in 'TS_ExpSmooth.pas' {frmExpSmooth},
  TS_ARIMASim in 'TS_ARIMASim.pas' {frmARIMASim},
  Wizard_ARIMA in 'Wizard_ARIMA.pas' {frmWizardARIMA},
  ARIMAWizard in 'ARIMAWizard.pas' {frmARIMAWizard},
  TS_ARAR in 'TS_ARAR.pas' {frmARAR},
  DecompWizard in 'DecompWizard.pas' {frmDecompositionWizard},
  Wizard_Decomp in 'Wizard_Decomp.pas' {frmDecompDemo},
  QC_Levey in 'QC_Levey.pas' {frmLevey},
  HotellingT2 in 'HotellingT2.pas' {frmHotellingWizard},
  Wizard_Hotelling in 'Wizard_Hotelling.pas' {frmShowHotellingWizard},
  Wizard_MDS in 'Wizard_MDS.pas' {frmShowMDSWizard},
  MDSWizard in 'MDSWizard.pas' {frmMDSWiz},
  Item_Analysis in 'Item_Analysis.pas' {frmItemAnalysis},
  BiPlotDemo in 'BiPlotDemo.pas' {frmBiPlot},
  PCRegWizard in 'PCRegWizard.pas' {frmPCRegWizard},
  Wizard_PCReg in 'Wizard_PCReg.pas' {frmShowPCRegWizard},
  Changes30 in 'Changes30.pas' {frmChanges30},
  RidgeRegWizard in 'RidgeRegWizard.pas' {frmRidgeRegWizard},
  Wizard_RidgeReg in 'Wizard_RidgeReg.pas' {frmShowRidgeReg},
  PCAWizard in 'PCAWizard.pas' {frmPCAWiz},
  MultiStepReg in 'MultiStepReg.pas' {MultiStepRegForm},
  MultiNLin_Tests in 'MultiNLin_Tests.pas' {frmMultiNonLinTest};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Dew Research - Stats Master 6.0 W32  Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
