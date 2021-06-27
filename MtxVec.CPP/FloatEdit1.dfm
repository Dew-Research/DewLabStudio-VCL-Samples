inherited frmFloatEdit1: TfrmFloatEdit1
  Caption = 'frmFloatEdit1'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 85
    ExplicitHeight = 85
    inherited RichEdit1: TRichEdit
      Height = 83
      ExplicitHeight = 83
    end
  end
  inherited Panel2: TPanel
    Top = 318
    Height = 45
    ExplicitTop = 318
    ExplicitHeight = 45
  end
  inherited Panel3: TPanel
    Top = 85
    Height = 233
    ExplicitTop = 85
    ExplicitHeight = 233
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 25
      Height = 13
      Caption = 'Z1 = '
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 25
      Height = 13
      Caption = 'Z2 = '
    end
    object Label3: TLabel
      Left = 16
      Top = 120
      Width = 30
      Height = 13
      Caption = 'Result'
    end
    object Label4: TLabel
      Left = 256
      Top = 16
      Width = 46
      Height = 13
      Caption = 'Operation'
    end
    object MtxFloatEdit1: TMtxFloatEdit
      Left = 64
      Top = 32
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.####;-0.####'
      ImFormat = '+0.####i;-0.####i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 0
      Value = '1+1i'
    end
    object MtxFloatEdit2: TMtxFloatEdit
      Left = 64
      Top = 64
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.####;-0.####'
      ImFormat = '+0.####i;-0.####i'
      Increment = '1'
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '1+1i'
    end
    object Button1: TButton
      Left = 256
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Z1 * Z2'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 256
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Z1 / Z2'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 256
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Z1 + Z2'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 256
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Z1 - Z2'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 16
      Top = 136
      Width = 145
      Height = 21
      TabOrder = 6
    end
    object Button5: TButton
      Left = 160
      Top = 32
      Width = 49
      Height = 22
      Caption = '<- Edit'
      TabOrder = 7
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 160
      Top = 64
      Width = 49
      Height = 22
      Caption = '<- Edit'
      TabOrder = 8
      OnClick = Button6Click
    end
  end
end
