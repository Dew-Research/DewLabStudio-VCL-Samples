inherited frmHotellingWizard: TfrmHotellingWizard
  Caption = 'Hotelling T2'
  ClientHeight = 381
  ClientWidth = 553
  OnDestroy = FormDestroy
  ExplicitWidth = 569
  ExplicitHeight = 420
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 349
    Width = 553
    ExplicitTop = 349
    ExplicitWidth = 553
    inherited btnNext: TButton
      Caption = '&Calculate'
    end
    inherited btnCancel: TButton
      Left = 479
      ExplicitLeft = 479
    end
  end
  inherited Panel2: TPanel
    Width = 553
    ExplicitWidth = 553
  end
  inherited PageControl: TPageControl
    Width = 553
    Height = 316
    ActivePage = tsInputData
    ExplicitWidth = 553
    ExplicitHeight = 316
    object tsInputData: TTabSheet
      Caption = 'Step 1: Input data'
      TabVisible = False
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 16
        Width = 217
        Height = 65
        Caption = 'Define test type'
        ItemIndex = 0
        Items.Strings = (
          'One sample test (paired or unpaired)'
          'Two sample test')
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
      object RadioGroup2: TRadioGroup
        Left = 8
        Top = 96
        Width = 217
        Height = 65
        Caption = 'Means'
        ItemIndex = 1
        Items.Strings = (
          'Means equal'
          'Means defined')
        TabOrder = 1
        OnClick = RadioGroup2Click
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 168
        Width = 105
        Height = 105
        Caption = 'First dataset'
        TabOrder = 2
        object lblSamples1: TLabel
          Left = 16
          Top = 64
          Width = 3
          Height = 13
        end
        object lblVariables1: TLabel
          Left = 16
          Top = 80
          Width = 3
          Height = 13
        end
        object btnEdit1: TButton
          Left = 8
          Top = 24
          Width = 89
          Height = 25
          Caption = 'Edit/View data'
          TabOrder = 0
          OnClick = btnEdit1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 120
        Top = 168
        Width = 105
        Height = 105
        Caption = 'Second dataset'
        TabOrder = 3
        Visible = False
        object lblSamples2: TLabel
          Left = 16
          Top = 64
          Width = 3
          Height = 13
        end
        object lblVariables2: TLabel
          Left = 16
          Top = 80
          Width = 3
          Height = 13
        end
        object btnEdit2: TButton
          Left = 8
          Top = 24
          Width = 89
          Height = 25
          Caption = 'Edit/View data'
          TabOrder = 0
          OnClick = btnEdit2Click
        end
      end
      object btnEditMeans: TButton
        Left = 112
        Top = 136
        Width = 57
        Height = 17
        Caption = 'Define'
        TabOrder = 4
        OnClick = btnEditMeansClick
      end
    end
    object tsTextReport: TTabSheet
      Caption = 'Hotelling T2: Text reports'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 545
        Height = 306
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
