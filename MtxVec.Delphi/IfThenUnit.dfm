object IfThenForm: TIfThenForm
  Left = 0
  Top = 0
  Caption = 'IfThenForm'
  ClientHeight = 591
  ClientWidth = 904
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
    904
    591)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 565
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Data length:'
  end
  object Memo1: TMemo
    Left = 12
    Top = 8
    Width = 884
    Height = 110
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object MaskThreadButton: TButton
    Left = 12
    Top = 529
    Width = 112
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Run'
    TabOrder = 1
    OnClick = MaskThreadButtonClick
  end
  object Chart: TChart
    Left = 12
    Top = 124
    Width = 884
    Height = 393
    Legend.Font.Color = 4210752
    Legend.Font.Height = -13
    Legend.Font.Name = 'Verdana'
    Legend.Frame.Visible = False
    Legend.Transparent = True
    Legend.Visible = False
    Title.Font.Color = clGray
    Title.Font.Height = -16
    Title.Text.Strings = (
      'Vectorization of If-then with masks')
    BottomAxis.Grid.Visible = False
    BottomAxis.LabelsSeparation = 0
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.Title.Font.Color = 4210752
    BottomAxis.Title.Font.Height = -15
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.MinorTicks.Visible = False
    DepthAxis.Title.Font.Color = 4210752
    DepthAxis.Title.Font.Height = -15
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.MinorTicks.Visible = False
    DepthTopAxis.Title.Font.Color = 4210752
    DepthTopAxis.Title.Font.Height = -15
    LeftAxis.Axis.Visible = False
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.MinorTicks.Visible = False
    LeftAxis.Title.Caption = 'Time [ms]'
    LeftAxis.Title.Font.Color = 4210752
    LeftAxis.Title.Font.Height = -15
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.MinorTicks.Visible = False
    RightAxis.Title.Font.Color = 4210752
    RightAxis.Title.Font.Height = -15
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.MinorTicks.Visible = False
    TopAxis.Title.Font.Color = 4210752
    TopAxis.Title.Font.Height = -15
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    View3DWalls = False
    Color = clWhite
    TabOrder = 2
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultCanvas = ''
    ColorPaletteIndex = 0
    object barSeries: TBarSeries
      HoverElement = []
      Marks.Brush.Color = 6868991
      Marks.Font.Name = 'Verdana'
      Marks.Style = smsValue
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object PlainBox: TCheckBox
    Left = 141
    Top = 533
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Plain'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object VecBox: TCheckBox
    Left = 264
    Top = 533
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Vectorized'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object FindIndexBlockBox: TCheckBox
    Left = 384
    Top = 533
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'FindIndexes'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object MaskBlockThreadBox: TCheckBox
    Left = 630
    Top = 533
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Masked&&Thread'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object PlainThreadBox: TCheckBox
    Left = 759
    Top = 533
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Plain&&Thread'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object MaskBlockBox: TCheckBox
    Left = 504
    Top = 533
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Masked&&Blocked'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object DataLenBox: TComboBox
    Left = 141
    Top = 562
    Width = 145
    Height = 21
    Anchors = [akLeft, akBottom]
    TabOrder = 9
    Text = '10MB'
    Items.Strings = (
      '800KB'
      '8MB'
      '80MB'
      '800MB')
  end
end
