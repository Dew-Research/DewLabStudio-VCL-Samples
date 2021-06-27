//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
//---------------------------------------------------------------------------
USEFORM("AmpltRatios.cpp", AmpltRatiosForm);
USEFORM("AutoRegressDemo.cpp", AutoRegressDemoForm);
USEFORM("Basic1.cpp", BasicForm1);
USEFORM("Basic2.cpp", BasicForm2);
USEFORM("Basic3.cpp", BasicForm3);
USEFORM("BicoherenceTest.cpp", BicoherenceTestForm);
USEFORM("BiSpcAnalyzer.cpp", BiSpcAnalyzerForm);
USEFORM("BispectrumColorGrid.cpp", BiSpectrumGridForm);
USEFORM("BispectrumSurface.cpp", BiSpectrumSurfaceForm);
USEFORM("BispectrumTest.cpp", BiSpectrumTestForm);
USEFORM("BrowseDemo.cpp", BrowseDemoForm);
USEFORM("BufferUnit.cpp", BufferForm);
USEFORM("CepstrumDemo.cpp", CepstrumDemoForm);
USEFORM("CoherenceTest.cpp", CoherenceTestForm);
USEFORM("CoherenceTest2.cpp", CoherenceTest2Form);
USEFORM("CZTDemo.cpp", CZTDemoForm);
USEFORM("Demodulator.cpp", DemodulatorForm);
USEFORM("Differentiator.cpp", DifferentiatorForm);
USEFORM("DiscreteSeriesDemo.cpp", DiscreteSeriesDemoForm);
USEFORM("EnvelopeDemo.cpp", EnvelopeDemoForm);
USEFORM("FiltersDemo.cpp", FiltersDemoForm);
USEFORM("FrequencyBands.cpp", FrequencyBandsForm);
USEFORM("GeneratorDemo.cpp", GeneratorDemoForm);
USEFORM("IirFiltering.cpp", IirFilteringForm);
USEFORM("IirGroupDelay.cpp", IirGroupDelayForm);
USEFORM("IirZeros.cpp", IirZerosForm);
USEFORM("InterpolateDecimate.cpp", InterpolateDecimateForm);
USEFORM("Intro.cpp", Introduction);
USEFORM("IntroApplication.cpp", IntroApplicationForm);
USEFORM("IntroCompList.cpp", IntroCompListForm);
USEFORM("IntroDesign.cpp", IntroDesignForm);
USEFORM("IntroFunctionList.cpp", IntroFunList);
USEFORM("IntroHigherSpectral.cpp", IntroHigherSpectralForm);
USEFORM("IntroPeakSpectral.cpp", IntroPeakSpectralForm);
USEFORM("IntroPerformance.cpp", IntroPerformanceForm);
USEFORM("IntroPlayback.cpp", IntroPlaybackForm);
USEFORM("IntroSignal.cpp", IntroSignalForm);
USEFORM("IntroSpectral.cpp", IntroSpectralForm);
USEFORM("LissajousScope.cpp", LissajousScopeForm);
USEFORM("Main.cpp", frmMain);
USEFORM("MedianDemo.cpp", MedianDemoForm);
USEFORM("MonitorDemo.cpp", MonitorDemoForm);
USEFORM("OnLineBicoherence.cpp", OnLineBicoherenceForm);
USEFORM("OnLineCoherence.cpp", OnLineCoherenceForm);
USEFORM("OptimalFilters.cpp", OptimalFiltersForm);
USEFORM("PeakFiltering.cpp", PeakFilteringForm);
USEFORM("PeakInterpolate.cpp", PeakInterpolateForm);
USEFORM("PeakMarkingBasic.cpp", PeakMarkingBasicForm);
USEFORM("PeakMarkingFormating.cpp", PeakMarkingFormatingForm);
USEFORM("PeakMarkingOrder.cpp", PeakMarkingOrderForm);
USEFORM("PhaseDemo.cpp", PhaseDemoForm);
USEFORM("PhaseScope.cpp", PhaseScopeForm);
USEFORM("PhaseShifter.cpp", PhaseShifterForm);
USEFORM("PlaybackDemo.cpp", PlaybackDemoForm);
USEFORM("RateConvert.cpp", RateConvertForm);
USEFORM("RegisterSignal.cpp", RegisterSignalForm);
USEFORM("SavGolayDemo.cpp", SavGolayDemoForm);
USEFORM("SignalAnalysisDemo.cpp", SignalAnalysisDemoForm);
USEFORM("SpcAnalyzer.cpp", SpcAnalyzerForm);
USEFORM("TriggerDemo.cpp", TriggerDemoForm);
USEFORM("WhatIsNew.cpp", WhatIsNewForm);
USEFORM("WindowFilters.cpp", WindowFiltersForm);
USEFORM("WindowsDemo.cpp", WindowsDemoForm);
//---------------------------------------------------------------------------
int WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
	try
	{
		Application->Initialize();
		Application->MainFormOnTaskBar = true;

		RegisterClass(__classid(TIntroduction));
		RegisterClass(__classid(TWhatIsNewForm));
		RegisterClass(__classid(TAutoRegressDemoForm));
		RegisterClass(__classid(TWindowsDemoForm));
		RegisterClass(__classid(TIntroSpectralForm));
		RegisterClass(__classid(TCZTDemoForm));
		RegisterClass(__classid(TFrequencyBandsForm));
		RegisterClass(__classid(TCoherenceTestForm));
		RegisterClass(__classid(TBrowseDemoForm));
		RegisterClass(__classid(TCepstrumDemoForm));
		RegisterClass(__classid(TIntroPeakSpectralForm));
		RegisterClass(__classid(TPeakMarkingBasicForm));
		RegisterClass(__classid(TPeakMarkingFormatingForm));
		RegisterClass(__classid(TPeakFilteringForm));
		RegisterClass(__classid(TPeakInterpolateForm));
		RegisterClass(__classid(TPeakMarkingOrderForm));
		RegisterClass(__classid(TAmpltRatiosForm));
		RegisterClass(__classid(TIntroHigherSpectralForm));
		RegisterClass(__classid(TBiSpectrumTestForm));
		RegisterClass(__classid(TBiSpectrumSurfaceForm));
		RegisterClass(__classid(TBiSpectrumGridForm));
		RegisterClass(__classid(TBicoherenceTestForm));
		RegisterClass(__classid(TIntroSignalForm));
		RegisterClass(__classid(TWindowFiltersForm));
		RegisterClass(__classid(TOptimalFiltersForm));
		RegisterClass(__classid(TIirFilteringForm));
		RegisterClass(__classid(TIirZerosForm));
		RegisterClass(__classid(TIirGroupDelayForm));
		RegisterClass(__classid(TDemodulatorForm));
		RegisterClass(__classid(TEnvelopeDemoForm));
		RegisterClass(__classid(TDifferentiatorForm));
		RegisterClass(__classid(TPhaseShifterForm));
		RegisterClass(__classid(TSavGolayDemoForm));
		RegisterClass(__classid(TMedianDemoForm));
		RegisterClass(__classid(TInterpolateDecimateForm));
		RegisterClass(__classid(TGeneratorDemoForm));
		RegisterClass(__classid(TDiscreteSeriesDemoForm));
		RegisterClass(__classid(TPhaseDemoForm));
		RegisterClass(__classid(TFiltersDemoForm));
		RegisterClass(__classid(TSignalAnalysisDemoForm));
		RegisterClass(__classid(TRateConvertForm));
		RegisterClass(__classid(TBufferForm));
		RegisterClass(__classid(TIntroPlaybackForm));
		RegisterClass(__classid(TPlaybackDemoForm));
		RegisterClass(__classid(TMonitorDemoForm));
		RegisterClass(__classid(TTriggerDemoForm));
		RegisterClass(__classid(TOnLineCoherenceForm));
		RegisterClass(__classid(TOnLineBicoherenceForm));
		RegisterClass(__classid(TPhaseScopeForm));
		RegisterClass(__classid(TLissajousScopeForm));
		RegisterClass(__classid(TIntroApplicationForm));
		RegisterClass(__classid(TSpcAnalyzerForm));
		RegisterClass(__classid(TCoherenceTest2Form));
		RegisterClass(__classid(TBiSpcAnalyzerForm));
		RegisterClass(__classid(TIntroDesignForm));
		RegisterClass(__classid(TIntroPerformanceForm));
		RegisterClass(__classid(TIntroFunList));
		RegisterClass(__classid(TIntroCompListForm));
		RegisterClass(__classid(TRegisterSignalForm));

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
