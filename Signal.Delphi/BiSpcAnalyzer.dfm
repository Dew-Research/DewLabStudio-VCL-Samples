object BiSpcAnalyzerForm: TBiSpcAnalyzerForm
  Left = 438
  Top = 319
  Caption = 'Bispectrum analyzer'
  ClientHeight = 359
  ClientWidth = 688
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
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 688
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object FrequencyLabel: TLabel
      Left = 394
      Top = 15
      Width = 49
      Height = 13
      Caption = 'Freq. [Hz]:'
    end
    object ProgressLabel: TLabel
      Left = 527
      Top = 15
      Width = 61
      Height = 13
      Caption = 'Progress: [%]'
    end
    object ToolBar1: TToolBar
      Left = 8
      Top = 9
      Width = 374
      Height = 28
      Align = alNone
      ButtonHeight = 29
      ButtonWidth = 94
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object SpectrumEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '      Spectrum      '
        ImageIndex = 0
        OnClick = SpectrumEditButtonClick
      end
      object ToolButton1: TToolButton
        Left = 94
        Top = 0
        Caption = 'Bispectrum'
        ImageIndex = 3
        OnClick = ToolButton1Click
      end
      object ChartEditButton: TToolButton
        Left = 188
        Top = 0
        AllowAllUp = True
        Caption = 'Chart'
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
      object Button1: TToolButton
        Left = 282
        Top = 0
        Caption = 'Options'
        DropdownMenu = PopupMenu
        ImageIndex = 2
        Style = tbsDropDown
      end
    end
    object FrequencyEdit: TMtxFloatEdit
      Left = 443
      Top = 9
      Width = 71
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.##'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '1024'
      MinValue = '0'
      TabOrder = 1
      Value = '20'
      OnChange = FrequencyEditChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 320
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel'
    TabOrder = 1
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 0
      Top = 120
      Width = 688
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart: TSpectrumChart
      Left = 0
      Top = 123
      Width = 688
      Height = 197
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
      LeftAxis.Maximum = 480.000000000000000000
      LeftAxis.Minimum = -145.000000000000000000
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
      Color = 12636883
      TabOrder = 0
      Spectrums = <
        item
          SeriesName = 'Series1'
          Series = Series1
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = SpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object Series1: TFastLineSeries
        HoverElement = []
        SeriesColor = clPurple
        LinePen.Color = clPurple
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
      object ChartTool4: TColorLineTool
        AxisID = 0
        object TAnnotationTool
          Shape.Alignment = taCenter
          Shape.Shadow.Visible = False
          Shape.TextAlignment = taCenter
          TextAlignment = taCenter
        end
      end
    end
    object SpectrumChart1: TSpectrumChart
      Left = 0
      Top = 0
      Width = 688
      Height = 120
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Bicoherence')
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
      LeftAxis.Maximum = 263.725000000000000000
      LeftAxis.Minimum = -10.884375000000000000
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
      Align = alTop
      Color = 12636883
      TabOrder = 1
      Spectrums = <
        item
          SeriesName = 'FastLineSeries1'
          Series = FastLineSeries1
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = BiSpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object FastLineSeries1: TFastLineSeries
        HoverElement = []
        SeriesColor = clPurple
        LinePen.Color = clPurple
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object PointSeries1: TPointSeries
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
      object AxisScaleTool1: TAxisScaleTool
        UpperMargin = 20
        LowerMargin = 5
        AxisScaleMode = amPeakHold
        DataIsSpectrum = True
        AxisID = 2
      end
      object ChartTool3: TSpectrumMarkTool
        CursorActive = True
        MarkSeries = PointSeries1
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
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    OnParameterUpdate = SpectrumAnalyzerParameterUpdate
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
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    Logarithmic = True
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
    Left = 422
    Top = 117
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 422
    Top = 78
    MtxDataValues = {}
  end
  object ChartEditor: TChartEditor
    Chart = SpectrumChart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
  object SignalRead1: TSignalRead
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 2048
    SamplingFrequency = 4666.666666666670000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 349
    Top = 117
    MtxDataValues = {}
  end
  object BiSpectrumAnalyzer: TBiSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    OnParameterUpdate = BiSpectrumAnalyzerParameterUpdate
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
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    ScaleFactor = 1.000000000000000000
    Input = SignalRead1
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    Stats.Averaging = avLinearInf
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 40.000000000000000000
    Window = wtHanning
    BiAnalyzer.Recursive = False
    BiAnalyzer.Transform = hoBicoherence
    BiAnalyzer.Lines.DataValues = {
      0000000000000000000000000000803F0000803F000016440000804000000000
      00137A47000000000000000000000000}
    Left = 490
    Top = 195
    MtxDataValues = {}
  end
  object PopupMenu: TPopupMenu
    Left = 309
    Top = 237
    object Openfile1: TMenuItem
      Caption = 'Open file...'
      OnClick = Openfile1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Copy1: TMenuItem
      Caption = 'Copy chart...'
      OnClick = Copy1Click
    end
    object Recalculate1: TMenuItem
      Caption = 'Recalculate'
      OnClick = Recalculate1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object SaveConfig: TMenuItem
      Caption = 'Save configuration'
      OnClick = SaveConfigClick
    end
    object LoadConfig: TMenuItem
      Caption = 'Load configuraion'
      OnClick = LoadConfigClick
    end
  end
  object OpenDialog: TOpenDialog
    Left = 180
    Top = 141
  end
  object SaveDialog: TSaveDialog
    Left = 141
    Top = 141
  end
  object BiSpectrumAnalyzerDialog: TBiSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = BiSpectrumAnalyzer
    SourceListIndex = 0
    Left = 567
    Top = 156
    MtxDataValues = {}
  end
end
