object PeakMarkingOrderForm: TPeakMarkingOrderForm
  Left = 168
  Top = 246
  Caption = 'Peak marking order'
  ClientHeight = 357
  ClientWidth = 680
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
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 91
    Width = 680
    Height = 227
    Gradient.Direction = gdFromBottomLeft
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
    LeftAxis.Maximum = 738.500000000000000000
    LeftAxis.Minimum = -19.625000000000000000
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
    TabOrder = 0
    Spectrums = <
      item
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SpectrumAnalyzer
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    OnAfterMarkPeak = SpectrumChartAfterMarkPeak
    DefaultCanvas = 'TGDIPlusCanvas'
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
      AxisScaleMode = amAuto
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
  object Panel1: TPanel
    Left = 0
    Top = 318
    Width = 680
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 272
      Top = 15
      Width = 56
      Height = 13
      Caption = 'Mark mode:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 217
      Height = 25
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
    end
    object ComboBox1: TComboBox
      Left = 338
      Top = 12
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = ComboBox1Change
      Items.Strings = (
        'Single peak'
        'Harmonic series'
        'Sidebands 1'
        'Sidebands 2'
        'Free style')
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 680
    Height = 91
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
  object SpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    OnParameterUpdate = SpectrumAnalyzerParameterUpdate
    PhaseRange = prPiPi
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
    Peaks.NormalizedFreq.Active = True
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
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
    Top = 84
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
  object SignalRead1: TSignalRead
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 1024
    SamplingFrequency = 1.000000000000000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 380
    Top = 117
    MtxDataValues = {}
  end
end
