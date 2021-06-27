inherited frmQQPlot: TfrmQQPlot
  Caption = 'frmQQPlot'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 97
    Height = 304
    ExplicitTop = 97
    ExplicitHeight = 304
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 481
      Height = 49
      Align = alTop
      TabOrder = 0
      object Button1: TButton
        Left = 8
        Top = 16
        Width = 81
        Height = 25
        Caption = '&Edit'
        TabOrder = 0
        OnClick = Button1Click
      end
      object ButtonPen1: TButtonPen
        Left = 96
        Top = 16
        Width = 89
        Caption = 'Slope pen ...'
        TabOrder = 1
      end
      object Button2: TButton
        Left = 294
        Top = 16
        Width = 90
        Height = 25
        Caption = 'Generate data'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
    object Chart1: TChart
      Left = 0
      Top = 49
      Width = 481
      Height = 255
      BackWall.Pen.Visible = False
      BottomWall.Pen.Visible = False
      BottomWall.Size = 4
      LeftWall.Pen.Visible = False
      LeftWall.Size = 4
      Legend.Brush.Gradient.EndColor = 8404992
      Legend.Brush.Gradient.StartColor = 16744448
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
        'Quantile-Quantile plot')
      Title.Transparent = False
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 13421772
      BottomAxis.Grid.Visible = False
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'Theoretical Quantiles'
      BottomAxis.Title.Font.Color = clWhite
      BottomAxis.Title.Color = clBlack
      BottomAxis.Title.Transparent = False
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
      LeftAxis.Title.Caption = 'Y Quantiles'
      LeftAxis.Title.Font.Color = clWhite
      LeftAxis.Title.Color = clBlack
      LeftAxis.Title.Transparent = False
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.Title.Visible = False
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.Title.Visible = False
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      Align = alClient
      Color = clWhite
      TabOrder = 1
      DefaultCanvas = ''
      PrintMargins = (
        15
        29
        15
        29)
      ColorPaletteIndex = 3
      object GridBandTool1: TGridBandTool
        Band1.Color = 15329769
        AxisID = 2
      end
    end
  end
  inherited Memo1: TMemo
    Height = 97
    ExplicitHeight = 97
  end
end
