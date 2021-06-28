inherited frmQCAttr: TfrmQCAttr
  Caption = 'frmQCAttr'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    ExplicitLeft = 0
  end
  inherited Panel1: TPanel
    ExplicitLeft = 0
    ExplicitTop = 129
    inherited Chart1: TChart
      PrintMargins = (
        15
        22
        15
        22)
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
        Top = 96
        ExplicitTop = 96
      end
      inherited Button2: TButton
        Top = 128
        ExplicitTop = 128
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
