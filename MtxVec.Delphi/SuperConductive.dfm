object SuperConductiveForm: TSuperConductiveForm
  Left = 0
  Top = 0
  Caption = 'SuperConductiveForm'
  ClientHeight = 563
  ClientWidth = 957
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 447
    Width = 957
    Height = 116
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      957
      116)
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 16
      Top = 35
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Thread1Label: TLabel
      Left = 168
      Top = 19
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Label41: TLabel
      Left = 561
      Top = 15
      Width = 68
      Height = 13
      Caption = 'Vector length:'
    end
    object Thread2Label: TLabel
      Left = 168
      Top = 38
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Label31: TLabel
      Left = 561
      Top = 43
      Width = 64
      Height = 13
      Caption = 'Test method:'
    end
    object Bevel1: TBevel
      Left = 387
      Top = 43
      Width = 161
      Height = 33
    end
    object Label3: TLabel
      Left = 16
      Top = 54
      Width = 31
      Height = 13
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 16
      Top = 73
      Width = 31
      Height = 13
      Caption = 'Label4'
    end
    object Thread4Label: TLabel
      Left = 168
      Top = 73
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Thread3Label: TLabel
      Left = 168
      Top = 54
      Width = 31
      Height = 13
      Caption = 'Label3'
    end
    object Label5: TLabel
      Left = 16
      Top = 92
      Width = 406
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 
        'All multithreading timing tests show meaningfull results only wh' +
        'en run outside of IDE!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object FullRunButton: TButton
      Left = 741
      Top = 9
      Width = 107
      Height = 25
      Caption = 'Run full test'
      TabOrder = 0
      OnClick = FullRunButtonClick
    end
    object MultithreadBox: TCheckBox
      Left = 427
      Top = 50
      Width = 121
      Height = 17
      Caption = 'Multithreaded'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object VectorLenEdit: TMtxFloatEdit
      Left = 635
      Top = 12
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '30000'
      MinValue = '3'
      TabOrder = 2
      Value = '300'
    end
    object TestBox: TComboBox
      Left = 635
      Top = 40
      Width = 90
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'tmGetMem'
        'tmTVec'
        'tmVector'
        'tmVectorGlobal')
    end
    object SuperConductiveMMBox: TCheckBox
      Left = 427
      Top = 15
      Width = 121
      Height = 17
      Caption = 'Super conductive MM'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object Button2: TButton
      Left = 741
      Top = 40
      Width = 107
      Height = 25
      Caption = 'Run single shot'
      TabOrder = 5
      OnClick = Button2Click
    end
  end
  object Chart: TChart
    Left = 0
    Top = 0
    Width = 957
    Height = 447
    Title.Text.Strings = (
      'Times needed to allocate memory - thread concurrency timings'
      
        'GetMem takes disproportionaly more time when number of threads i' +
        'ncreases.'
      
        'Cost of allocation of TVec and Vector remain relatively fixed wi' +
        'th super-conductive approach.')
    LeftAxis.Title.Caption = 'Time [ms]'
    View3D = False
    Zoom.Animated = True
    Zoom.Pen.Color = clBlack
    Align = alClient
    Color = clWhite
    TabOrder = 1
    ColorPaletteIndex = 13
  end
  object Thread1: TMtxProgressDialog
    FreeOnTerminate = False
    ThreadBypass = False
    Loops = 1000000
    OnCompute = Thread1Compute
    OnProgressUpdate = Thread1ProgressUpdate
    InternalLoop = True
    InfiniteLoop = False
    Min = 0
    Max = 999999
    UpdateInterval = 80
    ShowDialog = False
    Left = 168
    Top = 104
    MtxDataValues = {}
  end
end
