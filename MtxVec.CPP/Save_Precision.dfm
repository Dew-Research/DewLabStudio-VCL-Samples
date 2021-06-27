inherited frmSavePrec: TfrmSavePrec
  Caption = 'frmSavePrec'
  ClientHeight = 535
  ClientWidth = 648
  OldCreateOrder = True
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 648
    ExplicitWidth = 648
    inherited RichEdit1: TRichEdit
      Width = 646
      ExplicitWidth = 646
    end
  end
  inherited Panel2: TPanel
    Top = 499
    Width = 648
    Height = 36
    ExplicitTop = 499
    ExplicitWidth = 648
    ExplicitHeight = 36
  end
  inherited Panel3: TPanel
    Width = 648
    Height = 369
    ExplicitWidth = 648
    ExplicitHeight = 369
    object Label1: TLabel
      Left = 184
      Top = 5
      Width = 109
      Height = 13
      Caption = 'Original matrix (50x50): '
    end
    object Label2: TLabel
      Left = 184
      Top = 124
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
      Left = 353
      Top = 124
      Width = 86
      Height = 13
      Caption = 'MemStream size : '
    end
    object lblMemSize: TLabel
      Left = 448
      Top = 124
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
      TabOrder = 2
      Text = 'CBRounding'
      OnChange = CBRoundingChange
      Items.Strings = (
        'rnTrunc'
        'rnTruncNeg'
        'rnRound')
    end
    object StringGrid1: TStringGrid
      Left = 184
      Top = 20
      Width = 330
      Height = 98
      Anchors = [akLeft, akTop, akRight]
      DefaultColWidth = 75
      DefaultRowHeight = 16
      TabOrder = 3
    end
    object StringGrid2: TStringGrid
      Left = 184
      Top = 144
      Width = 330
      Height = 97
      Anchors = [akLeft, akTop, akRight]
      DefaultColWidth = 75
      DefaultRowHeight = 16
      TabOrder = 4
    end
  end
end
