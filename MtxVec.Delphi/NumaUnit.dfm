object NumaForm: TNumaForm
  Left = 0
  Top = 0
  Caption = 'NumaForm'
  ClientHeight = 688
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    742
    688)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 662
    Width = 33
    Height = 13
    Anchors = [akTop, akBottom]
    Caption = 'Count:'
    Visible = False
  end
  object RunButton: TButton
    Left = 635
    Top = 655
    Width = 99
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'Run'
    TabOrder = 0
    OnClick = RunButtonClick
  end
  object Memo1: TMemo
    Left = 378
    Top = 547
    Width = 356
    Height = 102
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
  end
  object Chart1: TChart
    Left = 8
    Top = 143
    Width = 726
    Height = 395
    Legend.Font.Color = 4210752
    Legend.Font.Height = -13
    Legend.Font.Name = 'Verdana'
    Legend.Frame.Visible = False
    Legend.Transparent = True
    Legend.Visible = False
    Title.Font.Color = clGray
    Title.Font.Height = -16
    Title.Text.Strings = (
      'Memory channel count and performance')
    BottomAxis.Grid.Visible = False
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.Title.Caption = 'Thread count'
    BottomAxis.Title.Font.Color = 4210752
    BottomAxis.Title.Font.Height = -15
    DepthAxis.MinorTicks.Visible = False
    DepthAxis.Title.Font.Color = 4210752
    DepthAxis.Title.Font.Height = -15
    DepthTopAxis.MinorTicks.Visible = False
    DepthTopAxis.Title.Font.Color = 4210752
    DepthTopAxis.Title.Font.Height = -15
    LeftAxis.Axis.Visible = False
    LeftAxis.MinorTicks.Visible = False
    LeftAxis.Title.Caption = 'Memory bandwidth [GB/s]'
    LeftAxis.Title.Font.Color = 4210752
    LeftAxis.Title.Font.Height = -15
    RightAxis.MinorTicks.Visible = False
    RightAxis.Title.Font.Color = 4210752
    RightAxis.Title.Font.Height = -15
    TopAxis.MinorTicks.Visible = False
    TopAxis.Title.Font.Color = 4210752
    TopAxis.Title.Font.Height = -15
    View3D = False
    View3DWalls = False
    Color = clWhite
    TabOrder = 2
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColorPaletteIndex = 0
    object Series1: TBarSeries
      Marks.Arrow.Visible = False
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = False
      Marks.Brush.Color = 6868991
      Marks.Font.Name = 'Verdana'
      Marks.Style = smsValue
      Marks.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object ComputeKindGroup: TRadioGroup
    Left = 8
    Top = 544
    Width = 185
    Height = 105
    Anchors = [akLeft, akBottom]
    Caption = 'Compute kind'
    ItemIndex = 0
    Items.Strings = (
      'Copy (read + write)'
      'Sum (reading only)')
    TabOrder = 3
  end
  object Memo: TMemo
    Left = 8
    Top = 4
    Width = 726
    Height = 133
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object CountEdit: TEdit
    Left = 45
    Top = 659
    Width = 43
    Height = 21
    Anchors = [akTop, akBottom]
    TabOrder = 5
    Text = '70'
    Visible = False
  end
  object MemoryGroup: TRadioGroup
    Left = 207
    Top = 544
    Width = 157
    Height = 105
    Anchors = [akLeft, akBottom]
    Caption = 'Memory selection'
    ItemIndex = 2
    Items.Strings = (
      'CPU Cache L1'
      'CPU Cache L2'
      'Main Memory')
    TabOrder = 6
  end
end
