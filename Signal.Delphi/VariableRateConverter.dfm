object VariableRateConverterForm: TVariableRateConverterForm
  Left = 359
  Top = 309
  Caption = 'Variable rate converter'
  ClientHeight = 416
  ClientWidth = 1015
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
    Top = 377
    Width = 1015
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 320
      Top = 15
      Width = 24
      Height = 13
      Caption = 'Freq:'
    end
    object Label2: TLabel
      Left = 412
      Top = 15
      Width = 33
      Height = 13
      Caption = 'Phase:'
    end
    object Label3: TLabel
      Left = 500
      Top = 15
      Width = 29
      Height = 13
      Caption = 'Amplt:'
    end
    object Label4: TLabel
      Left = 607
      Top = 12
      Width = 27
      Height = 13
      Caption = 'cFreq'
    end
    object Label5: TLabel
      Left = 721
      Top = 12
      Width = 32
      Height = 13
      Caption = 'cAmplt'
    end
    object Label6: TLabel
      Left = 826
      Top = 12
      Width = 33
      Height = 13
      Caption = 'ccFreq'
    end
    object ToolBar1: TToolBar
      Left = 4
      Top = 9
      Width = 309
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
    end
    object FreqEdit: TMtxFloatEdit
      Left = 346
      Top = 9
      Width = 61
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.0000;-0.0000'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.0002'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '0.0100'
      OnChange = FreqEditChange
    end
    object PhaseEdit: TMtxFloatEdit
      Left = 448
      Top = 9
      Width = 47
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 2
      Value = '0'
      OnChange = FreqEditChange
    end
    object AmpltEdit: TMtxFloatEdit
      Left = 534
      Top = 9
      Width = 47
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 3
      Value = '1.0'
      OnChange = FreqEditChange
    end
    object cFreqEdit: TMtxFloatEdit
      Left = 642
      Top = 9
      Width = 61
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 4
      Value = '96.0'
      OnChange = FreqEditChange
    end
    object cAmpltEdit: TMtxFloatEdit
      Left = 756
      Top = 9
      Width = 61
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 5
      Value = '1.0'
      OnChange = FreqEditChange
    end
    object ccFreqEdit: TMtxFloatEdit
      Left = 861
      Top = 9
      Width = 61
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 6
      Value = '8.0'
      OnChange = FreqEditChange
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 1015
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
    Width = 1015
    Height = 301
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 0
      Top = 120
      Width = 1015
      Height = 4
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart: TSpectrumChart
      Left = 0
      Top = 0
      Width = 1015
      Height = 120
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Frequency spectrum')
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
      LeftAxis.Maximum = 1302.165000000000000000
      LeftAxis.Minimum = -25.541250000000000000
      LeftAxis.Title.Caption = 'Magnitude [dB]'
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
          SeriesName = 'Series1'
          Series = Series1
          Caption = 'Resampled tone'
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = SpectrumAnalyzer
        end
        item
          SeriesName = 'Series4'
          Series = Series4
          Caption = 'Orignal tone'
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = SpectrumAnalyzer1
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
      object Series4: TMtxFastLineSeries
        HoverElement = []
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TPointSeries
        HoverElement = [heCurrent]
        Marks.Transparent = True
        Marks.Arrow.Visible = False
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
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
        CursorActive = False
        MarkSeries = Series2
        DoubleClickClear = True
        Series = Series1
        PeakFilterMode = False
        MarkMode = mmSingle
        MarkType = mtAmpltPhase
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
      Width = 1015
      Height = 177
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Signal')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.Title.Caption = 'Time [s]'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 1205.000000000000000000
      LeftAxis.Minimum = 551.156250000000000000
      LeftAxis.Title.Caption = 'Amplitude'
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.Maximum = 1090.000000000000000000
      RightAxis.Minimum = 386.650000000000000000
      RightAxis.Title.Caption = 'Frequency [Hz]'
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
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
        end
        item
          SeriesName = 'Series5'
          Series = Series5
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
          Input = RateConverter
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = ''
      ColorPaletteIndex = 0
      object Series3: TMtxFastLineSeries
        HoverElement = []
        SeriesColor = 10485760
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series5: TMtxFastLineSeries
        HoverElement = []
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series6: TMtxFastLineSeries
        HoverElement = []
        VertAxis = aRightAxis
        LinePen.Color = clGreen
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series7: TMtxFastLineSeries
        HoverElement = []
        VertAxis = aRightAxis
        LinePen.Color = clYellow
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object SignalChart1: TSignalChart
      Left = 0
      Top = 124
      Width = 1015
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
    Left = 510
    Top = 216
    MtxDataValues = {}
  end
  object RateConverter: TSignalVariableRateConverter
    IsDouble = True
    FloatPrecision = mvDouble
    SamplingFrequency = 1.000000000000000000
    Ripple = 0.001000000000000000
    Factor = 1.000000000000000000
    TransBW = 0.100000000000000000
    ScaleFactor = 1.000000000000000000
    MaxFactor = 2.000000000000000000
    MinFactor = 0.500000000000000000
    Left = 321
    Top = 120
    MtxDataValues = {}
  end
  object SpectrumAnalyzer1: TSpectrumAnalyzer
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
    Left = 513
    Top = 105
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\Dew Research\MtxVec'
    SourceListIndex = 0
    Left = 510
    Top = 284
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\Dew Research\MtxVec'
    SourceListIndex = 0
    Left = 621
    Top = 154
    MtxDataValues = {}
  end
  object ChartEditor1: TChartEditor
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 702
    Top = 272
  end
  object Signal1: TSignal
    IsDouble = True
    FloatPrecision = mvDouble
    SamplingFrequency = 1.000000000000000000
    Left = 246
    Top = 121
    MtxDataValues = {}
  end
end
