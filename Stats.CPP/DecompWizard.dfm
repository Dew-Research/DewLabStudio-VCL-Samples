inherited frmDecompositionWizard: TfrmDecompositionWizard
  Caption = 'frmDecompositionWizard'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    ActivePage = tsInputData
    object tsInputData: TTabSheet
      Caption = 'tsInputData'
      TabVisible = False
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 337
        Height = 346
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 160
          Width = 43
          Height = 13
          Caption = 'Seasons '
        end
        object Label2: TLabel
          Left = 8
          Top = 184
          Width = 69
          Height = 13
          Caption = '# of forecasts'
        end
        object Label3: TLabel
          Left = 8
          Top = 112
          Width = 73
          Height = 13
          Caption = 'Forecast cycle:'
          Enabled = False
        end
        object GroupBox1: TGroupBox
          Left = 0
          Top = 8
          Width = 137
          Height = 57
          Caption = 'Time series'
          TabOrder = 0
          object btnLoad: TButton
            Left = 8
            Top = 16
            Width = 75
            Height = 25
            Caption = 'Load'
            TabOrder = 0
            OnClick = btnLoadClick
          end
        end
        object chkCycle: TCheckBox
          Left = 8
          Top = 88
          Width = 121
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Use cycle'
          TabOrder = 1
          OnClick = chkCycleClick
        end
        object editSeasons: TEdit
          Left = 88
          Top = 160
          Width = 33
          Height = 21
          TabOrder = 2
          Text = '1'
          OnChange = editSeasonsChange
        end
        object udSeasons: TUpDown
          Left = 121
          Top = 160
          Width = 16
          Height = 21
          Associate = editSeasons
          Min = 1
          Position = 1
          TabOrder = 3
        end
        object editForecasts: TEdit
          Left = 88
          Top = 184
          Width = 33
          Height = 21
          TabOrder = 4
          Text = '10'
          OnChange = editForecastsChange
        end
        object udForecasts: TUpDown
          Left = 121
          Top = 184
          Width = 16
          Height = 21
          Associate = editForecasts
          Max = 1000
          Increment = 10
          Position = 10
          TabOrder = 5
        end
        object GroupBox2: TGroupBox
          Left = 144
          Top = 8
          Width = 185
          Height = 65
          Caption = 'Additional settings'
          TabOrder = 6
          object Label4: TLabel
            Left = 12
            Top = 32
            Width = 74
            Height = 13
            Caption = 'Format string : '
          end
          object EditFmtString: TEdit
            Left = 88
            Top = 32
            Width = 82
            Height = 21
            TabOrder = 0
            OnChange = EditFmtStringChange
          end
        end
        object editCycle: TEdit
          Left = 88
          Top = 112
          Width = 49
          Height = 21
          Enabled = False
          TabOrder = 7
        end
      end
      object chartData: TChart
        Left = 337
        Top = 0
        Width = 262
        Height = 346
        Legend.Alignment = laBottom
        Title.Text.Strings = (
          'Transformed time series')
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
        Color = clWhite
        TabOrder = 1
        DefaultCanvas = 'TTeeCanvas3D'
        ColorPaletteIndex = 0
        object Series2: TLineSeries
          HoverElement = [heCurrent]
          Title = 'Zero mean TS'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series3: TLineSeries
          HoverElement = [heCurrent]
          Title = 'MovAve'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series4: TLineSeries
          HoverElement = [heCurrent]
          SeriesColor = clBlack
          Title = 'Trend'
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
    object tsTextReport: TTabSheet
      Caption = 'tsTextReport'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 599
        Height = 346
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        Zoom = 100
      end
    end
    object tsChartReport: TTabSheet
      Caption = 'tsChartReport'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object reportChart: TChart
        Left = 0
        Top = 0
        Width = 599
        Height = 346
        Title.Text.Strings = (
          'TChart')
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
        Color = clWhite
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'vector (*.vec)|*.vec|text file (*.txt)|*.txt'
    Left = 164
    Top = 327
  end
end
