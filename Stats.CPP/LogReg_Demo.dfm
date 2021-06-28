inherited frmLogReg: TfrmLogReg
  Caption = 'frmLogReg'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    ExplicitLeft = 0
  end
  inherited Panel1: TPanel
    ExplicitLeft = 0
    ExplicitTop = 129
    object Memo2: TMemo
      Left = 163
      Top = 0
      Width = 377
      Height = 301
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 163
      Height = 301
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
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
  end
  object MtxLogReg: TMtxLogistReg
    Tolerance = 0.000000014901161194
    Left = 216
    Top = 47
    MtxDataValues = {}
  end
end
