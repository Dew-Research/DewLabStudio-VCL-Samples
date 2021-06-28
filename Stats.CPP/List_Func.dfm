object frmListFunc: TfrmListFunc
  Left = 0
  Top = 0
  Caption = 'frmListFunc'
  ClientHeight = 291
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 426
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 41
    Width = 426
    Height = 250
    Align = alClient
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 18
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 1
    ColWidths = (
      194
      329)
  end
end
