inherited frmSparseTest: TfrmSparseTest
  Left = 253
  Top = 139
  Caption = 'frmSparseTest'
  ClientHeight = 499
  ClientWidth = 800
  OnDestroy = FormDestroy
  ExplicitWidth = 816
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 105
    Width = 800
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 360
  end
  inherited Panel1: TPanel
    Width = 800
    Height = 105
    ExplicitWidth = 800
    ExplicitHeight = 105
    inherited RichEdit1: TRichEdit
      Width = 798
      Height = 103
      ExplicitWidth = 798
      ExplicitHeight = 103
    end
  end
  inherited Panel2: TPanel
    Top = 467
    Width = 800
    Height = 32
    ExplicitTop = 467
    ExplicitWidth = 800
    ExplicitHeight = 32
  end
  inherited Panel3: TPanel
    Top = 108
    Width = 800
    Height = 359
    ExplicitTop = 108
    ExplicitWidth = 800
    ExplicitHeight = 359
    object Chart1: TChart
      Left = 217
      Top = 1
      Width = 582
      Height = 357
      AllowPanning = pmNone
      BackWall.Brush.Style = bsClear
      LeftWall.Color = 16744703
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 5.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'Operation'
      BottomAxis.Visible = False
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 95.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'Time for 100 evaluations [ms]'
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      Align = alClient
      Color = 14869218
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object Series1: TBarSeries
        HoverElement = []
        SeriesColor = 12615808
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 216
      Height = 357
      Align = alLeft
      Caption = '$00E2E2E2'
      Color = 14869218
      TabOrder = 1
      DesignSize = (
        216
        357)
      object Label1: TLabel
        Left = 85
        Top = 13
        Width = 91
        Height = 13
        Caption = 'Solve Report Level'
      end
      object Button1: TButton
        Left = 7
        Top = 13
        Width = 72
        Height = 40
        Caption = 'Do tests'
        TabOrder = 0
        OnClick = Button1Click
      end
      object ComboBox1: TComboBox
        Left = 84
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'prlNone'
        OnChange = ComboBox1Change
        Items.Strings = (
          'prlNone'
          'prlErrorsOnly'
          'prlBasic'
          'prlExtensive'
          'prlComplete'
          'prlAll')
      end
      object Memo1: TMemo
        Left = 7
        Top = 67
        Width = 198
        Height = 197
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssBoth
        TabOrder = 2
      end
    end
  end
end
