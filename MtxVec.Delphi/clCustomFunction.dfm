object clCustomFunctionForm: TclCustomFunctionForm
  Left = 0
  Top = 0
  Caption = 'clCustomFunctionForm'
  ClientHeight = 441
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 124
    Width = 593
    Height = 317
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 8
      Width = 60
      Height = 13
      Caption = 'Platform list:'
    end
    object Label2: TLabel
      Left = 15
      Top = 109
      Width = 52
      Height = 13
      Caption = 'Device list:'
    end
    object Label5: TLabel
      Left = 12
      Top = 237
      Width = 68
      Height = 13
      Caption = 'Vector length:'
    end
    object Button1: TButton
      Left = 258
      Top = 232
      Width = 82
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = Button1Click
    end
    object PlatformListBox: TListBox
      Left = 15
      Top = 26
      Width = 325
      Height = 73
      Hint = 'Select the platform on which to run the function'
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = PlatformListBoxClick
    end
    object DeviceListBox: TListBox
      Left = 15
      Top = 128
      Width = 325
      Height = 89
      Hint = 'Select the device on which to run the function'
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object VectorLengthBox: TComboBox
      Left = 93
      Top = 234
      Width = 145
      Height = 21
      TabOrder = 3
      Items.Strings = (
        '4096'
        '16384'
        '32768'
        '131072'
        '262144'
        '524288'
        '1048576')
    end
    object AutoDeviceButton: TButton
      Left = 351
      Top = 128
      Width = 82
      Height = 25
      Hint = 
        'Test run load function to detect the fastest device for the func' +
        'tion given'
      Caption = 'Auto select'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = AutoDeviceButtonClick
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 593
    Height = 124
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    TabOrder = 1
  end
end
