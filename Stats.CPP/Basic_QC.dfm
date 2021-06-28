inherited frmBasicQC: TfrmBasicQC
  Caption = 'frmBasicQC'
  ClientHeight = 448
  ClientWidth = 556
  OnDestroy = FormDestroy
  ExplicitWidth = 572
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 556
    ExplicitWidth = 556
  end
  inherited Panel1: TPanel
    Width = 556
    Height = 319
    ExplicitWidth = 556
    ExplicitHeight = 319
    object Chart1: TChart
      Left = 150
      Top = 0
      Width = 406
      Height = 319
      Border.Visible = True
      Legend.FontSeriesColor = True
      Legend.Visible = False
      Title.Font.Color = clSilver
      Title.Font.Style = [fsBold]
      Title.Text.Strings = (
        'Quality Control Chart')
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
      Zoom.Brush.Color = clSilver
      Zoom.Brush.Style = bsFDiagonal
      Zoom.Pen.Color = clBlack
      Align = alClient
      Color = 12615808
      TabOrder = 0
      DefaultCanvas = 'TTeeCanvas3D'
      PrintMargins = (
        15
        22
        15
        22)
      ColorPaletteIndex = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 150
      Height = 319
      Align = alLeft
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 83
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
end
