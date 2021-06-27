object BrowseDemoForm: TBrowseDemoForm
  Left = 370
  Top = 201
  Caption = 'Browse demo'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 688
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 246
      Top = 12
      Width = 16
      Height = 13
      Caption = 'Ch:'
    end
    object ToolBar1: TToolBar
      Left = 8
      Top = 9
      Width = 215
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 89
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '         Chart          '
        ImageIndex = 1
        OnClick = ChartButtonClick
      end
      object OpenFileButton: TToolButton
        Left = 89
        Top = 0
        Caption = 'Open file'
        ImageIndex = 2
        OnClick = OpenFileButtonClick
      end
    end
    object ChannelBox: TComboBox
      Left = 272
      Top = 9
      Width = 59
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = ChannelBoxChange
      Items.Strings = (
        'Left'
        'Right')
    end
    object PositionPanel: TMtxPositionPanel
      Left = 342
      Top = 12
      Width = 161
      Height = 15
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = '0 [%]'
      Color = clWhite
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 2
      CancelMouse = False
      SliderSpan = 100.000000000000000000
      SliderSpanMin = 0
      SliderMax = 100.000000000000000000
      SliderRange = 100.000000000000000000
      SliderColor = clNavy
      SliderBevelInner = bvNone
      SliderBevelWidth = 1
      SliderBevelOuter = bvLowered
    end
    object ThreadedBox: TCheckBox
      Left = 514
      Top = 9
      Width = 83
      Height = 17
      Caption = 'Threaded'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 688
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
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 688
    Height = 244
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 2
    object SignalChart1: TSignalChart
      Left = 1
      Top = 1
      Width = 686
      Height = 242
      Gradient.Direction = gdFromCenter
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Gradient.Visible = True
      Legend.Visible = False
      Title.Text.Strings = (
        'Time signal')
      OnScroll = SignalChart1Scroll
      OnUndoZoom = SignalChart1UndoZoom
      OnZoom = SignalChart1Zoom
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.Title.Caption = 'Time [s]'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 824.000000000000000000
      LeftAxis.Minimum = 329.000000000000000000
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
      BevelOuter = bvNone
      TabOrder = 0
      Signals = <
        item
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: TSignalHighLowSeries
        HoverElement = []
        HighValues.Name = 'Y'
        HighValues.Order = loNone
        LowValues.Name = 'Low'
        LowValues.Order = loNone
        Pen.Color = clDefault
        XValues.Name = 'X'
        XValues.Order = loAscending
        LowBrush.Style = bsClear
        ComplexSignalPart = cspReal
        SeriesMode = ssmHighLow
        ZMiddleDepth = False
      end
    end
  end
  object SignalBrowse1: TSignalBrowse
    IsDouble = False
    FloatPrecision = mvSingle
    Increment = 100
    SpanLimit = 8192
    SpanTime = 16384.000000000000000000
    OnProgressUpdate = SignalBrowse1ProgressUpdate
    Threaded = False
    Left = 288
    Top = 123
    MtxDataValues = {}
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.wav'
    Filter = 'Uncompressed PCM wav file|*.wav'
    Left = 418
    Top = 126
  end
  object ChartEditor: TChartEditor
    Chart = SignalChart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 500
    Top = 90
  end
  object TeeGDIPlus1: TTeeGDIPlus
    Active = True
    Antialias = False
    AntiAliasText = gpfNormal
    TeePanel = SignalChart1
    Left = 497
    Top = 197
  end
end
