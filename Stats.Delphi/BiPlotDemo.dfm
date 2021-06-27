inherited frmBiPlot: TfrmBiPlot
  Caption = 'frmBiPlot'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Chart1: TChart
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'Principal Component Analysis: BiPlot')
      PrintMargins = (
        15
        7
        15
        7)
    end
    inherited Panel2: TPanel
      object Button2: TButton
        Left = 8
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Edit data'
        TabOrder = 1
        OnClick = Button2Click
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 88
        Width = 137
        Height = 49
        Caption = 'Biplot settings'
        TabOrder = 2
        object CheckBox1: TCheckBox
          Left = 8
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Show arrows'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = CheckBox1Click
        end
      end
    end
  end
end
