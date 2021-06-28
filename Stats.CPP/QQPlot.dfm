inherited frmQQPlot: TfrmQQPlot
  Caption = 'frmQQPlot'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    ExplicitLeft = 0
  end
  inherited Panel1: TPanel
    ExplicitLeft = 0
    ExplicitTop = 129
    object Chart1: TChart
      Left = 0
      Top = 49
      Width = 540
      Height = 252
      Gradient.EndColor = 8404992
      Gradient.StartColor = 16744448
      Legend.Brush.Gradient.EndColor = 8404992
      Legend.Brush.Gradient.StartColor = 16744448
      Legend.Visible = False
      Title.Font.Color = clWhite
      Title.Font.InterCharSize = 2
      Title.Font.Shadow.Color = clGray
      Title.Font.Shadow.HorizSize = 2
      Title.Font.Shadow.VertSize = 1
      Title.Text.Strings = (
        'Quantile-Quantile plot')
      BottomAxis.LabelsFormat.Font.Color = clWhite
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'X Quantiles'
      BottomAxis.Title.Font.Color = clWhite
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LabelsFormat.Font.Color = clWhite
      LeftAxis.LabelsSize = 30
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'Y Quantiles'
      LeftAxis.Title.Font.Color = clWhite
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
      Color = 12615808
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        29
        15
        29)
      ColorPaletteIndex = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 540
      Height = 49
      Align = alTop
      TabOrder = 1
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
  end
end
