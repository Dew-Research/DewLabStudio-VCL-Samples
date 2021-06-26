object frmListFunc: TfrmListFunc
  Left = 1495
  Top = 205
  Caption = 'frmListFunc'
  ClientHeight = 284
  ClientWidth = 544
  Color = 14869218
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    544
    284)
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 41
    Width = 544
    Height = 243
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
    TabOrder = 0
    ColWidths = (
      245
      329)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 544
    Height = 41
    Align = alTop
    Color = 14869218
    TabOrder = 1
    DesignSize = (
      544
      41)
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Button1: TButton
      Left = 397
      Top = 8
      Width = 57
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Find'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Button2: TButton
    Left = 477
    Top = 8
    Width = 60
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    TabOrder = 2
    OnClick = Button2Click
  end
end
