object ARMATrendForm: TARMATrendForm
  Left = 0
  Top = 0
  Caption = 'ARMA Trend'
  ClientHeight = 551
  ClientWidth = 990
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  DesignSize = (
    990
    551)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 60
    Height = 13
    Caption = 'ARMA model'
  end
  object ModelLabel: TLabel
    Left = 237
    Top = 520
    Width = 32
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Model:'
  end
  object SignalChart1: TChart
    Left = 231
    Top = 8
    Width = 745
    Height = 503
    Title.Text.Strings = (
      'ARIMA forecast with trend decomposition')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
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
    LeftAxis.Maximum = 887.500000000000000000
    LeftAxis.Minimum = 506.225000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    Color = clWhite
    TabOrder = 0
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultCanvas = ''
    ColorPaletteIndex = 0
    object Series1: TMtxFastLineSeries
      HoverElement = []
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TMtxFastLineSeries
      HoverElement = []
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TMtxFastLineSeries
      HoverElement = []
      SeriesColor = clBlue
      LinePen.Color = clBlue
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object ARMAModelBox: TComboBox
    Left = 80
    Top = 13
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = 'ARIMA (2, 0, 1)'
    OnChange = ARMAModelBoxChange
    Items.Strings = (
      'ARIMA (2, 0, 1)'
      'ARIMA (3, 0, 2)'
      'ARIMA (5, 0, 4)')
  end
end
