object MultiStepRegForm: TMultiStepRegForm
  Left = 0
  Top = 0
  Caption = 'Multistep regression'
  ClientHeight = 742
  ClientWidth = 1022
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1022
    742)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 890
    Top = 335
    Width = 112
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Initial variable selection'
    ExplicitLeft = 895
  end
  object Label2: TLabel
    Left = 891
    Top = 266
    Width = 74
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Quality criteria:'
    ExplicitLeft = 897
  end
  object VarListBox: TCheckListBox
    Left = 890
    Top = 354
    Width = 115
    Height = 197
    OnClickCheck = VarListBoxClickCheck
    Anchors = [akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object StepButton: TButton
    Left = 906
    Top = 565
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Step'
    TabOrder = 1
    OnClick = StepButtonClick
    ExplicitLeft = 911
    ExplicitTop = 560
  end
  object StringGrid: TStringGrid
    Left = 8
    Top = 107
    Width = 864
    Height = 618
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 20
    DefaultColWidth = 70
    DefaultRowHeight = 22
    RowCount = 100
    TabOrder = 2
    ExplicitWidth = 869
    ExplicitHeight = 613
    ColWidths = (
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70)
    RowHeights = (
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22
      22)
  end
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 1022
    Height = 94
    Align = alTop
    Lines.Strings = (
      'Memo')
    TabOrder = 3
  end
  object MethodGroup: TRadioGroup
    Left = 892
    Top = 114
    Width = 113
    Height = 133
    Anchors = [akTop, akRight]
    Caption = 'Method'
    ItemIndex = 0
    Items.Strings = (
      'Forward'
      'Backward'
      'Exhaustive'
      'Stepwise')
    TabOrder = 4
    OnClick = MethodGroupClick
    ExplicitLeft = 897
  end
  object Qualitybox: TComboBox
    Left = 892
    Top = 285
    Width = 113
    Height = 21
    Style = csDropDownList
    Anchors = [akTop, akRight]
    TabOrder = 5
    OnChange = QualityboxChange
    Items.Strings = (
      'Std Error'
      'F-Value')
  end
end
