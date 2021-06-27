object MedianDemoForm: TMedianDemoForm
  Left = 0
  Top = 0
  Caption = 'MedianDemoForm'
  ClientHeight = 459
  ClientWidth = 669
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
    Top = 420
    Width = 669
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 164
      Top = 12
      Width = 28
      Height = 13
      Caption = 'Filter:'
    end
    object Label2: TLabel
      Left = 338
      Top = 12
      Width = 49
      Height = 13
      Caption = 'Mask size:'
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
        Caption = '       Chart       '
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
    end
    object FilterBox: TComboBox
      Left = 198
      Top = 9
      Width = 103
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = FilterBoxChange
      Items.Strings = (
        'Median'
        'Delay')
    end
    object StepEdit: TMtxFloatEdit
      Left = 394
      Top = 9
      Width = 58
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '200'
      MinValue = '0'
      TabOrder = 2
      Value = '10'
      OnChange = FilterBoxChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 669
    Height = 344
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 1
      Width = 667
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SignalChart1: TSignalChart
      Left = 1
      Top = 4
      Width = 667
      Height = 339
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Title.Text.Strings = (
        'Time signal')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'Time [s]'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Zoom.Pen.Color = clBlack
      Align = alClient
      BevelOuter = bvNone
      Color = 12636883
      TabOrder = 0
      Signals = <
        item
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series3: TFastLineSeries
        HoverElement = []
        SeriesColor = 10485760
        Title = 'Original'
        LinePen.Color = 10485760
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series1: TFastLineSeries
        HoverElement = []
        Title = 'Filtered'
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 669
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
    Zoom = 100
  end
  object ChartEditor: TChartEditor
    Chart = SignalChart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
end
