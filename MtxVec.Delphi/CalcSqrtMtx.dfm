inherited frmSqrtMtx: TfrmSqrtMtx
  Left = 104
  Top = 191
  Caption = 'frmSqrtMtx'
  ClientHeight = 516
  ClientWidth = 623
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 639
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 623
    ExplicitWidth = 623
    inherited RichEdit1: TRichEdit
      Width = 621
      ExplicitWidth = 621
    end
  end
  inherited Panel2: TPanel
    Top = 458
    Width = 623
    ExplicitTop = 458
    ExplicitWidth = 623
    object Button1: TBitBtn
      Left = 16
      Top = 15
      Width = 135
      Height = 28
      Caption = 'Generate random matrix'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 160
      Top = 15
      Width = 120
      Height = 28
      Caption = 'SQRT(A)'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 298
      Top = 15
      Width = 120
      Height = 28
      Caption = 'SQRT(A)*SQRT(A) ?'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  inherited Panel3: TPanel
    Width = 623
    Height = 328
    ExplicitWidth = 623
    ExplicitHeight = 328
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 160
      Height = 326
      Align = alLeft
      Color = 14869218
      TabOrder = 0
      object RadioGroup1: TRadioGroup
        Left = 7
        Top = 13
        Width = 130
        Height = 80
        Caption = ' Matrix type '
        ItemIndex = 0
        Items.Strings = (
          'Symmetric'
          'General')
        TabOrder = 0
      end
    end
    object Panel5: TPanel
      Left = 161
      Top = 1
      Width = 461
      Height = 326
      Align = alClient
      Color = 14869218
      TabOrder = 1
      OnResize = Panel5Resize
      object StringGrid1: TStringGrid
        Left = 6
        Top = 2
        Width = 219
        Height = 91
        ColCount = 2
        DefaultRowHeight = 18
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
        TabOrder = 0
        OnSetEditText = StringGrid1SetEditText
        ColWidths = (
          64
          64)
        RowHeights = (
          18
          18)
      end
      object StringGrid2: TStringGrid
        Left = 14
        Top = 167
        Width = 219
        Height = 85
        ColCount = 2
        DefaultRowHeight = 18
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goAlwaysShowEditor]
        TabOrder = 1
        ColWidths = (
          64
          64)
        RowHeights = (
          18
          19)
      end
    end
  end
end
