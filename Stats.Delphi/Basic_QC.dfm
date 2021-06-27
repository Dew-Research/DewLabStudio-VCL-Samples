inherited frmBasicQC: TfrmBasicQC
  Caption = 'frmBasicQC'
  ClientHeight = 549
  ClientWidth = 666
  OldCreateOrder = True
  OnDestroy = FormDestroy
  ExplicitWidth = 682
  ExplicitHeight = 588
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 666
    Height = 420
    ExplicitWidth = 666
    ExplicitHeight = 420
    object Chart1: TChart
      Left = 150
      Top = 0
      Width = 516
      Height = 420
      BackWall.Pen.Visible = False
      BottomWall.Pen.Visible = False
      BottomWall.Size = 4
      LeftWall.Pen.Visible = False
      LeftWall.Size = 4
      Legend.Color = clInfoBk
      Legend.FontSeriesColor = True
      Legend.Frame.Color = clGray
      Legend.Frame.Visible = False
      Legend.Shadow.Color = 13421772
      Legend.Visible = False
      Title.Alignment = taLeftJustify
      Title.Color = clInfoBk
      Title.Font.Color = clBlack
      Title.Font.Height = -13
      Title.Font.Style = [fsBold]
      Title.Frame.Color = clGray
      Title.Shadow.HorizSize = 0
      Title.Shadow.VertSize = 0
      Title.Text.Strings = (
        'Quality Control Chart')
      Title.Transparent = False
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 13421772
      BottomAxis.Grid.Visible = False
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      Frame.Visible = False
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Visible = False
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
      Zoom.Brush.Color = clSilver
      Zoom.Brush.Style = bsFDiagonal
      Zoom.Pen.Color = clBlack
      Align = alClient
      Color = clWhite
      TabOrder = 0
      DefaultCanvas = ''
      PrintMargins = (
        15
        22
        15
        22)
      ColorPaletteIndex = 3
      object GridBandTool1: TGridBandTool
        Band1.Color = 15329769
        AxisID = 2
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 150
      Height = 420
      Align = alLeft
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 77
        Height = 13
        Caption = 'Confidence (%): '
      end
      object Edit1: TEdit
        Left = 88
        Top = 16
        Width = 41
        Height = 21
        TabOrder = 0
        OnChange = Edit1Change
      end
      object Button1: TButton
        Left = 8
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Edit Series'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 8
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Edit Data'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
  end
  inherited Memo1: TMemo
    Width = 666
    ExplicitWidth = 666
  end
end
