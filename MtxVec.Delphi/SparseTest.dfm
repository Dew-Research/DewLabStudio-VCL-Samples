inherited frmSparseTest: TfrmSparseTest
  Top = 179
  Caption = 'frmSparseTest'
  ClientHeight = 545
  ClientWidth = 771
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 787
  ExplicitHeight = 584
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 771
    Height = 118
    ExplicitWidth = 771
    ExplicitHeight = 118
    inherited RichEdit1: TRichEdit
      Width = 769
      Height = 116
      ExplicitWidth = 769
      ExplicitHeight = 71
    end
  end
  inherited Panel2: TPanel
    Top = 513
    Width = 771
    Height = 32
    ExplicitTop = 513
    ExplicitWidth = 771
    ExplicitHeight = 32
  end
  inherited Panel3: TPanel
    Top = 118
    Width = 771
    Height = 395
    ExplicitTop = 72
    ExplicitWidth = 771
    ExplicitHeight = 441
    object Splitter1: TSplitter
      Left = 247
      Top = 1
      Height = 393
      ExplicitLeft = 132
      ExplicitTop = 366
      ExplicitHeight = 100
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 246
      Height = 393
      Align = alLeft
      Color = 14869218
      TabOrder = 0
      ExplicitHeight = 439
      DesignSize = (
        246
        393)
      object Label1: TLabel
        Left = 93
        Top = 14
        Width = 90
        Height = 13
        Caption = 'Solve Report Level'
      end
      object Button1: TButton
        Left = 7
        Top = 22
        Width = 80
        Height = 32
        Caption = 'Run'
        TabOrder = 0
        OnClick = Button1Click
      end
      object ComboBox1: TComboBox
        Left = 93
        Top = 33
        Width = 142
        Height = 21
        ItemIndex = 0
        TabOrder = 1
        Text = 'prlNone'
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
        Top = 60
        Width = 234
        Height = 228
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssBoth
        TabOrder = 2
        ExplicitHeight = 274
      end
    end
    object Chart1: TChart
      Left = 250
      Top = 1
      Width = 520
      Height = 393
      AllowPanning = pmNone
      BackWall.Brush.Style = bsClear
      LeftWall.Color = clGray
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
      LeftAxis.Maximum = 832.500000000000000000
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
      Zoom.Pen.Mode = pmNotXor
      Align = alClient
      Color = 14869218
      TabOrder = 1
      ExplicitHeight = 439
      DefaultCanvas = ''
      ColorPaletteIndex = 13
      object Series1: TBarSeries
        HoverElement = []
        SeriesColor = 12222282
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
      end
    end
  end
end
