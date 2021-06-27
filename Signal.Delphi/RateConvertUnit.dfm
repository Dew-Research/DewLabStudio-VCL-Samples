object RateConvertForm: TRateConvertForm
  Left = 202
  Top = 112
  Caption = 'Rate converter test'
  ClientHeight = 622
  ClientWidth = 925
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 306
    Width = 925
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object SignalChart: TSignalChart
    Left = 0
    Top = 309
    Width = 925
    Height = 272
    Legend.CheckBoxes = True
    Title.Text.Strings = (
      'Time signal')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.Title.Caption = 'Time [s]'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 1145.000000000000000000
    LeftAxis.MaximumOffset = 1
    LeftAxis.Minimum = 810.000000000000000000
    LeftAxis.MinimumOffset = 1
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alBottom
    TabOrder = 0
    Signals = <
      item
        SeriesName = 'ConvertedSignal'
        Series = ConvertedSignal
        Caption = 'Converted signal'
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SignalStoreBuffer
      end
      item
        SeriesName = 'OriginalSignal'
        Series = OriginalSignal
        Caption = 'Original signal'
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SignalStoreBuffer1
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object ConvertedSignal: TFastLineSeries
      HoverElement = []
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Left = 152
      Top = 21
    end
    object OriginalSignal: TFastLineSeries
      HoverElement = []
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Left = 104
      Top = 24
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 581
    Width = 925
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      925
      41)
    object Label1: TLabel
      Left = 15
      Top = 15
      Width = 59
      Height = 13
      Caption = 'Rate factor:'
    end
    object Updatebutton: TButton
      Left = 714
      Top = 9
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Update'
      TabOrder = 0
      OnClick = UpdatebuttonClick
    end
    object RateFactorEdit: TMtxFloatEdit
      Left = 80
      Top = 12
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.05'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '0.40'
      OnChange = RateFactorEditChange
    end
    object ResetButton: TButton
      Left = 815
      Top = 9
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Reset'
      TabOrder = 2
      OnClick = ResetButtonClick
    end
    object Button1: TButton
      Left = 222
      Top = 9
      Width = 118
      Height = 25
      Caption = 'Signal generator'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 358
      Top = 9
      Width = 118
      Height = 25
      Caption = 'Benchmark'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 76
    Width = 925
    Height = 230
    Legend.CheckBoxes = True
    MarginBottom = 0
    MarginLeft = 0
    MarginRight = 0
    MarginTop = 0
    Title.Text.Strings = (
      'Frequency spectrum')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.170000000000006400
    DepthAxis.Minimum = -0.829999999999990300
    DepthTopAxis.Automatic = False
    DepthTopAxis.AutomaticMaximum = False
    DepthTopAxis.AutomaticMinimum = False
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.170000000000006400
    DepthTopAxis.Minimum = -0.829999999999990300
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 474.337500000000100000
    LeftAxis.MaximumOffset = 1
    LeftAxis.MinimumOffset = 1
    LeftAxis.Title.Caption = 'Amplitude [dB]'
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    TabOrder = 2
    Spectrums = <
      item
        SeriesName = 'ConvertedSpectrum'
        Series = ConvertedSpectrum
        Caption = 'ConvertedSpectrum'
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SpectrumAnalyzer
      end
      item
        SeriesName = 'OriginalSpectrum'
        Series = OriginalSpectrum
        Caption = 'Original spectrum'
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SpectrumAnalyzer1
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object ConvertedSpectrum: TFastLineSeries
      HoverElement = []
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Left = 64
      Top = 24
    end
    object OriginalSpectrum: TFastLineSeries
      HoverElement = []
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Left = 24
      Top = 24
    end
  end
  object RichEdit: TRichEdit
    Left = 0
    Top = 0
    Width = 925
    Height = 76
    Align = alTop
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object SignalRateConverter: TSignalRateConverter
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    Input = SignalGenerator
    Ripple = 0.000010000000000000
    Factor = 1.250000000000000000
    TransBW = 0.100000000000000000
    ScaleFactor = 1.000000000000000000
    Left = 192
    Top = 87
    MtxDataValues = {}
  end
  object SignalStoreBuffer: TSignalStoreBuffer
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 0
    SamplingFrequency = 1.000000000000000000
    ActualBufferSize = 0
    IncrementStep = 1.500000000000000000
    Input = SignalRateConverter
    Left = 285
    Top = 84
    MtxDataValues = {}
  end
  object SignalGenerator: TSignalGenerator
    IsDouble = False
    FloatPrecision = mvSingle
    OnParameterUpdate = SignalGeneratorParameterUpdate
    Length = 1024
    SamplingFrequency = 100.000000000000000000
    Inputs = <
      item
      end>
    Sounds.Templates.Strings = (
      'Tones'
      'Noise')
    Sounds.Templates.StreamBinaryData = {
      C801000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000005000000000100000E000000000000001440000000
      0000000000000000000000104000000000000000000000000000000000000000
      000000000000000000000000000100000000000000000000000000000100000E
      000000000000002A400000000000000000000000000000004000000000000000
      0000000000000000000000000000000000000000000000000001000000000000
      0000000000000000010111000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000100000E0000000000008046
      4000000000000000000000000000000840000000000000000000000000000000
      0000000000000000000000000000000000010000000000000000000000000000
      0101110000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000009800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000001000000000100050E
      0000000000000000000000000000000840000000000000084000000000000000
      0000000000000000000000000000000000000000000000000001000000000000
      0000000000000000}
    Sounds.TemplateIndex = 0
    Left = 96
    Top = 81
    MtxDataValues = {}
  end
  object SignalStoreBuffer1: TSignalStoreBuffer
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 0
    SamplingFrequency = 1.000000000000000000
    ActualBufferSize = 0
    IncrementStep = 1.500000000000000000
    Input = SignalGenerator
    Left = 279
    Top = 141
    MtxDataValues = {}
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 16.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 8
    Report.ReportItems.GeneralInfo = False
    Report.ReportItems.MarkedPeaks = False
    Report.ReportItems.FrequencyLines = False
    Report.ReportItems.Phase = False
    Report.ReportItems.THD = False
    Report.ReportItems.THDN = False
    Report.ReportItems.NF = False
    Report.ReportItems.SFDR = False
    Report.ReportItems.BandsRMS = False
    Report.ReportItems.SINAD = False
    Report.ReportItems.RMS = False
    Report.ReportItems.SNR = False
    Report.ReportItems.DateTime = False
    Peaks.Interpolation.RecursiveHarmonics = rhNone
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    Logarithmic = True
    LogSpan = ls200
    ScaleFactor = 1.000000000000000000
    Input = SignalStoreBuffer
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    DCDump = False
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 100.000000000000000000
    Window = wtKaiser
    Left = 387
    Top = 87
    MtxDataValues = {}
  end
  object SpectrumAnalyzer1: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 16.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 8
    Report.ReportItems.GeneralInfo = False
    Report.ReportItems.MarkedPeaks = False
    Report.ReportItems.FrequencyLines = False
    Report.ReportItems.Phase = False
    Report.ReportItems.THD = False
    Report.ReportItems.THDN = False
    Report.ReportItems.NF = False
    Report.ReportItems.SFDR = False
    Report.ReportItems.BandsRMS = False
    Report.ReportItems.SINAD = False
    Report.ReportItems.RMS = False
    Report.ReportItems.SNR = False
    Report.ReportItems.DateTime = False
    Peaks.Interpolation.RecursiveHarmonics = rhNone
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    Logarithmic = True
    LogSpan = ls200
    ScaleFactor = 1.000000000000000000
    Input = SignalStoreBuffer1
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    DCDump = False
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 100.000000000000000000
    Window = wtKaiser
    Left = 384
    Top = 141
    MtxDataValues = {}
  end
  object SignalGeneratorDialog: TSignalGeneratorDialog
    RegistryPath = '\Software\Dew Research\MtxVec'
    Source = SignalGenerator
    SourceListIndex = 0
    Left = 96
    Top = 153
    MtxDataValues = {}
  end
  object ChartEditor1: TChartEditor
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 504
    Top = 192
  end
end
