object IirZerosForm: TIirZerosForm
  Left = 438
  Top = 238
  Caption = 'Low pass IIR filter zeros'
  ClientHeight = 359
  ClientWidth = 688
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
  object ZeroPoleChart: TSpectrumChart
    Left = 0
    Top = 76
    Width = 688
    Height = 244
    Gradient.EndColor = 12615680
    Title.Font.Color = clWhite
    Title.Text.Strings = (
      'Pole-zero plot')
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.AxisValuesFormat = '#,##0.0'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 30.000000000000000000
    BottomAxis.LabelsOnAxis = False
    BottomAxis.LabelsSeparation = 60
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 1.000000000000000000
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.EndPosition = 100.000000000000000000
    ClipPoints = False
    DepthAxis.AxisValuesFormat = '#,##0.0'
    DepthAxis.LabelsOnAxis = False
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 0.200000000000000000
    LeftAxis.LabelsOnAxis = False
    LeftAxis.LabelsSeparation = 100
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 1.000000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.AxisValuesFormat = '#,##0.0'
    RightAxis.ExactDateTime = False
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.Increment = 0.200000000000000000
    RightAxis.LabelsOnAxis = False
    RightAxis.LabelsSeparation = 100
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.Maximum = 1.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Automatic = False
    TopAxis.AutomaticMaximum = False
    TopAxis.AutomaticMinimum = False
    TopAxis.AxisValuesFormat = '#,##0.0'
    TopAxis.ExactDateTime = False
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.Increment = 0.200000000000000000
    TopAxis.LabelsOnAxis = False
    TopAxis.LabelsSeparation = 50
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.Maximum = 1.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3DOptions.Elevation = 315
    View3DOptions.Orthogonal = False
    View3DOptions.Perspective = 0
    View3DOptions.Rotation = 360
    Zoom.Brush.Gradient.Direction = gdFromTopLeft
    Zoom.Brush.Gradient.EndColor = clSilver
    Zoom.Brush.Gradient.MidColor = clWhite
    Zoom.Brush.Gradient.StartColor = clSilver
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    Color = 12636883
    TabOrder = 0
    Spectrums = <
      item
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = ''
    ColorPaletteIndex = 0
    object Series1: TPolarSeries
      Title = 'Zeros'
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
      AngleIncrement = 30.000000000000000000
      AngleValues.Name = 'Angle'
      AngleValues.Order = loAscending
      Brush.Style = bsClear
      Pen.Color = clRed
      Pen.Visible = False
      Pointer.Brush.Gradient.EndColor = clRed
      Pointer.Gradient.EndColor = clRed
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clRed
      Pointer.Style = psCross
      RadiusIncrement = 0.200000000000000000
    end
    object Series2: TPolarSeries
      SeriesColor = clYellow
      Title = 'Poles'
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
      AngleIncrement = 30.000000000000000000
      AngleValues.Name = 'Angle'
      AngleValues.Order = loAscending
      Brush.Style = bsClear
      Pen.Color = clYellow
      Pen.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      RadiusIncrement = 0.200000000000000000
    end
    object ChartTool1: TAxisScaleTool
      UpperMargin = 20
      LowerMargin = 5
      AxisScaleMode = amNone
      DataIsSpectrum = True
      AxisID = 2
    end
    object ChartTool2: TSpectrumMarkTool
      CursorActive = True
      DoubleClickClear = True
      PeakFilterMode = False
      MarkMode = mmSingle
      MarkType = mtAmplt
      AmpltFormat = '0.00#'
      PhaseFormat = '0.00#'
      FreqFormat = '0.00#'
      LabelHeaders = True
      PeakZoomBand = False
      ConfLabels = cnfNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 688
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 282
      Top = 15
      Width = 29
      Height = 13
      Caption = 'Order:'
    end
    object Label2: TLabel
      Left = 402
      Top = 15
      Width = 38
      Height = 13
      Caption = 'Att (dB):'
    end
    object Label3: TLabel
      Left = 150
      Top = 12
      Width = 25
      Height = 13
      Caption = 'Filter:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 121
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 95
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '          Chart           '
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
    end
    object OrderEdit: TMtxFloatEdit
      Left = 326
      Top = 9
      Width = 53
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '45'
      MinValue = '1'
      TabOrder = 1
      Value = '5'
      OnChange = OrderEditChange
    end
    object AttEdit: TMtxFloatEdit
      Left = 446
      Top = 9
      Width = 53
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Enabled = False
      Increment = '1'
      MaxValue = '200'
      MinValue = '1'
      TabOrder = 2
      Value = '40'
      OnChange = OrderEditChange
    end
    object FilterBox: TComboBox
      Left = 186
      Top = 9
      Width = 85
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = FilterBoxChange
      Items.Strings = (
        'Butterworth'
        'Chebyshev I'
        'Chebyshev II'
        'Elliptic')
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 688
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
    Chart = ZeroPoleChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
end
