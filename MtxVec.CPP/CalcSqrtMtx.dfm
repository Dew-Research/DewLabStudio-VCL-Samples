inherited frmSqrtMtx: TfrmSqrtMtx
  Caption = 'frmSqrtMtx'
  ClientHeight = 518
  ClientWidth = 631
  OldCreateOrder = True
  ExplicitWidth = 647
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 631
    Height = 79
    ExplicitWidth = 631
    ExplicitHeight = 79
    inherited RichEdit1: TRichEdit
      Width = 629
      Height = 77
      ExplicitWidth = 629
      ExplicitHeight = 77
    end
  end
  inherited Panel2: TPanel
    Top = 460
    Width = 631
    ExplicitTop = 460
    ExplicitWidth = 631
    object Button1: TBitBtn
      Left = 16
      Top = 10
      Width = 129
      Height = 24
      Caption = 'Generate random matrix'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 160
      Top = 10
      Width = 97
      Height = 24
      Caption = 'SQRT(A)'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 264
      Top = 10
      Width = 120
      Height = 24
      Caption = 'SQRT(A)*SQRT(A) ?'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  inherited Panel3: TPanel
    Top = 79
    Width = 631
    Height = 381
    ExplicitTop = 79
    ExplicitWidth = 631
    ExplicitHeight = 381
    object Label1: TLabel
      Left = 150
      Top = 13
      Width = 16
      Height = 13
      Caption = 'A : '
    end
    object Label2: TLabel
      Left = 130
      Top = 111
      Width = 35
      Height = 13
      Caption = 'Sqrt A :'
    end
    object StringGrid1: TStringGrid
      Left = 172
      Top = 14
      Width = 219
      Height = 91
      ColCount = 2
      DefaultRowHeight = 18
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      TabOrder = 0
      OnSetEditText = StringGrid1SetEditText
    end
    object StringGrid2: TStringGrid
      Left = 172
      Top = 111
      Width = 219
      Height = 85
      ColCount = 2
      DefaultRowHeight = 18
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goAlwaysShowEditor]
      TabOrder = 1
      RowHeights = (
        18
        19)
    end
    object RadioGroup1: TRadioGroup
      Left = 7
      Top = 13
      Width = 130
      Height = 59
      Caption = ' Matrix type '
      ItemIndex = 0
      Items.Strings = (
        'Symmetric'
        'General')
      TabOrder = 2
    end
  end
end
