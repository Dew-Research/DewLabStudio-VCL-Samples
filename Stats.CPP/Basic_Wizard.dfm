object frmBasicWizard: TfrmBasicWizard
  Left = 0
  Top = 0
  Caption = 'frmBasicWizard'
  ClientHeight = 421
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 33
    Width = 607
    Height = 356
    Align = alClient
    TabOrder = 0
    TabStop = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 389
    Width = 607
    Height = 32
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      607
      32)
    object btnHelp: TButton
      Left = 16
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Help'
      TabOrder = 0
    end
    object btnBack: TButton
      Left = 144
      Top = 4
      Width = 75
      Height = 25
      Caption = '< &Back'
      TabOrder = 1
      OnClick = btnBackClick
    end
    object btnNext: TButton
      Left = 224
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Next >'
      TabOrder = 2
      OnClick = btnNextClick
    end
    object btnCancel: TButton
      Left = 525
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      TabOrder = 3
      OnClick = btnCancelClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 607
    Height = 33
    Align = alTop
    TabOrder = 2
    object lblHeader: TLabel
      Left = 8
      Top = 16
      Width = 55
      Height = 13
      Caption = 'lblHeader'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
