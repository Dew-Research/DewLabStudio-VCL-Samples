inherited frmMDSWiz: TfrmMDSWiz
  Left = 266
  Top = 237
  Caption = 'frmMDSWiz'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    ExplicitWidth = 459
  end
  inherited PageControl: TPageControl
    ActivePage = tsInputData
    ExplicitWidth = 459
    ExplicitHeight = 237
    object tsInputData: TTabSheet
      Caption = 'Step 1: Input data'
      TabVisible = False
      object GroupBox2: TGroupBox
        Left = 224
        Top = 8
        Width = 185
        Height = 65
        Caption = 'Additional settings'
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
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 201
        Height = 153
        Caption = 'Data matrix'
        TabOrder = 1
        object Label1: TLabel
          Left = 14
          Top = 48
          Width = 43
          Height = 13
          Alignment = taRightJustify
          Caption = 'Columns:'
        end
        object Label2: TLabel
          Left = 19
          Top = 24
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Rows:'
        end
        object Label3: TLabel
          Left = 121
          Top = 24
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data : '
        end
        object Label5: TLabel
          Left = 8
          Top = 96
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data type:'
        end
        object Label6: TLabel
          Left = 17
          Top = 120
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Metric:'
        end
        object Label7: TLabel
          Left = 12
          Top = 72
          Width = 53
          Height = 13
          Caption = 'Data matrix'
        end
        object EditCols: TEdit
          Left = 64
          Top = 48
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object EditRows: TEdit
          Left = 64
          Top = 24
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
        object BtnEditData: TButton
          Left = 120
          Top = 48
          Width = 41
          Height = 25
          Caption = 'Edit'
          TabOrder = 2
          OnClick = BtnEditDataClick
        end
        object CBoxDataType: TComboBox
          Left = 64
          Top = 96
          Width = 129
          Height = 21
          TabOrder = 3
          OnChange = CBoxDataTypeChange
          Items.Strings = (
            'Dissimilarities matrix'
            'Similarities matrix'
            'Raw data')
        end
        object CBoxMetricType: TComboBox
          Left = 64
          Top = 120
          Width = 129
          Height = 21
          TabOrder = 4
          OnChange = CBoxMetricTypeChange
          Items.Strings = (
            'Euclidian'
            'City-Block')
        end
      end
    end
    object tsConfigReport: TTabSheet
      Caption = 'Step 2: Configure reports'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 16
        Width = 185
        Height = 105
        Caption = 'Text reports'
        TabOrder = 0
        object chkBoxEigenvalues: TCheckBox
          Left = 8
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Eigenvalues'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object chkBoxFit: TCheckBox
          Left = 8
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Fit and solution'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkBoxDissimilarities: TCheckBox
          Left = 8
          Top = 72
          Width = 97
          Height = 17
          Caption = 'Dissimilarities'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
      object GroupBox4: TGroupBox
        Left = 200
        Top = 16
        Width = 241
        Height = 105
        Caption = 'Report range'
        TabOrder = 1
        object Label8: TLabel
          Left = 48
          Top = 24
          Width = 91
          Height = 13
          Caption = 'Minimum dimension'
        end
        object Label9: TLabel
          Left = 48
          Top = 48
          Width = 94
          Height = 13
          Caption = 'Maximum dimension'
        end
        object Label10: TLabel
          Left = 8
          Top = 72
          Width = 131
          Height = 13
          Caption = 'Reduced space dimensions'
        end
        object EditMinDim: TEdit
          Left = 152
          Top = 24
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 0
          Text = '1'
        end
        object EditMaxDim: TEdit
          Left = 152
          Top = 48
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 1
          Text = '1'
        end
        object UpDownMinDim: TUpDown
          Left = 193
          Top = 24
          Width = 16
          Height = 21
          Associate = EditMinDim
          Min = 1
          Position = 1
          TabOrder = 2
        end
        object UpDownMaxDim: TUpDown
          Left = 193
          Top = 48
          Width = 16
          Height = 21
          Associate = EditMaxDim
          Min = 1
          Position = 1
          TabOrder = 3
        end
        object EditNumDim: TEdit
          Left = 152
          Top = 72
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 4
          Text = '1'
        end
        object UpDownNumDim: TUpDown
          Left = 193
          Top = 72
          Width = 16
          Height = 21
          Associate = EditNumDim
          Min = 1
          Position = 1
          TabOrder = 5
        end
      end
    end
    object tsTextReport: TTabSheet
      Caption = 'Classical MDS: Text report'
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
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tsChart: TTabSheet
      Caption = 'Classical MDS: Charts'
      ImageIndex = 3
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Chart1: TChart
        Left = 0
        Top = 33
        Width = 451
        Height = 194
        Legend.LegendStyle = lsValues
        Legend.TextStyle = ltsPlain
        Title.Text.Strings = (
          'MDS Map')
        BottomAxis.LogarithmicBase = 10.000000000000000000
        Chart3DPercent = 100
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        LeftAxis.LogarithmicBase = 10.000000000000000000
        RightAxis.Grid.ZPosition = 100.000000000000000000
        RightAxis.LogarithmicBase = 10.000000000000000000
        RightAxis.ZPosition = 100.000000000000000000
        TopAxis.Grid.ZPosition = 100.000000000000000000
        TopAxis.LogarithmicBase = 10.000000000000000000
        TopAxis.ZPosition = 100.000000000000000000
        View3DOptions.Elevation = 336
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 29
        View3DOptions.Rotation = 343
        View3DOptions.Zoom = 70
        Zoom.Brush.Gradient.Direction = gdFromTopLeft
        Zoom.Brush.Gradient.EndColor = clSilver
        Zoom.Brush.Gradient.MidColor = clWhite
        Zoom.Brush.Gradient.StartColor = clSilver
        Zoom.Pen.Mode = pmNotXor
        Align = alClient
        Color = clWhite
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 0
      end
      object TeeCommander1: TTeeCommander
        Left = 0
        Top = 0
        Width = 451
        Height = 33
        Panel = Chart1
        Align = alTop
        ParentShowHint = False
        TabOrder = 1
      end
    end
  end
end
