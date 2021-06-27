inherited frmARIMASim: TfrmARIMASim
  Caption = 'frmARIMASim'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Chart1: TChart
      Legend.Alignment = laBottom
      Legend.LegendStyle = lsSeries
      PrintMargins = (
        15
        7
        15
        7)
      object Series1: TLineSeries
        HoverElement = [heCurrent]
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        Title = 'Theoretical ACF'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      object Label1: TLabel [0]
        Left = 8
        Top = 64
        Width = 45
        Height = 13
        Caption = 'AR order:'
      end
      object Label2: TLabel [1]
        Left = 8
        Top = 88
        Width = 46
        Height = 13
        Caption = 'MA order:'
      end
      object Label3: TLabel [2]
        Left = 8
        Top = 112
        Width = 80
        Height = 13
        Caption = '# of differencing:'
      end
      object Label4: TLabel [3]
        Left = 8
        Top = 136
        Width = 82
        Height = 13
        Caption = '# of simul. points:'
      end
      object EditAR: TEdit
        Left = 96
        Top = 64
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '2'
        OnChange = EditARChange
      end
      object EditMA: TEdit
        Left = 96
        Top = 88
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '3'
        OnChange = EditMAChange
      end
      object EditD: TEdit
        Left = 96
        Top = 112
        Width = 33
        Height = 21
        TabOrder = 3
        Text = '1'
        OnChange = EditDChange
      end
      object EditN: TEdit
        Left = 96
        Top = 136
        Width = 33
        Height = 21
        TabOrder = 4
        Text = '100'
        OnChange = EditNChange
      end
      object UpDownAR: TUpDown
        Left = 129
        Top = 64
        Width = 16
        Height = 21
        Associate = EditAR
        Max = 50
        Position = 2
        TabOrder = 5
      end
      object UpDownMA: TUpDown
        Left = 129
        Top = 88
        Width = 16
        Height = 21
        Associate = EditMA
        Max = 50
        Position = 3
        TabOrder = 6
      end
      object UpDownD: TUpDown
        Left = 129
        Top = 112
        Width = 16
        Height = 21
        Associate = EditD
        Max = 10
        Position = 1
        TabOrder = 7
      end
      object UpDownN: TUpDown
        Left = 129
        Top = 136
        Width = 16
        Height = 21
        Associate = EditN
        Min = 10
        Max = 1000
        Increment = 10
        Position = 100
        TabOrder = 8
      end
      object Button2: TButton
        Left = 144
        Top = 64
        Width = 41
        Height = 25
        Caption = 'AR'
        TabOrder = 9
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 144
        Top = 88
        Width = 41
        Height = 25
        Caption = 'MA'
        TabOrder = 10
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 8
        Top = 168
        Width = 89
        Height = 25
        Caption = 'Simulate'
        TabOrder = 11
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 144
        Top = 112
        Width = 41
        Height = 25
        Caption = 'D(init)'
        TabOrder = 12
        OnClick = Button5Click
      end
      object RadioGroupCT: TRadioGroup
        Left = 8
        Top = 200
        Width = 137
        Height = 73
        Caption = 'Plot'
        ItemIndex = 0
        Items.Strings = (
          'Time series'
          'Time series ACF'
          'Time series PACF')
        TabOrder = 13
        OnClick = RadioGroupCTClick
      end
      object MemoLog: TMemo
        Left = 8
        Top = 280
        Width = 137
        Height = 89
        ScrollBars = ssVertical
        TabOrder = 14
      end
    end
  end
end
