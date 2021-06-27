object LissajousScopeForm: TLissajousScopeForm
  Left = 0
  Top = 0
  Caption = 'LissajousScopeForm'
  ClientHeight = 434
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 395
    Width = 625
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 134
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Samples:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 111
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 73
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '      Chart       '
        ImageIndex = 1
        OnClick = ChartButtonClick
      end
    end
    object SamplesBox: TComboBox
      Left = 184
      Top = 9
      Width = 85
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = SamplesBoxChange
      Items.Strings = (
        '500'
        '1000'
        '2000'
        '3000'
        '4000'
        '8000'
        '16000')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 625
    Height = 319
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object PhaseChart: TChart
      Left = 1
      Top = 1
      Width = 623
      Height = 317
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Lissajous')
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMaximum = False
      BottomAxis.AutomaticMinimum = False
      BottomAxis.AxisValuesFormat = '#,##0.0'
      BottomAxis.ExactDateTime = False
      BottomAxis.Increment = 45.000000000000000000
      BottomAxis.Labels = False
      BottomAxis.LabelsSeparation = 100
      BottomAxis.Maximum = 988.000000000000000000
      BottomAxis.Minimum = 15.000000000000000000
      BottomAxis.Visible = False
      ClipPoints = False
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Grid.Visible = False
      LeftAxis.Labels = False
      LeftAxis.LabelsSeparation = 100
      LeftAxis.Maximum = 988.000000000000000000
      LeftAxis.Minimum = 15.000000000000000000
      LeftAxis.Visible = False
      RightAxis.Automatic = False
      RightAxis.AutomaticMaximum = False
      RightAxis.AutomaticMinimum = False
      RightAxis.Labels = False
      RightAxis.LabelsSeparation = 40
      RightAxis.Maximum = 0.000000000100000000
      RightAxis.Visible = False
      TopAxis.Automatic = False
      TopAxis.AutomaticMaximum = False
      TopAxis.AutomaticMinimum = False
      TopAxis.AxisValuesFormat = '#,##0.0'
      TopAxis.Labels = False
      TopAxis.LabelsSeparation = 100
      TopAxis.Maximum = 0.000000000100000000
      TopAxis.Visible = False
      View3D = False
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      BevelOuter = bvLowered
      Color = 12636883
      TabOrder = 0
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series1: TPolarSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Visible = False
        XValues.Name = 'Angle'
        XValues.Order = loNone
        YValues.Name = 'Radius'
        YValues.Order = loNone
        AngleIncrement = 45.000000000000000000
        AngleValues.Name = 'Angle'
        AngleValues.Order = loAscending
        Brush.Color = clWhite
        Brush.Style = bsClear
        CirclePen.Visible = False
        Pen.Color = clRed
        Pen.Visible = False
        Pointer.Brush.Gradient.EndColor = clRed
        Pointer.Gradient.EndColor = clRed
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psSmallDot
        Pointer.VertSize = 2
        Pointer.Visible = True
      end
      object ChartTool1: TAxisScaleTool
        UpperMargin = 0
        LowerMargin = 0
        AxisScaleMode = amPeakHold
        DataIsSpectrum = False
        AxisID = 2
      end
      object ChartTool2: TAxisScaleTool
        UpperMargin = 0
        LowerMargin = 0
        AxisScaleMode = amPeakHold
        DataIsSpectrum = False
        AxisID = 1
      end
      object ChartTool3: TAxisScaleTool
        UpperMargin = 0
        LowerMargin = 0
        AxisScaleMode = amPeakHold
        DataIsSpectrum = False
        AxisID = 3
      end
      object ChartTool4: TAxisScaleTool
        UpperMargin = 0
        LowerMargin = 0
        AxisScaleMode = amPeakHold
        DataIsSpectrum = False
        AxisID = 0
      end
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 625
    Height = 76
    Align = alTop
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object ChartEditor: TChartEditor
    Chart = PhaseChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 282
    Top = 99
  end
  object Signal1: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 123
    MtxDataValues = {}
  end
  object Signal2: TSignal
    SamplingFrequency = 1.000000000000000000
    Left = 374
    Top = 159
    MtxDataValues = {}
  end
  object SignalIn1: TSignalIn
    ChannelCount = 2
    SamplingFrequency = 44100.000000000000000000
    BufferSize = 32000
    UsesInputs = False
    TriggerChannel = chLeft
    TriggerDelay = 0
    TriggerPosition = tpAfter
    TriggerMode = trCrossing
    Triggering = trNone
    Left = 330
    Top = 135
    MtxDataValues = {}
  end
  object SignalTimer1: TSignalTimer
    Enabled = True
    Interval = 50
    Frequency = 20.000000000000000000
    OnTimer = SignalTimer1Timer
    Left = 374
    Top = 87
    MtxDataValues = {}
  end
end
