object PhaseDemoForm: TPhaseDemoForm
  Left = 0
  Top = 0
  Caption = 'PhaseDemoForm'
  ClientHeight = 455
  ClientWidth = 681
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
    Top = 416
    Width = 681
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 176
      Top = 12
      Width = 49
      Height = 13
      Caption = 'Fir length:'
    end
    object Label2: TLabel
      Left = 308
      Top = 12
      Width = 100
      Height = 13
      Caption = 'Zero padding power:'
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
    object StepEdit: TMtxFloatEdit
      Left = 226
      Top = 9
      Width = 71
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '64'
      MinValue = '4'
      TabOrder = 1
      Value = '60'
      OnChange = StepEditChange
    end
    object ZeroPaddEdit: TMtxFloatEdit
      Left = 410
      Top = 9
      Width = 71
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '10'
      MinValue = '1'
      TabOrder = 2
      Value = '4'
      OnChange = StepEditChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 681
    Height = 340
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 1
      Width = 679
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SignalChart1: TSignalChart
      Left = 1
      Top = 4
      Width = 679
      Height = 335
      Gradient.Direction = gdFromTopLeft
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Legend.Visible = False
      Title.Text.Strings = (
        'Phase spectrum')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Title.Caption = 'Frequency'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Title.Caption = 'Degrees'
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
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
      object Series1: TSignalDiscreteSeries
        HoverElement = [heCurrent]
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = clRed
        Pointer.Gradient.EndColor = clRed
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
        UseYOrigin = True
      end
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 681
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
