inherited LinearSystem1: TLinearSystem1
  Caption = 'LinearSystem1'
  ClientHeight = 416
  ClientWidth = 519
  OldCreateOrder = True
  OnDestroy = FormDestroy
  ExplicitWidth = 535
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 519
    ExplicitWidth = 519
    inherited RichEdit1: TRichEdit
      Width = 517
      ExplicitWidth = 517
    end
  end
  inherited Panel2: TPanel
    Top = 416
    Width = 519
    Height = 0
    ExplicitTop = 416
    ExplicitWidth = 519
    ExplicitHeight = 0
  end
  inherited Panel3: TPanel
    Width = 519
    Height = 286
    ExplicitWidth = 519
    ExplicitHeight = 286
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 73
      Height = 13
      Caption = 'matrix A (LHS): '
    end
    object Label2: TLabel
      Left = 264
      Top = 8
      Width = 44
      Height = 13
      Caption = 'vector x :'
    end
    object Label3: TLabel
      Left = 368
      Top = 8
      Width = 77
      Height = 13
      Caption = 'vector b (RHS): '
    end
    object Label4: TLabel
      Left = 240
      Top = 56
      Width = 7
      Height = 13
      Caption = 'x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 344
      Top = 56
      Width = 8
      Height = 13
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 24
      Top = 112
      Width = 45
      Height = 13
      Caption = 'Method : '
    end
    object StringGrid1: TStringGrid
      Left = 24
      Top = 24
      Width = 209
      Height = 81
      ColCount = 4
      DefaultColWidth = 50
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 4
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      ScrollBars = ssNone
      TabOrder = 0
    end
    object StringGrid2: TStringGrid
      Left = 264
      Top = 24
      Width = 73
      Height = 81
      ColCount = 1
      DefaultColWidth = 66
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 4
      FixedRows = 0
      ScrollBars = ssHorizontal
      TabOrder = 1
    end
    object StringGrid3: TStringGrid
      Left = 368
      Top = 24
      Width = 57
      Height = 81
      ColCount = 1
      DefaultColWidth = 50
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 4
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      ScrollBars = ssNone
      TabOrder = 2
    end
    object Button1: TButton
      Left = 432
      Top = 80
      Width = 65
      Height = 25
      Caption = 'SOLVE'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Panel4: TPanel
      Left = 24
      Top = 144
      Width = 369
      Height = 137
      TabOrder = 4
      object Label6: TLabel
        Left = 120
        Top = 16
        Width = 41
        Height = 13
        Caption = 'Report : '
      end
      object Memo2: TMemo
        Left = 120
        Top = 32
        Width = 241
        Height = 89
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 32
        Width = 97
        Height = 81
        Caption = 'Condition Norm'
        ItemIndex = 1
        Items.Strings = (
          'cnNone'
          'cnNorm1'
          'cnNormInf')
        TabOrder = 1
        OnClick = RadioGroup1Click
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 8
        Width = 97
        Height = 17
        Caption = 'Refine solution'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = CheckBox1Click
      end
    end
    object ComboBox1: TComboBox
      Left = 72
      Top = 112
      Width = 129
      Height = 21
      TabOrder = 5
      Text = 'ComboBox1'
      OnChange = ComboBox1Change
      Items.Strings = (
        'LUSolve'
        'SVDSolve')
    end
    object Panel5: TPanel
      Left = 24
      Top = 144
      Width = 97
      Height = 113
      TabOrder = 6
      object Label7: TLabel
        Left = 8
        Top = 8
        Width = 81
        Height = 13
        Caption = 'Singular values : '
      end
      object StringGrid4: TStringGrid
        Left = 8
        Top = 24
        Width = 73
        Height = 81
        ColCount = 1
        DefaultColWidth = 66
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        ScrollBars = ssHorizontal
        TabOrder = 0
      end
    end
  end
end
