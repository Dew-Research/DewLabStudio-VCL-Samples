inherited Mult1: TMult1
  Caption = 'Mult1'
  ClientHeight = 477
  OldCreateOrder = True
  ExplicitHeight = 516
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Top = 433
    Height = 44
    ExplicitTop = 433
    ExplicitHeight = 44
    object Button4: TButton
      Left = 8
      Top = 8
      Width = 89
      Height = 25
      Caption = 'Do comparison'
      TabOrder = 0
      OnClick = Button4Click
    end
  end
  inherited Panel3: TPanel
    Width = 183
    Height = 303
    Align = alLeft
    BevelOuter = bvNone
    ExplicitWidth = 183
    ExplicitHeight = 303
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 78
      Height = 13
      Caption = 'Matrix dimension'
    end
    object TrackBar1: TTrackBar
      Left = 24
      Top = 40
      Width = 129
      Height = 17
      Max = 1000
      Min = 1
      Frequency = 50
      Position = 60
      TabOrder = 0
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object StaticText1: TStaticText
      Left = 120
      Top = 24
      Width = 34
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'StaticText1'
      TabOrder = 1
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 72
      Width = 161
      Height = 73
      Caption = 'Matrix size'
      ItemIndex = 1
      Items.Strings = (
        'Small matrix (eval. 1000 x)'
        'Medium matrix (eval. 100 x)'
        'Large matrix (eval. 1 x)')
      TabOrder = 2
      OnClick = RadioGroup1Click
    end
  end
  object Chart1: TChart
    Left = 183
    Top = 130
    Width = 391
    Height = 303
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    Legend.Alignment = laTop
    MarginBottom = 5
    MarginLeft = 5
    MarginRight = 5
    MarginTop = 5
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.EndPosition = 100.000000000000000000
    BottomAxis.Title.Caption = 'Dim'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    LeftAxis.Title.Caption = 'time [ms]'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    Color = 14869218
    TabOrder = 3
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series1: TLineSeries
      HoverElement = [heCurrent]
      Title = 'C++'
      Brush.BackColor = clDefault
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psDiagCross
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      HoverElement = [heCurrent]
      Title = 'MtxVec'
      Brush.BackColor = clDefault
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psDownTriangle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
