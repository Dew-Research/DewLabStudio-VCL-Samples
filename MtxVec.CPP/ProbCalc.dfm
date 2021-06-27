inherited Prob1: TProb1
  Caption = 'Prob1'
  ClientHeight = 596
  ClientWidth = 656
  OldCreateOrder = True
  OnDestroy = FormDestroy
  ExplicitWidth = 672
  ExplicitHeight = 635
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 656
    Height = 73
    ExplicitWidth = 656
    ExplicitHeight = 73
    inherited RichEdit1: TRichEdit
      Width = 654
      Height = 71
      Font.Color = 7105644
      ExplicitWidth = 654
      ExplicitHeight = 71
    end
  end
  inherited Panel2: TPanel
    Top = 554
    Width = 656
    Height = 42
    ExplicitTop = 554
    ExplicitWidth = 656
    ExplicitHeight = 42
    object Button1: TBitBtn
      Left = 16
      Top = 8
      Width = 89
      Height = 25
      Hint = 'calculate PDF/CDF'
      Caption = 'Calc probability'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 112
      Top = 8
      Width = 89
      Height = 25
      Hint = 'calculate inverse CDF'
      Caption = 'Calc x'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  inherited Panel3: TPanel
    Top = 73
    Width = 656
    Height = 481
    Constraints.MinHeight = 350
    Constraints.MinWidth = 615
    ExplicitTop = 73
    ExplicitWidth = 656
    ExplicitHeight = 481
    object Chart1: TChart
      Left = 1
      Top = 257
      Width = 654
      Height = 223
      AllowPanning = pmNone
      BackWall.Brush.Style = bsClear
      Gradient.EndColor = 12615680
      Legend.Visible = False
      MarginBottom = 3
      MarginTop = 5
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
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
      View3D = False
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = 14869218
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: TLineSeries
        HoverElement = [heCurrent]
        SeriesColor = 12222282
        Brush.BackColor = clDefault
        LinePen.Width = 2
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.VertSize = 2
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 654
      Height = 256
      Align = alTop
      Color = 14671839
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 111
        Width = 32
        Height = 13
        Caption = 'Label1'
      end
      object Label5: TLabel
        Left = 160
        Top = 111
        Width = 47
        Height = 13
        Caption = 'PDF ( = x)'
      end
      object Label6: TLabel
        Left = 160
        Top = 150
        Width = 53
        Height = 13
        Caption = 'CDF ( <= x)'
      end
      object Label2: TLabel
        Left = 16
        Top = 150
        Width = 32
        Height = 13
        Caption = 'Label2'
      end
      object Label3: TLabel
        Left = 16
        Top = 186
        Width = 32
        Height = 13
        Caption = 'Label3'
      end
      object Label4: TLabel
        Left = 16
        Top = 219
        Width = 32
        Height = 13
        Caption = 'Label4'
      end
      object Label7: TLabel
        Left = 344
        Top = 105
        Width = 52
        Height = 13
        Caption = 'Decimals : '
      end
      object Label8: TLabel
        Left = 463
        Top = 121
        Width = 26
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Label8'
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 8
        Width = 585
        Height = 97
        Caption = 'Distribution'
        Columns = 5
        ItemIndex = 7
        Items.Strings = (
          'Beta'
          'Binomial'
          'Cauchy'
          'Chi2'
          'Exponential'
          'F (Fisher)'
          'Gamma'
          'Geometric'
          'Hypergeometric'
          'Logistic'
          'LogNormal'
          'Maxwell'
          'Negative binomial'
          'Normal'
          'Pareto'
          'Poisson'
          'Student (t)'
          'Rayleigh'
          'Triangular'
          'Uniform continuous'
          'Uniform discrete'
          'Weibull')
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
      object Edit1: TEdit
        Left = 16
        Top = 129
        Width = 121
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7105644
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnEnter = Edit1Enter
      end
      object Edit5: TEdit
        Left = 160
        Top = 129
        Width = 121
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7105644
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object Edit2: TEdit
        Left = 16
        Top = 164
        Width = 121
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7105644
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnEnter = Edit1Enter
      end
      object Edit6: TEdit
        Left = 160
        Top = 164
        Width = 121
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7105644
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnEnter = Edit6Enter
      end
      object CheckBox1: TCheckBox
        Left = 160
        Top = 200
        Width = 121
        Height = 17
        Caption = 'Show PDF(x)'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object Edit3: TEdit
        Left = 16
        Top = 199
        Width = 121
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7105644
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnEnter = Edit1Enter
      end
      object Edit4: TEdit
        Left = 16
        Top = 232
        Width = 121
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7105644
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnEnter = Edit1Enter
      end
      object TrackBar1: TTrackBar
        Left = 344
        Top = 121
        Width = 113
        Height = 17
        Max = 16
        Min = 2
        Position = 8
        TabOrder = 8
        TickMarks = tmTopLeft
        OnChange = TrackBar1Change
      end
    end
  end
end
