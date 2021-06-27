object frmFind: TfrmFind
  Left = 467
  Top = 285
  Caption = 'Look for'
  ClientHeight = 76
  ClientWidth = 287
  Color = 14869218
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 78
    Height = 13
    Caption = 'Search for text : '
  end
  object Edit1: TEdit
    Left = 88
    Top = 8
    Width = 177
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Search'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 88
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 184
    Top = 40
    Width = 97
    Height = 17
    Caption = 'Find All Words'
    TabOrder = 3
  end
end
