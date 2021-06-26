inherited frmSavePrec: TfrmSavePrec
  Left = 252
  Top = 107
  Width = 706
  Height = 611
  Caption = 'frmSavePrec'
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 698
    inherited RichEdit1: TRichEdit
      Width = 696
      Font.Color = 7105644
    end
  end
  inherited Panel2: TPanel
    Top = 519
    Width = 698
  end
  inherited Panel3: TPanel
    Width = 698
    Height = 389
    object Label1: TLabel
      Left = 184
      Top = 5
      Width = 109
      Height = 13
      Caption = 'Original matrix (50x50): '
    end
    object Label2: TLabel
      Left = 184
      Top = 137
      Width = 105
      Height = 13
      Caption = 'Saved matrix (50x50): '
    end
    object Label3: TLabel
      Left = 16
      Top = 5
      Width = 52
      Height = 13
      Caption = 'Precision : '
    end
    object Label4: TLabel
      Left = 16
      Top = 53
      Width = 78
      Height = 13
      Caption = 'Rounding type : '
    end
    object Label5: TLabel
      Left = 360
      Top = 137
      Width = 86
      Height = 13
      Caption = 'MemStream size : '
    end
    object lblMemSize: TLabel
      Left = 448
      Top = 137
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Button1: TButton
      Left = 16
      Top = 112
      Width = 75
      Height = 25
      Caption = '&Save'
      TabOrder = 0
      OnClick = Button1Click
    end
    object CBPrecision: TComboBox
      Left = 16
      Top = 24
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'CBPrecision'
      OnChange = CBPrecisionChange
      Items.Strings = (
        'prDouble'
        'prSingle'
        'prInteger'
        'prCardinal'
        'prSmallInt'
        'prWord'
        'prShortInt'
        'prByte')
    end
    object CBRounding: TComboBox
      Left = 16
      Top = 72
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'CBRounding'
      OnChange = CBRoundingChange
      Items.Strings = (
        'rnTrunc'
        'rnTruncNeg'
        'rnRound')
    end
    object StringGrid1: TStringGrid
      Left = 190
      Top = 20
      Width = 363
      Height = 104
      Anchors = [akLeft, akTop, akRight]
      DefaultColWidth = 75
      DefaultRowHeight = 16
      TabOrder = 3
    end
    object StringGrid2: TStringGrid
      Left = 190
      Top = 157
      Width = 363
      Height = 123
      Anchors = [akLeft, akTop, akRight, akBottom]
      DefaultColWidth = 75
      DefaultRowHeight = 16
      TabOrder = 4
      RowHeights = (
        16
        16
        16
        16
        16)
    end
  end
end
