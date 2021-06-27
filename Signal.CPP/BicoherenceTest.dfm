object BicoherenceTestForm: TBicoherenceTestForm
  Left = 0
  Top = 0
  Caption = 'BicoherenceTestForm'
  ClientHeight = 456
  ClientWidth = 610
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
    Top = 417
    Width = 610
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 330
      Top = 9
      Width = 35
      Height = 13
      Caption = 'Freq 1:'
    end
    object Label2: TLabel
      Left = 436
      Top = 9
      Width = 35
      Height = 13
      Caption = 'Freq 2:'
    end
    object ToolBar1: TToolBar
      Left = 4
      Top = 6
      Width = 315
      Height = 31
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 88
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
      object ChartEditButton: TToolButton
        Left = 88
        Top = 0
        AllowAllUp = True
        Caption = 'Chart'
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
      object Button1: TToolButton
        Left = 176
        Top = 0
        Caption = 'Recalculate'
        ImageIndex = 2
        OnClick = Button1Click
      end
    end
    object Freq1Edit: TMtxFloatEdit
      Left = 366
      Top = 6
      Width = 61
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '20.00'
      OnChange = Freq1EditChange
    end
    object Freq2Edit: TMtxFloatEdit
      Left = 472
      Top = 6
      Width = 61
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 2
      Value = '80.00'
      OnChange = Freq1EditChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 103
    Width = 610
    Height = 314
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 0
      Top = 169
      Width = 606
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Chart1: TChart
      Left = 0
      Top = 0
      Width = 606
      Height = 169
      Gradient.EndColor = 12615680
      Title.Font.Color = clWhite
      Title.Text.Strings = (
        'Bicoherence')
      BottomAxis.Title.Caption = 'Frequency [Hz]'
      Chart3DPercent = 80
      DepthAxis.Title.Caption = 'Frequency [Hz]'
      DepthAxis.Visible = True
      LeftAxis.Title.Caption = 'Frequency [Hz]'
      View3D = False
      View3DOptions.OrthoAngle = 60
      Align = alTop
      BevelOuter = bvNone
      Color = 12636883
      TabOrder = 0
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series1: TMtxGridSeries
        XStep = 1.000000000000000000
        YStep = 1.000000000000000000
        PixelResample = False
        PixelResampleMethod = pdsPattern
        LegendItemsCount = 11
        ColorPalette.TopColor = clWhite
        ColorPalette.BottomColor = clNavy
        ColorPalette.ColorBalance = -0.500000000000000000
        ColorPalette.SharpContrast = False
        ColorPalette.TopClipOffColor = clNone
        ColorPalette.BottomClipOffColor = clNone
        ColorPalette.UseMidColor = False
      end
    end
    object SpectrumChart: TSpectrumChart
      Left = 0
      Top = 172
      Width = 606
      Height = 138
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Frequency spectrum')
      BottomAxis.LabelsSeparation = 0
      BottomAxis.MinorTicks.Visible = False
      BottomAxis.Title.Caption = 'Frequency [Hz]'
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Maximum = 979.778124999999900000
      LeftAxis.Minimum = 453.465937500000100000
      Zoom.Pen.Color = clBlack
      Align = alClient
      Color = 12636883
      TabOrder = 1
      Spectrums = <
        item
          InputsItemIndex = 0
          Input = SpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object FastLineSeries1: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Visible = False
        SeriesColor = clWhite
        LinePen.Color = clWhite
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TPointSeries
        Marks.Arrow.Visible = False
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Transparent = True
        Marks.Visible = True
        SeriesColor = clGreen
        ClickableLine = False
        Pointer.Brush.Color = clRed
        Pointer.Brush.Gradient.EndColor = clGreen
        Pointer.Gradient.EndColor = clGreen
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object ChartTool2: TAxisScaleTool
        UpperMargin = 50
        LowerMargin = 5
        AxisScaleMode = amPeakHold
        DataIsSpectrum = False
        AxisID = 2
      end
      object ChartTool1: TSpectrumMarkTool
        CursorActive = False
        MarkSeries = Series2
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
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 610
    Height = 103
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
  end
  object BiSpectrumAnalyzer: TBiSpectrumAnalyzer
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
    Stats.Averaging = avLinearInf
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 60.000000000000000000
    Window = wtKaiser
    BiAnalyzer.Recursive = False
    BiAnalyzer.Transform = hoBicoherence
    BiAnalyzer.Lines.DataValues = {
      0000000000000000000000000000803F000000000000D2430000004100000000
      00137A47000000000000000000000000}
    Left = 421
    Top = 129
    MtxDataValues = {}
  end
  object ChartEditor: TChartEditor
    Chart = Chart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 421
    Top = 165
  end
  object Signal1: TSignal
    Continuous = False
    OnAfterUpdate = Signal1AfterUpdate
    Length = 256
    SamplingFrequency = 256.000000000000000000
    Left = 354
    Top = 132
    MtxDataValues = {}
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
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
    Peaks.LargestCount = 4
    Peaks.TraceMethod = ptLargest
    Bands.Templates.Strings = (
      'Template 1')
    Bands.Templates.StreamBinaryData = {
      2F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000}
    Bands.TemplateIndex = 0
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
    Left = 282
    Top = 312
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 322
    Top = 312
    MtxDataValues = {}
  end
end
