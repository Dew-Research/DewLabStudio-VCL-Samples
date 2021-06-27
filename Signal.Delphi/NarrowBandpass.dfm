object NarrowBandpassForm: TNarrowBandpassForm
  Left = 527
  Top = 235
  Caption = 'NarrowBandpassForm'
  ClientHeight = 426
  ClientWidth = 887
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 887
    Height = 94
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
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 387
    Width = 887
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 234
      Top = 15
      Width = 48
      Height = 13
      Caption = 'Left edge:'
    end
    object Label2: TLabel
      Left = 371
      Top = 15
      Width = 78
      Height = 13
      Caption = 'Passband width:'
    end
    object PositionLabel: TLabel
      Left = 540
      Top = 15
      Width = 40
      Height = 13
      Caption = 'Position:'
    end
    object FilterDelayLabel: TLabel
      Left = 624
      Top = 15
      Width = 30
      Height = 13
      Caption = 'Delay:'
    end
    object Label3: TLabel
      Left = 717
      Top = 15
      Width = 57
      Height = 13
      Caption = 'Attenuation:'
    end
    object Label4: TLabel
      Left = 856
      Top = 12
      Width = 19
      Height = 13
      Caption = '[dB]'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 218
      Height = 25
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
    end
    object MtxFloatEdit1: TMtxFloatEdit
      Left = 292
      Top = 9
      Width = 69
      Height = 22
      Hint = 
        'Defines the carrier frequency as a multiple of the original samp' +
        'ling frequency.'
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.001'
      MaxValue = '0.5'
      MinValue = '0'
      TabOrder = 1
      Value = '0.00'
      OnChange = MtxFloatEdit1Change
    end
    object MtxFloatEdit2: TMtxFloatEdit
      Left = 455
      Top = 9
      Width = 68
      Height = 22
      Hint = 
        'Defines the final sampling frequency as a multiple of the origin' +
        'al.'
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.001'
      MaxValue = '0.5'
      MinValue = '0'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = '0.20'
      OnChange = MtxFloatEdit1Change
    end
    object AttBox: TComboBox
      Left = 775
      Top = 9
      Width = 75
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = AttBoxChange
      Items.Strings = (
        '80'
        '120'
        '160')
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 94
    Width = 887
    Height = 293
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 1
      Top = 145
      Width = 885
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object SpectrumChart2: TSpectrumChart
      Left = 1
      Top = 1
      Width = 885
      Height = 144
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Frequency spectrum of the bandpass filtered signal')
      BottomAxis.MaximumOffset = 1
      BottomAxis.MinimumOffset = 1
      BottomAxis.MinorTicks.Visible = False
      LeftAxis.MaximumOffset = 1
      LeftAxis.MinimumOffset = 1
      Align = alClient
      Color = 12636883
      TabOrder = 0
      Spectrums = <
        item
          SeriesName = 'FastLineSeries1'
          Series = FastLineSeries1
          InputsItemIndex = 0
          Input = SpectrumAnalyzer1
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object FastLineSeries1: TFastLineSeries
        SeriesColor = clWhite
        LinePen.Color = clWhite
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SignalDiscreteSeries1: TSignalDiscreteSeries
        Marks.Transparent = True
        Marks.Visible = True
        Marks.Arrow.Visible = False
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
        SeriesColor = clGreen
        ClickableLine = False
        Pointer.Brush.Color = 4227327
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
        UpperMargin = 0
        LowerMargin = 0
        AxisScaleMode = amAuto
        DataIsSpectrum = False
        AxisID = 2
      end
      object ChartTool2: TSpectrumMarkTool
        CursorActive = False
        MarkSeries = SignalDiscreteSeries1
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
    object SpectrumChart3: TSpectrumChart
      Left = 1
      Top = 148
      Width = 885
      Height = 144
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Original spectrum')
      BottomAxis.MaximumOffset = 1
      BottomAxis.MinimumOffset = 1
      BottomAxis.MinorTicks.Visible = False
      LeftAxis.MaximumOffset = 1
      LeftAxis.MinimumOffset = 1
      Align = alBottom
      Color = 12636883
      TabOrder = 1
      Spectrums = <
        item
          SeriesName = 'FastLineSeries2'
          Series = FastLineSeries2
          InputsItemIndex = 0
          Input = SpectrumAnalyzer3
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object FastLineSeries2: TFastLineSeries
        SeriesColor = clWhite
        LinePen.Color = clWhite
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SignalDiscreteSeries2: TSignalDiscreteSeries
        Marks.Transparent = True
        Marks.Visible = True
        Marks.Arrow.Visible = False
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
        SeriesColor = clGreen
        ClickableLine = False
        Pointer.Brush.Color = 4227327
        Pointer.Brush.Gradient.EndColor = clGreen
        Pointer.Gradient.EndColor = clGreen
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object AxisScaleTool2: TAxisScaleTool
        UpperMargin = 0
        LowerMargin = 0
        AxisScaleMode = amAuto
        DataIsSpectrum = False
        AxisID = 2
      end
      object ChartTool1: TSpectrumMarkTool
        CursorActive = False
        MarkSeries = SignalDiscreteSeries2
        DoubleClickClear = True
        Series = FastLineSeries2
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
  object SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer1
    SourceListIndex = 0
    Left = 385
    Top = 54
    MtxDataValues = {}
  end
  object SpectrumAnalyzer1: TSpectrumAnalyzer
    OnParameterUpdate = SpectrumAnalyzer1ParameterUpdate
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
    LogSpan = ls200
    ScaleFactor = 1.000000000000000000
    Input = SignalBuffer
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 150.000000000000000000
    Window = wtKaiser
    Left = 347
    Top = 54
    MtxDataValues = {}
  end
  object SignalRead1: TSignalRead
    Length = 1024
    SamplingFrequency = 4666.666666666670000000
    FileFormat = ffSfs
    FileName = 'D:\CommonObjects\SignalProcessing\CZT\BZ.SFS'
    SelectionStop = -1
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 229
    Top = 54
    MtxDataValues = {}
  end
  object ChartEditor1: TChartEditor
    Chart = SpectrumChart2
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 166
    Top = 57
  end
  object SpectrumAnalyzer3: TSpectrumAnalyzer
    OnParameterUpdate = SpectrumAnalyzer1ParameterUpdate
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
    LogSpan = ls200
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
    SidelobeAtt = 150.000000000000000000
    Window = wtKaiser
    Left = 406
    Top = 288
    MtxDataValues = {}
  end
  object SignalBandpass: TSignalBandpass
    SamplingFrequency = 1.000000000000000000
    Input = SignalRead1
    Ripple = 0.001000000000000000
    Factor = 1.000000000000000000
    TransBW = 0.100000000000000000
    ScaleFactor = 1.000000000000000000
    Left = 270
    Top = 54
    MtxDataValues = {}
  end
  object SignalBuffer: TSignalBuffer
    Length = 2048
    SamplingFrequency = 1.000000000000000000
    IncrementStep = 1.500000000000000000
    Input = SignalBandpass
    Left = 309
    Top = 54
    MtxDataValues = {}
  end
end
