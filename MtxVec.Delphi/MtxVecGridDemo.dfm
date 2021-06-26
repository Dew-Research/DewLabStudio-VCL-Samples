inherited frmGridDemo: TfrmGridDemo
  Left = 227
  Top = 183
  Caption = 'frmGridDemo'
  ClientHeight = 571
  ClientWidth = 756
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 772
  ExplicitHeight = 610
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 756
    ExplicitWidth = 756
    inherited RichEdit1: TRichEdit
      Width = 754
      ExplicitWidth = 754
    end
  end
  inherited Panel2: TPanel
    Top = 536
    Width = 756
    Height = 35
    ExplicitTop = 536
    ExplicitWidth = 756
    ExplicitHeight = 35
  end
  inherited Panel3: TPanel
    Width = 756
    Height = 406
    ExplicitWidth = 756
    ExplicitHeight = 406
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 222
      Height = 404
      Align = alLeft
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 5
        Width = 197
        Height = 163
        Caption = 'Behavior'
        TabOrder = 0
        object CheckBox1: TCheckBox
          Left = 16
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Editable'
          TabOrder = 0
          OnClick = CheckBox1Click
        end
        object CheckBox2: TCheckBox
          Left = 16
          Top = 50
          Width = 121
          Height = 17
          Caption = 'Can append rows'
          TabOrder = 1
          OnClick = CheckBox2Click
        end
        object CheckBox3: TCheckBox
          Left = 16
          Top = 76
          Width = 121
          Height = 17
          Caption = 'Autosize columns'
          TabOrder = 2
          OnClick = CheckBox3Click
        end
        object CheckBox4: TCheckBox
          Left = 16
          Top = 102
          Width = 145
          Height = 17
          Caption = 'Split complex numbers'
          TabOrder = 3
          OnClick = CheckBox4Click
        end
        object CheckBox6: TCheckBox
          Left = 16
          Top = 128
          Width = 121
          Height = 17
          Caption = 'Show object info'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = CheckBox6Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 174
        Width = 194
        Height = 124
        Caption = 'Format'
        TabOrder = 1
        object Label1: TLabel
          Left = 17
          Top = 53
          Width = 38
          Height = 13
          Caption = 'Format:'
        end
        object Label2: TLabel
          Left = 16
          Top = 89
          Width = 75
          Height = 13
          Caption = 'Text alignment:'
        end
        object CheckBox5: TCheckBox
          Left = 16
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Scientific format'
          TabOrder = 0
          OnClick = CheckBox5Click
        end
        object Edit1: TEdit
          Left = 61
          Top = 50
          Width = 120
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
          OnChange = Edit1Change
        end
        object ComboBox1: TComboBox
          Left = 94
          Top = 83
          Width = 87
          Height = 21
          ItemIndex = 1
          TabOrder = 2
          Text = 'Right'
          OnChange = ComboBox1Change
          Items.Strings = (
            'Left'
            'Right'
            'Center')
        end
      end
      object Button1: TButton
        Left = 5
        Top = 308
        Width = 100
        Height = 28
        Caption = 'Show vector'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 111
        Top = 308
        Width = 91
        Height = 28
        Caption = 'Show matrix'
        TabOrder = 3
        OnClick = Button2Click
      end
    end
  end
end
