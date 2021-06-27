object BasicForm1: TBasicForm1
  Left = 1551
  Top = 174
  Caption = 'BasicForm1'
  ClientHeight = 457
  ClientWidth = 566
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 566
    Height = 130
    Align = alTop
    TabOrder = 0
    object RichEdit1: TRichEdit
      Left = 1
      Top = 1
      Width = 564
      Height = 128
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 383
    Width = 566
    Height = 74
    Align = alBottom
    TabOrder = 1
    object CheckDownSample: TCheckBox
      Left = 8
      Top = 8
      Width = 89
      Height = 17
      Caption = 'DownSample'
      TabOrder = 0
      OnClick = CheckDownSampleClick
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 130
    Width = 566
    Height = 253
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = 12615680
    Title.Text.Strings = (
      'TChart')
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    Color = 12570367
    TabOrder = 2
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
  end
end
