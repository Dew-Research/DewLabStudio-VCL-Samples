inherited LQRDemo: TLQRDemo
  Caption = 'LQRDemo'
  ClientHeight = 510
  ClientWidth = 570
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 570
    ExplicitWidth = 570
    inherited RichEdit1: TRichEdit
      Width = 568
      ExplicitWidth = 568
    end
  end
  inherited Panel2: TPanel
    Top = 452
    Width = 570
    ExplicitTop = 452
    ExplicitWidth = 570
    object Button1: TBitBtn
      Left = 16
      Top = 16
      Width = 121
      Height = 25
      Caption = 'Perform decomposition'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 160
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Singular values'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TBitBtn
      Left = 256
      Top = 16
      Width = 81
      Height = 25
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  inherited Panel3: TPanel
    Width = 570
    Height = 322
    Constraints.MinHeight = 275
    Constraints.MinWidth = 570
    ExplicitWidth = 570
    ExplicitHeight = 322
    object Label1: TLabel
      Left = 160
      Top = 8
      Width = 47
      Height = 13
      Caption = 'Matrix A : '
    end
    object RadioGroup1: TRadioGroup
      Left = 16
      Top = 8
      Width = 129
      Height = 97
      Caption = 'Examples : '
      ItemIndex = 1
      Items.Strings = (
        'LQ (Rows < Cols)'
        'QR (Rows > Cols)'
        'SVD (Rows < Cols)'
        'SVD (Rows > Cols)')
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object StringGrid1: TStringGrid
      Left = 160
      Top = 24
      Width = 265
      Height = 89
      ColCount = 4
      DefaultColWidth = 60
      DefaultRowHeight = 18
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      ScrollBars = ssNone
      TabOrder = 1
    end
    object StringGrid2: TStringGrid
      Left = 8
      Top = 136
      Width = 249
      Height = 81
      ColCount = 4
      DefaultColWidth = 60
      DefaultRowHeight = 18
      RowCount = 4
      ScrollBars = ssNone
      TabOrder = 2
    end
    object StringGrid3: TStringGrid
      Left = 264
      Top = 136
      Width = 177
      Height = 81
      ColCount = 4
      DefaultColWidth = 60
      DefaultRowHeight = 18
      RowCount = 4
      ScrollBars = ssNone
      TabOrder = 3
      RowHeights = (
        18
        18
        18
        18)
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 112
      Width = 113
      Height = 17
      Caption = '"Ecomony" size'
      TabOrder = 4
    end
  end
end
