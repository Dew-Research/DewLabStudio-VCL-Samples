object IirGroupDelayForm: TIirGroupDelayForm
  Left = 0
  Top = 0
  Caption = 'IirGroupDelayForm'
  ClientHeight = 503
  ClientWidth = 694
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
    Top = 464
    Width = 694
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 148
      Top = 15
      Width = 32
      Height = 13
      Caption = 'Order:'
    end
    object Label2: TLabel
      Left = 268
      Top = 15
      Width = 42
      Height = 13
      Caption = 'Att (dB):'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 127
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 76
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '      Chart        '
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
    end
    object OrderEdit: TMtxFloatEdit
      Left = 192
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
      Left = 312
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
      MaxValue = '200'
      MinValue = '1'
      TabOrder = 2
      Value = '40'
      OnChange = OrderEditChange
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 694
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
    TabOrder = 1
    Zoom = 100
  end
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 76
    Width = 694
    Height = 388
    Gradient.EndColor = 12615680
    Legend.CheckBoxes = True
    Title.Font.Color = clWhite
    Title.Text.Strings = (
      'Group delay')
    BottomAxis.AxisValuesFormat = '#,##0.00'
    BottomAxis.LabelsSeparation = 20
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Title.Caption = 'Group delay [samples]'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Pen.Color = clBlack
    Align = alClient
    Color = 12636883
    TabOrder = 2
    Spectrums = <
      item
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TTeeCanvas3D'
    ColorPaletteIndex = 0
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
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
end
