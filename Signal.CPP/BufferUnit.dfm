object BufferForm: TBufferForm
  Left = 0
  Top = 0
  Caption = 'BufferForm'
  ClientHeight = 482
  ClientWidth = 608
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
    Top = 105
    Width = 608
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -78
    ExplicitTop = 139
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 325
    Width = 608
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = -78
    ExplicitTop = 437
  end
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 608
    Height = 154
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      608
      154)
    object BufferSizeLabel: TLabel
      Left = 15
      Top = 54
      Width = 55
      Height = 13
      Caption = 'Buffer size:'
    end
    object UnreadBufferDataLabel: TLabel
      Left = 15
      Top = 100
      Width = 72
      Height = 13
      Caption = 'Unread Buffer:'
    end
    object Label3: TLabel
      Left = 158
      Top = 12
      Width = 92
      Height = 13
      Caption = 'Output buffer size:'
    end
    object SignalUpdateLabel: TLabel
      Left = 400
      Top = 9
      Width = 169
      Height = 13
      Caption = 'Signal generator has been updated'
    end
    object ReadCursorLabel: TLabel
      Left = 194
      Top = 87
      Width = 62
      Height = 13
      Caption = 'Read cursor:'
    end
    object DataReadLabel: TLabel
      Left = 194
      Top = 66
      Width = 55
      Height = 13
      Caption = 'Stream OK:'
    end
    object WriteCursorLabel: TLabel
      Left = 194
      Top = 105
      Width = 63
      Height = 13
      Caption = 'Write cursor:'
    end
    object InputBufferSizeLabel: TLabel
      Left = 15
      Top = 77
      Width = 84
      Height = 13
      Caption = 'Input buffer size:'
    end
    object StoreBufferLabel: TLabel
      Left = 15
      Top = 123
      Width = 63
      Height = 13
      Caption = 'Store buffer:'
    end
    object Label1: TLabel
      Left = 12
      Top = 15
      Width = 84
      Height = 13
      Caption = 'Input buffer size:'
    end
    object ButtonUpdate: TButton
      Left = 485
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
      Left = 485
      Top = 86
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Reset'
      TabOrder = 3
      OnClick = ResetButtonClick
    end
  end
  object SignalChart1: TSignalChart
    Left = 0
    Top = 108
    Width = 608
    Height = 100
    Legend.Visible = False
    Title.Text.Strings = (
      'Signal generator chart')
    Zoom.Pen.Color = clBlack
    Align = alClient
    TabOrder = 1
    Signals = <
      item
        SeriesName = 'Series1'
        Series = Series1
        InputsItemIndex = 0
        Input = SignalGenerator
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TTeeCanvas3D'
    ColorPaletteIndex = 0
    object Series1: TFastLineSeries
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
  end
  object SignalChart2: TSignalChart
    Left = 0
    Top = 208
    Width = 608
    Height = 117
    Legend.Visible = False
    Title.Text.Strings = (
      'Signal buffer chart')
    Zoom.Pen.Color = clBlack
    Align = alBottom
    TabOrder = 2
    Signals = <
      item
        SeriesName = 'FastLineSeries1'
        Series = FastLineSeries1
        InputsItemIndex = 0
        Input = SignalBuffer
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TTeeCanvas3D'
    ColorPaletteIndex = 0
    object FastLineSeries1: TFastLineSeries
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
  end
  object SpectrumChart1: TSpectrumChart
    Left = 0
    Top = 0
    Width = 608
    Height = 105
    Legend.Visible = False
    Title.Text.Strings = (
      'TSpectrumChart')
    Align = alTop
    TabOrder = 3
    Spectrums = <
      item
        SeriesName = 'Series2'
        Series = Series2
        InputsItemIndex = 0
        Input = SpectrumAnalyzer1
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TTeeCanvas3D'
    ColorPaletteIndex = 0
    object Series2: TFastLineSeries
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
  end
  object SignalBuffer: TSignalBuffer
    OnAfterUpdate = SignalBufferAfterUpdate
    OnBeforeUpdate = SignalBufferBeforeUpdate
    Length = 500
    SamplingFrequency = 1.000000000000000000
    IncrementStep = 1.000000000000000000
    Input = SignalGenerator
    Left = 266
    Top = 102
    MtxDataValues = {}
  end
  object SignalGenerator: TSignalGenerator
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
    Left = 218
    Top = 102
    MtxDataValues = {}
  end
  object SignalStoreBuffer: TSignalStoreBuffer
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
    Left = 350
    Top = 108
    MtxDataValues = {}
  end
  object SpectrumAnalyzer2: TSpectrumAnalyzer
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
    Left = 432
    Top = 111
    MtxDataValues = {}
  end
end
