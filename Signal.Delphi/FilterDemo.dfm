object FiltersDemoForm: TFiltersDemoForm
  Left = 301
  Top = 280
  Width = 696
  Height = 393
  Caption = 'Filter demo'
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
    Top = 327
    Width = 688
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
    object ToolBar1: TToolBar
      Left = 4
      Top = 9
      Width = 309
      Height = 31
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 82
      EdgeBorders = []
      Flat = True
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
      Position = 0.010000000000000000
      IntPosition = 0
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
      IntPosition = 0
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
      Position = 1
      IntPosition = 1
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
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 688
    Height = 76
    Align = alTop
    Color = 16768991
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
    Height = 251
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
      Gradient.Visible = True
      Legend.Visible = False
      Title.Text.Strings = (
        'Frequency spectrum')
      BottomAxis.LabelsSeparation = 0
      BottomAxis.MinorTicks.Visible = False
      BottomAxis.Title.Caption = 'Frequency [Hz]'
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Maximum = 1157
      LeftAxis.Minimum = -47.500000000000000000
      Zoom.Pen.Color = clBlack
      Align = alTop
      TabOrder = 0
      SpectrumPart = spAmplt
      Spectrums = <
        item
          Input = SpectrumAnalyzer
        end>
      object Series1: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Length = 8
        Marks.Visible = False
        SeriesColor = 10485760
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
      end
      object Series2: TPointSeries
        Marks.ArrowLength = 0
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Distance = 10
        Marks.Callout.Length = 0
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
      end
    end
    object SignalChart: TSignalChart
      Left = 0
      Top = 124
      Width = 688
      Height = 127
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Gradient.Visible = True
      Legend.Visible = False
      Title.Text.Strings = (
        'Signal')
      Zoom.Pen.Color = clBlack
      Align = alClient
      TabOrder = 1
      Signals = <
        item
          Input = Signal1
        end>
      object Series3: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Length = 8
        Marks.Visible = False
        SeriesColor = 10485760
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
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
      Align = alTop
      TabOrder = 2
      Signals = <>
    end
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    OnParameterUpdate = SpectrumAnalyzerParameterUpdate
    SamplingFrequency = 1
    SamplingTime = 128
    HzRes = 0.007812500000000000
    Dt = 1
    Averages = 0
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    Bands.TemplateIndex = -1
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1
    CZT.StopRadius = 1
    ExpWindow = 0.010000000000000000
    Input = Signal1
    Peaks.Interpolation.Method = imNumeric
    Peaks.TraceMethod = ptLargest
    Peaks.HarmonicsCount = 10
    Peaks.OrderFrequency = 1
    PhaseRange = prPiPi
    RealCepstrum = False
    ScaleFactor = 1
    SidelobeAtt = 60
    Window = wtKaiser
    Left = 422
    Top = 117
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    ShowLive = True
    RegistryPath = '\Software\DewResearch\MtxVec'
    Continuous = False
    Source = SpectrumAnalyzer
    Left = 422
    Top = 75
  end
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    Left = 424
    Top = 159
  end
  object Signal1: TSignal
    OnAfterUpdate = Signal1AfterUpdate
    Length = 512
    SamplingFrequency = 1
    Left = 374
    Top = 117
  end
  object ChartEditor1: TChartEditor
    Chart = SignalChart
    Left = 510
    Top = 216
  end
end
