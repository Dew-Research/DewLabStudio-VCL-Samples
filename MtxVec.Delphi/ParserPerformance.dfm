inherited frmParserPerformance: TfrmParserPerformance
  Left = 372
  Top = 230
  Caption = 'frmParserPerformance'
  ClientHeight = 500
  ClientWidth = 649
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 665
  ExplicitHeight = 539
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 649
    ExplicitWidth = 649
    inherited RichEdit1: TRichEdit
      Width = 647
      ExplicitWidth = 647
    end
  end
  inherited Panel2: TPanel
    Top = 442
    Width = 649
    ExplicitTop = 442
    ExplicitWidth = 649
  end
  inherited Panel3: TPanel
    Width = 649
    Height = 312
    ExplicitWidth = 649
    ExplicitHeight = 312
    object Label1: TLabel
      Left = 16
      Top = 18
      Width = 80
      Height = 13
      Caption = 'Start at [x = ..]:'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 81
      Height = 13
      Caption = 'Stop at [x = ..] :'
    end
    object Label3: TLabel
      Left = 16
      Top = 124
      Width = 65
      Height = 13
      Caption = 'Formula: y = '
    end
    object Label4: TLabel
      Left = 16
      Top = 76
      Width = 68
      Height = 13
      Caption = 'Step on x axis'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 105
      Width = 165
      Height = 50
      Shape = bsTopLine
    end
    object StandardLabel: TLabel
      Left = 24
      Top = 252
      Width = 81
      Height = 13
      Caption = 'Standard time = '
      Visible = False
    end
    object vectorLabel: TLabel
      Left = 24
      Top = 271
      Width = 68
      Height = 13
      Caption = 'Vector time = '
      Visible = False
    end
    object RatioLabel: TLabel
      Left = 23
      Top = 290
      Width = 68
      Height = 13
      Caption = 'Vector time = '
      Visible = False
    end
    object Chart1: TChart
      Left = 204
      Top = 1
      Width = 444
      Height = 310
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 687.500000000000000000
      LeftAxis.Minimum = 120.000000000000000000
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      Zoom.Pen.Mode = pmNotXor
      BevelOuter = bvLowered
      TabOrder = 0
      Anchors = [akLeft, akTop, akRight, akBottom]
      DefaultCanvas = ''
      ColorPaletteIndex = 0
      object Series1: TFastLineSeries
        HoverElement = []
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object FormulaEdit: TEdit
      Left = 90
      Top = 118
      Width = 91
      Height = 21
      TabOrder = 1
      Text = 'x'
    end
    object ComputationGroup: TRadioGroup
      Left = 16
      Top = 154
      Width = 174
      Height = 48
      Caption = 'Computation method'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Standard'
        'Vectorized')
      TabOrder = 2
    end
    object UpdateButton: TButton
      Left = 105
      Top = 216
      Width = 85
      Height = 25
      Caption = 'Update'
      TabOrder = 3
      OnClick = UpdateButtonClick
    end
    object BenchmarkButtom: TButton
      Left = 14
      Top = 216
      Width = 85
      Height = 25
      Caption = 'Benchmark'
      TabOrder = 4
      OnClick = BenchmarkButtomClick
    end
    object StartXEdit: TMtxFloatEdit
      Left = 100
      Top = 14
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 5
      Value = '0.00'
    end
    object StopXEdit: TMtxFloatEdit
      Left = 100
      Top = 42
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 6
      Value = '99.00'
    end
    object StepXEdit: TMtxFloatEdit
      Left = 100
      Top = 70
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 7
      Value = '1.00'
    end
  end
end
