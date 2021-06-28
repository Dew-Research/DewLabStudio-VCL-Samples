inherited frmPCAWiz: TfrmPCAWiz
  Caption = 'frmPCAWiz'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    ActivePage = tsInputData
    object tsInputData: TTabSheet
      Caption = '1. Define data'
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
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 217
        Height = 177
        Caption = ' Define data matrix'
        TabOrder = 1
        object Label1: TLabel
          Left = 6
          Top = 24
          Width = 155
          Height = 13
          Alignment = taRightJustify
          Caption = 'Number of variables (columns) : '
        end
        object Label2: TLabel
          Left = 9
          Top = 56
          Width = 152
          Height = 13
          Alignment = taRightJustify
          Caption = 'Number of observables (rows) :'
        end
        object Label3: TLabel
          Left = 128
          Top = 88
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data : '
        end
        object Label5: TLabel
          Left = 8
          Top = 128
          Width = 65
          Height = 13
          Alignment = taRightJustify
          Caption = 'Matrix type : '
        end
        object EditCols: TEdit
          Left = 168
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 0
          OnChange = EditColsChange
        end
        object EditRows: TEdit
          Left = 168
          Top = 56
          Width = 41
          Height = 21
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
          Left = 80
          Top = 128
          Width = 129
          Height = 21
          ItemIndex = 1
          TabOrder = 3
          Text = 'Raw data'
          OnChange = CBoxPCAModeChange
          Items.Strings = (
            'Correlation matrix'
            'Raw data')
        end
      end
    end
    object tsReportConfig: TTabSheet
      Caption = '2 .Define reports'
      ImageIndex = 1
      TabVisible = False
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
    end
    object tsTextReport: TTabSheet
      Caption = 'PCA: Text report'
      ImageIndex = 2
      TabVisible = False
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 599
        Height = 346
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        Zoom = 100
      end
    end
    object tsChart: TTabSheet
      Caption = 'PCA: Charts'
      ImageIndex = 3
      TabVisible = False
      object Chart: TChart
        Left = 0
        Top = 33
        Width = 599
        Height = 313
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
        Color = clSilver
        TabOrder = 0
        DefaultCanvas = 'TTeeCanvas3D'
        ColorPaletteIndex = 0
      end
      object TeeCommander1: TTeeCommander
        Left = 0
        Top = 0
        Width = 599
        Height = 33
        Panel = Chart
        Align = alTop
        ParentShowHint = False
        TabOrder = 1
      end
    end
  end
  object MtxPCA: TMtxPCA
    Left = 535
    Top = 308
    MtxDataValues = {}
  end
end
