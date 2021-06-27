object MedianDemoForm: TMedianDemoForm
  Left = 116
  Top = 145
  Caption = 'Median demo'
  ClientHeight = 355
  ClientWidth = 680
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
  object Panel1: TPanel
    Left = 0
    Top = 316
    Width = 680
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 164
      Top = 12
      Width = 25
      Height = 13
      Caption = 'Filter:'
    end
    object Label2: TLabel
      Left = 338
      Top = 12
      Width = 50
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
      ButtonWidth = 74
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
      OnChange = StepEditChange
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 680
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 680
    Height = 240
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 1
      Width = 678
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SignalChart1: TSignalChart
      Left = 1
      Top = 4
      Width = 678
      Height = 235
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Title.Text.Strings = (
        'Time signal')
      BottomAxis.MaximumOffset = 1
      BottomAxis.MinimumOffset = 1
      BottomAxis.Title.Caption = 'Time [s]'
      LeftAxis.MaximumOffset = 1
      LeftAxis.MinimumOffset = 1
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
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
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
