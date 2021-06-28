inherited frmQCXR: TfrmQCXR
  Caption = 'frmQCXR'
  ClientHeight = 554
  ClientWidth = 661
  OnShow = FormShow
  ExplicitWidth = 677
  ExplicitHeight = 593
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 661
    ExplicitLeft = 0
    ExplicitWidth = 661
  end
  inherited Panel1: TPanel
    Width = 661
    Height = 425
    ExplicitLeft = 0
    ExplicitTop = 129
    ExplicitWidth = 661
    ExplicitHeight = 425
    inherited Chart1: TChart
      Width = 511
      Height = 425
      ExplicitWidth = 511
      ExplicitHeight = 425
      PrintMargins = (
        15
        22
        15
        22)
    end
    inherited Panel2: TPanel
      Height = 425
      ExplicitHeight = 425
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
