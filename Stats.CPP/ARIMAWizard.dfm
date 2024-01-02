inherited frmARIMAWizard: TfrmARIMAWizard
  Caption = 'frmARIMAWizard'
  ClientHeight = 471
  ClientWidth = 666
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 682
  ExplicitHeight = 510
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 666
    Height = 406
    ActivePage = tsInputData
    ExplicitWidth = 666
    ExplicitHeight = 406
    object tsInputData: TTabSheet
      Caption = 'tsInputData'
      TabVisible = False
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 401
        Height = 396
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 8
          Top = 16
          Width = 185
          Height = 105
          Caption = 'Time series'
          TabOrder = 0
          object Label3: TLabel
            Left = 8
            Top = 72
            Width = 44
            Height = 13
            Caption = '# of diff.'
          end
          object btnLoad: TButton
            Left = 8
            Top = 24
            Width = 75
            Height = 25
            Caption = 'Load'
            TabOrder = 0
            OnClick = btnLoadClick
          end
          object chkBoxRemoveMean: TCheckBox
            Left = 8
            Top = 56
            Width = 97
            Height = 17
            Caption = 'Remove mean'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = chkBoxRemoveMeanClick
          end
          object editD: TEdit
            Left = 72
            Top = 72
            Width = 41
            Height = 21
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 2
            Text = '0'
            OnChange = editDChange
          end
          object udD: TUpDown
            Left = 113
            Top = 72
            Width = 16
            Height = 21
            Associate = editD
            TabOrder = 3
          end
        end
        object GroupBox2: TGroupBox
          Left = 200
          Top = 16
          Width = 185
          Height = 97
          Caption = 'Additional settings'
          TabOrder = 1
          object Label4: TLabel
            Left = 12
            Top = 32
            Width = 74
            Height = 13
            Caption = 'Format string : '
          end
          object Label8: TLabel
            Left = 12
            Top = 64
            Width = 62
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
          Left = 8
          Top = 128
          Width = 185
          Height = 89
          Caption = 'Untransformed series statistics'
          TabOrder = 2
          object lblLength: TLabel
            Left = 16
            Top = 20
            Width = 28
            Height = 13
            Caption = 'size : '
          end
          object lblMean: TLabel
            Left = 16
            Top = 36
            Width = 36
            Height = 13
            Caption = 'mean : '
          end
          object lblStdDev: TLabel
            Left = 16
            Top = 52
            Width = 50
            Height = 13
            Caption = 'std.dev  : '
          end
          object lblVariance: TLabel
            Left = 16
            Top = 68
            Width = 54
            Height = 13
            Caption = 'variance  : '
          end
        end
        object GroupBox7: TGroupBox
          Left = 8
          Top = 216
          Width = 185
          Height = 89
          Caption = 'Transformed series statistics'
          TabOrder = 3
          object lblTrSize: TLabel
            Left = 16
            Top = 20
            Width = 28
            Height = 13
            Caption = 'size : '
          end
          object lblTrMean: TLabel
            Left = 16
            Top = 36
            Width = 36
            Height = 13
            Caption = 'mean : '
          end
          object lblTrStdDev: TLabel
            Left = 16
            Top = 52
            Width = 50
            Height = 13
            Caption = 'std.dev  : '
          end
          object lblTrVar: TLabel
            Left = 16
            Top = 68
            Width = 54
            Height = 13
            Caption = 'variance  : '
          end
        end
        object rgPlot: TRadioGroup
          Left = 200
          Top = 128
          Width = 185
          Height = 89
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
        Left = 401
        Top = 0
        Width = 257
        Height = 396
        AllowPanning = pmNone
        Legend.Visible = False
        Title.Text.Strings = (
          'Time series')
        View3D = False
        Zoom.Allow = False
        Zoom.Pen.Mode = pmNotXor
        OnAfterDraw = chartDataAfterDraw
        OnBeforeDrawSeries = chartDataBeforeDrawSeries
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
    end
    object tsDefineModel: TTabSheet
      Caption = 'tsDefineModel'
      ImageIndex = 1
      TabVisible = False
      object lblModel: TLabel
        Left = 8
        Top = 128
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
        Left = 8
        Top = 8
        Width = 145
        Height = 105
        Caption = 'Order'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 60
          Height = 13
          Caption = 'AR order (p)'
        end
        object Label2: TLabel
          Left = 8
          Top = 48
          Width = 61
          Height = 13
          Caption = 'MA order (q)'
        end
        object editAROrder: TEdit
          Left = 72
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = editAROrderChange
        end
        object editMAOrder: TEdit
          Left = 72
          Top = 48
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '0'
          OnChange = editMAOrderChange
        end
        object udAR: TUpDown
          Left = 113
          Top = 24
          Width = 16
          Height = 21
          Associate = editAROrder
          Max = 50
          TabOrder = 2
        end
        object udMA: TUpDown
          Left = 113
          Top = 48
          Width = 16
          Height = 21
          Associate = editMAOrder
          TabOrder = 3
        end
      end
      object rgARInit: TRadioGroup
        Left = 168
        Top = 8
        Width = 153
        Height = 80
        Caption = 'Preliminary estimates'
        ItemIndex = 2
        Items.Strings = (
          'Yule-Walker'
          'Burg'
          'Fixed')
        TabOrder = 1
        Visible = False
        OnClick = rgARInitClick
      end
      object rgARMAInit: TRadioGroup
        Left = 168
        Top = 8
        Width = 153
        Height = 80
        Caption = 'Preliminary estimates'
        ItemIndex = 2
        Items.Strings = (
          'Innovations'
          'Hannah-Rissanen'
          'Fixed')
        TabOrder = 2
        Visible = False
        OnClick = rgARMAInitClick
      end
      object gbPhiThetaEdit: TGroupBox
        Left = 328
        Top = 8
        Width = 121
        Height = 81
        Caption = 'Phi, Theta'
        TabOrder = 3
        Visible = False
        object btnEditPhi: TButton
          Left = 8
          Top = 16
          Width = 65
          Height = 25
          Caption = 'Edit Phi'
          TabOrder = 0
          OnClick = btnEditPhiClick
        end
        object btnEditTheta: TButton
          Left = 8
          Top = 48
          Width = 65
          Height = 25
          Caption = 'Edit Theta'
          TabOrder = 1
          OnClick = btnEditThetaClick
        end
      end
      object gbInnovationsLag: TGroupBox
        Left = 328
        Top = 8
        Width = 121
        Height = 81
        Caption = 'Maximum lag'
        TabOrder = 4
        Visible = False
        object Label5: TLabel
          Left = 8
          Top = 40
          Width = 71
          Height = 13
          Caption = '-1 = automatic'
        end
        object EditInnoLag: TEdit
          Left = 8
          Top = 16
          Width = 57
          Height = 21
          TabOrder = 0
          Text = '-1'
          OnChange = EditInnoLagChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 152
        Width = 185
        Height = 57
        Caption = 'Estimation'
        TabOrder = 5
        object chkDoMLE: TCheckBox
          Left = 8
          Top = 16
          Width = 129
          Height = 17
          Caption = 'Do MLE estimation'
          TabOrder = 0
        end
      end
    end
    object tsDefineReport: TTabSheet
      Caption = 'tsDefineReport'
      ImageIndex = 2
      TabVisible = False
      object GroupBox4: TGroupBox
        Left = 8
        Top = 8
        Width = 201
        Height = 153
        Caption = 'Additional settings'
        TabOrder = 0
        object Label6: TLabel
          Left = 8
          Top = 24
          Width = 79
          Height = 13
          Caption = '# of forecasts : '
        end
        object Label7: TLabel
          Left = 8
          Top = 48
          Width = 67
          Height = 13
          Caption = 'Lag for ACF : '
        end
        object editForecastNo: TEdit
          Left = 80
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '20'
          OnChange = editForecastNoChange
        end
        object editACFLag: TEdit
          Left = 80
          Top = 48
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '-1'
          OnChange = editACFLagChange
        end
        object chkAddMean: TCheckBox
          Left = 8
          Top = 80
          Width = 137
          Height = 17
          Caption = 'Add mean to forecasts'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object chkIntegrate: TCheckBox
          Left = 8
          Top = 104
          Width = 185
          Height = 17
          Caption = 'Forecast the undifferenced data'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object udForecastsNo: TUpDown
          Left = 121
          Top = 24
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
      Caption = 'tsTextReport'
      ImageIndex = 3
      TabVisible = False
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 658
        Height = 396
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
      end
    end
    object tsChart: TTabSheet
      Caption = 'tsChart'
      ImageIndex = 4
      TabVisible = False
      object Chart: TChart
        Left = 0
        Top = 0
        Width = 658
        Height = 396
        Title.Text.Strings = (
          '')
        View3D = False
        Zoom.Pen.Mode = pmNotXor
        Align = alClient
        Color = 12615808
        TabOrder = 0
        DefaultCanvas = 'TTeeCanvas3D'
        ColorPaletteIndex = 0
      end
    end
  end
  inherited Panel1: TPanel
    Top = 439
    Width = 666
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 439
    ExplicitWidth = 666
    inherited btnCancel: TButton
      Left = 584
      ExplicitLeft = 584
    end
  end
  inherited Panel2: TPanel
    Width = 666
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 666
    inherited lblHeader: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'vector (*.vec)|*.vec|text file (*.txt)|*.txt'
    Left = 396
    Top = 63
  end
end
