object SignalAnalysisDemoForm: TSignalAnalysisDemoForm
  Left = 0
  Top = 0
  Caption = 'SignalAnalysisDemoForm'
  ClientHeight = 471
  ClientWidth = 676
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
    Top = 432
    Width = 676
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 248
      Top = 12
      Width = 53
      Height = 13
      Caption = 'Transform:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 179
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 76
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '       Chart       '
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
      object AnalysisButton: TToolButton
        Left = 76
        Top = 0
        Caption = 'Analysis'
        ImageIndex = 2
        OnClick = AnalysisButtonClick
      end
    end
    object FilterBox: TComboBox
      Left = 300
      Top = 9
      Width = 103
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = FilterBoxChange
      Items.Strings = (
        'Window'
        'AutoCorr'
        'CrossCorr'
        'Dct'
        'InverseDct'
        'RealCepstrum'
        'CplxCepstrum')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 676
    Height = 356
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 1
      Width = 674
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SignalChart1: TSignalChart
      Left = 1
      Top = 4
      Width = 674
      Height = 351
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Time signal')
      BottomAxis.Title.Caption = 'Time [s]'
      Zoom.Pen.Color = clBlack
      Align = alClient
      BevelOuter = bvNone
      Color = 12636883
      TabOrder = 0
      Signals = <
        item
          SeriesName = 'Series3'
          Series = Series3
          InputsItemIndex = 0
          Input = SignalAnalyzer1
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
        Title = 'Original'
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series1: TPointSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Visible = False
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = clRed
        Pointer.Gradient.EndColor = clRed
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object ChartTool1: TSignalMarkTool
        CursorActive = True
        MarkSeries = Series1
        DoubleClickClear = True
        Series = Series3
        AmpltFormat = '0.00#'
        TimeFormat = '0.00#'
        MarkMode = tmFreeStyle
      end
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 676
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
    Chart = SignalChart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
  object SignalAnalyzer1: TSignalAnalyzer
    OnParameterUpdate = SignalAnalyzer1ParameterUpdate
    SamplingFrequency = 1.000000000000000000
    Inputs = <
      item
        Input = SignalRead1
      end>
    AutoCorrType = ctNormal
    SidelobeAtt = 40.000000000000000000
    ScaleFactor = 1.000000000000000000
    Window = wtRectangular
    Transform = ttWindow
    Integration = inNone
    ExpWindow = 0.010000000000000000
    Left = 360
    Top = 153
    MtxDataValues = {}
  end
  object SignalAnalyzerDialog1: TSignalAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SignalAnalyzer1
    SourceListIndex = 0
    Left = 360
    Top = 111
    MtxDataValues = {}
  end
  object SignalRead1: TSignalRead
    Length = 1024
    SamplingFrequency = 4666.666666666667000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 322
    Top = 153
    MtxDataValues = {}
  end
end
