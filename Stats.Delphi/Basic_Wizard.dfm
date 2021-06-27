object frmBasicWizard: TfrmBasicWizard
  Left = 236
  Top = 106
  ClientHeight = 302
  ClientWidth = 459
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 270
    Width = 459
    Height = 32
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      459
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
      Left = 385
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
    Width = 459
    Height = 33
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 467
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
  object PageControl: TPageControl
    Left = 0
    Top = 33
    Width = 459
    Height = 237
    Align = alClient
    TabOrder = 2
    TabStop = False
    ExplicitWidth = 467
    ExplicitHeight = 241
  end
end
