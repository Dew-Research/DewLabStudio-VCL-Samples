object Introduction: TIntroduction
  Left = 464
  Top = 266
  Caption = 'Introduction'
  ClientHeight = 329
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 506
    Height = 49
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Welcome to DSP Master  v6'
    Color = 14869218
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clGray
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 49
    Width = 506
    Height = 280
    Align = alClient
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
end
