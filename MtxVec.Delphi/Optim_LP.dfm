inherited frmLP: TfrmLP
  Caption = 'frmLP'
  ClientHeight = 521
  ClientWidth = 741
  OnCreate = FormCreate
  ExplicitWidth = 757
  ExplicitHeight = 560
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 741
    ExplicitWidth = 741
    inherited RichEdit1: TRichEdit
      Width = 739
      ExplicitWidth = 739
    end
  end
  inherited Panel2: TPanel
    Top = 463
    Width = 741
    ExplicitTop = 463
    ExplicitWidth = 741
  end
  inherited Panel3: TPanel
    Width = 741
    Height = 333
    ExplicitWidth = 741
    ExplicitHeight = 333
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 192
      Height = 331
      Align = alLeft
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 49
        Height = 13
        Caption = 'Algorithm:'
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 122
        Width = 172
        Height = 89
        Caption = 'System of equations'
        TabOrder = 0
        object Label2: TLabel
          Left = 16
          Top = 24
          Width = 71
          Height = 13
          Caption = '# of equations'
        end
        object Label3: TLabel
          Left = 16
          Top = 56
          Width = 77
          Height = 13
          Caption = '# of constraints'
        end
        object MtxFloatEdit2: TMtxFloatEdit
          Left = 104
          Top = 53
          Width = 57
          Height = 22
          RegistryPath = '\Software\Dew Research\MtxVec'
          StoreInRegistry = False
          IntegerIncrement = True
          Scientific = False
          ReFormat = '0'
          ImFormat = '+0.00#i;-0.00#i'
          Increment = '1'
          MaxValue = '100'
          MinValue = '0'
          TabOrder = 0
          Value = '2'
          OnChange = MtxFloatEdit2Change
        end
        object MtxFloatEdit1: TMtxFloatEdit
          Left = 104
          Top = 25
          Width = 57
          Height = 22
          RegistryPath = '\Software\Dew Research\MtxVec'
          StoreInRegistry = False
          IntegerIncrement = True
          Scientific = False
          ReFormat = '0'
          ImFormat = '+0.00#i;-0.00#i'
          Increment = '1'
          MaxValue = '100'
          MinValue = '0'
          TabOrder = 1
          Value = '7'
          OnChange = MtxFloatEdit1Change
        end
      end
      object ComboBox1: TComboBox
        Left = 8
        Top = 35
        Width = 121
        Height = 21
        ItemIndex = 1
        TabOrder = 1
        Text = 'Two Phase Simplex'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Dual Simplex'
          'Two Phase Simplex'
          'Simplex'
          'Gomory'#39's CPA')
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 95
        Width = 97
        Height = 15
        Caption = 'Log'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = CheckBox2Click
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 68
        Width = 97
        Height = 15
        Caption = 'Minimum'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object Button1: TButton
        Left = 9
        Top = 224
        Width = 172
        Height = 28
        Caption = 'Solve'
        TabOrder = 4
        OnClick = Button1Click
      end
    end
    object Panel5: TPanel
      Left = 193
      Top = 1
      Width = 547
      Height = 331
      Align = alClient
      TabOrder = 1
      object Splitter1: TSplitter
        Left = 1
        Top = 169
        Width = 545
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 137
        ExplicitWidth = 482
      end
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 545
        Height = 168
        Align = alTop
        TabOrder = 0
        DesignSize = (
          545
          168)
        object LabelA: TLabel
          Left = 5
          Top = 8
          Width = 56
          Height = 13
          Caption = 'A in Ax<=b'
        end
        object Label5: TLabel
          Left = 221
          Top = 8
          Width = 55
          Height = 13
          Caption = 'b in Ax<=b'
        end
        object Label4: TLabel
          Left = 365
          Top = 8
          Width = 70
          Height = 13
          Caption = 'c in f(x)=c(T)x'
        end
        object Label6: TLabel
          Left = 5
          Top = 146
          Width = 48
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Relations:'
        end
        object MtxVecGrid1: TMtxVecGrid
          Left = 5
          Top = 27
          Width = 188
          Height = 106
          Anchors = [akLeft, akTop, akBottom]
          DefaultColWidth = 50
          DefaultRowHeight = 14
          Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goTabs, goThumbTracking]
          TabOrder = 0
          Editable = True
          Scientific = False
          StringFormat = '0.####'
          ShowInfo = False
          ColWidths = (
            50
            41)
          RowHeights = (
            16
            14)
        end
        object MtxVecGrid2: TMtxVecGrid
          Left = 227
          Top = 27
          Width = 132
          Height = 106
          Anchors = [akLeft, akTop, akBottom]
          DefaultColWidth = 50
          DefaultRowHeight = 14
          Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goTabs, goThumbTracking]
          TabOrder = 1
          Editable = True
          Scientific = False
          StringFormat = '0.####'
          ShowInfo = False
          ColWidths = (
            50
            41)
          RowHeights = (
            16
            14)
        end
        object MtxVecGrid3: TMtxVecGrid
          Left = 367
          Top = 27
          Width = 132
          Height = 106
          Anchors = [akLeft, akTop, akBottom]
          DefaultColWidth = 50
          DefaultRowHeight = 14
          Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goTabs, goThumbTracking]
          TabOrder = 2
          Editable = True
          Scientific = False
          StringFormat = '0.####'
          ShowInfo = False
          ColWidths = (
            50
            41)
          RowHeights = (
            16
            14)
        end
        object EditRelations: TEdit
          Left = 59
          Top = 141
          Width = 134
          Height = 21
          Anchors = [akLeft, akBottom]
          TabOrder = 3
          Text = '=='
          OnChange = EditRelationsChange
        end
      end
      object Memo1: TMemo
        Left = 1
        Top = 172
        Width = 545
        Height = 158
        Align = alClient
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
  end
  object MtxLP1: TMtxLP
    c.DataValues = {
      0000000000000000000000000000803F0000000000001B440000004100000000
      00137A47000000000000000000000000}
    A.LeadingCols = 0
    A.DataValues = {
      000000000000000000000000000000000000000000000000000040400000803F
      0000000000000000000000000000803F00000000000000000000000000000041
      00001B440000000000137A470000000000000000000000000000000000000000
      000000000000000000000000}
    b.DataValues = {
      0000000000000000000000000000803F0000000000001B440000004100000000
      00137A47000000000000000000000000}
    Algorithm = LPAlgoTwoPhaseSimplex
    Left = 128
    Top = 64
    MtxDataValues = {}
  end
end
