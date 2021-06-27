inherited frmProgDialog: TfrmProgDialog
  Caption = 'frmProgDialog'
  ClientHeight = 484
  ClientWidth = 497
  OldCreateOrder = True
  ExplicitWidth = 513
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 497
    Height = 85
    ExplicitWidth = 497
    ExplicitHeight = 85
    inherited RichEdit1: TRichEdit
      Width = 495
      Height = 83
      ExplicitWidth = 495
      ExplicitHeight = 83
    end
  end
  inherited Panel2: TPanel
    Top = 426
    Width = 497
    ExplicitTop = 426
    ExplicitWidth = 497
  end
  inherited Panel3: TPanel
    Top = 85
    Width = 497
    Height = 341
    ExplicitTop = 85
    ExplicitWidth = 497
    ExplicitHeight = 341
    object Label1: TLabel
      Left = 13
      Top = 123
      Width = 70
      Height = 13
      Caption = 'Thread priority:'
    end
    object ProgressLabel: TLabel
      Left = 237
      Top = 13
      Width = 87
      Height = 13
      Caption = 'Progress indicator:'
    end
    object Label2: TLabel
      Left = 13
      Top = 156
      Width = 165
      Height = 13
      Caption = 'Progress indicators update interval:'
    end
    object Label3: TLabel
      Left = 243
      Top = 156
      Width = 19
      Height = 13
      Caption = '[ms]'
    end
    object IteratorGroup: TRadioGroup
      Left = 8
      Top = 10
      Width = 109
      Height = 66
      Caption = 'Iterator control'
      ItemIndex = 0
      Items.Strings = (
        'Internal loop'
        'External loop'
        'InProcedure')
      TabOrder = 0
      OnClick = IteratorGroupClick
    end
    object LoopTypeGroup: TRadioGroup
      Left = 125
      Top = 10
      Width = 102
      Height = 66
      Caption = 'Loop type'
      ItemIndex = 0
      Items.Strings = (
        'For loop'
        'While loop')
      TabOrder = 1
      OnClick = LoopTypeGroupClick
    end
    object ShowFormBox: TCheckBox
      Left = 12
      Top = 86
      Width = 152
      Height = 17
      Caption = 'Show progress form'
      TabOrder = 2
      OnClick = ShowFormBoxClick
    end
    object ThreadBox: TComboBox
      Left = 98
      Top = 118
      Width = 89
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = ThreadBoxChange
      Items.Strings = (
        'Idle'
        'Lowest'
        'Lower'
        'Normal'
        'Higher'
        'Highest'
        'Time critical')
    end
    object StartButton: TButton
      Left = 253
      Top = 190
      Width = 75
      Height = 20
      Caption = 'Start'
      TabOrder = 4
      OnClick = StartButtonClick
    end
    object StopButton: TButton
      Left = 253
      Top = 217
      Width = 75
      Height = 18
      Caption = 'Stop/Cancel'
      TabOrder = 5
      OnClick = StopButtonClick
    end
    object ProgressBar: TProgressBar
      Left = 236
      Top = 32
      Width = 151
      Height = 16
      TabOrder = 6
    end
    object UpdateIntervalEdit: TMtxFloatEdit
      Left = 187
      Top = 148
      Width = 49
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
      Value = '200'
      OnChange = UpdateIntervalEditChange
    end
    object GroupBox1: TGroupBox
      Left = 13
      Top = 180
      Width = 232
      Height = 54
      Caption = 'Loop range'
      TabOrder = 8
      object Label4: TLabel
        Left = 12
        Top = 24
        Width = 70
        Height = 13
        Caption = 'For Counter := '
      end
      object Label5: TLabel
        Left = 137
        Top = 23
        Width = 12
        Height = 13
        Caption = 'to '
      end
      object Label6: TLabel
        Left = 209
        Top = 23
        Width = 12
        Height = 13
        Caption = 'do'
      end
      object MinEdit: TMtxFloatEdit
        Left = 85
        Top = 19
        Width = 44
        Height = 22
        RegistryPath = '\Software\Dew Research\MtxVec'
        StoreInRegistry = False
        IntegerIncrement = True
        Scientific = False
        ReFormat = '0'
        ImFormat = '+0.00#i;-0.00#i'
        Increment = '100'
        MaxValue = '0'
        MinValue = '0'
        TabOrder = 0
        Value = '0'
        OnChange = MinEditChange
      end
      object MaxEdit: TMtxFloatEdit
        Left = 154
        Top = 18
        Width = 49
        Height = 22
        RegistryPath = '\Software\Dew Research\MtxVec'
        StoreInRegistry = False
        IntegerIncrement = True
        Scientific = False
        ReFormat = '0'
        ImFormat = '+0.00#i;-0.00#i'
        Increment = '100'
        MaxValue = '0'
        MinValue = '0'
        TabOrder = 1
        Value = '1500'
        OnChange = MaxEditChange
      end
    end
  end
  object MtxThread: TMtxProgressDialog
    FreeOnTerminate = False
    ThreadBypass = False
    OnCompute = MtxThreadCompute
    OnProgressUpdate = MtxThreadProgressUpdate
    InternalLoop = True
    InfiniteLoop = False
    Min = 0
    Max = 0
    ShowDialog = False
    Left = 282
    Top = 21
    MtxDataValues = {}
  end
end
