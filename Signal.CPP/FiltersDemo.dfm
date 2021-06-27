object FiltersDemoForm: TFiltersDemoForm
  Left = 0
  Top = 0
  Caption = 'FiltersDemoForm'
  ClientHeight = 489
  ClientWidth = 710
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
    Top = 450
    Width = 710
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 4
      Top = 9
      Width = 390
      Height = 31
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
      object ToolButton1: TToolButton
        Left = 164
        Top = 0
        Caption = 'Signal chart'
        ImageIndex = 2
        OnClick = ToolButton1Click
      end
      object FilterButton: TToolButton
        Left = 246
        Top = 0
        Caption = 'Filter editor'
        ImageIndex = 3
        OnClick = FilterButtonClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 710
    Height = 374
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 0
      Top = 120
      Width = 710
      Height = 4
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart: TSpectrumChart
      Left = 0
      Top = 0
      Width = 710
      Height = 120
      Gradient.Direction = gdFromTopLeft
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
      LeftAxis.Maximum = 479.353750000000000000
      LeftAxis.Minimum = -16.607187500000000000
      Zoom.Pen.Color = clBlack
      Align = alTop
      Color = 12636883
      TabOrder = 0
      Spectrums = <
        item
          InputsItemIndex = 0
          Input = SpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series1: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Visible = False
        SeriesColor = 10485760
        LinePen.Color = 10485760
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
        MarkMode = mmFreeStyle
        MarkType = mtAmplt
        AmpltFormat = '0.0000'
        PhaseFormat = '0.0000'
        FreqFormat = '0.0000'
        LabelHeaders = True
        PeakZoomBand = False
        ConfLabels = cnfNone
      end
    end
    object SignalChart: TSignalChart
      Left = 0
      Top = 124
      Width = 710
      Height = 250
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Filter taps')
      Zoom.Pen.Color = clBlack
      Align = alClient
      Color = 12636883
      TabOrder = 1
      Signals = <
        item
          SeriesName = 'Series3'
          Series = Series3
          InputsItemIndex = 0
          Input = Signal2
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series3: TSignalDiscreteSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Visible = False
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = clRed
        Pointer.Gradient.EndColor = clRed
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.VertSize = 2
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
        UseYOrigin = True
      end
    end
    object SignalChart1: TSignalChart
      Left = 0
      Top = 124
      Width = 710
      Height = 0
      Legend.Visible = False
      Title.Text.Strings = (
        'TSignalChart')
      Align = alTop
      TabOrder = 2
      Signals = <>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 710
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
  object ChartEditor1: TChartEditor
    Chart = SignalChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 510
    Top = 216
  end
  object Signal1: TSignal
    Length = 512
    SamplingFrequency = 2.000000000000000000
    Left = 335
    Top = 117
    MtxDataValues = {}
  end
  object Signal2: TSignal
    Length = 512
    SamplingFrequency = 1.000000000000000000
    Left = 356
    Top = 243
    MtxDataValues = {}
  end
  object SignalFilter1: TSignalFilter
    Continuous = False
    OnAfterUpdate = SignalFilter1AfterUpdate
    OnParameterUpdate = SignalFilter1ParameterUpdate
    SamplingFrequency = 2.000000000000000000
    Input = Signal1
    Filters.Templates.Strings = (
      'Lowpass'
      'Highpass'
      'Comb filter'
      'Hilbert'
      'Bandstop'
      'Bandpass')
    Filters.Templates.StreamBinaryData = {
      7B00000000000000000000400000000000000000000000000000000000000000
      000000000000000000000000000000000000000000333333333333D33F000000
      000000F03F9A9999999999B93F99B93F000000000001333333333333E33F0000
      00000000F03F00000000000000000000000000004F40000000004F400000017B
      0000000000000000000040000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000333333333333D33F00000000
      000000000000000000004F40004F40000000000001333333333333E33F000000
      000000F03F000000000000F03F9A9999999999B93F99999999B93F000001A400
      0000000000000000084000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000333333333333D33F0000000000
      0000409A9999999999B93F99B93F0000000000019A9999999999D93F33333333
      3333E33F00000000000010409A9999999999B93F99999999B93F000001666666
      666666E63F000000000000F03F000000000000F03F9A9999999999B93F409A99
      99999999B90152000000000000000000F03F0000000000000000000000000000
      000000000000000000000000000000000000009A9999999999B93FCDCCCCCCCC
      CCEC3F000000000000F03F0AD7A3703D0AC73F99B93F000000000001A4000000
      0000000000000840000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000333333333333D33F000000000000F0
      3F9A9999999999B93F99B93F0000000000019A9999999999D93F333333333333
      E33F00000000000000000000000000004F400000000052400000016666666666
      66E63F000000000000F03F000000000000F03F9A9999999999B93F3F9A999999
      9999B901A4000000000000000000084000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000333333333333D3
      3F00000000000000000000000000004F40004F400000000000019A9999999999
      D93F333333333333E33F000000000000F03F333333333333C33FAE47E17A843F
      000001666666666666E63F000000000000F03F00000000000000000000000000
      004F40000000000000004F01}
    Filters.TemplateIndex = 5
    Taps.DataValues = {
      0000000000005C42000000000000803F000000000000D2430000004100000000
      00137A47000000000000000000000000DFB0F60D6B63C23C4327E6359F54613F
      794A90A704B7C9BCF22191CA8A076CBFA38B2EBAE848C43C8CCDFA7D4662543F
      D6BE61ED1B96AEBC2841A850B7537A3F419E12E4295192BCF7E8BEEAA5E58FBF
      823C25C853C2A63CF26005B2CE97903F6BDFB0F60D33A33C6B540519C5F6163F
      D145175D749BC4BCE868FEB20D8D9DBF58FB86B56F0CCE3C62BAA648C9B8A83F
      CDCCCCCCCC78C6BC23FACABB3B2C9EBF6BDFB0F60D4BA03CD8066572B48AA5BF
      74D145175D64BE3CE6530BCD8E1BC33F419E12E4299DC5BC9065AAEF2997CFBF
      666666666696B33CF704F4695651D23F666666666696B33C9065AAEF2997CFBF
      419E12E4299DC5BCE6530BCD8E1BC33F74D145175D64BE3CD8066572B48AA5BF
      6BDFB0F60D4BA03C23FACABB3B2C9EBFCDCCCCCCCC78C6BC62BAA648C9B8A83F
      58FB86B56F0CCE3CE868FEB20D8D9DBFD145175D749BC4BC6B540519C5F6163F
      6BDFB0F60D33A33CF26005B2CE97903F823C25C853C2A63CF7E8BEEAA5E58FBF
      419E12E4295192BC2841A850B7537A3FD6BE61ED1B96AEBC8CCDFA7D4662543F
      A38B2EBAE848C43CF22191CA8A076CBF794A90A704B7C9BC4327E6359F54613F
      DFB0F60D6B63C23C}
    FirMethod = fimParksMcClellan
    Response = rstFIR
    Beta = 4.000000000000000000
    Order = 6
    NormalizedFrequency = 2.000000000000000000
    FirLength = 55
    WaveletP1 = 0
    WaveletP2 = 0
    ScaleFactor = 1.000000000000000000
    Left = 375
    Top = 117
    MtxDataValues = {}
  end
  object SignalFilterDialog1: TSignalFilterDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SignalFilter1
    SourceListIndex = 0
    Left = 375
    Top = 78
    MtxDataValues = {}
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
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
    Logarithmic = True
    ScaleFactor = 1.000000000000000000
    Input = SignalFilter1
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    DCDump = False
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 60.000000000000000000
    Left = 422
    Top = 117
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    ShowLive = True
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 422
    Top = 75
    MtxDataValues = {}
  end
end
