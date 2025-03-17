object CompoundExpressionsForm: TCompoundExpressionsForm
  Left = 0
  Top = 0
  Caption = 'CompoundExpressionsForm'
  ClientHeight = 746
  ClientWidth = 1114
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 674
    Width = 1114
    Height = 72
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      1114
      72)
    object RunButton: TButton
      Left = 23
      Top = 21
      Width = 107
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = RunButtonClick
    end
    object PrecisionGroup: TRadioGroup
      Left = 189
      Top = 3
      Width = 907
      Height = 58
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Math selection'
      Columns = 5
      ItemIndex = 0
      Items.Strings = (
        'Double Floating point'
        'Complex Floating point'
        'Saturated Integer'
        'Saturated SmallInt'
        'Saturated Byte')
      TabOrder = 1
      OnClick = PrecisionGroupClick
    end
  end
  object Chart: TChart
    Left = 0
    Top = 89
    Width = 1114
    Height = 585
    Title.Text.Strings = (
      'Comparing compound and sequenced expressions')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 5.000000000000000000
    BottomAxis.EndPosition = 100.000000000000000000
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 217.331250000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    LeftAxis.Title.Caption = 'Time [ms]'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    Zoom.Animated = True
    Zoom.Pen.Color = clBlack
    Align = alClient
    Color = clWhite
    TabOrder = 1
    DefaultCanvas = ''
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      Marks.Style = smsValue
      Marks.OnTop = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series2: TBarSeries
      Marks.Style = smsValue
      Marks.OnTop = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object Memo: TRichEdit
    Left = 0
    Top = 0
    Width = 1114
    Height = 89
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Memo')
    ParentFont = False
    TabOrder = 2
  end
end
