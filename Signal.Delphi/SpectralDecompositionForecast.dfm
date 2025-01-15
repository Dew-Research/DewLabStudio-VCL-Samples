object SpectralDecomposition: TSpectralDecomposition
  Left = 0
  Top = 0
  Caption = 'Spectral decomposition forecasting'
  ClientHeight = 477
  ClientWidth = 695
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
    Top = 271
    Width = 695
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 244
    ExplicitWidth = 684
  end
  object SpectrumChart1: TSpectrumChart
    Left = 0
    Top = 76
    Width = 695
    Height = 195
    Legend.Visible = False
    Title.Text.Strings = (
      'Frequency spectrum')
    BottomAxis.LabelsSeparation = 0
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
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
    LeftAxis.Grid.Visible = False
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 729.000000000000000000
    LeftAxis.MaximumOffset = 1
    LeftAxis.Minimum = -30.375000000000000000
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
    Zoom.Animated = True
    Zoom.Brush.Gradient.Direction = gdFromTopLeft
    Zoom.Brush.Gradient.EndColor = clSilver
    Zoom.Brush.Gradient.MidColor = clWhite
    Zoom.Brush.Gradient.StartColor = clSilver
    Zoom.History = True
    Zoom.Pen.Color = 4194368
    Zoom.Pen.Mode = pmNotXor
    Align = alTop
    TabOrder = 0
    Spectrums = <
      item
        SeriesName = 'Series1'
        Series = Series1
        InputsItemIndex = -1
        UnitScaleXAxis = 1.000000000000000000
        Input = SpectrumAnalyzer1
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    OnAfterMarkPeak = SpectrumChart1AfterMarkPeak
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TMtxFastLineSeries
      Depth = 0
      LinePen.Color = 10708548
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TPointSeries
      Marks.Transparent = True
      Marks.Arrow.Visible = False
      Marks.Callout.Arrow.Visible = False
      Marks.Callout.Length = 10
      SeriesColor = clRed
      ClickableLine = False
      Pointer.Brush.Gradient.EndColor = clRed
      Pointer.Gradient.EndColor = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object ChartTool1: TSpectrumMarkTool
      CursorActive = True
      MarkSeries = Series3
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
    object ChartTool2: TAxisScaleTool
      UpperMargin = 20
      LowerMargin = 5
      AxisScaleMode = amPeakHold
      DataIsSpectrum = True
      AxisID = 2
    end
  end
  object SignalChart1: TSignalChart
    Left = 0
    Top = 274
    Width = 695
    Height = 162
    Legend.CheckBoxes = True
    Legend.TextStyle = ltsPlain
    Title.Text.Strings = (
      'Time series')
    BottomAxis.Grid.Visible = False
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
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
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Grid.Visible = False
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 242.500000000000000000
    LeftAxis.MaximumOffset = 1
    LeftAxis.Minimum = 0.499999999999985100
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
    Zoom.Brush.Gradient.Direction = gdFromTopLeft
    Zoom.Brush.Gradient.EndColor = clSilver
    Zoom.Brush.Gradient.MidColor = clWhite
    Zoom.Brush.Gradient.StartColor = clSilver
    Zoom.History = True
    Zoom.Pen.Color = 4194368
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    TabOrder = 1
    Signals = <
      item
        SeriesName = 'Series2'
        Series = Series2
        InputsItemIndex = -1
        UnitScaleXAxis = 1.000000000000000000
        Input = SignalRead1
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = ''
    ColorPaletteIndex = 13
    object Series2: TFastLineSeries
      SeriesColor = 8404992
      Title = 'Original'
      LinePen.Color = 8404992
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TMtxFastLineSeries
      Depth = 0
      SeriesColor = clRed
      Title = 'Forecasted'
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object UpperLimit: TLineSeries
      SeriesColor = clGreen
      Title = '95% UpperLimit'
      Brush.BackColor = clDefault
      LinePen.Color = clGreen
      LinePen.Style = psDot
      Pointer.Brush.Gradient.EndColor = clGreen
      Pointer.Gradient.EndColor = clGreen
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      TreatNulls = tnIgnore
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object LowerLimit: TLineSeries
      SeriesColor = clGreen
      Title = '95% LowerLimit'
      Brush.BackColor = clDefault
      LinePen.Color = clGreen
      LinePen.Style = psDot
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      TreatNulls = tnIgnore
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object ChartTool3: TAxisScaleTool
      UpperMargin = 0
      LowerMargin = 0
      AxisScaleMode = amPeakHold
      DataIsSpectrum = False
      AxisID = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 436
    Width = 695
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 129
      Top = 15
      Width = 60
      Height = 13
      Caption = 'File position:'
    end
    object Button3: TButton
      Left = 12
      Top = 9
      Width = 97
      Height = 25
      Caption = 'Edit spectrum'
      TabOrder = 0
      OnClick = Button3Click
    end
    object FilePositionEdit: TMtxFloatEdit
      Left = 195
      Top = 12
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '10'
      MaxValue = '100000'
      MinValue = '0'
      TabOrder = 1
      Value = '0'
      OnChange = FilePositionEditChange
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 695
    Height = 76
    Align = alTop
    BevelInner = bvNone
    BevelOuter = bvNone
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
  object SpectrumAnalyzer1: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 64.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 2
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
    Peaks.TraceMethod = ptCurrent
    Peaks.TraceInterval = 5.000000000000000000
    Peaks.LargestRatio = 1000000000000000.000000000000000000
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    OnPeaksUpdate = SpectrumAnalyzer1PeaksUpdate
    ScaleFactor = 1.000000000000000000
    Input = SignalRead1
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
    Left = 234
    Top = 93
    MtxDataValues = {}
  end
  object SignalRead1: TSignalRead
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 512
    SamplingFrequency = 4666.666666666667000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 144
    Top = 93
    MtxDataValues = {}
  end
  object ChartEditor1: TChartEditor
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 318
    Top = 93
  end
  object SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\Dew Research\MtxVec'
    Source = SpectrumAnalyzer1
    SourceListIndex = 0
    Left = 411
    Top = 93
    MtxDataValues = {}
  end
  object TeeGDIPlus1: TTeeGDIPlus
    Antialias = False
    AntiAliasText = gpfNormal
    TeePanel = SignalChart1
    Left = 424
    Top = 402
  end
  object TeeGDIPlus2: TTeeGDIPlus
    Active = True
    Antialias = False
    AntiAliasText = gpfNormal
    TeePanel = SpectrumChart1
    Left = 512
    Top = 212
  end
end
