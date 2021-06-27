object frmListFunc: TfrmListFunc
  Left = 438
  Top = 272
  Caption = 'frmListFunc'
  ClientHeight = 313
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  DesignSize = (
    514
    313)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 41
    Align = alTop
    Color = 14869218
    TabOrder = 0
    DesignSize = (
      514
      41)
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Button1: TButton
      Left = 367
      Top = 8
      Width = 57
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Find'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 41
    Width = 514
    Height = 272
    Align = alClient
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 18
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 1
    ColWidths = (
      245
      329)
  end
  object Button2: TButton
    Left = 446
    Top = 8
    Width = 60
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    TabOrder = 2
    OnClick = Button2Click
  end
end
