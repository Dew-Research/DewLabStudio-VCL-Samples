inherited frmANOVATest: TfrmANOVATest
  Caption = 'frmANOVATest'
  ClientHeight = 426
  ClientWidth = 659
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 659
    ExplicitLeft = 0
    ExplicitWidth = 659
  end
  inherited Panel1: TPanel
    Width = 659
    Height = 297
    ExplicitLeft = 0
    ExplicitTop = 129
    ExplicitWidth = 659
    ExplicitHeight = 297
    object Panel2: TPanel
      Left = 0
      Top = 195
      Width = 659
      Height = 102
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 106
        Height = 13
        Align = alTop
        Caption = 'Analysis of variance : '
      end
      object StringGrid1: TStringGrid
        Left = 0
        Top = 13
        Width = 640
        Height = 82
        Align = alClient
        ColCount = 7
        DefaultColWidth = 90
        DefaultRowHeight = 18
        RowCount = 4
        TabOrder = 0
        ColWidths = (
          90
          90
          90
          90
          90
          90
          90)
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 163
      Height = 195
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 10
        Top = 10
        Width = 31
        Height = 13
        Caption = 'Test : '
      end
      object SpeedButton1: TSpeedButton
        Left = 10
        Top = 64
        Width = 75
        Height = 22
        Caption = 'Recalculate'
        OnClick = SpeedButton1Click
      end
      object ComboBox1: TComboBox
        Left = 6
        Top = 32
        Width = 144
        Height = 21
        TabOrder = 0
        Text = 'ComboBox1'
        OnChange = ComboBox1Change
        Items.Strings = (
          'SmLs01 (lower difficulty)'
          'tmWtAg (avg. difficulty)'
          'SmLs07 (higher difficulty)')
      end
    end
    object RichEdit1: TRichEdit
      Left = 163
      Top = 0
      Width = 496
      Height = 195
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        '')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  object MtxAnova: TMtxAnova
    Alpha = 0.050000000000000000
    FmtString = '0.0000'
    ResultDest = StringGrid1
    Left = 136
    Top = 201
    MtxDataValues = {}
  end
end
