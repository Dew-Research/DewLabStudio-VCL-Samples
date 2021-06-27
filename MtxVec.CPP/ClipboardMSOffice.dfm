inherited MSOffice: TMSOffice
  Caption = 'MSOffice'
  ClientHeight = 359
  OldCreateOrder = True
  ExplicitHeight = 397
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 220
    ExplicitHeight = 220
    inherited RichEdit1: TRichEdit
      Height = 218
      ExplicitHeight = 218
    end
  end
  inherited Panel2: TPanel
    Top = 301
    ExplicitTop = 301
  end
  inherited Panel3: TPanel
    Top = 220
    Height = 81
    ExplicitTop = 220
    ExplicitHeight = 81
    object Button1: TButton
      Left = 16
      Top = 24
      Width = 97
      Height = 25
      Caption = 'MtxVec -> Excel'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 56
      Width = 97
      Height = 25
      Caption = 'Word -> MtxVec'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
