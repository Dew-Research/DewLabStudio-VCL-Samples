inherited frmANOVATest: TfrmANOVATest
  Left = 218
  Caption = 'frmANOVATest'
  ClientHeight = 477
  ClientWidth = 645
  OldCreateOrder = True
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 645
    Height = 348
    ExplicitWidth = 645
    ExplicitHeight = 348
    object Panel2: TPanel
      Left = 0
      Top = 251
      Width = 645
      Height = 97
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 645
        Height = 13
        Align = alTop
        Caption = 'Analysis of variance : '
        ExplicitWidth = 103
      end
      object StringGrid1: TStringGrid
        Left = 0
        Top = 13
        Width = 645
        Height = 84
        Align = alClient
        ColCount = 7
        DefaultColWidth = 90
        DefaultRowHeight = 18
        RowCount = 4
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 163
      Height = 251
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 10
        Top = 10
        Width = 30
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
      Width = 482
      Height = 251
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        '')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  inherited Memo1: TMemo
    Width = 645
    ExplicitWidth = 645
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
