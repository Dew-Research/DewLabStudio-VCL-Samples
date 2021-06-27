inherited frmGOFKS: TfrmGOFKS
  Caption = 'frmGOFKS'
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 329
      Height = 272
      Align = alLeft
      TabOrder = 0
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 327
        Height = 96
        Align = alTop
        TabOrder = 0
        object Button1: TButton
          Left = 0
          Top = 32
          Width = 75
          Height = 25
          Caption = 'Run test'
          TabOrder = 0
          OnClick = Button1Click
        end
        object RadioGroup1: TRadioGroup
          Left = 80
          Top = 8
          Width = 137
          Height = 81
          Caption = 'Generated distribution'
          ItemIndex = 0
          Items.Strings = (
            'Normal'
            'Log-normal'
            'Student-T'
            'Weibull')
          TabOrder = 1
          OnClick = RadioGroup1Click
        end
      end
      object Memo2: TMemo
        Left = 1
        Top = 97
        Width = 327
        Height = 174
        Align = alClient
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        WordWrap = False
      end
    end
    object Chart1: TChart
      Left = 329
      Top = 0
      Width = 152
      Height = 272
      Legend.Alignment = laBottom
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
      Color = 12615808
      TabOrder = 1
      DefaultCanvas = ''
      ColorPaletteIndex = 0
      object Series1: THistogramSeries
        HoverElement = []
        SeriesColor = 8421631
        Title = 'Empirical CDF'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        ColorEachLine = False
        SeriesColor = clYellow
        Title = 'Theoretical distribution'
        Brush.BackColor = clDefault
        LinePen.Width = 2
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
end
