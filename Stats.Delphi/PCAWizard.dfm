inherited frmPCAWiz: TfrmPCAWiz
  Caption = 'frmPCAWiz'
  ClientHeight = 341
  ClientWidth = 528
  OldCreateOrder = True
  OnDestroy = FormDestroy
  ExplicitWidth = 544
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 309
    Width = 528
    ExplicitTop = 309
    ExplicitWidth = 528
    inherited btnCancel: TButton
      Left = 441
      ExplicitLeft = 441
    end
  end
  inherited Panel2: TPanel
    Width = 528
    ExplicitWidth = 528
  end
  inherited PageControl: TPageControl
    Width = 528
    Height = 276
    ActivePage = tsInputData
    ExplicitWidth = 528
    ExplicitHeight = 276
    object tsInputData: TTabSheet
      Caption = 'Step 1: Define data'
      TabVisible = False
      object GroupBox2: TGroupBox
        Left = 232
        Top = 8
        Width = 185
        Height = 129
        Caption = ' Additional settings '
        TabOrder = 0
        object Label4: TLabel
          Left = 12
          Top = 32
          Width = 69
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
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 217
        Height = 177
        Caption = ' Define data matrix'
        TabOrder = 1
        object Label1: TLabel
          Left = 10
          Top = 24
          Width = 151
          Height = 13
          Alignment = taRightJustify
          Caption = 'Number of variables (columns) : '
        end
        object Label2: TLabel
          Left = 15
          Top = 56
          Width = 146
          Height = 13
          Alignment = taRightJustify
          Caption = 'Number of observables (rows) :'
        end
        object Label3: TLabel
          Left = 129
          Top = 88
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data : '
        end
        object Label5: TLabel
          Left = 13
          Top = 128
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Matrix type : '
        end
        object EditCols: TEdit
          Left = 168
          Top = 24
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object EditRows: TEdit
          Left = 168
          Top = 56
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
        object BtnEditData: TButton
          Left = 168
          Top = 88
          Width = 41
          Height = 25
          Caption = 'Edit'
          TabOrder = 2
          OnClick = BtnEditDataClick
        end
        object CBoxPCAMode: TComboBox
          Left = 79
          Top = 123
          Width = 129
          Height = 21
          ItemIndex = 1
          TabOrder = 3
          Text = 'Raw data matrix'
          OnChange = CBoxPCAModeChange
          Items.Strings = (
            'Correlation matrix'
            'Raw data matrix')
        end
      end
    end
    object tsReportConfig: TTabSheet
      Caption = 'Step 2: Configure reports'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 12
        Width = 185
        Height = 171
        Caption = 'Text reports : '
        TabOrder = 0
        object ChkBoxDescStat: TCheckBox
          Left = 8
          Top = 24
          Width = 129
          Height = 17
          Caption = 'Descriptive statistics'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object ChkBoxCorrMtx: TCheckBox
          Left = 8
          Top = 72
          Width = 137
          Height = 17
          Caption = 'Correlation matrix'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object ChkBoxEigValues: TCheckBox
          Left = 8
          Top = 96
          Width = 97
          Height = 17
          Caption = 'Eigenvalues'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object ChkBoxPrinComp: TCheckBox
          Left = 8
          Top = 120
          Width = 145
          Height = 17
          Caption = 'Principal components'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object ChkBoxZScores: TCheckBox
          Left = 8
          Top = 144
          Width = 97
          Height = 17
          Caption = 'Z Scores'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object ChkBoxBarlett: TCheckBox
          Left = 8
          Top = 48
          Width = 169
          Height = 17
          Caption = 'Barlett test for dimensinality'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
      end
      object GroupBox4: TGroupBox
        Left = 208
        Top = 16
        Width = 185
        Height = 169
        Caption = 'Additional settings'
        TabOrder = 1
        object Label6: TLabel
          Left = 8
          Top = 24
          Width = 96
          Height = 13
          Caption = 'Rotate eigenvectors'
        end
        object CBoxRotation: TComboBox
          Left = 8
          Top = 40
          Width = 145
          Height = 21
          ItemIndex = 0
          TabOrder = 0
          Text = 'None'
          OnChange = CBoxRotationChange
          Items.Strings = (
            'None'
            'Varimax'
            'Ortomax'
            'Quartimax'
            'Equamax')
        end
      end
    end
    object tsTextReport: TTabSheet
      Caption = 'PCA: Text report'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 520
        Height = 266
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tsChart: TTabSheet
      Caption = 'PCA: Charts'
      ImageIndex = 3
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Chart: TChart
        Left = 0
        Top = 33
        Width = 520
        Height = 233
        Legend.CheckBoxes = True
        Title.Text.Strings = (
          'TChart')
        BottomAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.Maximum = 0.500000000000000000
        DepthAxis.Minimum = -0.500000000000000000
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.Maximum = 0.500000000000000000
        DepthTopAxis.Minimum = -0.500000000000000000
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
        Color = clSilver
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
      object TeeCommander1: TTeeCommander
        Left = 0
        Top = 0
        Width = 520
        Height = 33
        Panel = Chart
        Align = alTop
        ParentShowHint = False
        TabOrder = 1
      end
    end
  end
end
