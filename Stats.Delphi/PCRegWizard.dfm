inherited frmPCRegWizard: TfrmPCRegWizard
  Caption = 'frmPCRegWizard'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    ExplicitWidth = 459
  end
  inherited PageControl: TPageControl
    ActivePage = tsInputData
    MultiLine = True
    ExplicitWidth = 459
    ExplicitHeight = 237
    object tsInputData: TTabSheet
      Caption = '1. Define data'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 3
        Width = 169
        Height = 182
        Caption = 'Equation'
        TabOrder = 0
        object Label1: TLabel
          Left = 18
          Top = 24
          Width = 66
          Height = 13
          Caption = 'Solving A*b=y'
        end
        object Label2: TLabel
          Left = 18
          Top = 48
          Width = 10
          Height = 13
          Caption = 'A:'
        end
        object Label3: TLabel
          Left = 18
          Top = 80
          Width = 8
          Height = 13
          Caption = 'y:'
        end
        object Label4: TLabel
          Left = 18
          Top = 111
          Width = 42
          Height = 13
          Caption = 'Weights:'
        end
        object Label5: TLabel
          Left = 18
          Top = 144
          Width = 89
          Height = 13
          Caption = 'Ommited variables:'
        end
        object Button1: TButton
          Left = 66
          Top = 43
          Width = 63
          Height = 25
          Caption = 'Edit'
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 66
          Top = 75
          Width = 63
          Height = 25
          Caption = 'Edit'
          TabOrder = 1
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 66
          Top = 106
          Width = 63
          Height = 25
          Caption = 'Edit'
          Enabled = False
          TabOrder = 2
          OnClick = Button3Click
        end
        object Edit1: TEdit
          Left = 113
          Top = 137
          Width = 32
          Height = 21
          TabOrder = 3
          Text = '1'
          OnChange = Edit1Change
        end
        object UpDown1: TUpDown
          Left = 145
          Top = 137
          Width = 16
          Height = 21
          Associate = Edit1
          Min = 1
          Max = 5
          Position = 1
          TabOrder = 4
        end
      end
      object GroupBox2: TGroupBox
        Left = 175
        Top = 3
        Width = 183
        Height = 182
        Caption = 'Additional settings : '
        TabOrder = 1
        object Label6: TLabel
          Left = 18
          Top = 55
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Alpha  : '
        end
        object Label7: TLabel
          Left = 12
          Top = 87
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = 'Format string : '
        end
        object ChkBoxUseWeights: TCheckBox
          Left = 16
          Top = 24
          Width = 121
          Height = 17
          TabStop = False
          Alignment = taLeftJustify
          Caption = 'Use weights ?'
          TabOrder = 0
          OnClick = ChkBoxUseWeightsClick
        end
        object Edit4: TEdit
          Left = 80
          Top = 87
          Width = 90
          Height = 21
          TabStop = False
          TabOrder = 1
          Text = '0.0000'
          OnChange = Edit4Change
        end
        object Edit3: TEdit
          Left = 56
          Top = 55
          Width = 49
          Height = 21
          TabOrder = 2
          Text = '0'
          OnChange = Edit3Change
        end
      end
    end
    object tsReports: TTabSheet
      Caption = '2. Reports'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cbDescStat: TCheckBox
        Left = 12
        Top = 10
        Width = 133
        Height = 17
        Caption = 'Descriptive statistics'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbCorrMtx: TCheckBox
        Left = 12
        Top = 33
        Width = 133
        Height = 17
        Caption = 'Correlation matrix'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object cbLSMultiCol: TCheckBox
        Left = 12
        Top = 56
        Width = 133
        Height = 17
        Caption = 'LS multicollinearity'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cbEigenvalues: TCheckBox
        Left = 12
        Top = 79
        Width = 133
        Height = 17
        Caption = 'Eigenvalues'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object cbPCCoeffs: TCheckBox
        Left = 12
        Top = 102
        Width = 133
        Height = 17
        Caption = 'PC coefficients'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object cbResiduals: TCheckBox
        Left = 12
        Top = 125
        Width = 133
        Height = 17
        Caption = 'Residuals'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
    end
    object tsTextReports: TTabSheet
      Caption = 'Text results'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 451
        Height = 227
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsCharts: TTabSheet
      Caption = 'Charts'
      ImageIndex = 3
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object TeeCommander1: TTeeCommander
        Left = 0
        Top = 0
        Width = 451
        Height = 33
        Panel = Chart
        Align = alTop
        ParentShowHint = False
        TabOrder = 0
      end
      object Chart: TChart
        Left = 0
        Top = 33
        Width = 451
        Height = 194
        Title.Text.Strings = (
          'TChart')
        BottomAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        LeftAxis.LogarithmicBase = 10.000000000000000000
        RightAxis.Grid.ZPosition = 100.000000000000000000
        RightAxis.LogarithmicBase = 10.000000000000000000
        RightAxis.ZPosition = 100.000000000000000000
        TopAxis.Grid.ZPosition = 100.000000000000000000
        TopAxis.LogarithmicBase = 10.000000000000000000
        TopAxis.ZPosition = 100.000000000000000000
        View3D = False
        Zoom.Brush.Gradient.Direction = gdFromTopLeft
        Zoom.Brush.Gradient.EndColor = clSilver
        Zoom.Brush.Gradient.MidColor = clWhite
        Zoom.Brush.Gradient.StartColor = clSilver
        Zoom.Pen.Mode = pmNotXor
        Align = alClient
        TabOrder = 1
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
    end
  end
end
