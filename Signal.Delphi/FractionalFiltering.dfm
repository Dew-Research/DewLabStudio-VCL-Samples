object FractionalFilteringForm: TFractionalFilteringForm
  Left = 527
  Top = 235
  Caption = 'FractionalFilteringForm'
  ClientHeight = 426
  ClientWidth = 967
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 967
    Height = 94
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
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 387
    Width = 967
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 439
      Top = 15
      Width = 77
      Height = 13
      Caption = 'Fractional delay:'
    end
    object FilterDelayLabel: TLabel
      Left = 690
      Top = 15
      Width = 55
      Height = 13
      Caption = 'Total delay:'
    end
    object Label1: TLabel
      Left = 248
      Top = 15
      Width = 25
      Height = 13
      Caption = 'Filter:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 228
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 82
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object SpectrumEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '    Spectrum      '
        ImageIndex = 0
        OnClick = SpectrumEditButtonClick
      end
      object ChartEditButton: TToolButton
        Left = 82
        Top = 0
        AllowAllUp = True
        Caption = 'Spectrum chart'
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
    end
    object FractionalEdit: TMtxFloatEdit
      Left = 522
      Top = 9
      Width = 55
      Height = 22
      Hint = 'Defines fractional part of the delay'
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.01'
      MaxValue = '1'
      MinValue = '0'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = '0.50'
      OnChange = FractionalEditChange
    end
    object FractionalFilterBox: TComboBox
      Left = 279
      Top = 9
      Width = 118
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = FractionalFilterBoxChange
      Items.Strings = (
        'Type 1, 160dB'
        'Type 2, 140dB'
        'Type 3, 140dB'
        'Type 4, 100dB'
        'Type 5, 60dB'
        'Type 6, 50dB'
        'Type 7, 50dB')
    end
    object LogBox: TCheckBox
      Left = 609
      Top = 12
      Width = 55
      Height = 17
      Caption = 'Log'
      TabOrder = 3
      OnClick = LogBoxClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 94
    Width = 967
    Height = 293
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 1
      Top = 145
      Width = 965
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object SpectrumChart: TSpectrumChart
      Left = 1
      Top = 1
      Width = 965
      Height = 144
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Frequency response')
      BottomAxis.AxisValuesFormat = '#,##0.########'
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
      LeftAxis.AxisValuesFormat = '#,##0.#########'
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 1183.500000000000000000
      LeftAxis.Minimum = -18.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'Amplitude'
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Zoom.Pen.Mode = pmNotXor
      Align = alClient
      Color = 12636883
      TabOrder = 0
      Spectrums = <
        item
          SeriesName = 'FastLineSeries1'
          Series = FastLineSeries1
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = SpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object FastLineSeries1: TFastLineSeries
        SeriesColor = clWhite
        LinePen.Color = clWhite
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SignalDiscreteSeries1: TSignalDiscreteSeries
        Marks.Transparent = True
        Marks.Visible = True
        Marks.Arrow.Visible = False
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
        SeriesColor = clGreen
        ClickableLine = False
        Pointer.Brush.Color = 4227327
        Pointer.Brush.Gradient.EndColor = clGreen
        Pointer.Gradient.EndColor = clGreen
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object AxisScaleTool1: TAxisScaleTool
        UpperMargin = 10
        LowerMargin = 5
        AxisScaleMode = amAuto
        DataIsSpectrum = True
        AxisID = 2
      end
      object ChartTool2: TSpectrumMarkTool
        CursorActive = False
        MarkSeries = SignalDiscreteSeries1
        DoubleClickClear = True
        Series = FastLineSeries1
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
    object GroupDelayChart: TSpectrumChart
      Left = 1
      Top = 148
      Width = 965
      Height = 144
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Group delay')
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
      LeftAxis.AutomaticMinimum = False
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 310.562500000000000000
      LeftAxis.Minimum = -15.028125000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'Delay [Samples]'
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Zoom.Pen.Mode = pmNotXor
      Align = alBottom
      Color = 12636883
      TabOrder = 1
      Spectrums = <
        item
          SeriesName = 'FastLineSeries2'
          Series = FastLineSeries2
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object FastLineSeries2: TFastLineSeries
        SeriesColor = clWhite
        LinePen.Color = clWhite
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SignalDiscreteSeries2: TSignalDiscreteSeries
        Marks.Transparent = True
        Marks.Visible = True
        Marks.Arrow.Visible = False
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
        SeriesColor = clGreen
        ClickableLine = False
        Pointer.Brush.Color = 4227327
        Pointer.Brush.Gradient.EndColor = clGreen
        Pointer.Gradient.EndColor = clGreen
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object AxisScaleTool2: TAxisScaleTool
        UpperMargin = 20
        LowerMargin = 5
        AxisScaleMode = amAuto
        DataIsSpectrum = True
        AxisID = 2
      end
      object ChartTool1: TSpectrumMarkTool
        CursorActive = False
        MarkSeries = SignalDiscreteSeries2
        DoubleClickClear = True
        Series = FastLineSeries2
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
  end
  object ChartEditor1: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 304
    Top = 66
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    OnParameterUpdate = SpectrumAnalyzer1ParameterUpdate
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
    Peaks.Interpolation.RecursiveHarmonics = rhNone
    Peaks.LargestRatio = 1000000000000000.000000000000000000
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    ScaleFactor = 1.000000000000000000
    Input = Signal
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    DCDump = False
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 40.000000000000000000
    Left = 406
    Top = 129
    MtxDataValues = {}
  end
  object Signal: TSignal
    IsDouble = False
    FloatPrecision = mvSingle
    OnAfterUpdate = SignalAfterUpdate
    Length = 4096
    SamplingFrequency = 2.000000000000000000
    Left = 312
    Top = 129
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\Dew Research\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 522
    Top = 129
    MtxDataValues = {}
  end
end
