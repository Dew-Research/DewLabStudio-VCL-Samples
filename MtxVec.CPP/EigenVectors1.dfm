inherited EigVec1: TEigVec1
  Caption = 'EigVec1'
  ClientHeight = 555
  ClientWidth = 714
  OldCreateOrder = True
  ExplicitWidth = 730
  ExplicitHeight = 594
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 714
    Height = 116
    Anchors = [akLeft, akTop, akRight, akBottom]
    Constraints.MinHeight = 100
    ExplicitWidth = 714
    ExplicitHeight = 116
    inherited RichEdit1: TRichEdit
      Width = 712
      Height = 114
      Constraints.MinHeight = 100
      ExplicitWidth = 712
      ExplicitHeight = 114
    end
  end
  inherited Panel2: TPanel
    Top = 516
    Width = 714
    Height = 39
    ExplicitTop = 516
    ExplicitWidth = 714
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
    Top = 116
    Width = 714
    Height = 400
    Constraints.MinHeight = 360
    Constraints.MinWidth = 615
    ExplicitTop = 116
    ExplicitWidth = 714
    ExplicitHeight = 400
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 47
      Height = 13
      Caption = 'Matrix A : '
    end
    object Label2: TLabel
      Left = 8
      Top = 160
      Width = 189
      Height = 13
      Caption = 'Eigenvalues are elements of vector D :  '
    end
    object Label3: TLabel
      Left = 232
      Top = 160
      Width = 71
      Height = 13
      Caption = 'Eigenvectors : '
    end
    object SpeedButton1: TSpeedButton
      Left = 304
      Top = 160
      Width = 33
      Height = 17
      GroupIndex = 1
      Caption = 'Left'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 336
      Top = 160
      Width = 33
      Height = 17
      GroupIndex = 1
      Down = True
      Caption = 'Right'
      OnClick = SpeedButton2Click
    end
    object StringGrid4: TStringGrid
      Left = 8
      Top = 24
      Width = 265
      Height = 121
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
      Top = 176
      Width = 209
      Height = 113
      ColCount = 3
      DefaultColWidth = 65
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
      Left = 280
      Top = 40
      Width = 77
      Height = 65
      Caption = 'Vector Form'
      ItemIndex = 0
      Items.Strings = (
        'vfEig'
        'vfShur')
      TabOrder = 2
      OnClick = RadioGroup1Click
    end
    object RadioGroup2: TRadioGroup
      Left = 372
      Top = 32
      Width = 123
      Height = 65
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
      Left = 232
      Top = 176
      Width = 385
      Height = 121
      ColCount = 9
      DefaultColWidth = 65
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
