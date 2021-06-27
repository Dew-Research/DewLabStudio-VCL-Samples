inherited frmXBarSeries: TfrmXBarSeries
  Caption = 'frmXBarSeries'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 97
    Height = 315
    object Chart1: TChart
      Left = 185
      Top = 81
      Width = 304
      Height = 234
      Gradient.EndColor = 8404992
      Gradient.StartColor = 16744448
      Gradient.Visible = True
      Legend.Visible = False
      Title.Font.Color = clWhite
      Title.Font.InterCharSize = 1
      Title.Font.Shadow.HorizSize = 1
      Title.Font.Shadow.VertSize = 1
      Title.Text.Strings = (
        'XBar plot')
      BottomAxis.LabelsFont.Color = clWhite
      BottomAxis.Title.Font.Color = clWhite
      LeftAxis.LabelsFont.Color = clWhite
      LeftAxis.Title.Font.Color = clWhite
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 489
      Height = 81
      Align = alTop
      TabOrder = 1
      object Button1: TButton
        Left = 160
        Top = 16
        Width = 75
        Height = 25
        Caption = '&Edit series'
        TabOrder = 0
        TabStop = False
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 312
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Define data'
        TabOrder = 1
        TabStop = False
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 392
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Recalc'
        Enabled = False
        TabOrder = 2
        TabStop = False
        OnClick = Button3Click
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 8
        Width = 145
        Height = 65
        Caption = ' Series type '
        ItemIndex = 0
        Items.Strings = (
          'XBar series'
          'SPlot series')
        TabOrder = 3
        OnClick = RadioGroup1Click
      end
    end
    object StringGrid1: TStringGrid
      Left = 0
      Top = 81
      Width = 185
      Height = 234
      TabStop = False
      Align = alLeft
      ColCount = 2
      DefaultRowHeight = 16
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
      TabOrder = 2
      OnKeyPress = StringGrid1KeyPress
    end
  end
  inherited Memo1: TMemo
    Height = 97
  end
end
