object BasicForm1: TBasicForm1
  Left = 252
  Top = 107
  Caption = 'BasicForm1'
  ClientHeight = 461
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 130
    Align = alTop
    TabOrder = 0
    object RichEdit1: TRichEdit
      Left = 1
      Top = 1
      Width = 572
      Height = 128
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      Zoom = 100
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 387
    Width = 574
    Height = 74
    Align = alBottom
    Color = 14869218
    TabOrder = 1
    object CheckDownSample: TCheckBox
      Left = 8
      Top = 8
      Width = 89
      Height = 17
      Caption = 'DownSample'
      TabOrder = 0
      OnClick = CheckDownSampleClick
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 130
    Width = 574
    Height = 257
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = 12615680
    Title.Text.Strings = (
      'TChart')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.EndPosition = 100.000000000000000000
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    Color = 14869218
    TabOrder = 2
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
  end
end
