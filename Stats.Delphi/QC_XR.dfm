inherited frmQCXR: TfrmQCXR
  Caption = 'frmQCXR'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
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
      inherited Edit1: TEdit
        Top = 23
        ExplicitTop = 23
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 112
        Width = 113
        Height = 81
        Caption = ' Type '
        ItemIndex = 0
        Items.Strings = (
          'X Chart'
          'R Chart'
          'S Chart')
        TabOrder = 3
        OnClick = RadioGroup1Click
      end
    end
  end
end
