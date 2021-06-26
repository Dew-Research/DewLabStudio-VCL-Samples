inherited EigVec1: TEigVec1
  Top = 127
  Caption = 'EigVec1'
  ClientHeight = 509
  ClientWidth = 653
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 669
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 653
    Height = 102
    Anchors = [akLeft, akTop, akRight, akBottom]
    Constraints.MinHeight = 100
    ExplicitWidth = 607
    ExplicitHeight = 102
    inherited RichEdit1: TRichEdit
      Width = 651
      Height = 100
      Font.Color = 7105644
      Constraints.MinHeight = 100
      ExplicitWidth = 651
      ExplicitHeight = 100
    end
  end
  inherited Panel2: TPanel
    Top = 470
    Width = 653
    Height = 39
    ExplicitTop = 470
    ExplicitWidth = 607
    ExplicitHeight = 39
    object Button1: TBitBtn
      Left = 16
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Calc eigenvalues'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  inherited Panel3: TPanel
    Top = 102
    Width = 653
    Height = 368
    Constraints.MinHeight = 360
    Constraints.MinWidth = 607
    ExplicitTop = 102
    ExplicitWidth = 607
    ExplicitHeight = 368
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 50
      Height = 13
      Caption = 'Matrix A : '
    end
    object Label2: TLabel
      Left = 8
      Top = 150
      Width = 192
      Height = 13
      Caption = 'Eigenvalues are elements of vector D :  '
    end
    object Label3: TLabel
      Left = 216
      Top = 150
      Width = 72
      Height = 13
      Caption = 'Eigenvectors : '
    end
    object SpeedButton1: TSpeedButton
      Left = 288
      Top = 146
      Width = 50
      Height = 20
      GroupIndex = 1
      Caption = 'Left'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 335
      Top = 146
      Width = 50
      Height = 20
      GroupIndex = 1
      Down = True
      Caption = 'Right'
      OnClick = SpeedButton2Click
    end
    object StringGrid4: TStringGrid
      Left = 8
      Top = 24
      Width = 265
      Height = 113
      DefaultRowHeight = 18
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      ScrollBars = ssHorizontal
      TabOrder = 0
      RowHeights = (
        18
        18
        18
        18
        18)
    end
    object StringGrid2: TStringGrid
      Left = 8
      Top = 169
      Width = 193
      Height = 105
      ColCount = 3
      DefaultColWidth = 60
      DefaultRowHeight = 18
      ScrollBars = ssHorizontal
      TabOrder = 1
      RowHeights = (
        18
        18
        18
        18
        18)
    end
    object RadioGroup1: TRadioGroup
      Left = 279
      Top = 18
      Width = 91
      Height = 82
      Caption = 'Vector Form'
      ItemIndex = 0
      Items.Strings = (
        'vfEig'
        'vfShur')
      TabOrder = 2
      OnClick = RadioGroup1Click
    end
    object RadioGroup2: TRadioGroup
      Left = 384
      Top = 18
      Width = 160
      Height = 82
      Caption = 'Balance'
      Columns = 2
      ItemIndex = 3
      Items.Strings = (
        'btNone'
        'btScale'
        'btPerm'
        'btFull')
      TabOrder = 3
      OnClick = RadioGroup2Click
    end
    object StringGrid1: TStringGrid
      Left = 216
      Top = 169
      Width = 391
      Height = 105
      ColCount = 9
      DefaultColWidth = 60
      DefaultRowHeight = 18
      ScrollBars = ssHorizontal
      TabOrder = 4
      RowHeights = (
        18
        18
        18
        17
        18)
    end
  end
end
