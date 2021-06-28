inherited frmBasicChart: TfrmBasicChart
  Caption = 'frmBasicChart'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    ExplicitLeft = 0
  end
  inherited Panel1: TPanel
    ExplicitLeft = 0
    ExplicitTop = 129
    object Chart1: TChart
      Left = 189
      Top = 0
      Width = 351
      Height = 301
      BackWall.Color = clWhite
      BackWall.Transparent = False
      BackWall.Visible = False
      Border.Visible = True
      LeftWall.Color = clWhite
      Legend.Font.Height = -12
      Legend.Font.Name = 'Lucida Console'
      Legend.Shadow.Color = clGray
      RightWall.Color = clWhite
      Title.Font.Color = clBlack
      Title.Font.Height = -13
      Title.Font.Name = 'Lucida Console'
      Title.Font.Style = [fsBold]
      Title.Font.Shadow.Color = clBlack
      Title.Font.Shadow.HorizSize = 1
      Title.Font.Shadow.VertSize = 1
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Grid.Color = 12895428
      BottomAxis.Grid.Visible = False
      BottomAxis.LabelsFormat.Font.Name = 'Lucida Console'
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.MinorTickLength = -3
      BottomAxis.MinorTicks.Color = clBlack
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.TickInnerLength = 6
      BottomAxis.TickLength = 0
      BottomAxis.TicksInner.Color = clBlack
      DepthAxis.Grid.Color = 12895428
      DepthAxis.LabelsFormat.Font.Name = 'Lucida Console'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthAxis.MinorTickLength = -3
      DepthAxis.MinorTicks.Color = clBlack
      DepthAxis.EndPosition = 100.000000000000000000
      DepthAxis.TickInnerLength = 6
      DepthAxis.TickLength = 0
      DepthAxis.TicksInner.Color = clBlack
      DepthTopAxis.Grid.Color = 12895428
      DepthTopAxis.LabelsFormat.Font.Name = 'Lucida Console'
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      DepthTopAxis.MinorTickLength = -3
      DepthTopAxis.MinorTicks.Color = clBlack
      DepthTopAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.TickInnerLength = 6
      DepthTopAxis.TickLength = 0
      DepthTopAxis.TicksInner.Color = clBlack
      LeftAxis.Grid.Color = 12895428
      LeftAxis.LabelsFormat.Font.Name = 'Lucida Console'
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.MinorTickLength = -3
      LeftAxis.MinorTicks.Color = clBlack
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.TickInnerLength = 6
      LeftAxis.TickLength = 0
      LeftAxis.TicksInner.Color = clBlack
      RightAxis.Grid.Color = 12895428
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LabelsFormat.Font.Name = 'Lucida Console'
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.MinorTickLength = -3
      RightAxis.MinorTicks.Color = clBlack
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.TickInnerLength = 6
      RightAxis.TickLength = 0
      RightAxis.TicksInner.Color = clBlack
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.Color = 12895428
      TopAxis.Grid.Visible = False
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LabelsFormat.Font.Name = 'Lucida Console'
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.MinorTickLength = -3
      TopAxis.MinorTicks.Color = clBlack
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.TickInnerLength = 6
      TopAxis.TickLength = 0
      TopAxis.TicksInner.Color = clBlack
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      Color = 12895428
      TabOrder = 0
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 6
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 189
      Height = 301
      Align = alLeft
      TabOrder = 1
      object Button1: TButton
        Left = 8
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Edit Chart'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
end
