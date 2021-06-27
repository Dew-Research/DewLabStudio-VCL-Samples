object frmListFunc: TfrmListFunc
  Left = 236
  Top = 106
  Caption = 'frmListFunc'
  ClientHeight = 282
  ClientWidth = 523
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 41
    Width = 523
    Height = 241
    Align = alClient
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 18
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 0
    ColWidths = (
      194
      329)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 523
    Height = 41
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
  end
end
