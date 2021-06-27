object BufferForm: TBufferForm
  Left = 430
  Top = 161
  Caption = 'Buffer test'
  ClientHeight = 704
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 139
    Width = 678
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 430
    Width = 678
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 432
  end
  object SignalChart1: TSignalChart
    Left = 0
    Top = 142
    Width = 678
    Height = 288
    Legend.Visible = False
    Title.Text.Strings = (
      'Signal generator chart')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.EndPosition = 100.000000000000000000
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 985.000000000000000000
    LeftAxis.MaximumOffset = 1
    LeftAxis.Minimum = 417.500000000000000000
    LeftAxis.MinimumOffset = 1
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    TabOrder = 0
    Signals = <
      item
        SeriesName = 'Series1'
        Series = Series1
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SignalGenerator
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series1: TFastLineSeries
      HoverElement = []
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 550
    Width = 678
    Height = 154
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      678
      154)
    object BufferSizeLabel: TLabel
      Left = 15
      Top = 54
      Width = 52
      Height = 13
      Caption = 'Buffer size:'
    end
    object UnreadBufferDataLabel: TLabel
      Left = 15
      Top = 100
      Width = 69
      Height = 13
      Caption = 'Unread Buffer:'
    end
    object Label3: TLabel
      Left = 158
      Top = 12
      Width = 86
      Height = 13
      Caption = 'Output buffer size:'
    end
    object SignalUpdateLabel: TLabel
      Left = 400
      Top = 9
      Width = 166
      Height = 13
      Caption = 'Signal generator has been updated'
    end
    object ReadCursorLabel: TLabel
      Left = 194
      Top = 87
      Width = 61
      Height = 13
      Caption = 'Read cursor:'
    end
    object DataReadLabel: TLabel
      Left = 194
      Top = 66
      Width = 54
      Height = 13
      Caption = 'Stream OK:'
    end
    object WriteCursorLabel: TLabel
      Left = 194
      Top = 105
      Width = 60
      Height = 13
      Caption = 'Write cursor:'
    end
    object InputBufferSizeLabel: TLabel
      Left = 15
      Top = 77
      Width = 78
      Height = 13
      Caption = 'Input buffer size:'
    end
    object StoreBufferLabel: TLabel
      Left = 15
      Top = 123
      Width = 58
      Height = 13
      Caption = 'Store buffer:'
    end
    object Label1: TLabel
      Left = 12
      Top = 15
      Width = 78
      Height = 13
      Caption = 'Input buffer size:'
    end
    object ButtonUpdate: TButton
      Left = 563
      Top = 122
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Update'
      TabOrder = 0
      OnClick = ButtonUpdateClick
    end
    object BufferSizeEdit: TMtxFloatEdit
      Left = 260
      Top = 9
      Width = 75
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '500'
      OnChange = BufferSizeEditChange
    end
    object InputBufferEdit: TMtxFloatEdit
      Left = 102
      Top = 9
      Width = 47
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 2
      Value = '500'
      OnChange = InputBufferEditChange
    end
    object ResetButton: TButton
      Left = 563
      Top = 86
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Reset'
      TabOrder = 3
      OnClick = ResetButtonClick
    end
  end
  object SpectrumChart1: TSpectrumChart
    Left = 0
    Top = 0
    Width = 678
    Height = 139
    Legend.Visible = False
    Title.Text.Strings = (
      'TSpectrumChart')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.EndPosition = 100.000000000000000000
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 895.000000000000000000
    LeftAxis.MaximumOffset = 1
    LeftAxis.Minimum = 340.000000000000000000
    LeftAxis.MinimumOffset = 1
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Pen.Mode = pmNotXor
    Align = alTop
    TabOrder = 2
    Spectrums = <
      item
        SeriesName = 'Series2'
        Series = Series2
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SpectrumAnalyzer1
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series2: TFastLineSeries
      HoverElement = []
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object SignalChart2: TSignalChart
    Left = 0
    Top = 433
    Width = 678
    Height = 117
    Legend.Visible = False
    Title.Text.Strings = (
      'Signal buffer chart')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.EndPosition = 100.000000000000000000
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 677.500000000000000000
    LeftAxis.MaximumOffset = 1
    LeftAxis.Minimum = 180.000000000000000000
    LeftAxis.MinimumOffset = 1
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alBottom
    TabOrder = 3
    Signals = <
      item
        SeriesName = 'FastLineSeries1'
        Series = FastLineSeries1
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SignalBuffer
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object FastLineSeries1: TFastLineSeries
      HoverElement = []
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object SignalBuffer: TSignalBuffer
    IsDouble = False
    FloatPrecision = mvSingle
    OnAfterUpdate = SignalBufferAfterUpdate
    OnBeforeUpdate = SignalBufferBeforeUpdate
    Length = 500
    SamplingFrequency = 1.000000000000000000
    IncrementStep = 1.000000000000000000
    Input = SignalGenerator
    Left = 209
    Top = 102
    MtxDataValues = {}
  end
  object SignalGenerator: TSignalGenerator
    IsDouble = False
    FloatPrecision = mvSingle
    OnAfterUpdate = SignalGeneratorAfterUpdate
    Length = 900
    SamplingFrequency = 40.000000000000000000
    Inputs = <
      item
      end>
    Sounds.Templates.Strings = (
      'Template 1'
      'Template 2')
    Sounds.Templates.StreamBinaryData = {
      9800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000001000000000100000E005839B4C876BEF33F000000
      0000000000CDCCCCCCCCCC004000000000000000000000000000000000000000
      0000000000000000000000000001000000000000000000000000000098000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000001000000000100000E00000000000000084000000000000000
      00CDCCCCCCCCCC00400000000000000000000000000000000000000000000000
      000000000000000000010000000000000000000000000000}
    Sounds.TemplateIndex = 0
    Left = 134
    Top = 102
    MtxDataValues = {}
  end
  object SignalStoreBuffer: TSignalStoreBuffer
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 0
    SamplingFrequency = 1.000000000000000000
    ActualBufferSize = 0
    IncrementStep = 1.500000000000000000
    Input = SignalBuffer
    Left = 304
    Top = 105
    MtxDataValues = {}
  end
  object SpectrumAnalyzer1: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 8.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 16
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
    SidelobeAtt = 90.000000000000000000
    Window = wtKaiser
    Left = 392
    Top = 108
    MtxDataValues = {}
  end
  object SpectrumAnalyzer2: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 128.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
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
    ScaleFactor = 1.000000000000000000
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 40.000000000000000000
    Left = 489
    Top = 111
    MtxDataValues = {}
  end
end
