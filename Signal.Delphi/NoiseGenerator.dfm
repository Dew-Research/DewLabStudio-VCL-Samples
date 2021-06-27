object NoiseGeneratorForm: TNoiseGeneratorForm
  Left = 197
  Top = 111
  Caption = 'Signal Generator'
  ClientHeight = 465
  ClientWidth = 634
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
  object Label7: TLabel
    Left = 24
    Top = 146
    Width = 51
    Height = 13
    Caption = 'Amplitude:'
  end
  object Label8: TLabel
    Left = 24
    Top = 178
    Width = 55
    Height = 13
    Caption = 'Frequence:'
  end
  object Label15: TLabel
    Left = 172
    Top = 146
    Width = 65
    Height = 13
    Caption = '(Range in dB)'
  end
  object Label16: TLabel
    Left = 430
    Top = 171
    Width = 113
    Height = 26
    Caption = '(0Hz to 1/2 Max Sound Card Sample Rate)'
    WordWrap = True
  end
  object Label17: TLabel
    Left = 105
    Top = 200
    Width = 38
    Height = 13
    Caption = 'Single/1'
  end
  object Label18: TLabel
    Left = 212
    Top = 200
    Width = 34
    Height = 13
    Caption = 'Tone/2'
  end
  object Label19: TLabel
    Left = 318
    Top = 200
    Width = 34
    Height = 13
    Caption = 'Tone/3'
  end
  object Label20: TLabel
    Left = 106
    Top = 247
    Width = 34
    Height = 13
    Caption = 'Tone/4'
  end
  object Label21: TLabel
    Left = 212
    Top = 247
    Width = 34
    Height = 13
    Caption = 'Tone/5'
  end
  object Label23: TLabel
    Left = 318
    Top = 247
    Width = 34
    Height = 13
    Caption = 'Tone/6'
  end
  object GroupBox1: TGroupBox
    Left = 273
    Top = 269
    Width = 249
    Height = 177
    Caption = 'Frequency Sweep'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 82
      Height = 13
      Caption = 'Start Frequency:'
    end
    object Label2: TLabel
      Left = 16
      Top = 62
      Width = 80
      Height = 13
      Caption = 'Stop Frequency:'
    end
    object Label3: TLabel
      Left = 16
      Top = 104
      Width = 80
      Height = 13
      Caption = 'Frequency Step:'
      Enabled = False
    end
    object Label12: TLabel
      Left = 16
      Top = 126
      Width = 59
      Height = 13
      Caption = 'Step Speed:'
      Enabled = False
    end
    object MtxFloatEdit5: TMtxFloatEdit
      Left = 138
      Top = 132
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Enabled = False
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 0
      Value = '0.00'
    end
    object MtxFloatEdit8: TMtxFloatEdit
      Left = 138
      Top = 103
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Enabled = False
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '0.00'
    end
    object F2SweepEdit: TMtxFloatEdit
      Left = 138
      Top = 63
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '192000'
      MinValue = '0'
      TabOrder = 2
      Value = '1000'
      OnChange = F2SweepEditChange
    end
    object F1SweepEdit: TMtxFloatEdit
      Left = 138
      Top = 31
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '192000'
      MinValue = '0'
      TabOrder = 3
      Value = '1000'
      OnChange = F1SweepEditChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 24
    Top = 269
    Width = 227
    Height = 177
    Caption = 'Amplitude Sweep'
    TabOrder = 1
    object Label4: TLabel
      Left = 16
      Top = 32
      Width = 79
      Height = 13
      Caption = 'Start Level (dB):'
    end
    object Label5: TLabel
      Left = 16
      Top = 62
      Width = 77
      Height = 13
      Caption = 'Stop Level [dB]:'
    end
    object Label6: TLabel
      Left = 16
      Top = 104
      Width = 77
      Height = 13
      Caption = 'Level [dB] Step:'
      Enabled = False
    end
    object Label13: TLabel
      Left = 16
      Top = 126
      Width = 59
      Height = 13
      Caption = 'Step Speed:'
      Enabled = False
    end
    object MtxFloatEdit4: TMtxFloatEdit
      Left = 138
      Top = 132
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Enabled = False
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 0
      Value = '0.00'
    end
    object MtxFloatEdit6: TMtxFloatEdit
      Left = 138
      Top = 103
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Enabled = False
      Increment = '0.1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '0.00'
    end
    object A1SweepEdit: TMtxFloatEdit
      Left = 138
      Top = 31
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0.0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '-140'
      TabOrder = 2
      Value = '0.0'
      OnChange = A1SweepEditChange
    end
    object A2SweepEdit: TMtxFloatEdit
      Left = 138
      Top = 63
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0.0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '-140'
      TabOrder = 3
      Value = '0.0'
      OnChange = A2SweepEditChange
    end
  end
  object F2Edit: TMtxFloatEdit
    Left = 212
    Top = 175
    Width = 100
    Height = 22
    RegistryPath = '\Software\Dew Research\MtxVec'
    StoreInRegistry = False
    IntegerIncrement = True
    Scientific = False
    ReFormat = '0'
    ImFormat = '+0.00#i;-0.00#i'
    Increment = '10'
    MaxValue = '0'
    MinValue = '0'
    TabOrder = 2
    Value = '1000'
    OnChange = F2EditChange
  end
  object FunctionGroup: TRadioGroup
    Left = 24
    Top = 8
    Width = 120
    Height = 122
    Caption = 'Function'
    ItemIndex = 0
    Items.Strings = (
      'Sine'
      'Square'
      'Triangle'
      'White Noise'
      'Pink Noise')
    TabOrder = 3
    OnClick = FunctionGroupClick
  end
  object ToneGroup: TRadioGroup
    Left = 150
    Top = 8
    Width = 147
    Height = 122
    Caption = 'Selection'
    ItemIndex = 0
    Items.Strings = (
      'Single Tone'
      'Multi Tone'
      'Amp Sweep'
      'Freq Sweep')
    TabOrder = 4
    OnClick = ToneGroupClick
  end
  object GroupBox3: TGroupBox
    Left = 312
    Top = 8
    Width = 291
    Height = 122
    Caption = 'Output Sound Device'
    TabOrder = 5
    object Label9: TLabel
      Left = 16
      Top = 25
      Width = 73
      Height = 13
      Caption = 'Output Device:'
    end
    object Label10: TLabel
      Left = 16
      Top = 47
      Width = 69
      Height = 13
      Caption = 'Sampling rate:'
    end
    object Label11: TLabel
      Left = 16
      Top = 69
      Width = 58
      Height = 13
      Caption = 'Bits/sample:'
    end
    object Label14: TLabel
      Left = 16
      Top = 91
      Width = 43
      Height = 13
      Caption = 'Channel:'
    end
    object ComboBox1: TComboBox
      Left = 131
      Top = 22
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object SampleRateEdit: TMtxFloatEdit
      Left = 131
      Top = 44
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '48000'
      OnChange = SampleRateEditChange
    end
    object BitRateEdit: TMtxFloatEdit
      Left = 131
      Top = 69
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 2
      Value = '16'
    end
    object ChannelEdit: TMtxFloatEdit
      Left = 131
      Top = 88
      Width = 79
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 3
      Value = '0'
    end
  end
  object F3Edit: TMtxFloatEdit
    Left = 318
    Top = 175
    Width = 100
    Height = 22
    RegistryPath = '\Software\Dew Research\MtxVec'
    StoreInRegistry = False
    IntegerIncrement = True
    Scientific = False
    ReFormat = '0'
    ImFormat = '+0.00#i;-0.00#i'
    Increment = '10'
    MaxValue = '0'
    MinValue = '0'
    TabOrder = 6
    Value = '1000'
    OnChange = F3EditChange
  end
  object F4Edit: TMtxFloatEdit
    Left = 106
    Top = 222
    Width = 100
    Height = 22
    RegistryPath = '\Software\Dew Research\MtxVec'
    StoreInRegistry = False
    IntegerIncrement = True
    Scientific = False
    ReFormat = '0'
    ImFormat = '+0.00#i;-0.00#i'
    Increment = '10'
    MaxValue = '0'
    MinValue = '0'
    TabOrder = 7
    Value = '1000'
    OnChange = F4EditChange
  end
  object A1Edit: TMtxFloatEdit
    Left = 105
    Top = 143
    Width = 61
    Height = 22
    RegistryPath = '\Software\Dew Research\MtxVec'
    StoreInRegistry = False
    IntegerIncrement = True
    Scientific = False
    ReFormat = '0'
    ImFormat = '+0.00#i;-0.00#i'
    Increment = '1'
    MaxValue = '0'
    MinValue = '-100'
    TabOrder = 8
    Value = '0'
    OnChange = A1EditChange
  end
  object F1Edit: TMtxFloatEdit
    Left = 105
    Top = 175
    Width = 100
    Height = 22
    RegistryPath = '\Software\Dew Research\MtxVec'
    StoreInRegistry = False
    IntegerIncrement = True
    Scientific = False
    ReFormat = '0'
    ImFormat = '+0.00#i;-0.00#i'
    Increment = '10'
    MaxValue = '0'
    MinValue = '0'
    TabOrder = 9
    Value = '1000'
    OnChange = F1EditChange
  end
  object StartButton: TButton
    Left = 542
    Top = 269
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 10
    OnClick = StartButtonClick
  end
  object StopButton: TButton
    Left = 542
    Top = 309
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 11
    OnClick = StopButtonClick
  end
  object F5Edit: TMtxFloatEdit
    Left = 212
    Top = 222
    Width = 100
    Height = 22
    RegistryPath = '\Software\Dew Research\MtxVec'
    StoreInRegistry = False
    IntegerIncrement = True
    Scientific = False
    ReFormat = '0'
    ImFormat = '+0.00#i;-0.00#i'
    Increment = '10'
    MaxValue = '0'
    MinValue = '0'
    TabOrder = 12
    Value = '1000'
    OnChange = F5EditChange
  end
  object F6Edit: TMtxFloatEdit
    Left = 318
    Top = 222
    Width = 100
    Height = 22
    RegistryPath = '\Software\Dew Research\MtxVec'
    StoreInRegistry = False
    IntegerIncrement = True
    Scientific = False
    ReFormat = '0'
    ImFormat = '+0.00#i;-0.00#i'
    Increment = '10'
    MaxValue = '0'
    MinValue = '0'
    TabOrder = 13
    Value = '1000'
    OnChange = F6EditChange
  end
  object SignalOut: TSignalOut
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 512
    SamplingFrequency = 48000.000000000000000000
    ScaleFactor = 1.000000000000000000
    BufferSize = 32768
    Input = SignalMux
    Left = 589
    Top = 211
    MtxDataValues = {}
  end
  object SignalMux: TSignalMux
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    Inputs = <
      item
        Input = SignalGenerator
      end
      item
        Input = Signal
      end>
    Left = 530
    Top = 211
    MtxDataValues = {}
  end
  object SignalGenerator: TSignalGenerator
    IsDouble = False
    FloatPrecision = mvSingle
    OnAfterUpdate = SignalGeneratorAfterUpdate
    Length = 512
    SamplingFrequency = 48000.000000000000000000
    Inputs = <
      item
      end>
    Sounds.Templates.Strings = (
      'Square'
      'Sine'
      'Triangle'
      'Gaussian noise'
      'PinkNoise'
      'MultiSine'
      'Amplitue sweep')
    Sounds.Templates.StreamBinaryData = {
      9800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000001000000000100000E000000000000408F40000000
      000000000000000000004CDD4000000000000000000000000000000000000000
      0000000000000000000000000001000000000000000000000000000098000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000001000000000100040E000000000000408F4000000000000000
      0000000000004CDD400000000000000000000000000000000000000000000000
      0000000000000000000100000000000000000000000000009800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000001000000000100030E000000000000408F400000000000000000000000
      00004CDD40000000000000000000000000000000000000000000000000000000
      0000000000010000000000000000000000000000980000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000001
      000000000100060E00000000000040DFC0000000000040DF4000000000004CDD
      4000000000000000000000000000000000000000000000000000000000000000
      0001000000000000000000000000000098000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000100000000
      0100060E00000000000040DFC0000000000040DF4000000000004CDD40000000
      0000000000000000000000000000000000000000000000000000000000010000
      0000000000000000000000009003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000B000000000100000E
      000000000000408F400000000000000000000000000000E04000000000000000
      0000000000000000000000000000000000000000000000000001000000000000
      00000000000000000100000E000000000000408F400000000000000000000000
      000000E040000000000000000000000000000000000000000000000000000000
      00000000000100000000000000000000000000000100000E000000000000408F
      400000000000000000000000000000E040000000000000000000000000000000
      0000000000000000000000000000000000010000000000000000000000000000
      0100000E000000000000408F400000000000000000000000000000E040000000
      0000000000000000000000000000000000000000000000000000000000010000
      0000000000000000000000000100000E000000000000408F4000000000000000
      00000000000000E0400000000000000000000000000000000000000000000000
      0000000000000000000100000000000000000000000000000100000E00000000
      0000408F400000000000000000000000000000E0400000000000000000000000
      0000000000000000000000000000000000000000000100000000000000000000
      0000000001011100000000000000408F40000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000001011100000000000000408F40000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000001011100
      000000000000408F400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000001011100000000000000408F400000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000001011100000000000000408F
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000001000000000100070E000000000000408F40000000
      0000000000000000000000E04000000000000000000000000000000000000000
      00000000000000000000002040010000000000000000000000000000}
    Sounds.TemplateIndex = 5
    Left = 483
    Top = 147
    MtxDataValues = {}
  end
  object Signal: TSignal
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 512
    SamplingFrequency = 1.000000000000000000
    Left = 483
    Top = 210
    MtxDataValues = {}
  end
end
