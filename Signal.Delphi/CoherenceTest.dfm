object CoherenceTestForm: TCoherenceTestForm
  Left = 561
  Top = 267
  Caption = 'Cross-spectrum analyzer'
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 88
    Width = 688
    Height = 232
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    Legend.Visible = False
    Title.Text.Strings = (
      'Frequency spectrum')
    BottomAxis.LabelsSeparation = 0
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
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
    LeftAxis.AxisValuesFormat = '#,##0.#####'
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 455.000000000000000000
    LeftAxis.Minimum = -18.750000000000000000
    LeftAxis.Title.Caption = 'Amplitude [dB]'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
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
        Input = CrossAnalyzer
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TFastLineSeries
      HoverElement = []
      SeriesColor = 8421631
      LinePen.Color = 8421631
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
      AmpltFormat = '0.00##'
      PhaseFormat = '0.00##'
      FreqFormat = '0.00##'
      LabelHeaders = True
      PeakZoomBand = False
      ConfLabels = cnfNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 688
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 284
      Top = 15
      Width = 48
      Height = 13
      Caption = 'Spectrum:'
    end
    object FilterLengthLabel: TLabel
      Left = 550
      Top = 14
      Width = 57
      Height = 13
      Caption = 'Filter length:'
    end
    object ToolBar1: TToolBar
      Left = 8
      Top = 9
      Width = 269
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 83
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
      object EditSpectrumButton: TToolButton
        Left = 83
        Top = 0
        Caption = 'Spectrum'
        ImageIndex = 2
        OnClick = EditSpectrumButtonClick
      end
      object UpdateButton: TToolButton
        Left = 166
        Top = 0
        Caption = 'Update'
        ImageIndex = 3
        OnClick = UpdateButtonClick
      end
    end
    object SpectrumBox: TComboBox
      Left = 336
      Top = 12
      Width = 102
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
    object PhaseBox: TCheckBox
      Left = 448
      Top = 13
      Width = 65
      Height = 17
      Caption = 'Phase'
      TabOrder = 2
      OnClick = PhaseBoxClick
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 688
    Height = 88
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
    Top = 195
  end
  object SignalRead1: TSignalRead
    IsDouble = True
    FloatPrecision = mvDouble
    OnAfterUpdate = SignalRead1AfterUpdate
    Length = 2048
    SamplingFrequency = 4666.666666666669000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 317
    Top = 111
    MtxDataValues = {}
  end
  object CrossAnalyzer: TCrossSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    OnParameterUpdate = CrossAnalyzerParameterUpdate
    PhaseMode = pmPhaseDelay
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 16.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 8
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
    UnwrapPhase = True
    SidelobeAtt = 40.000000000000000000
    Output = FilteredSignal
    Left = 413
    Top = 141
    MtxDataValues = {}
  end
  object FilteredSignal: TSignal
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    Left = 319
    Top = 168
    MtxDataValues = {}
  end
  object CrossSpectrumAnalyzerDialog: TCrossSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = CrossAnalyzer
    SourceListIndex = 0
    Left = 420
    Top = 87
    MtxDataValues = {}
  end
end
