inherited frmMulLinRegWiz: TfrmMulLinRegWiz
  Caption = 'frmRegressWizard'
  ClientHeight = 337
  ClientWidth = 540
  OnDestroy = FormDestroy
  ExplicitWidth = 552
  ExplicitHeight = 375
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 305
    Width = 540
    ExplicitTop = 304
    ExplicitWidth = 536
    inherited btnCancel: TButton
      Left = 444
      ExplicitLeft = 440
    end
  end
  inherited Panel2: TPanel
    Width = 540
    ExplicitWidth = 536
  end
  inherited PageControl: TPageControl
    Width = 540
    Height = 272
    ActivePage = tsInputData
    ExplicitWidth = 536
    ExplicitHeight = 271
    object tsInputData: TTabSheet
      Caption = 'Step 1: System of equations'
      TabVisible = False
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 225
        Height = 185
        Caption = 'Equations : '
        TabOrder = 0
        object Label1: TLabel
          Left = 56
          Top = 88
          Width = 114
          Height = 13
          Alignment = taRightJustify
          Caption = 'Independent variables : '
        end
        object Label2: TLabel
          Left = 64
          Top = 120
          Width = 105
          Height = 13
          Alignment = taRightJustify
          Caption = 'Dependent variable :  '
        end
        object Label3: TLabel
          Left = 72
          Top = 148
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Weights (optional) : '
        end
        object Label4: TLabel
          Left = 51
          Top = 24
          Width = 118
          Height = 13
          Alignment = taRightJustify
          Caption = 'Number of observables : '
        end
        object Label5: TLabel
          Left = 4
          Top = 48
          Width = 165
          Height = 13
          Alignment = taRightJustify
          Caption = 'Number of independent variables : '
        end
        object BitBtnA: TBitBtn
          Left = 176
          Top = 80
          Width = 41
          Height = 25
          Caption = 'Edit'
          TabOrder = 0
          TabStop = False
          OnClick = BitBtnAClick
        end
        object BitBtnY: TBitBtn
          Left = 176
          Top = 112
          Width = 41
          Height = 25
          Caption = 'Edit'
          TabOrder = 1
          TabStop = False
          OnClick = BitBtnAClick
        end
        object BitBtnW: TBitBtn
          Left = 176
          Top = 144
          Width = 41
          Height = 25
          Caption = 'Edit'
          TabOrder = 2
          TabStop = False
          OnClick = BitBtnAClick
        end
        object Edit1: TEdit
          Left = 168
          Top = 24
          Width = 33
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = Edit1Change
        end
        object Edit2: TEdit
          Left = 168
          Top = 48
          Width = 33
          Height = 21
          TabOrder = 4
          Text = '0'
          OnChange = Edit1Change
        end
      end
      object GroupBox2: TGroupBox
        Left = 240
        Top = 8
        Width = 183
        Height = 185
        Caption = 'Additional settings : '
        TabOrder = 1
        object Label6: TLabel
          Left = 18
          Top = 80
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Alpha  : '
        end
        object Label7: TLabel
          Left = 12
          Top = 112
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
        object ChkBoxRemoveInt: TCheckBox
          Left = 16
          Top = 48
          Width = 121
          Height = 17
          TabStop = False
          Alignment = taLeftJustify
          Caption = 'Remove intercept ?'
          TabOrder = 1
          OnClick = ChkBoxRemoveIntClick
        end
        object Edit4: TEdit
          Left = 80
          Top = 112
          Width = 90
          Height = 21
          TabStop = False
          TabOrder = 2
          Text = '0.0000'
          OnChange = Edit4Change
        end
        object Edit3: TEdit
          Left = 56
          Top = 80
          Width = 49
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = Edit3Change
        end
      end
    end
    object tsReportConfig: TTabSheet
      Caption = 'Step 2: Configure reports'
      ImageIndex = 1
      TabVisible = False
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 201
        Caption = 'Text report : '
        TabOrder = 0
        object ChkBoxCorr: TCheckBox
          Left = 16
          Top = 120
          Width = 113
          Height = 17
          Caption = 'Correlation matrix'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object ChkBoxDescStat: TCheckBox
          Left = 16
          Top = 96
          Width = 121
          Height = 17
          Caption = 'Descriptive statistics'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object ChkBoxRegCoeff: TCheckBox
          Left = 16
          Top = 24
          Width = 137
          Height = 17
          Caption = 'Regression coefficients'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object ChkBoxRes: TCheckBox
          Left = 16
          Top = 72
          Width = 97
          Height = 17
          Caption = 'Residuals'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object ChkBoxRegStats: TCheckBox
          Left = 16
          Top = 48
          Width = 145
          Height = 17
          Caption = 'Basic regression statistic'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object ChkBoxSerCorr: TCheckBox
          Left = 16
          Top = 144
          Width = 113
          Height = 17
          Caption = 'Serial correlation'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object ChkBoxNormality: TCheckBox
          Left = 16
          Top = 168
          Width = 153
          Height = 17
          Caption = 'Normality tests on residuals'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
      end
    end
    object tsTextReport: TTabSheet
      Caption = 'MLR: Text reports'
      ImageIndex = 3
      TabVisible = False
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 532
        Height = 262
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object tsChart: TTabSheet
      Caption = 'MLR: Charts'
      ImageIndex = 2
      TabVisible = False
      object TeeCommander1: TTeeCommander
        Left = 0
        Top = 0
        Width = 532
        Height = 33
        Panel = Chart1
        Align = alTop
        ParentShowHint = False
        TabOrder = 0
      end
      object Chart1: TChart
        Left = 0
        Top = 33
        Width = 532
        Height = 229
        Legend.Visible = False
        Title.Text.Strings = (
          'TChart')
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
        Zoom.Brush.Color = clSilver
        Zoom.Brush.Style = bsFDiagonal
        Zoom.Brush.Gradient.Direction = gdFromTopLeft
        Zoom.Brush.Gradient.EndColor = clSilver
        Zoom.Brush.Gradient.MidColor = clWhite
        Zoom.Brush.Gradient.StartColor = clSilver
        Zoom.Pen.Color = clBlack
        Zoom.Pen.Mode = pmNotXor
        Align = alClient
        Color = clSilver
        TabOrder = 1
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
    end
  end
end
