object frmLogForm: TfrmLogForm
  Left = 260
  Top = 163
  Caption = 'Calculated coefficients'
  ClientHeight = 323
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 46
    Width = 404
    Height = 277
    Align = alClient
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 404
    Height = 46
    Align = alTop
    TabOrder = 1
    object Button1: TButton
      Left = 7
      Top = 13
      Width = 60
      Height = 20
      Caption = 'Clear'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
