object BasicForm1: TBasicForm1
  Left = 348
  Top = 216
  Caption = 'BasicForm1'
  ClientHeight = 461
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 130
    Align = alTop
    TabOrder = 0
    object RichEdit1: TRichEdit
      Left = 1
      Top = 1
      Width = 572
      Height = 128
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
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
    Top = 387
    Width = 574
    Height = 74
    Align = alBottom
    Color = 14869218
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
    Width = 574
    Height = 257
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Color = 14869218
    Title.Font.Color = 12222282
    Title.Font.Height = -13
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'TChart')
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    Color = 14869218
    TabOrder = 2
  end
end
