inherited MtxFastLineForm: TMtxFastLineForm
  Caption = 'MtxFastLineForm'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Top = 422
    Height = 39
    ExplicitTop = 422
    ExplicitHeight = 39
    object Label1: TLabel [0]
      Left = 186
      Top = 9
      Width = 81
      Height = 13
      Caption = 'Samples to draw:'
    end
    inherited CheckDownSample: TCheckBox
      Checked = True
      State = cbChecked
    end
    object MtxFloatEdit: TMtxFloatEdit
      Left = 273
      Top = 6
      Width = 90
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '10'
      MaxValue = '10000000'
      MinValue = '0'
      TabOrder = 1
      Value = '100000'
      OnChange = MtxFloatEditChange
    end
  end
  inherited Chart1: TChart
    Height = 292
    Title.Text.Strings = (
      'TMtxFastLineSeries')
    ExplicitHeight = 292
  end
  object Timer1: TTimer
    Enabled = False
    Left = 288
    Top = 168
  end
end
