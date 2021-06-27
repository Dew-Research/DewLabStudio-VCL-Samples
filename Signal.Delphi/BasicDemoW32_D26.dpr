program BasicDemoW32_D26;



uses
  Forms,
  Intro in 'Intro.pas' {Introduction},
  Basic2 in 'Basic2.pas' {BasicForm2},
  Basic1 in 'Basic1.pas' {BasicForm1},
  Basic3 in 'Basic3.pas' {BasicForm3},
  IntroPeakSpectral in 'IntroPeakSpectral.pas' {IntroPeakSpectralForm},
  IntroDesign in 'IntroDesign.pas' {IntroDesignForm},
  RegisterSignal in 'RegisterSignal.pas' {RegisterSignalForm},
  PhaseShifter in 'PhaseShifter.pas' {PhaseShifterForm},
  PeakMarkingFormating in 'PeakMarkingFormating.pas' {PeakMarkingFormatingForm},
  PeakFiltering in 'PeakFiltering.pas' {PeakFilteringForm},
  GeneratorDemo in 'GeneratorDemo.pas' {GeneratorDemoForm},
  OnLineBicoherence in 'OnLineBicoherence.pas' {OnLineBicoherenceForm},
  BispectrumSurface in 'BispectrumSurface.pas' {BiSpectrumSurfaceForm},
  BispectrumColorGrid in 'BispectrumColorGrid.pas' {BiSpectrumGridForm},
  IntroHigherSpectral in 'IntroHigherSpectral.pas' {IntroHigherSpectralForm},
  AutoregressDemo in 'AutoregressDemo.pas' {AutoRegressDemoForm},
  OnLineCoherence in 'OnLineCoherence.pas' {OnLineCoherenceForm},
  IirZeros in 'IirZeros.pas' {IirZerosForm},
  IntroFunctionList in 'IntroFunctionList.pas' {IntroFunList},
  IntroUnderConstr in 'IntroUnderConstr.pas' {IntroUnderConstrForm},
  IntroCompList in 'IntroCompList.pas' {IntroCompListForm},
  IntroPerformance in 'IntroPerformance.pas' {IntroPerformanceForm},
  WindowsDemo in 'WindowsDemo.pas' {WindowsDemoForm},
  CZTDemo in 'CZTDemo.pas' {CZTDemoForm},
  CepstrumDemo in 'CepstrumDemo.pas' {CepstrumDemoForm},
  WindowFilters in 'WindowFilters.pas' {WindowFiltersForm},
  PlaybackDemo in 'PlaybackDemo.pas' {PlaybackDemoForm},
  SavGolayDemo in 'SavGolayDemo.pas' {SavGolayDemoForm},
  OptimalFilters in 'OptimalFilters.pas' {OptimalFiltersForm},
  Differentiator in 'Differentiator.pas' {DifferentiatorForm},
  PhaseDemo in 'PhaseDemo.pas' {PhaseDemoForm},
  IntroSpectral in 'IntroSpectral.pas' {IntroSpectralForm},
  TriggerDemo in 'TriggerDemo.pas' {TriggerDemoForm},
  BrowseDemo in 'BrowseDemo.pas' {BrowseDemoForm},
  AmpltRatios in 'AmpltRatios.pas' {AmpltRatiosForm},
  LissajousScope in 'LissajousScope.pas' {LissajousScopeForm},
  VarResample in 'VarResample.pas' {VarResampleForm},
  InterpolateDecimate in 'InterpolateDecimate.pas' {InterpolateDecimateForm},
  PeakMarkingOrder in 'PeakMarkingOrder.pas' {PeakMarkingOrderForm},
  IirGroupDelay in 'IirGroupDelay.pas' {IirGroupDelayForm},
  CoherenceTest2 in 'CoherenceTest2.pas' {CoherenceTest2Form},
  BicoherenceTest in 'BicoherenceTest.pas' {BicoherenceTestForm},
  BiSpcAnalyzer in 'BiSpcAnalyzer.pas' {BiSpcAnalyzerForm},
  MonitorDemo in 'MonitorDemo.pas' {MonitorDemoForm},
  PhaseScope in 'PhaseScope.pas' {PhaseScopeForm},
  FrequencyBands in 'FrequencyBands.pas' {FrequencyBandsForm},
  IirFiltering in 'IirFiltering.pas' {IirFilteringForm},
  FiltersDemo in 'FiltersDemo.pas' {FiltersDemoForm},
  SignalAnalysisDemo in 'SignalAnalysisDemo.pas' {SignalAnalysisDemoForm},
  DiscreteSeriesDemo in 'DiscreteSeriesDemo.pas' {DiscreteSeriesDemoForm},
  NarrowBandpass in 'NarrowBandpass.pas' {NarrowBandpassForm},
  VariableRateConverter in 'VariableRateConverter.pas' {VariableRateConverterForm},
  CoherenceTest in 'CoherenceTest.pas' {CoherenceTestForm},
  PeakMarkingBasic in 'PeakMarkingBasic.pas' {PeakMarkingBasicForm},
  BispectrumTest in 'BispectrumTest.pas' {BiSpectrumTestForm},
  IntroPlayback in 'IntroPlayback.pas' {IntroPlaybackForm},
  MedianDemo in 'MedianDemo.pas' {MedianDemoForm},
  IntroApplication in 'IntroApplication.pas' {IntroApplicationForm},
  SpcAnalyzer in 'SpcAnalyzer.pas' {SpcAnalyzerForm},
  WhatIsNew in 'WhatIsNew.pas' {WhatIsNewForm},
  Main in 'Main.pas' {frmMain},
  RateConvertUnit in 'RateConvertUnit.pas' {RateConvertForm},
  BufferUnit in 'BufferUnit.pas' {BufferForm},
  Demodulator in 'Demodulator.pas' {DemodulatorForm},
  FractionalFiltering in 'FractionalFiltering.pas' {FractionalFilteringForm},
  IntroSignalRate in 'IntroSignalRate.pas' {IntroSignalRateForm},
  IntroKalman in 'IntroKalman.pas' {IntroKalmanForm},
  PeakInterpolate in 'PeakInterpolate.pas' {PeakInterpolateForm},
  SpectrogramDemo in 'SpectrogramDemo.pas' {SpectrogramDemoForm},
  AsioPlaybackUnit in 'AsioPlaybackUnit.pas' {AsioPlaybackForm},
  AsioRecordUnit in 'AsioRecordUnit.pas' {AsioRecordForm},
  PinkNoise in 'PinkNoise.pas' {PinkNoiseForm},
  IntroSignalGeneration in 'IntroSignalGeneration.pas' {IntroSignalGenerationForm},
  IntroSignal in 'IntroSignal.pas' {IntroSignalForm},
  NoiseGenerator in 'NoiseGenerator.pas' {NoiseGeneratorForm},
  SpectralDecompositionForecast in 'SpectralDecompositionForecast.pas' {SpectralDecomposition},
  KalmanDemo2 in 'KalmanDemo2.pas' {KalmanFilterForm2},
  KalmanDemo3 in 'KalmanDemo3.pas' {KalmanFilterForm3},
  BasicKalman in 'BasicKalman.pas' {BasicKalmanForm},
  Modulator in 'Modulator.pas' {ModulatorForm},
  EnvelopeDemo in 'EnvelopeDemo.pas' {EnvelopeDemoForm},
  IntroASIO in 'IntroASIO.pas' {IntroASIOForm},
  IntroWasapi in 'IntroWasapi.pas' {IntroWASAPIForm},
  AudioCoreDemo in 'AudioCoreDemo.pas' {AudioCoreDemoForm};

{$R *.RES}

//Enable support for 4GB address space on 64bit OS
//FastMM allows allocating only about 3.5GBytes

const IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  Application.Initialize;
  Application.Title := 'Dew Research  - DSP Master v6 ' + {$IFDEF CPUX64} 'Win64' {$ELSE} 'Win32' {$ENDIF};
  Application.HelpFile := '';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
