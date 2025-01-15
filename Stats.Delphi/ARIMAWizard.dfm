inherited frmARIMAWizard: TfrmARIMAWizard
  Left = 164
  Top = 166
  Caption = 'frmARIMAWizard'
  ClientHeight = 658
  ClientWidth = 877
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 893
  ExplicitHeight = 697
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 626
    Width = 877
    ExplicitTop = 625
    ExplicitWidth = 873
    DesignSize = (
      877
      32)
    inherited btnCancel: TButton
      Left = 787
      ExplicitLeft = 783
    end
  end
  inherited Panel2: TPanel
    Width = 877
    ExplicitWidth = 873
  end
  inherited PageControl: TPageControl
    Width = 877
    Height = 593
    ActivePage = tsDefineModel
    ExplicitWidth = 877
    ExplicitHeight = 593
    object tsInputData: TTabSheet
      Caption = 'Step 1: Define time series'
      TabVisible = False
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 457
        Height = 583
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitHeight = 582
        object GroupBox1: TGroupBox
          Left = 15
          Top = 19
          Width = 200
          Height = 129
          Caption = 'Time series'
          TabOrder = 0
          object Label3: TLabel
            Left = 17
            Top = 89
            Width = 39
            Height = 13
            Caption = '# of diff.'
          end
          object btnLoad: TButton
            Left = 17
            Top = 23
            Width = 97
            Height = 25
            Caption = 'Load'
            TabOrder = 0
            OnClick = btnLoadClick
          end
          object chkBoxRemoveMean: TCheckBox
            Left = 17
            Top = 58
            Width = 97
            Height = 17
            Caption = 'Remove mean'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = chkBoxRemoveMeanClick
          end
          object editD: TEdit
            Left = 81
            Top = 89
            Width = 41
            Height = 21
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 2
            Text = '0'
            OnChange = editDChange
          end
          object udD: TUpDown
            Left = 122
            Top = 89
            Width = 16
            Height = 21
            Associate = editD
            TabOrder = 3
          end
        end
        object GroupBox2: TGroupBox
          Left = 231
          Top = 22
          Width = 200
          Height = 105
          Caption = 'Additional settings'
          TabOrder = 1
          object Label4: TLabel
            Left = 12
            Top = 32
            Width = 69
            Height = 13
            Caption = 'Format string : '
          end
          object Label8: TLabel
            Left = 12
            Top = 64
            Width = 61
            Height = 13
            Caption = 'Alpha level : '
          end
          object EditFmtString: TEdit
            Left = 88
            Top = 32
            Width = 82
            Height = 21
            TabOrder = 0
            OnChange = EditFmtStringChange
          end
          object editAlpha: TEdit
            Left = 88
            Top = 64
            Width = 81
            Height = 21
            TabOrder = 1
            OnChange = editAlphaChange
          end
        end
        object GroupBox6: TGroupBox
          Left = 16
          Top = 159
          Width = 200
          Height = 117
          Caption = 'Untransformed series statistics'
          TabOrder = 2
          object lblLength: TLabel
            Left = 16
            Top = 26
            Width = 27
            Height = 13
            Caption = 'size : '
          end
          object lblMean: TLabel
            Left = 16
            Top = 48
            Width = 35
            Height = 13
            Caption = 'mean : '
          end
          object lblStdDev: TLabel
            Left = 16
            Top = 70
            Width = 47
            Height = 13
            Caption = 'std.dev  : '
          end
          object lblVariance: TLabel
            Left = 16
            Top = 92
            Width = 53
            Height = 13
            Caption = 'variance  : '
          end
        end
        object GroupBox7: TGroupBox
          Left = 16
          Top = 291
          Width = 200
          Height = 124
          Caption = 'Transformed series statistics'
          TabOrder = 3
          object lblTrSize: TLabel
            Left = 16
            Top = 29
            Width = 27
            Height = 13
            Caption = 'size : '
          end
          object lblTrMean: TLabel
            Left = 16
            Top = 50
            Width = 35
            Height = 13
            Caption = 'mean : '
          end
          object lblTrStdDev: TLabel
            Left = 16
            Top = 71
            Width = 47
            Height = 13
            Caption = 'std.dev  : '
          end
          object lblTrVar: TLabel
            Left = 16
            Top = 92
            Width = 53
            Height = 13
            Caption = 'variance  : '
          end
        end
        object rgPlot: TRadioGroup
          Left = 231
          Top = 141
          Width = 200
          Height = 112
          Caption = 'Plot'
          ItemIndex = 0
          Items.Strings = (
            'data set'
            'data set ACF'
            'data set PACF')
          TabOrder = 4
          OnClick = rgPlotClick
        end
      end
      object chartData: TChart
        Left = 457
        Top = 0
        Width = 412
        Height = 583
        AllowPanning = pmNone
        Legend.Visible = False
        Title.Text.Strings = (
          'Time series')
        BottomAxis.LogarithmicBase = 10.000000000000000000
        BottomAxis.EndPosition = 100.000000000000000000
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.Maximum = 0.500000000000000000
        DepthAxis.Minimum = -0.500000000000000000
        DepthAxis.EndPosition = 100.000000000000000000
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.Maximum = 0.500000000000000000
        DepthTopAxis.Minimum = -0.500000000000000000
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
        Zoom.Allow = False
        Zoom.Brush.Gradient.Direction = gdFromTopLeft
        Zoom.Brush.Gradient.EndColor = clSilver
        Zoom.Brush.Gradient.MidColor = clWhite
        Zoom.Brush.Gradient.StartColor = clSilver
        Zoom.Pen.Mode = pmNotXor
        OnAfterDraw = chartDataAfterDraw
        OnBeforeDrawSeries = chartDataBeforeDrawSeries
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        ExplicitWidth = 408
        ExplicitHeight = 582
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
    end
    object tsDefineModel: TTabSheet
      Caption = 'Step 2: Define model'
      ImageIndex = 1
      TabVisible = False
      object lblModel: TLabel
        Left = 15
        Top = 188
        Width = 47
        Height = 13
        Caption = 'Model : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox3: TGroupBox
        Left = 15
        Top = 14
        Width = 200
        Height = 158
        Caption = 'Order'
        TabOrder = 0
        object Label1: TLabel
          Left = 17
          Top = 30
          Width = 57
          Height = 13
          Caption = 'AR order (p)'
        end
        object Label2: TLabel
          Left = 17
          Top = 60
          Width = 58
          Height = 13
          Caption = 'MA order (q)'
        end
        object editAROrder: TEdit
          Left = 81
          Top = 30
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '2'
          OnChange = editAROrderChange
        end
        object editMAOrder: TEdit
          Left = 81
          Top = 60
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '1'
          OnChange = editMAOrderChange
        end
        object udAR: TUpDown
          Left = 122
          Top = 30
          Width = 16
          Height = 21
          Associate = editAROrder
          Max = 50
          Position = 2
          TabOrder = 2
        end
        object udMA: TUpDown
          Left = 122
          Top = 60
          Width = 16
          Height = 21
          Associate = editMAOrder
          Position = 1
          TabOrder = 3
        end
      end
      object rgARInit: TRadioGroup
        Left = 232
        Top = 188
        Width = 200
        Height = 122
        Caption = 'Preliminary estimates'
        ItemIndex = 2
        Items.Strings = (
          'Fixed'
          'Yule-Walker'
          'Burg')
        TabOrder = 1
        Visible = False
        OnClick = rgARInitClick
      end
      object rgARMAInit: TRadioGroup
        Left = 232
        Top = 14
        Width = 200
        Height = 158
        Caption = 'Preliminary estimates'
        ItemIndex = 1
        Items.Strings = (
          'Fixed'
          'Yule-Walker'
          'Burg'
          'Innovations'
          'Hannah-Rissanen')
        TabOrder = 2
        Visible = False
        OnClick = rgARMAInitClick
      end
      object gbPhiThetaEdit: TGroupBox
        Left = 448
        Top = 188
        Width = 200
        Height = 122
        Caption = 'Phi, Theta'
        TabOrder = 3
        Visible = False
        object btnEditPhi: TButton
          Left = 23
          Top = 28
          Width = 80
          Height = 25
          Caption = 'Edit Phi'
          TabOrder = 0
          OnClick = btnEditPhiClick
        end
        object btnEditTheta: TButton
          Left = 23
          Top = 66
          Width = 80
          Height = 25
          Caption = 'Edit Theta'
          TabOrder = 1
          OnClick = btnEditThetaClick
        end
      end
      object gbInnovationsLag: TGroupBox
        Left = 448
        Top = 14
        Width = 200
        Height = 158
        Caption = 'Maximum lag'
        TabOrder = 4
        Visible = False
        object Label5: TLabel
          Left = 17
          Top = 60
          Width = 67
          Height = 13
          Caption = '-1 = automatic'
        end
        object EditInnoLag: TEdit
          Left = 17
          Top = 27
          Width = 57
          Height = 21
          TabOrder = 0
          Text = '-1'
          OnChange = EditInnoLagChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 15
        Top = 218
        Width = 185
        Height = 57
        Caption = 'Estimation'
        TabOrder = 5
        object chkDoMLE: TCheckBox
          Left = 11
          Top = 25
          Width = 129
          Height = 17
          Caption = 'Do MLE estimation'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
    end
    object tsDefineReport: TTabSheet
      Caption = 'Step 3: Define reports'
      ImageIndex = 2
      TabVisible = False
      object GroupBox4: TGroupBox
        Left = 12
        Top = 14
        Width = 241
        Height = 161
        Caption = 'Additional settings'
        TabOrder = 0
        object Label6: TLabel
          Left = 17
          Top = 27
          Width = 74
          Height = 13
          Caption = '# of forecasts : '
        end
        object Label7: TLabel
          Left = 17
          Top = 60
          Width = 65
          Height = 13
          Caption = 'Lag for ACF : '
        end
        object editForecastNo: TEdit
          Left = 89
          Top = 27
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '20'
          OnChange = editForecastNoChange
        end
        object editACFLag: TEdit
          Left = 89
          Top = 60
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '-1'
          OnChange = editACFLagChange
        end
        object chkAddMean: TCheckBox
          Left = 17
          Top = 95
          Width = 137
          Height = 17
          Caption = 'Add mean to forecasts'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object chkIntegrate: TCheckBox
          Left = 17
          Top = 125
          Width = 185
          Height = 17
          Caption = 'Forecast the undifferenced data'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object udForecastsNo: TUpDown
          Left = 130
          Top = 27
          Width = 16
          Height = 21
          Associate = editForecastNo
          Min = 1
          Position = 20
          TabOrder = 4
        end
      end
    end
    object tsTextReport: TTabSheet
      Caption = 'ARMA/ARIMA: Text reports'
      ImageIndex = 3
      TabVisible = False
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 869
        Height = 583
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsChart: TTabSheet
      Caption = 'ARMA/ARIMA: Charts'
      ImageIndex = 4
      TabVisible = False
      object Chart: TChart
        Left = 0
        Top = 0
        Width = 869
        Height = 583
        Title.Text.Strings = (
          '')
        BottomAxis.LogarithmicBase = 10.000000000000000000
        BottomAxis.EndPosition = 100.000000000000000000
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.Maximum = 0.500000000000000000
        DepthAxis.Minimum = -0.500000000000000000
        DepthAxis.EndPosition = 100.000000000000000000
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.Maximum = 0.500000000000000000
        DepthTopAxis.Minimum = -0.500000000000000000
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
        Zoom.Brush.Gradient.Direction = gdFromTopLeft
        Zoom.Brush.Gradient.EndColor = clSilver
        Zoom.Brush.Gradient.MidColor = clWhite
        Zoom.Brush.Gradient.StartColor = clSilver
        Zoom.Pen.Mode = pmNotXor
        Align = alClient
        Color = 12615808
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'vector (*.vec)|*.vec|text file (*.txt)|*.txt'
    Left = 522
    Top = 63
  end
end
