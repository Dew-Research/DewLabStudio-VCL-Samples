inherited frmBasicChart: TfrmBasicChart
  Caption = 'frmBasicChart'
  ClientHeight = 470
  ClientWidth = 623
  OldCreateOrder = True
  ExplicitWidth = 639
  ExplicitHeight = 509
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 97
    Width = 623
    Height = 373
    ExplicitTop = 97
    ExplicitWidth = 623
    ExplicitHeight = 373
    object Chart1: TChart
      Left = 189
      Top = 0
      Width = 434
      Height = 373
      Border.Color = clNavy
      Border.Width = 6
      Border.Visible = True
      BorderRound = 10
      Gradient.EndColor = clGray
      Gradient.Visible = True
      Legend.Brush.Gradient.Direction = gdTopBottom
      Legend.Brush.Gradient.EndColor = clYellow
      Legend.Brush.Gradient.StartColor = clWhite
      Legend.Color = clInfoBk
      Legend.Frame.Color = clGray
      Legend.Shadow.Color = 13421772
      Legend.Symbol.Pen.Visible = False
      Title.Color = clInfoBk
      Title.Font.Shadow.Color = clBlack
      Title.Font.Shadow.HorizSize = 1
      Title.Font.Shadow.VertSize = 1
      Title.Frame.Color = clGray
      Title.Shadow.HorizSize = 0
      Title.Shadow.VertSize = 0
      Title.Text.Strings = (
        'TChart')
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        7
        15
        7)
      ColorPaletteIndex = 3
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 189
      Height = 373
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
  inherited Memo1: TMemo
    Width = 623
    Height = 97
    ExplicitWidth = 623
    ExplicitHeight = 97
  end
end
