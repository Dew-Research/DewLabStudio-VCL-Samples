object OnLineCoherenceForm: TOnLineCoherenceForm
  Left = 0
  Top = 0
  Caption = 'OnLineCoherenceForm'
  ClientHeight = 442
  ClientWidth = 707
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
    Top = 403
    Width = 707
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 242
      Top = 12
      Width = 49
      Height = 13
      Caption = 'Spectrum:'
    end
    object ToolBar1: TToolBar
      Left = 8
      Top = 9
      Width = 185
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 85
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '         Chart        '
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
      object ToolButton1: TToolButton
        Left = 85
        Top = 0
        Caption = 'Spectrum'
        ImageIndex = 2
        OnClick = ToolButton1Click
      end
    end
    object SpectrumBox: TComboBox
      Left = 304
      Top = 9
      Width = 111
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = SpectrumBoxChange
      Items.Strings = (
        'Input spectrum'
        'Output spectrum'
        'Cross spectrum'
        'Coherence'
        'TransferFunction')
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 707
    Height = 130
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
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 130
    Width = 707
    Height = 273
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
    LeftAxis.Maximum = 8.291432057990202E248
    LeftAxis.Minimum = -3.454763357495917E247
    LeftAxis.Title.Caption = 'Amplitude [dB]'
    Zoom.Pen.Color = clBlack
    Align = alClient
    TabOrder = 2
    Spectrums = <
      item
        SeriesName = 'Series1'
        Series = Series1
        InputsItemIndex = 0
        Input = CrossAnalyzer
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
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 520
    Top = 156
  end
  object CrossAnalyzer: TCrossSpectrumAnalyzer
    OnParameterUpdate = CrossAnalyzerParameterUpdate
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
    SidelobeAtt = 40.000000000000000000
    Output = Signal2
    Left = 426
    Top = 150
    MtxDataValues = {}
  end
  object CrossSpectrumAnalyzerDialog: TCrossSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = CrossAnalyzer
    SourceListIndex = 0
    Left = 426
    Top = 117
    MtxDataValues = {}
  end
  object Signal1: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 129
    MtxDataValues = {}
  end
  object Signal2: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 168
    MtxDataValues = {}
  end
  object SignalIn1: TSignalIn
    ChannelCount = 2
    SamplingFrequency = 44100.000000000000000000
    BufferSize = 32000
    UsesInputs = False
    TriggerChannel = chLeft
    TriggerDelay = 0
    TriggerPosition = tpAfter
    TriggerMode = trCrossing
    Triggering = trNone
    Left = 332
    Top = 129
    MtxDataValues = {}
  end
  object SignalTimer1: TSignalTimer
    Enabled = True
    Interval = 50
    Frequency = 20.000000000000000000
    OnTimer = SignalTimer1Timer
    Left = 374
    Top = 84
    MtxDataValues = {}
  end
end
