inherited frmNormalProb: TfrmNormalProb
  Caption = 'frmNormalProb'
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 481
      Height = 49
      Align = alTop
      TabOrder = 0
      object Button1: TButton
        Left = 303
        Top = 10
        Width = 89
        Height = 24
        Caption = 'Generate data'
        TabOrder = 0
        TabStop = False
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 8
        Top = 16
        Width = 81
        Height = 25
        Caption = '&Edit'
        TabOrder = 1
        TabStop = False
        OnClick = Button2Click
      end
      object ButtonPen1: TButtonPen
        Left = 96
        Top = 16
        Width = 89
        Caption = 'Slope pen...'
        TabOrder = 2
        TabStop = False
      end
    end
    object Chart1: TChart
      Left = 0
      Top = 49
      Width = 481
      Height = 223
      BackWall.Pen.Visible = False
      BottomWall.Pen.Visible = False
      BottomWall.Size = 4
      LeftWall.Pen.Visible = False
      LeftWall.Size = 4
      Legend.Color = clInfoBk
      Legend.Frame.Color = clGray
      Legend.Frame.Visible = False
      Legend.Shadow.Color = 13421772
      Legend.Visible = False
      Title.Alignment = taLeftJustify
      Title.Color = clInfoBk
      Title.Font.Color = clBlack
      Title.Font.Height = -13
      Title.Font.InterCharSize = 2
      Title.Font.Shadow.Color = clGray
      Title.Font.Shadow.HorizSize = 2
      Title.Font.Shadow.VertSize = 1
      Title.Frame.Color = clGray
      Title.Shadow.HorizSize = 0
      Title.Shadow.VertSize = 0
      Title.Text.Strings = (
        'Normal probability plot')
      Title.Transparent = False
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 13421772
      BottomAxis.Grid.Visible = False
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'Ordered data values'
      BottomAxis.Title.Color = clBlack
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      Frame.Visible = False
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Visible = False
      LeftAxis.LabelsSize = 30
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'p'
      LeftAxis.Title.Color = 8454143
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
      Color = clWhite
      TabOrder = 1
      DefaultCanvas = ''
      ColorPaletteIndex = 3
      object GridBandTool1: TGridBandTool
        Band1.Color = 15329769
        AxisID = 2
      end
    end
  end
end
