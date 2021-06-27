inherited frmQCAttr: TfrmQCAttr
  Caption = 'frmQCAttr'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object Label2: TLabel [0]
      Left = 8
      Top = 120
      Width = 65
      Height = 13
      Caption = 'Sample size : '
    end
    inherited Chart1: TChart
      Border.Color = clNavy
      Border.Width = 6
      BorderRound = 10
      Gradient.EndColor = clGray
      Gradient.Visible = True
      Legend.Brush.Gradient.Direction = gdTopBottom
      Legend.Brush.Gradient.EndColor = clYellow
      Legend.Brush.Gradient.StartColor = clWhite
      Legend.Brush.Gradient.Visible = True
      BevelOuter = bvNone
      Color = clBtnFace
      PrintMargins = (
        15
        22
        15
        22)
      ColorPaletteIndex = 2
      inherited GridBandTool1: TGridBandTool
        AxisID = 2
      end
    end
    inherited Panel2: TPanel
      object Label3: TLabel [1]
        Left = 8
        Top = 49
        Width = 65
        Height = 13
        Caption = 'Sample size : '
      end
      inherited Button1: TButton
        Top = 93
        ExplicitTop = 93
      end
      inherited Button2: TButton
        Top = 125
        ExplicitTop = 125
      end
      object RadioGroup1: TRadioGroup
        Left = 10
        Top = 162
        Width = 121
        Height = 96
        Caption = ' Type : '
        ItemIndex = 0
        Items.Strings = (
          'P Chart'
          'NP Chart'
          'U Chart'
          'C Chart')
        TabOrder = 3
        OnClick = RadioGroup1Click
      end
      object Edit2: TEdit
        Left = 88
        Top = 49
        Width = 41
        Height = 21
        TabOrder = 4
        OnChange = Edit2Change
      end
    end
  end
end
