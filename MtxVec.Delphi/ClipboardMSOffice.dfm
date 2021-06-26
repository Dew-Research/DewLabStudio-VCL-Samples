inherited MSOffice: TMSOffice
  Caption = 'MSOffice'
  ClientHeight = 357
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 193
    inherited RichEdit1: TRichEdit
      Height = 191
    end
  end
  inherited Panel2: TPanel
    Top = 299
    ExplicitTop = 301
  end
  inherited Panel3: TPanel
    Top = 193
    Height = 106
    ExplicitTop = 193
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
