object PinkNoiseForm: TPinkNoiseForm
  Left = 0
  Top = 0
  Caption = 'Pink noise'
  ClientHeight = 452
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 0
    Width = 635
    Height = 416
    Legend.Visible = False
    Title.Text.Strings = (
      'Frequency response of the designed FIR filter')
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Logarithmic = True
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.Minimum = 0.100000000000000000
    BottomAxis.EndPosition = 100.000000000000000000
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = -1.809999999999999000
    DepthAxis.Minimum = -2.809999999999996000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.Automatic = False
    DepthTopAxis.AutomaticMaximum = False
    DepthTopAxis.AutomaticMinimum = False
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = -1.809999999999999000
    DepthTopAxis.Minimum = -2.809999999999996000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 130.000000000000000000
    LeftAxis.MaximumOffset = 1
    LeftAxis.Minimum = 2.500000000000000000
    LeftAxis.MinimumOffset = 1
    LeftAxis.EndPosition = 100.000000000000000000
    LeftAxis.Title.Caption = 'Magnitude [dB]'
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Animated = True
    Zoom.Pen.Color = clBlack
    Align = alClient
    TabOrder = 0
    Spectrums = <>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TMtxFastLineSeries
      HoverElement = []
      LinePen.Color = 10708548
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 416
    Width = 635
    Height = 36
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 9
      Width = 56
      Height = 13
      Caption = 'Noise color:'
    end
    object FsLabel: TLabel
      Left = 264
      Top = 9
      Width = 98
      Height = 13
      Caption = 'Sampling frequency:'
    end
    object NoiseBox: TComboBox
      Left = 78
      Top = 6
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = NoiseBoxChange
      Items.Strings = (
        'Pink (-10dB/dek)'
        'Brown(ian) (-20dB/dek)'
        'Blue (+10dB/dek)'
        'Violet (+20dB/dek)')
    end
    object FSEdit: TMtxFloatEdit
      Left = 368
      Top = 6
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1000'
      MaxValue = '1E30'
      MinValue = '1'
      TabOrder = 1
      Value = '22050'
      OnChange = FSEditChange
    end
  end
  object ChartEditor1: TChartEditor
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 248
    Top = 232
  end
end
