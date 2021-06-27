inherited frmLogReg: TfrmLogReg
  Left = 323
  Top = 242
  Caption = 'frmLogReg'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 163
      Height = 272
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Button1: TButton
        Left = 13
        Top = 13
        Width = 131
        Height = 20
        Caption = 'Dependent variable (Y)'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 13
        Top = 39
        Width = 131
        Height = 20
        Caption = 'Independent variables (A)'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 13
        Top = 85
        Width = 131
        Height = 20
        Caption = '&Recalculate'
        TabOrder = 2
        OnClick = Button3Click
      end
    end
    object Memo2: TMemo
      Left = 163
      Top = 0
      Width = 318
      Height = 272
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object MtxLogReg: TMtxLogistReg
    Tolerance = 0.000000014901161194
    Left = 216
    Top = 47
    MtxDataValues = {}
  end
end
