object CepstrumDemoForm: TCepstrumDemoForm
  Left = 0
  Top = 0
  Caption = 'Cepstrum Demo'
  ClientHeight = 472
  ClientWidth = 659
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 76
    Width = 659
    Height = 357
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 1
      Top = 170
      Width = 657
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart2: TSpectrumChart
      Left = 1
      Top = 1
      Width = 657
      Height = 169
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Frequency spectrum')
      BottomAxis.LabelsSeparation = 0
      BottomAxis.MinorTicks.Visible = False
      BottomAxis.Title.Caption = 'Frequency [Hz]'
      Zoom.Pen.Color = clBlack
      Align = alTop
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
      object SignalDiscreteSeries1: TSignalDiscreteSeries
        Marks.Arrow.Visible = False
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = False
        Marks.Callout.Length = 10
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Transparent = True
        Marks.Visible = True
        SeriesColor = clGreen
        ClickableLine = False
        Pointer.Brush.Color = 4227327
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
      object AxisScaleTool1: TAxisScaleTool
        UpperMargin = 0
        LowerMargin = 0
        AxisScaleMode = amAuto
        DataIsSpectrum = False
        AxisID = 2
      end
      object ChartTool2: TSpectrumMarkTool
        CursorActive = True
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
    object SignalChart1: TSignalChart
      Left = 1
      Top = 173
      Width = 657
      Height = 183
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Cepstrum')
      BottomAxis.LabelsSeparation = 0
      BottomAxis.MinorTicks.Visible = False
      BottomAxis.Title.Caption = 'Spectral frequency (quefrency) [Hz]'
      Zoom.Pen.Color = clBlack
      Align = alClient
      Color = 12636883
      TabOrder = 1
      Signals = <
        item
          SeriesName = 'Series1'
          Series = Series1
          InputsItemIndex = 0
          Input = Signal1
        end>
      ComplexSignalPart = cspReal
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
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Visible = False
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = clRed
        Pointer.Gradient.EndColor = clRed
        Pointer.HorizSize = 3
        Pointer.InflateMargins = True
        Pointer.Style = psDiamond
        Pointer.VertSize = 3
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object ChartTool1: TSignalMarkTool
        CursorActive = True
        MarkSeries = Series2
        DoubleClickClear = True
        Series = Series1
        AmpltFormat = '0.00#'
        TimeFormat = '0.00#'
        MarkMode = tmMaximum
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 433
    Width = 659
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 318
      Top = 12
      Width = 50
      Height = 13
      Caption = 'Cepstrum:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 255
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
      object ToolButton1: TToolButton
        Left = 164
        Top = 0
        Caption = 'Chart'
        ImageIndex = 2
        OnClick = ToolButton1Click
      end
    end
    object CepstrumBox: TComboBox
      Left = 372
      Top = 9
      Width = 88
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = CepstrumBoxChange
      Items.Strings = (
        'Real'
        'Complex')
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 659
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
  object ChartEditor1: TChartEditor
    Chart = SpectrumChart2
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 187
    Top = 60
  end
  object ChartEditor2: TChartEditor
    Chart = SignalChart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 361
    Top = 258
  end
  object Signal1: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 237
    Top = 255
    MtxDataValues = {}
  end
  object SignalRead1: TSignalRead
    Length = 1024
    SamplingFrequency = 4666.666666666670000000
    FileFormat = ffSfs
    FileName = 'D:\CommonObjects\SignalProcessing\CZT\BZ.SFS'
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 229
    Top = 60
    MtxDataValues = {}
  end
  object SpectrumAnalyzer1: TSpectrumAnalyzer
    OnAfterUpdate = SpectrumAnalyzer1AfterUpdate
    OnParameterUpdate = SpectrumAnalyzer1ParameterUpdate
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 64.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 2
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
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    RunningPhase = rpDefault
    SidelobeAtt = 40.000000000000000000
    Window = wtHanning
    Left = 269
    Top = 57
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog1: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer1
    SourceListIndex = 0
    Left = 316
    Top = 57
    MtxDataValues = {}
  end
end
