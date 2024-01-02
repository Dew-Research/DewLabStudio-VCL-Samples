object clFunctionForm: TclFunctionForm
  Left = 0
  Top = 0
  Caption = 'clFunctionForm'
  ClientHeight = 625
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 124
    Width = 717
    Height = 501
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
    object Label3: TLabel
      Left = 363
      Top = 8
      Width = 39
      Height = 13
      Caption = 'Timings:'
    end
    object Label4: TLabel
      Left = 15
      Top = 231
      Width = 83
      Height = 13
      Caption = 'Test function list:'
    end
    object Label5: TLabel
      Left = 15
      Top = 348
      Width = 68
      Height = 13
      Caption = 'Vector length:'
    end
    object Label6: TLabel
      Left = 15
      Top = 375
      Width = 115
      Height = 13
      Caption = 'Open CL float precision:'
    end
    object CPUFloatPrecisionLabel: TLabel
      Left = 15
      Top = 402
      Width = 140
      Height = 13
      Caption = 'CPU (MtxVec) float precision:'
    end
    object Button1: TButton
      Left = 555
      Top = 343
      Width = 82
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Memo: TMemo
      Left = 363
      Top = 24
      Width = 274
      Height = 308
      TabOrder = 1
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
      TabOrder = 2
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
      TabOrder = 3
    end
    object FunctionBox: TListBox
      Left = 15
      Top = 250
      Width = 325
      Height = 82
      Hint = 'Select a function to benchmark'
      ItemHeight = 13
      Items.Strings = (
        'c = c *  b'
        'a = sin(a) + sin(c)'
        'c = sqrt(4 * a * INVTWOPI) * a * sqr(x) * Exp(-0.5 * a * sqr(x))'
        'a = Mean(c)')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object VectorLengthBox: TComboBox
      Left = 145
      Top = 345
      Width = 145
      Height = 21
      TabOrder = 5
      Items.Strings = (
        '4096'
        '16384'
        '32768'
        '131072'
        '262144'
        '524288'
        '1048576')
    end
    object ComplexBox: TCheckBox
      Left = 304
      Top = 347
      Width = 84
      Height = 17
      Hint = 'Check to run complex number math'
      Caption = 'Complex'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object FloatPrecisionBox: TComboBox
      Left = 145
      Top = 372
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 7
      Items.Strings = (
        '32bit single precision'
        '64bit double precision')
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 717
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
