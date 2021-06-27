object PeakInterpolateForm: TPeakInterpolateForm
  Left = 0
  Top = 0
  Caption = 'PeakInterpolateForm'
  ClientHeight = 427
  ClientWidth = 583
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
    Top = 388
    Width = 583
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 320
      Top = 15
      Width = 26
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
      Width = 31
      Height = 13
      Caption = 'Amplt:'
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 583
    Height = 312
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 0
      Top = 120
      Width = 583
      Height = 4
      Cursor = crVSplit
      Align = alTop
    end
    object SpectrumChart: TSpectrumChart
      Left = 0
      Top = 0
      Width = 583
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
      LeftAxis.Maximum = 746.000000000000000000
      LeftAxis.Minimum = -30.875000000000000000
      Zoom.Pen.Color = clBlack
      Align = alTop
      Color = 12636883
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
      Width = 583
      Height = 188
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Signal')
      Zoom.Pen.Color = clBlack
      Align = alClient
      Color = 12636883
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
    object SignalChart1: TSignalChart
      Left = 0
      Top = 124
      Width = 583
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
    Width = 583
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
    OnAfterUpdate = Signal1AfterUpdate
    Length = 512
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 117
    MtxDataValues = {}
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
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
    Peaks.TraceMethod = ptLargest
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
    SidelobeAtt = 90.000000000000000000
    Window = wtKaiser
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
