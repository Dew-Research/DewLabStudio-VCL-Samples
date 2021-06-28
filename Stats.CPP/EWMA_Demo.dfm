inherited frmEWMA: TfrmEWMA
  Caption = 'frmEWMA'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object Chart1: TChart
      Left = 150
      Top = 0
      Width = 390
      Height = 301
      Title.Font.Color = clWhite
      Title.Text.Strings = (
        'EWMA Chart')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      OnAfterDraw = Chart1AfterDraw
      Align = alClient
      Color = 12615808
      TabOrder = 0
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 150
      Height = 301
      Align = alLeft
      Color = 14869218
      TabOrder = 1
      object Label1: TLabel
        Left = 13
        Top = 104
        Width = 11
        Height = 13
        Caption = 'r :'
      end
      object Label2: TLabel
        Left = 13
        Top = 150
        Width = 61
        Height = 13
        Caption = 'Confidence :'
      end
      object RadioGroup1: TRadioGroup
        Left = 13
        Top = 46
        Width = 105
        Height = 52
        Caption = ' UCL/LCL style '
        ItemIndex = 0
        Items.Strings = (
          'Asymptote'
          'Exact')
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
      object Button1: TButton
        Left = 13
        Top = 13
        Width = 61
        Height = 20
        Caption = 'Edit data'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Edit1: TEdit
        Left = 13
        Top = 117
        Width = 66
        Height = 21
        TabOrder = 2
        Text = 'Edit1'
        OnChange = Edit1Change
      end
      object Edit2: TEdit
        Left = 13
        Top = 163
        Width = 66
        Height = 21
        TabOrder = 3
        Text = 'Edit1'
        OnChange = Edit2Change
      end
    end
  end
end
