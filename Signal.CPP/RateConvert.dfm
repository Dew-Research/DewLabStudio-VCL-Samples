object RateConvertForm: TRateConvertForm
  Left = 0
  Top = 0
  Caption = 'RateConvertForm'
  ClientHeight = 658
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 342
    Width = 703
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 32
    ExplicitTop = 333
  end
  object Panel1: TPanel
    Left = 0
    Top = 617
    Width = 703
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      703
      41)
    object Label1: TLabel
      Left = 15
      Top = 15
      Width = 59
      Height = 13
      Caption = 'Rate factor:'
    end
    object Updatebutton: TButton
      Left = 492
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
      Left = 593
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
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 703
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
    TabOrder = 1
  end
  object SignalChart: TSignalChart
    Left = 0
    Top = 345
    Width = 703
    Height = 272
    Legend.CheckBoxes = True
    Title.Text.Strings = (
      'Time signal')
    BottomAxis.Title.Caption = 'Time [s]'
    Zoom.Pen.Color = clBlack
    Align = alBottom
    TabOrder = 2
    Signals = <
      item
        SeriesName = 'ConvertedSignal'
        Series = ConvertedSignal
        Caption = 'Converted signal'
        InputsItemIndex = 0
        Input = SignalStoreBuffer
      end
      item
        SeriesName = 'OriginalSignal'
        Series = OriginalSignal
        Caption = 'Original signal'
        InputsItemIndex = 0
        Input = SignalStoreBuffer1
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TTeeCanvas3D'
    ColorPaletteIndex = 0
    object ConvertedSignal: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Top = 65533
    end
    object OriginalSignal: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 76
    Width = 703
    Height = 266
    Legend.CheckBoxes = True
    MarginBottom = 0
    MarginLeft = 0
    MarginRight = 0
    MarginTop = 0
    Title.Text.Strings = (
      'Frequency spectrum')
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    LeftAxis.Title.Caption = 'Amplitude [dB]'
    Zoom.Pen.Color = clBlack
    Align = alClient
    TabOrder = 3
    Spectrums = <
      item
        SeriesName = 'ConvertedSpectrum'
        Series = ConvertedSpectrum
        Caption = 'ConvertedSpectrum'
        InputsItemIndex = 0
        Input = SpectrumAnalyzer
      end
      item
        SeriesName = 'OriginalSpectrum'
        Series = OriginalSpectrum
        Caption = 'Original spectrum'
        InputsItemIndex = 0
        Input = SpectrumAnalyzer1
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TTeeCanvas3D'
    ColorPaletteIndex = 0
    object ConvertedSpectrum: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object OriginalSpectrum: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object SignalGenerator: TSignalGenerator
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
    Left = 148
    Top = 67
    MtxDataValues = {}
  end
  object SignalGeneratorDialog: TSignalGeneratorDialog
    RegistryPath = '\Software\Dew Research\MtxVec'
    Source = SignalGenerator
    SourceListIndex = 0
    Left = 148
    Top = 109
    MtxDataValues = {}
  end
  object SignalRateConverter: TSignalRateConverter
    SamplingFrequency = 1.000000000000000000
    Input = SignalGenerator
    Ripple = 0.000010000000000000
    Factor = 5.200000000000000000
    TransBW = 0.100000000000000000
    ScaleFactor = 1.000000000000000000
    Left = 184
    Top = 67
    MtxDataValues = {}
  end
  object SignalStoreBuffer: TSignalStoreBuffer
    Length = 0
    SamplingFrequency = 1.000000000000000000
    ActualBufferSize = 0
    IncrementStep = 1.500000000000000000
    Input = SignalRateConverter
    Left = 220
    Top = 67
    MtxDataValues = {}
  end
  object SignalStoreBuffer1: TSignalStoreBuffer
    Length = 0
    SamplingFrequency = 1.000000000000000000
    ActualBufferSize = 0
    IncrementStep = 1.500000000000000000
    Input = SignalGenerator
    Left = 217
    Top = 106
    MtxDataValues = {}
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 32.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 4
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
    Left = 271
    Top = 67
    MtxDataValues = {}
  end
  object SpectrumAnalyzer1: TSpectrumAnalyzer
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 32.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 4
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
    Left = 271
    Top = 106
    MtxDataValues = {}
  end
end
