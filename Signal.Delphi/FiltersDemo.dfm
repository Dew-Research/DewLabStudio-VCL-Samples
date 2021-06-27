object FiltersDemoForm: TFiltersDemoForm
  Left = 306
  Top = 246
  Caption = 'Filter demo'
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
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 688
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
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 688
    Height = 244
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 0
      Top = 120
      Width = 688
      Height = 4
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart: TSpectrumChart
      Left = 0
      Top = 0
      Width = 688
      Height = 120
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
      BottomAxis.Title.Caption = 'Frequency [Hz]'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 1367.210000000000000000
      LeftAxis.Minimum = 424.803750000000000000
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Zoom.Brush.Gradient.Direction = gdFromTopLeft
      Zoom.Brush.Gradient.EndColor = clSilver
      Zoom.Brush.Gradient.MidColor = clWhite
      Zoom.Brush.Gradient.StartColor = clSilver
      Zoom.Pen.Color = clBlack
      Zoom.Pen.Mode = pmNotXor
      Align = alTop
      Color = 12636883
      TabOrder = 0
      Spectrums = <
        item
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = SpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = ''
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
      Width = 688
      Height = 120
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Filter taps')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 637.500000000000000000
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Zoom.Brush.Gradient.Direction = gdFromTopLeft
      Zoom.Brush.Gradient.EndColor = clSilver
      Zoom.Brush.Gradient.MidColor = clWhite
      Zoom.Brush.Gradient.StartColor = clSilver
      Zoom.Pen.Color = clBlack
      Zoom.Pen.Mode = pmNotXor
      Align = alClient
      Color = 12636883
      TabOrder = 1
      Signals = <
        item
          SeriesName = 'Series3'
          Series = Series3
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = Signal2
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = ''
      ColorPaletteIndex = 0
      object Series3: TSignalDiscreteSeries
        HoverElement = [heCurrent]
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = clRed
        Pointer.Gradient.EndColor = clRed
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.VertSize = 2
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
      Width = 688
      Height = 0
      Legend.Visible = False
      Title.Text.Strings = (
        'TSignalChart')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Zoom.Brush.Gradient.Direction = gdFromTopLeft
      Zoom.Brush.Gradient.EndColor = clSilver
      Zoom.Brush.Gradient.MidColor = clWhite
      Zoom.Brush.Gradient.StartColor = clSilver
      Zoom.Pen.Mode = pmNotXor
      Align = alTop
      TabOrder = 2
      Signals = <>
      ComplexSignalPart = cspReal
      DefaultCanvas = ''
      ColorPaletteIndex = 0
    end
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
    Peaks.Interpolation.RecursiveHarmonics = rhNone
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
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
  object Signal1: TSignal
    IsDouble = True
    FloatPrecision = mvDouble
    Length = 512
    SamplingFrequency = 2.000000000000000000
    Left = 287
    Top = 123
    MtxDataValues = {}
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
  object SignalFilter1: TSignalFilter
    IsDouble = True
    FloatPrecision = mvDouble
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
      000000F03F8087E0BA77CE913F3F000000000000F001333333333333E33F0000
      00000000F03F00000000000000000000000000004E400000333333333333017B
      0000000000000000000040000000000000000000000000000000000000000000
      00000000000000000000000000000000000000009A9999999999D93F00000000
      000000000000000000004E403F0000000000000001333333333333E33F000000
      000000F03F000000000000F03F8087E0BA77CE913F000033333333333301A400
      0000000000000000084000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000333333333333D33F0000000000
      000040B548953B1476C63F3F00000000000000019A9999999999D93F33333333
      3333E33F0000000000000840B548953B1476C63F00009A999999999901666666
      666666E63F000000000000F03F0000000000001040B548953B1476C63F400101
      00000000000152000000000000000000F03F0000000000000000000000000000
      000000000000000000000000000000000000009A9999999999B93FCDCCCCCCCC
      CCEC3F000000000000F03F8087E0BA77CE913F3F000000000000F001A4000000
      0000000000000840000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000333333333333D33F000000000000F0
      3FB548953B1476C63F3F000000000000F001666666666666D63F333333333333
      E33F00000000000000000000000000004E400000CDCCCCCCCCCC01CDCCCCCCCC
      CCE43F000000000000F03F000000000000F03F8087E0BA77CE913F3F01010000
      00000001A4000000000000000000084000000000000000000000000000000000
      000000000000000000000000000000000000000000000000009A9999999999D9
      3F00000000000000000000000000004F403F0000000000000001A4703D0AD7A3
      E03F333333333333E33F000000000000F03F8087E0BA77CE913F00009A999999
      999901666666666666E63F000000000000F03F00000000000000000000000000
      004F40000101000000000001}
    Filters.TemplateIndex = 5
    Taps.DataValues = {
      0000000000008642000000000000803F0000000000C016440000004100000000
      00137A47000000000000000000000000000000404523E8BE000000C053E2513F
      0000008079BE40BF000000E037595FBF0000002069C3603F00000080040E603F
      000000C0289C6EBF000000A029B242BF0000006090486E3F000000408B0350BF
      000000E06A9645BF00000020C82736BF000000000D976FBF000000A0BF827B3F
      000000A01394763F000000008D8F90BF00000040C2FE48BF00000020A49E963F
      000000A09C9580BF000000E0726592BF00000040F192873F000000C055A6733F
      00000020AA6C5B3F000000603797763F00000020976BA1BF000000C0D7B9703F
      000000E02FB1B23F000000209203A6BF000000C0A271B8BF00000020593CBA3F
      00000020040AB53F00000040751CC4BF0000006083A3A0BF00000000F1F2C63F
      0000006083A3A0BF00000040751CC4BF00000020040AB53F00000020593CBA3F
      000000C0A271B8BF000000209203A6BF000000E02FB1B23F000000C0D7B9703F
      00000020976BA1BF000000603797763F00000020AA6C5B3F000000C055A6733F
      00000040F192873F000000E0726592BF000000A09C9580BF00000020A49E963F
      00000040C2FE48BF000000008D8F90BF000000A01394763F000000A0BF827B3F
      000000000D976FBF00000020C82736BF000000E06A9645BF000000408B0350BF
      0000006090486E3F000000A029B242BF000000C0289C6EBF00000080040E603F
      0000002069C3603F000000E037595FBF0000008079BE40BF000000C053E2513F
      000000404523E8BE}
    FirMethod = fimParksMcClellan
    Response = rstFIR
    Beta = 4.000000000000000000
    Order = 6
    NormalizedFrequency = 2.000000000000000000
    FirLength = 67
    WaveletP1 = 0
    WaveletP2 = 0
    ScaleFactor = 1.000000000000000000
    FractionalDelay = 30.500000000000000000
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
  object Signal2: TSignal
    IsDouble = True
    FloatPrecision = mvDouble
    Length = 512
    SamplingFrequency = 1.000000000000000000
    Left = 290
    Top = 243
    MtxDataValues = {}
  end
end
