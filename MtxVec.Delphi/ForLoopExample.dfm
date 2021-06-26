object ForLoopExampleForm: TForLoopExampleForm
  Left = 0
  Top = 0
  Caption = 'ForLoopExampleForm'
  ClientHeight = 404
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 194
    Width = 625
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 169
  end
  object Panel1: TPanel
    Left = 0
    Top = 350
    Width = 625
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 345
    DesignSize = (
      625
      54)
    object Label1: TLabel
      Left = 11
      Top = 12
      Width = 26
      Height = 13
      Caption = 'Time:'
    end
    object Label5: TLabel
      Left = 11
      Top = 31
      Width = 406
      Height = 13
      Anchors = [akTop, akBottom]
      Caption = 
        'All multithreading timing tests show meaningfull results only wh' +
        'en run outside of IDE!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object MultiThreadedBox: TCheckBox
      Left = 181
      Top = 12
      Width = 97
      Height = 17
      Caption = 'Multi-threaded'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object Button2: TButton
      Left = 539
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Benchmark'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Chart: TChart
    Left = 0
    Top = 0
    Width = 625
    Height = 194
    Title.Text.Strings = (
      'CPU cost per element as a function of vector '
      
        'length and memory manager with multi-core processing of Student ' +
        'CDF function')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.EndPosition = 100.000000000000000000
    BottomAxis.Title.Caption = 'Vector length'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 1272.500000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    LeftAxis.Title.Caption = 'Time [ms]'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    Zoom.Animated = True
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    DefaultCanvas = ''
    ColorPaletteIndex = 13
    object Series1: TFastLineSeries
      HoverElement = []
      SeriesColor = 10485760
      Title = 'Standard MM'
      LinePen.Color = 10485760
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      HoverElement = []
      SeriesColor = 33023
      Title = 'Super conductive MM'
      LinePen.Color = 33023
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 197
    Width = 625
    Height = 153
    Legend.Visible = False
    Title.Text.Strings = (
      'Super conductive MM/Default MM'
      
        'Super conductive memory allocation makes the code run faster on ' +
        'multi-core CPU'#39's for short arrays (vectors) '
      'Gains grow with core count.')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.EndPosition = 100.000000000000000000
    BottomAxis.Title.Caption = 'Vector length'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 535.000000000000000000
    LeftAxis.Minimum = 157.500000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    LeftAxis.Title.Caption = 'Factor'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    Zoom.Animated = True
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 2
    ExplicitHeight = 160
    DefaultCanvas = ''
    ColorPaletteIndex = 13
    object FastLineSeries1: TFastLineSeries
      HoverElement = []
      SeriesColor = 10485760
      Title = 'Scalability'
      LinePen.Color = 10485760
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Timer1: TTimer
    Interval = 150
    OnTimer = Timer1Timer
    Left = 376
    Top = 32
  end
end
