object CoherenceTestForm: TCoherenceTestForm
  Left = 0
  Top = 0
  Caption = 'Cross-spectrum analyzer'
  ClientHeight = 570
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 531
    Width = 672
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 284
      Top = 15
      Width = 49
      Height = 13
      Caption = 'Spectrum:'
    end
    object ToolBar1: TToolBar
      Left = 8
      Top = 9
      Width = 269
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
      object EditSpectrumButton: TToolButton
        Left = 85
        Top = 0
        Caption = 'Spectrum'
        ImageIndex = 2
        OnClick = EditSpectrumButtonClick
      end
      object UpdateButton: TToolButton
        Left = 170
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
      Left = 450
      Top = 15
      Width = 97
      Height = 17
      Caption = 'Phase'
      TabOrder = 2
      OnClick = PhaseBoxClick
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 672
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
    TabOrder = 1
  end
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 88
    Width = 672
    Height = 443
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
    LeftAxis.Maximum = 636.000000000000000000
    LeftAxis.Minimum = -26.500000000000000000
    LeftAxis.Title.Caption = 'Amplitude [dB]'
    Zoom.Pen.Color = clBlack
    Align = alClient
    Color = 12636883
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
      SeriesColor = 8421631
      LinePen.Color = 8421631
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
    Left = 424
    Top = 159
  end
  object CrossAnalyzer: TCrossSpectrumAnalyzer
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
    Output = FilteredSignal
    Left = 422
    Top = 120
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
  object FilteredSignal: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 358
    Top = 144
    MtxDataValues = {}
  end
  object SignalRead1: TSignalRead
    OnAfterUpdate = SignalRead1AfterUpdate
    Length = 2048
    SamplingFrequency = 4666.666666666669000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 324
    Top = 102
    MtxDataValues = {}
  end
end
