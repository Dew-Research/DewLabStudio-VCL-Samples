inherited frmProgDialog: TfrmProgDialog
  Caption = 'frmProgDialog'
  ClientHeight = 479
  ClientWidth = 489
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 505
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 489
    Height = 85
    ExplicitWidth = 489
    ExplicitHeight = 85
    inherited RichEdit1: TRichEdit
      Width = 487
      Height = 83
      DragMode = dmAutomatic
      Font.Color = 7105644
      ExplicitWidth = 487
      ExplicitHeight = 83
    end
  end
  inherited Panel2: TPanel
    Top = 421
    Width = 489
    ExplicitTop = 421
    ExplicitWidth = 489
  end
  inherited Panel3: TPanel
    Top = 85
    Width = 489
    Height = 336
    ExplicitTop = 85
    ExplicitWidth = 489
    ExplicitHeight = 336
    object Label1: TLabel
      Left = 13
      Top = 144
      Width = 75
      Height = 13
      Caption = 'Thread priority:'
    end
    object ProgressLabel: TLabel
      Left = 237
      Top = 13
      Width = 90
      Height = 13
      Caption = 'Progress indicator:'
    end
    object Label2: TLabel
      Left = 21
      Top = 180
      Width = 171
      Height = 13
      Caption = 'Progress indicators update interval:'
    end
    object Label3: TLabel
      Left = 251
      Top = 180
      Width = 21
      Height = 13
      Caption = '[ms]'
    end
    object IteratorGroup: TRadioGroup
      Left = 8
      Top = 10
      Width = 109
      Height = 84
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
      Height = 60
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
      Top = 107
      Width = 152
      Height = 17
      Caption = 'Show progress form'
      TabOrder = 2
      OnClick = ShowFormBoxClick
    end
    object ThreadBox: TComboBox
      Left = 98
      Top = 139
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
      Left = 291
      Top = 225
      Width = 96
      Height = 25
      Caption = 'Start'
      TabOrder = 4
      OnClick = StartButtonClick
    end
    object ProgressBar: TProgressBar
      Left = 236
      Top = 32
      Width = 151
      Height = 16
      TabOrder = 5
    end
    object UpdateIntervalEdit: TMtxFloatEdit
      Left = 195
      Top = 172
      Width = 49
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '10'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 6
      Value = '200'
      OnChange = UpdateIntervalEditChange
    end
    object GroupBox1: TGroupBox
      Left = 12
      Top = 207
      Width = 256
      Height = 54
      Caption = 'Loop range'
      TabOrder = 7
      object Label4: TLabel
        Left = 15
        Top = 24
        Width = 76
        Height = 13
        Caption = 'For Counter := '
      end
      object Label5: TLabel
        Left = 147
        Top = 23
        Width = 13
        Height = 13
        Caption = 'to '
      end
      object Label6: TLabel
        Left = 221
        Top = 23
        Width = 12
        Height = 13
        Caption = 'do'
      end
      object MinEdit: TMtxFloatEdit
        Left = 97
        Top = 21
        Width = 44
        Height = 22
        RegistryPath = '\Software\DewResearch\MtxVec'
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
        Left = 166
        Top = 21
        Width = 49
        Height = 22
        RegistryPath = '\Software\DewResearch\MtxVec'
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
