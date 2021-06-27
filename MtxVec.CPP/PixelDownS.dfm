inherited DownS: TDownS
  Left = 282
  Top = 214
  Caption = 'DownS'
  ClientHeight = 405
  ClientWidth = 667
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitWidth = 683
  ExplicitHeight = 444
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 667
    Height = 100
    ExplicitWidth = 667
    ExplicitHeight = 100
    inherited RichEdit1: TRichEdit
      Width = 665
      Height = 98
      ExplicitWidth = 665
      ExplicitHeight = 98
    end
  end
  inherited Panel2: TPanel
    Top = 331
    Width = 667
    Height = 74
    Constraints.MinWidth = 615
    ExplicitTop = 331
    ExplicitWidth = 667
    ExplicitHeight = 74
    object Label1: TLabel
      Left = 112
      Top = 16
      Width = 167
      Height = 13
      Caption = 'Time needed for "normal" plotting : '
    end
    object Label2: TLabel
      Left = 112
      Top = 48
      Width = 170
      Height = 13
      Caption = 'Time needed for optimized plotting : '
    end
    object Label3: TLabel
      Left = 304
      Top = 16
      Width = 49
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0000'
    end
    object Label4: TLabel
      Left = 304
      Top = 48
      Width = 49
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0000'
    end
    object Label5: TLabel
      Left = 464
      Top = 24
      Width = 89
      Height = 13
      Caption = 'Number of points : '
    end
    object Label6: TLabel
      Left = 553
      Top = 24
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label6'
    end
    object SpeedButton1: TSpeedButton
      Left = 400
      Top = 11
      Width = 49
      Height = 22
      Caption = 'Draw'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 400
      Top = 43
      Width = 49
      Height = 22
      Caption = 'Draw'
      OnClick = SpeedButton2Click
    end
    object TrackBar1: TTrackBar
      Left = 464
      Top = 40
      Width = 167
      Height = 17
      Max = 10000000
      Min = 100000
      Frequency = 300000
      Position = 600000
      TabOrder = 1
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object Button1: TBitBtn
      Left = 8
      Top = 24
      Width = 97
      Height = 25
      Caption = 'Compare'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  inherited Panel3: TPanel
    Top = 100
    Width = 667
    Height = 231
    ExplicitTop = 100
    ExplicitWidth = 667
    ExplicitHeight = 231
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 665
      Height = 78
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      MarginBottom = 0
      MarginTop = 0
      Title.Text.Strings = (
        'Normal')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
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
      Align = alTop
      Color = 14671839
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object Series1: TFastLineSeries
        HoverElement = []
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chart2: TChart
      Left = 1
      Top = 79
      Width = 665
      Height = 151
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      MarginBottom = 0
      MarginTop = 0
      Title.Text.Strings = (
        'Using PixelDownSample')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
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
      Align = alClient
      Color = 14671839
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object Series2: TFastLineSeries
        HoverElement = []
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
end
