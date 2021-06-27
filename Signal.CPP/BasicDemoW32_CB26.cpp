//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
//---------------------------------------------------------------------------
USEFORM("OnLineBicoherence.cpp", OnLineBicoherenceForm);
USEFORM("MonitorDemo.cpp", MonitorDemoForm);
USEFORM("MedianDemo.cpp", MedianDemoForm);
USEFORM("Main.cpp", frmMain);
USEFORM("PeakInterpolate.cpp", PeakInterpolateForm);
USEFORM("PeakFiltering.cpp", PeakFilteringForm);
USEFORM("OptimalFilters.cpp", OptimalFiltersForm);
USEFORM("OnLineCoherence.cpp", OnLineCoherenceForm);
USEFORM("IntroPerformance.cpp", IntroPerformanceForm);
USEFORM("IntroPeakSpectral.cpp", IntroPeakSpectralForm);
USEFORM("IntroHigherSpectral.cpp", IntroHigherSpectralForm);
USEFORM("IntroFunctionList.cpp", IntroFunList);
USEFORM("LissajousScope.cpp", LissajousScopeForm);
USEFORM("IntroSpectral.cpp", IntroSpectralForm);
USEFORM("IntroSignal.cpp", IntroSignalForm);
USEFORM("IntroPlayback.cpp", IntroPlaybackForm);
USEFORM("SpcAnalyzer.cpp", SpcAnalyzerForm);
USEFORM("SignalAnalysisDemo.cpp", SignalAnalysisDemoForm);
USEFORM("SavGolayDemo.cpp", SavGolayDemoForm);
USEFORM("RegisterSignal.cpp", RegisterSignalForm);
USEFORM("WindowsDemo.cpp", WindowsDemoForm);
USEFORM("WindowFilters.cpp", WindowFiltersForm);
USEFORM("WhatIsNew.cpp", WhatIsNewForm);
USEFORM("TriggerDemo.cpp", TriggerDemoForm);
USEFORM("PhaseDemo.cpp", PhaseDemoForm);
USEFORM("PeakMarkingOrder.cpp", PeakMarkingOrderForm);
USEFORM("PeakMarkingFormating.cpp", PeakMarkingFormatingForm);
USEFORM("PeakMarkingBasic.cpp", PeakMarkingBasicForm);
USEFORM("RateConvert.cpp", RateConvertForm);
USEFORM("PlaybackDemo.cpp", PlaybackDemoForm);
USEFORM("PhaseShifter.cpp", PhaseShifterForm);
USEFORM("PhaseScope.cpp", PhaseScopeForm);
USEFORM("BrowseDemo.cpp", BrowseDemoForm);
USEFORM("BispectrumTest.cpp", BiSpectrumTestForm);
USEFORM("BispectrumSurface.cpp", BiSpectrumSurfaceForm);
USEFORM("BispectrumColorGrid.cpp", BiSpectrumGridForm);
USEFORM("CoherenceTest2.cpp", CoherenceTest2Form);
USEFORM("CoherenceTest.cpp", CoherenceTestForm);
USEFORM("CepstrumDemo.cpp", CepstrumDemoForm);
USEFORM("BufferUnit.cpp", BufferForm);
USEFORM("Basic2.cpp", BasicForm2);
USEFORM("Basic1.cpp", BasicForm1);
USEFORM("AutoRegressDemo.cpp", AutoRegressDemoForm);
USEFORM("AmpltRatios.cpp", AmpltRatiosForm);
USEFORM("BiSpcAnalyzer.cpp", BiSpcAnalyzerForm);
USEFORM("BicoherenceTest.cpp", BicoherenceTestForm);
USEFORM("Basic3.cpp", BasicForm3);
USEFORM("InterpolateDecimate.cpp", InterpolateDecimateForm);
USEFORM("IirZeros.cpp", IirZerosForm);
USEFORM("IirGroupDelay.cpp", IirGroupDelayForm);
USEFORM("IirFiltering.cpp", IirFilteringForm);
USEFORM("IntroDesign.cpp", IntroDesignForm);
USEFORM("IntroCompList.cpp", IntroCompListForm);
USEFORM("IntroApplication.cpp", IntroApplicationForm);
USEFORM("Intro.cpp", Introduction);
USEFORM("DiscreteSeriesDemo.cpp", DiscreteSeriesDemoForm);
USEFORM("Differentiator.cpp", DifferentiatorForm);
USEFORM("Demodulator.cpp", DemodulatorForm);
USEFORM("CZTDemo.cpp", CZTDemoForm);
USEFORM("GeneratorDemo.cpp", GeneratorDemoForm);
USEFORM("FrequencyBands.cpp", FrequencyBandsForm);
USEFORM("FiltersDemo.cpp", FiltersDemoForm);
USEFORM("EnvelopeDemo.cpp", EnvelopeDemoForm);
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
