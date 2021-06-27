object PlaybackDemoForm: TPlaybackDemoForm
  Left = 0
  Top = 0
  Caption = 'PlaybackDemoForm'
  ClientHeight = 488
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 449
    Width = 591
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 318
      Top = 15
      Width = 80
      Height = 13
      Caption = 'Monitor channel:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 241
      Height = 25
      Align = alNone
      ButtonHeight = 29
      ButtonWidth = 79
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object SpectrumEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '         Edit       '
        DropdownMenu = PopupMenu1
        ImageIndex = 0
        Style = tbsDropDown
      end
      object ToolButton1: TToolButton
        Left = 94
        Top = 0
        Caption = 'Open file'
        ImageIndex = 2
        OnClick = ToolButton1Click
      end
    end
    object ChannelBox: TComboBox
      Left = 404
      Top = 9
      Width = 53
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        'Left'
        'Right')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 591
    Height = 373
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 1
      Top = 127
      Width = 589
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart: TSpectrumChart
      Left = 1
      Top = 1
      Width = 589
      Height = 126
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Frequency spectrum')
      BottomAxis.LabelsSeparation = 0
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.MinorTicks.Visible = False
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'Frequency [Hz]'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 1737.170000000001000000
      LeftAxis.Minimum = -55.298750000000020000
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
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      Spectrums = <
        item
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = SpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TTeeCanvas3D'
      PrintMargins = (
        15
        43
        15
        43)
      ColorPaletteIndex = 0
      object Series1: TFastLineSeries
        HoverElement = []
        SeriesColor = 10485760
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TPointSeries
        HoverElement = [heCurrent]
        Marks.Transparent = True
        Marks.Visible = True
        Marks.Arrow.Visible = False
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
        SeriesColor = clGreen
        ClickableLine = False
        Pointer.Brush.Color = clRed
        Pointer.Brush.Gradient.EndColor = clGreen
        Pointer.Gradient.EndColor = clGreen
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object ChartTool1: TAxisScaleTool
        UpperMargin = 20
        LowerMargin = 5
        AxisScaleMode = amPeakHold
        DataIsSpectrum = True
        AxisID = 2
      end
      object ChartTool2: TSpectrumMarkTool
        CursorActive = True
        MarkSeries = Series2
        DoubleClickClear = True
        Series = Series1
        PeakFilterMode = False
        MarkMode = mmSingle
        MarkType = mtAmplt
        AmpltFormat = '0.00#'
        PhaseFormat = '0.00#'
        FreqFormat = '0.00#'
        LabelHeaders = True
        PeakZoomBand = False
        ConfLabels = cnfNone
      end
    end
    object SignalChart1: TSignalChart
      Left = 1
      Top = 130
      Width = 589
      Height = 242
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Time signal')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'Time [s]'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 922.500000000000000000
      LeftAxis.Minimum = 197.500000000000000000
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
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Signals = <
        item
          SeriesName = 'Series3'
          Series = Series3
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = Signal1
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series3: TFastLineSeries
        HoverElement = []
        SeriesColor = 10485760
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 591
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
    TabOrder = 2
    Zoom = 100
  end
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
  object ChartEditor2: TChartEditor
    Chart = SignalChart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 486
    Top = 228
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.wav'
    Filter = 'Uncompressed PCM wav|*.wav'
    Left = 480
    Top = 108
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 129
    object Spectrum1: TMenuItem
      Caption = 'Spectrum...'
      OnClick = Spectrum1Click
    end
    object Playback1: TMenuItem
      Caption = 'Playback...'
      OnClick = Playback1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Chart1: TMenuItem
      Caption = 'Spectrum chart...'
      OnClick = Chart1Click
    end
    object imechart1: TMenuItem
      Caption = 'Time chart...'
      OnClick = imechart1Click
    end
  end
  object Signal1: TSignal
    IsDouble = True
    FloatPrecision = mvDouble
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 123
    MtxDataValues = {}
  end
  object SignalOut1: TSignalOut
    IsDouble = True
    FloatPrecision = mvDouble
    SamplingFrequency = 22050.000000000000000000
    MonitorAggressiveness = 0
    ScaleFactor = 1.000000000000000000
    BufferSize = 30000
    Input = SignalRead1
    Left = 326
    Top = 123
    MtxDataValues = {}
  end
  object SignalOutDialog: TSignalOutDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SignalOut1
    SourceListIndex = 0
    Left = 326
    Top = 87
    MtxDataValues = {}
  end
  object SignalRead1: TSignalRead
    IsDouble = True
    FloatPrecision = mvDouble
    SamplingFrequency = 1.000000000000000000
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 282
    Top = 123
    MtxDataValues = {}
  end
  object SignalTimer1: TSignalTimer
    Enabled = True
    Interval = 100
    Frequency = 10.000000000000000000
    OnTimer = SignalTimer1Timer
    Left = 374
    Top = 87
    MtxDataValues = {}
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = True
    FloatPrecision = mvDouble
    OnParameterUpdate = SpectrumAnalyzerParameterUpdate
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
    Input = Signal1
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 40.000000000000000000
    Window = wtHanning
    Left = 422
    Top = 120
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 422
    Top = 84
    MtxDataValues = {}
  end
end
