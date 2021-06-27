object BasicForm1: TBasicForm1
  Left = 0
  Top = 0
  Caption = 'BasicForm1'
  ClientHeight = 566
  ClientWidth = 677
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
    Width = 677
    Height = 130
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -148
    object RichEdit1: TRichEdit
      Left = 1
      Top = 1
      Width = 675
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
    Top = 492
    Width = 677
    Height = 74
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = -148
    ExplicitTop = 217
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
    Width = 677
    Height = 362
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = 12615680
    Title.Text.Strings = (
      'TChart')
    View3D = False
    Align = alClient
    Color = 12570367
    TabOrder = 2
  end
end
