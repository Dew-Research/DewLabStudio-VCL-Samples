inherited frmRidgeRegWizard: TfrmRidgeRegWizard
  Caption = 'frmRidgeRegWizard'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    ActivePage = tsChart
    object tsInputData: TTabSheet
      Caption = '1. Define data'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 12
        Top = 19
        Width = 169
        Height = 142
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
      end
      object GroupBox2: TGroupBox
        Left = 187
        Top = 19
        Width = 183
        Height = 142
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
    object tsCoeff: TTabSheet
      Caption = '2. k'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 4
        Top = 3
        Width = 198
        Height = 105
        Caption = 'k values in report'
        TabOrder = 0
        object Label5: TLabel
          Left = 9
          Top = 24
          Width = 65
          Height = 13
          Caption = 'Lower bound:'
        end
        object Label8: TLabel
          Left = 9
          Top = 48
          Width = 65
          Height = 13
          Caption = 'Upper bound:'
        end
        object Label9: TLabel
          Left = 9
          Top = 75
          Width = 31
          Height = 13
          Caption = '# of k:'
        end
        object EditkLB: TEdit
          Left = 80
          Top = 21
          Width = 89
          Height = 21
          TabOrder = 0
          Text = 'EditkLB'
          OnChange = EditkLBChange
        end
        object EditkUB: TEdit
          Left = 80
          Top = 48
          Width = 89
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
          OnChange = EditkUBChange
        end
        object EditkSteps: TEdit
          Left = 80
          Top = 75
          Width = 73
          Height = 21
          TabOrder = 2
          Text = '20'
          OnChange = EditkStepsChange
        end
        object UpDown1: TUpDown
          Left = 153
          Top = 75
          Width = 16
          Height = 21
          Associate = EditkSteps
          Min = 1
          Position = 20
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 220
        Top = 3
        Width = 185
        Height = 88
        Caption = 'Final k'
        TabOrder = 1
        object Label10: TLabel
          Left = 16
          Top = 24
          Width = 30
          Height = 13
          Caption = 'Value:'
        end
        object EditkFinal: TEdit
          Left = 52
          Top = 21
          Width = 93
          Height = 21
          Enabled = False
          TabOrder = 0
          Text = 'EditkFinal'
        end
        object CheckBoxkOptimal: TCheckBox
          Left = 16
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Use optimal'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = CheckBoxkOptimalClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 220
        Top = 97
        Width = 185
        Height = 105
        Caption = 'Optimal k'
        TabOrder = 2
      end
    end
    object tsConfigReports: TTabSheet
      Caption = 'tsConfigReports'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tsTextReport: TTabSheet
      Caption = 'tsTextReport'
      ImageIndex = 3
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
          '')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object tsChart: TTabSheet
      Caption = 'tsChart'
      ImageIndex = 4
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
        Panel = Chart1
        Align = alTop
        ParentShowHint = False
        TabOrder = 0
      end
      object Chart1: TChart
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
