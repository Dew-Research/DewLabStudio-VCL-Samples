object MonitorDemoForm: TMonitorDemoForm
  Left = 0
  Top = 0
  Caption = 'MonitorDemoForm'
  ClientHeight = 436
  ClientWidth = 614
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
    Top = 397
    Width = 614
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 262
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Channel:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 199
      Height = 25
      Align = alNone
      ButtonHeight = 29
      ButtonWidth = 82
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object SpectrumEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '         Edit        '
        DropdownMenu = PopupMenu1
        ImageIndex = 0
        Style = tbsDropDown
      end
      object StartButton: TToolButton
        Left = 97
        Top = 0
        Caption = 'Start'
        ImageIndex = 2
        OnClick = StartButtonClick
      end
    end
    object ChannelBox: TComboBox
      Left = 308
      Top = 9
      Width = 53
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        'Left'
        'Right')
    end
    object RecordToFileBox: TCheckBox
      Left = 408
      Top = 12
      Width = 97
      Height = 17
      Caption = 'Record to file'
      TabOrder = 2
      OnClick = RecordToFileBoxClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 614
    Height = 321
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 1
      Top = 127
      Width = 612
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart: TSpectrumChart
      Left = 1
      Top = 1
      Width = 612
      Height = 126
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
      LeftAxis.Maximum = 594.000000000000000000
      LeftAxis.Minimum = -24.750000000000000000
      Zoom.Pen.Color = clBlack
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      Spectrums = <
        item
          SeriesName = 'Series1'
          Series = Series1
          InputsItemIndex = 0
          Input = SpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TTeeCanvas3D'
      PrintMargins = (
        15
        43
        15
        43)
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
    object SignalChart: TSignalChart
      Left = 1
      Top = 130
      Width = 612
      Height = 190
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Time signal')
      BottomAxis.AxisValuesFormat = '#,##0.000'
      BottomAxis.Title.Caption = 'Time [s]'
      Zoom.Pen.Color = clBlack
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Signals = <
        item
          SeriesName = 'Series3'
          Series = Series3
          InputsItemIndex = 0
          Input = Signal1
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series3: TFastLineSeries
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
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 614
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
    Top = 168
  end
  object ChartEditor1: TChartEditor
    Chart = SignalChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 432
    Top = 243
  end
  object PopupMenu1: TPopupMenu
    Left = 206
    Top = 84
    object Spectrum1: TMenuItem
      Caption = 'Spectrum...'
      OnClick = Spectrum1Click
    end
    object Recording1: TMenuItem
      Caption = 'Recording...'
      OnClick = Recording1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Spectrumchart1: TMenuItem
      Caption = 'Spectrum chart...'
      OnClick = Spectrumchart1Click
    end
    object imechart1: TMenuItem
      Caption = 'Time chart...'
      OnClick = imechart1Click
    end
  end
  object Signal1: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 123
    MtxDataValues = {}
  end
  object SignalIn1: TSignalIn
    ChannelCount = 2
    SamplingFrequency = 44100.000000000000000000
    MonitorAggressiveness = -200
    BufferSize = 262144
    UsesInputs = False
    Input = SignalWrite1
    TriggerChannel = chLeft
    TriggerAbove = 100.000000000000000000
    TriggerBelow = -1000.000000000000000000
    TriggerDelay = 0
    TriggerPosition = tpAfter
    TriggerMode = trCrossing
    Triggering = trNone
    Left = 332
    Top = 123
    MtxDataValues = {}
  end
  object SignalInDialog: TSignalInDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SignalIn1
    SourceListIndex = 0
    Left = 330
    Top = 84
    MtxDataValues = {}
  end
  object SignalTimer1: TSignalTimer
    Enabled = True
    Interval = 50
    Frequency = 20.000000000000000000
    OnTimer = SignalTimer1Timer
    Left = 374
    Top = 87
    MtxDataValues = {}
  end
  object SignalWrite1: TSignalWrite
    Active = False
    SamplingFrequency = 1.000000000000000000
    FileFormat = ffWav
    FileName = 'C:\test.wav'
    AuthorInfo = 'Unknown'
    Input = SignalIn1
    Left = 332
    Top = 168
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
    RunningPhase = rpDefault
    SidelobeAtt = 40.000000000000000000
    Window = wtHanning
    Left = 422
    Top = 123
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 422
    Top = 87
    MtxDataValues = {}
  end
end
