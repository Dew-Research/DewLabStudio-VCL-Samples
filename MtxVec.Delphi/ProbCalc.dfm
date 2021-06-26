inherited Prob1: TProb1
  Left = 103
  Top = 101
  Caption = 'Prob1'
  ClientHeight = 624
  ClientWidth = 709
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 725
  ExplicitHeight = 663
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 709
    Height = 73
    ExplicitWidth = 656
    ExplicitHeight = 73
    inherited RichEdit1: TRichEdit
      Width = 707
      Height = 71
      Font.Color = 7105644
      ExplicitWidth = 654
      ExplicitHeight = 71
    end
  end
  inherited Panel2: TPanel
    Top = 582
    Width = 709
    Height = 42
    ExplicitTop = 554
    ExplicitWidth = 656
    ExplicitHeight = 42
    object Button1: TBitBtn
      Left = 16
      Top = 8
      Width = 100
      Height = 28
      Hint = 'calculate PDF/CDF'
      Caption = 'Calc probability'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 130
      Top = 8
      Width = 100
      Height = 28
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
    Width = 709
    Height = 509
    Constraints.MinHeight = 350
    Constraints.MinWidth = 615
    ExplicitTop = 73
    ExplicitWidth = 656
    ExplicitHeight = 481
    object Chart1: TChart
      Left = 1
      Top = 298
      Width = 707
      Height = 210
      AllowPanning = pmNone
      BackWall.Brush.Style = bsClear
      Gradient.EndColor = 12615680
      MarginBottom = 3
      MarginTop = 5
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      RightAxis.Automatic = False
      RightAxis.AutomaticMaximum = False
      RightAxis.AutomaticMinimum = False
      RightAxis.ExactDateTime = False
      RightAxis.Grid.Visible = False
      RightAxis.Increment = 0.100000000000000000
      RightAxis.Maximum = 1.000000000000000000
      View3D = False
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = 14869218
      TabOrder = 0
      ExplicitTop = 257
      ExplicitWidth = 654
      ExplicitHeight = 223
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object Series1: TLineSeries
        SeriesColor = 12222282
        Title = 'PDF'
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
      object Series2: TLineSeries
        SeriesColor = 4227327
        Title = 'CDF'
        VertAxis = aRightAxis
        Brush.BackColor = clDefault
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psDiamond
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
      Width = 707
      Height = 297
      Align = alTop
      Color = 14671839
      TabOrder = 1
      ExplicitWidth = 654
      object Label1: TLabel
        Left = 19
        Top = 142
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Label5: TLabel
        Left = 163
        Top = 142
        Width = 50
        Height = 13
        Caption = 'PDF ( = x)'
      end
      object Label6: TLabel
        Left = 163
        Top = 181
        Width = 59
        Height = 13
        Caption = 'CDF ( <= x)'
      end
      object Label2: TLabel
        Left = 19
        Top = 181
        Width = 31
        Height = 13
        Caption = 'Label2'
      end
      object Label3: TLabel
        Left = 19
        Top = 217
        Width = 31
        Height = 13
        Caption = 'Label3'
      end
      object Label4: TLabel
        Left = 19
        Top = 250
        Width = 31
        Height = 13
        Caption = 'Label4'
      end
      object Label7: TLabel
        Left = 344
        Top = 142
        Width = 51
        Height = 13
        Caption = 'Decimals : '
      end
      object Label8: TLabel
        Left = 481
        Top = 158
        Width = 39
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Label8'
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 8
        Width = 683
        Height = 122
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
          'Laplace'
          'Logistic'
          'LogNormal'
          'LogWeibull'
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
        Left = 19
        Top = 160
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
        Left = 163
        Top = 160
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
        Left = 19
        Top = 195
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
        Left = 163
        Top = 195
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
        Left = 163
        Top = 231
        Width = 121
        Height = 17
        Caption = 'Show PDF(x)'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object Edit3: TEdit
        Left = 19
        Top = 230
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
        Left = 19
        Top = 263
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
        Left = 339
        Top = 158
        Width = 142
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
