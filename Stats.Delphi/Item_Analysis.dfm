inherited frmItemAnalysis: TfrmItemAnalysis
  Left = 206
  Top = 152
  Caption = 'frmItemAnalysis'
  ClientHeight = 433
  ClientWidth = 694
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 710
  ExplicitHeight = 472
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 694
    Height = 304
    Anchors = []
    ExplicitWidth = 694
    ExplicitHeight = 304
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 137
      Height = 304
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 121
        Height = 89
        Caption = 'Data'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 48
          Width = 32
          Height = 13
          Caption = 'Label1'
        end
        object Label2: TLabel
          Left = 8
          Top = 64
          Width = 32
          Height = 13
          Caption = 'Label2'
        end
        object Button1: TButton
          Left = 8
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Edit'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 104
        Width = 121
        Height = 145
        Caption = 'Reports'
        TabOrder = 1
        object CheckBox1: TCheckBox
          Left = 8
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Reliability'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckBox2: TCheckBox
          Left = 8
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Distribution'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckBox4: TCheckBox
          Left = 8
          Top = 72
          Width = 97
          Height = 17
          Caption = 'Correlation'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object CheckBox5: TCheckBox
          Left = 8
          Top = 96
          Width = 97
          Height = 17
          Caption = 'Covariance'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CheckBox3: TCheckBox
          Left = 8
          Top = 120
          Width = 97
          Height = 17
          Caption = 'Details'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
      end
      object Button2: TButton
        Left = 16
        Top = 256
        Width = 75
        Height = 25
        Caption = '&Report'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
    object RichEdit1: TRichEdit
      Left = 137
      Top = 0
      Width = 557
      Height = 304
      Align = alClient
      Anchors = []
      BevelInner = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  inherited Memo1: TMemo
    Width = 694
    ExplicitWidth = 694
  end
end
