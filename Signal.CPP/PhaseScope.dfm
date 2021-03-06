object PhaseScopeForm: TPhaseScopeForm
  Left = 0
  Top = 0
  Caption = 'PhaseScopeForm'
  ClientHeight = 447
  ClientWidth = 648
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
    Top = 408
    Width = 648
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 230
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Channel:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 201
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
    object ChannelBox: TComboBox
      Left = 276
      Top = 9
      Width = 53
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        'Left'
        'Right')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 648
    Height = 332
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    OnResize = Panel2Resize
    object Splitter1: TSplitter
      Left = 1
      Top = 205
      Width = 646
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SignalChart1: TSignalChart
      Left = 1
      Top = 208
      Width = 646
      Height = 123
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Time signal')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.Title.Caption = 'Time [s]'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 1017.500000000000000000
      LeftAxis.Minimum = 505.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Zoom.Pen.Color = clBlack
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      Signals = <
        item
          SeriesName = 'Series3'
          Series = Series3
          InputsItemIndex = 0
          Input = Signal1
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series3: TFastLineSeries
        SeriesColor = 10485760
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 646
      Height = 204
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Splitter2: TSplitter
        Left = 335
        Top = 0
        Width = 4
        Height = 204
      end
      object RightPhaseChart: TChart
        Left = 339
        Top = 0
        Width = 307
        Height = 204
        Legend.Visible = False
        Title.Text.Strings = (
          'Right channel')
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.AxisValuesFormat = '#,##0.0'
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 45.000000000000000000
        BottomAxis.LabelsSeparation = 100
        BottomAxis.LogarithmicBase = 10.000000000000000000
        BottomAxis.Maximum = 813.131961155965500000
        ClipPoints = False
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.LabelsSeparation = 40
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.Maximum = 0.500000000000000000
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.Maximum = 0.500000000000000000
        LeftAxis.AxisValuesFormat = '#,##0.0'
        LeftAxis.ExactDateTime = False
        LeftAxis.LabelsSeparation = 40
        LeftAxis.LogarithmicBase = 10.000000000000000000
        LeftAxis.Maximum = 941.655240392849000000
        LeftAxis.Minimum = -799.896586652017400000
        RightAxis.Automatic = False
        RightAxis.AutomaticMinimum = False
        RightAxis.AxisValuesFormat = '#,##0.0'
        RightAxis.ExactDateTime = False
        RightAxis.LabelsSeparation = 40
        RightAxis.LogarithmicBase = 10.000000000000000000
        RightAxis.ZPosition = 100.000000000000000000
        TopAxis.Automatic = False
        TopAxis.AutomaticMinimum = False
        TopAxis.AxisValuesFormat = '#,##0.0'
        TopAxis.ExactDateTime = False
        TopAxis.LabelsSeparation = 40
        TopAxis.LogarithmicBase = 10.000000000000000000
        TopAxis.ZPosition = 100.000000000000000000
        View3D = False
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        BevelOuter = bvLowered
        Color = clWhite
        TabOrder = 0
        DefaultCanvas = 'TTeeCanvas3D'
        ColorPaletteIndex = 0
        object Series1: TSignalPolarSeries
          XValues.Name = 'Angle'
          XValues.Order = loNone
          YValues.Name = 'Radius'
          YValues.Order = loNone
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          Shadow.Visible = False
          AngleIncrement = 45.000000000000000000
          AngleValues.Name = 'Angle'
          AngleValues.Order = loNone
          Brush.Style = bsClear
          Pen.Color = clRed
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
        end
        object ChartTool5: TAxisScaleTool
          UpperMargin = 0
          LowerMargin = 0
          AxisScaleMode = amPeakHold
          DataIsSpectrum = False
          AxisID = 2
        end
      end
      object LeftPhaseChart: TChart
        Left = 0
        Top = 0
        Width = 335
        Height = 204
        Legend.Visible = False
        Title.Text.Strings = (
          'Left channel')
        BottomAxis.AxisValuesFormat = '#,##0.0'
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 45.000000000000000000
        BottomAxis.LabelsSeparation = 100
        BottomAxis.LogarithmicBase = 10.000000000000000000
        BottomAxis.Maximum = 869.410784243132500000
        BottomAxis.Minimum = -724.543151646832100000
        ClipPoints = False
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.Maximum = 0.500000000000000000
        DepthAxis.Minimum = -0.500000000000000000
        DepthAxis.Visible = True
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.Maximum = 0.500000000000000000
        DepthTopAxis.Minimum = -0.500000000000000000
        LeftAxis.LabelsSeparation = 100
        LeftAxis.LogarithmicBase = 10.000000000000000000
        LeftAxis.Maximum = 850.852702034167700000
        LeftAxis.Minimum = -819.102870766060200000
        RightAxis.LabelsSeparation = 40
        RightAxis.LogarithmicBase = 10.000000000000000000
        RightAxis.ZPosition = 100.000000000000000000
        TopAxis.AxisValuesFormat = '#,##0.0'
        TopAxis.LabelsSeparation = 100
        TopAxis.LogarithmicBase = 10.000000000000000000
        TopAxis.ZPosition = 100.000000000000000000
        View3D = False
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alLeft
        BevelOuter = bvLowered
        Color = clWhite
        TabOrder = 1
        DefaultCanvas = 'TTeeCanvas3D'
        ColorPaletteIndex = 0
        object Series4: TSignalPolarSeries
          XValues.Name = 'Angle'
          XValues.Order = loNone
          YValues.Name = 'Radius'
          YValues.Order = loNone
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          Shadow.Visible = False
          AngleIncrement = 45.000000000000000000
          AngleValues.Name = 'Angle'
          AngleValues.Order = loNone
          Brush.Style = bsClear
          Pen.Color = clGreen
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
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
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 648
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
    Chart = LeftPhaseChart
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
    SamplingFrequency = 11025.000000000000000000
    UsesInputs = False
    TriggerChannel = chLeft
    TriggerDelay = 0
    TriggerPosition = tpAfter
    TriggerMode = trCrossing
    Triggering = trNone
    Left = 332
    Top = 123
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
