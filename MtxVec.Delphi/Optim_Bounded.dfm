inherited frmOptimBounded: TfrmOptimBounded
  Caption = 'frmOptimBounded'
  ClientHeight = 603
  ClientWidth = 721
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 737
  ExplicitHeight = 642
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 721
    ExplicitWidth = 721
    inherited RichEdit1: TRichEdit
      Width = 719
      ExplicitWidth = 719
    end
  end
  inherited Panel2: TPanel
    Top = 564
    Width = 721
    Height = 39
    ExplicitTop = 558
    ExplicitWidth = 697
    ExplicitHeight = 39
  end
  inherited Panel3: TPanel
    Width = 721
    Height = 434
    ExplicitWidth = 721
    ExplicitHeight = 303
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 45
      Height = 13
      Caption = 'Function:'
    end
    object Label2: TLabel
      Left = 8
      Top = 57
      Width = 47
      Height = 13
      Caption = 'Variables:'
    end
    object Label5: TLabel
      Left = 300
      Top = 200
      Width = 42
      Height = 13
      Caption = 'Results :'
    end
    object EditFunction: TEdit
      Left = 58
      Top = 13
      Width = 378
      Height = 21
      TabOrder = 0
      OnChange = EditFunctionChange
    end
    object StringGridVars: TStringGrid
      Left = 8
      Top = 76
      Width = 281
      Height = 117
      ColCount = 4
      DefaultRowHeight = 16
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      ScrollBars = ssVertical
      TabOrder = 1
      ColWidths = (
        64
        64
        64
        64)
      RowHeights = (
        16
        16)
    end
    object ButtonDetect: TButton
      Left = 455
      Top = 11
      Width = 75
      Height = 25
      Caption = 'Detect'
      TabOrder = 2
      OnClick = ButtonDetectClick
    end
    object Button1: TButton
      Left = 455
      Top = 42
      Width = 75
      Height = 25
      Caption = 'Calculate'
      Enabled = False
      TabOrder = 3
      OnClick = Button1Click
    end
    object Memo1: TMemo
      Left = 8
      Top = 219
      Width = 281
      Height = 210
      Anchors = [akLeft, akTop, akBottom]
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 4
      ExplicitHeight = 204
    end
    object GroupBox1: TGroupBox
      Left = 300
      Top = 70
      Width = 230
      Height = 124
      Caption = 'Parameters'
      TabOrder = 5
      object Label3: TLabel
        Left = 16
        Top = 27
        Width = 51
        Height = 13
        Caption = 'Tolerance:'
      end
      object Label4: TLabel
        Left = 16
        Top = 60
        Width = 51
        Height = 13
        Caption = 'Max. iter.:'
      end
      object Edit1: TEdit
        Left = 73
        Top = 24
        Width = 141
        Height = 21
        TabOrder = 0
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 90
        Width = 51
        Height = 17
        Caption = 'Log'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object Edit2: TEdit
      Left = 373
      Top = 127
      Width = 41
      Height = 21
      TabOrder = 6
      Text = '500'
    end
    object UpDown1: TUpDown
      Left = 414
      Top = 127
      Width = 16
      Height = 21
      Associate = Edit2
      Min = 100
      Max = 1000
      Position = 500
      TabOrder = 7
    end
    object StringGridResults: TStringGrid
      Left = 300
      Top = 219
      Width = 230
      Height = 209
      Anchors = [akLeft, akTop, akBottom]
      ColCount = 2
      DefaultRowHeight = 16
      FixedCols = 0
      TabOrder = 8
      ExplicitHeight = 203
      ColWidths = (
        87
        124)
      RowHeights = (
        16
        16
        16
        16
        16)
    end
  end
end
