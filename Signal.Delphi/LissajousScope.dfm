object LissajousScopeForm: TLissajousScopeForm
  Left = 671
  Top = 283
  Caption = 'Lissajous scope'
  ClientHeight = 315
  ClientWidth = 611
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
  object Panel1: TPanel
    Left = 0
    Top = 276
    Width = 611
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 134
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Samples:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 111
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 71
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '      Chart       '
        ImageIndex = 1
        OnClick = ChartButtonClick
      end
    end
    object SamplesBox: TComboBox
      Left = 184
      Top = 9
      Width = 85
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = SamplesBoxChange
      Items.Strings = (
        '500'
        '1000'
        '2000'
        '3000'
        '4000'
        '8000'
        '16000')
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 611
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
    Width = 611
    Height = 200
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 2
    object PhaseChart: TChart
      Left = 1
      Top = 1
      Width = 609
      Height = 198
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Color = clWhite
      BackWall.Transparent = False
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Visible = False
      RightWall.Color = 14745599
      SubFoot.Font.Name = 'Verdana'
      SubTitle.Font.Name = 'Verdana'
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'Lissajous')
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMinimum = False
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.Increment = 10.000000000000000000
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      ClipPoints = False
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Automatic = False
      RightAxis.AutomaticMinimum = False
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Automatic = False
      TopAxis.AutomaticMinimum = False
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      Zoom.Brush.Gradient.Direction = gdFromTopLeft
      Zoom.Brush.Gradient.EndColor = clSilver
      Zoom.Brush.Gradient.MidColor = clWhite
      Zoom.Brush.Gradient.StartColor = clSilver
      Zoom.Pen.Mode = pmNotXor
      Align = alClient
      Color = clWhite
      TabOrder = 0
      ColorPaletteIndex = 13
      object Series1: TSignalPolarSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        XValues.DateTime = False
        XValues.Name = 'Angle'
        XValues.Order = loNone
        YValues.DateTime = False
        YValues.Name = 'Radius'
        YValues.Order = loNone
        Shadow.Visible = False
        AngleIncrement = 10.000000000000000000
        AngleValues.DateTime = False
        AngleValues.Name = 'Angle'
        AngleValues.Order = loNone
        Brush.Color = clWhite
        Brush.Style = bsClear
        CloseCircle = False
        Pen.Color = 10708548
        Pen.Visible = False
        Pointer.Brush.Gradient.EndColor = 10708548
        Pointer.Gradient.EndColor = 10708548
        Pointer.InflateMargins = True
        Pointer.Style = psSmallDot
        Pointer.Visible = True
      end
    end
  end
  object ChartEditor: TChartEditor
    Chart = PhaseChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 282
    Top = 99
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
    Left = 330
    Top = 135
    MtxDataValues = {}
  end
  object Signal1: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 123
    MtxDataValues = {}
  end
  object Signal2: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 159
    MtxDataValues = {}
  end
  object TeeGDIPlus1: TTeeGDIPlus
    Active = True
    Antialias = False
    AntiAliasText = gpfClearType
    TeePanel = PhaseChart
    Left = 457
    Top = 229
  end
end
