object frmLogForm: TfrmLogForm
  Left = 260
  Top = 163
  Caption = 'Calculated coefficients'
  ClientHeight = 316
  ClientWidth = 396
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 396
    Height = 46
    Align = alTop
    TabOrder = 0
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
  object Memo1: TMemo
    Left = 0
    Top = 46
    Width = 396
    Height = 270
    Align = alClient
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
