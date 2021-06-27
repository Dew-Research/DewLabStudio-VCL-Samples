object clFunctionForm: TclFunctionForm
  Left = 252
  Top = 107
  Caption = 'Open CL benchmark'
  ClientHeight = 723
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 873
    Height = 130
    Align = alTop
    TabOrder = 0
    object RichEdit1: TRichEdit
      Left = 1
      Top = 1
      Width = 871
      Height = 128
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      Zoom = 100
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 665
    Width = 873
    Height = 58
    Align = alBottom
    Color = 14869218
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 0
    Top = 130
    Width = 873
    Height = 535
    Align = alClient
    Color = 14869218
    TabOrder = 2
    object Label5: TLabel
      Left = 15
      Top = 348
      Width = 66
      Height = 13
      Caption = 'Vector length:'
    end
    object Label6: TLabel
      Left = 15
      Top = 372
      Width = 113
      Height = 13
      Caption = 'Open CL float precision:'
    end
    object CPUFloatPrecisionLabel: TLabel
      Left = 15
      Top = 399
      Width = 138
      Height = 13
      Caption = 'CPU (MtxVec) float precision:'
    end
    object Label1: TLabel
      Left = 15
      Top = 8
      Width = 56
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
    object Label4: TLabel
      Left = 15
      Top = 231
      Width = 80
      Height = 13
      Caption = 'Test function list:'
    end
    object Label3: TLabel
      Left = 363
      Top = 8
      Width = 39
      Height = 13
      Caption = 'Timings:'
    end
    object Memo: TMemo
      Left = 363
      Top = 24
      Width = 274
      Height = 308
      TabOrder = 0
    end
    object FloatPrecisionBox: TComboBox
      Left = 145
      Top = 372
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        '32bit single precision'
        '64bit double precision')
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
      TabOrder = 2
    end
    object VectorLengthBox: TComboBox
      Left = 145
      Top = 345
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
    object DeviceListBox: TListBox
      Left = 15
      Top = 128
      Width = 325
      Height = 89
      Hint = 'Select the device on which to run the function'
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
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
      TabOrder = 6
      OnClick = PlatformListBoxClick
    end
    object Button1: TButton
      Left = 555
      Top = 343
      Width = 82
      Height = 25
      Caption = 'Run'
      TabOrder = 7
      OnClick = Button1Click
    end
  end
end
