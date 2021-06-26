object ExprToolTipForm: TExprToolTipForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 2
  Caption = 'ToolTip'
  ClientHeight = 370
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MtxVecGrid: TMtxVecGrid
    Left = 0
    Top = 0
    Width = 508
    Height = 370
    Align = alClient
    DefaultRowHeight = 16
    Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goTabs, goThumbTracking]
    TabOrder = 0
    Scientific = False
    StringFormat = '0.####'
    ExplicitLeft = 102
    ExplicitTop = 69
    ExplicitWidth = 320
    ExplicitHeight = 120
    ColWidths = (
      60
      64)
    RowHeights = (
      32
      16)
  end
end
