inherited frmARIMASim: TfrmARIMASim
  Caption = 'frmARIMASim'
  ClientHeight = 606
  ClientWidth = 727
  ExplicitWidth = 743
  ExplicitHeight = 645
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 727
    ExplicitWidth = 727
  end
  inherited Panel1: TPanel
    Width = 727
    Height = 477
    ExplicitWidth = 727
    ExplicitHeight = 477
    inherited Chart1: TChart
      Width = 538
      Height = 477
      Legend.Alignment = laBottom
      Legend.LegendStyle = lsSeries
      ExplicitWidth = 538
      ExplicitHeight = 477
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
      Height = 477
      ExplicitHeight = 477
      object Label1: TLabel [0]
        Left = 8
        Top = 64
        Width = 47
        Height = 13
        Caption = 'AR order:'
      end
      object Label2: TLabel [1]
        Left = 8
        Top = 88
        Width = 48
        Height = 13
        Caption = 'MA order:'
      end
      object Label3: TLabel [2]
        Left = 8
        Top = 112
        Width = 85
        Height = 13
        Caption = '# of differencing:'
      end
      object Label4: TLabel [3]
        Left = 8
        Top = 136
        Width = 87
        Height = 13
        Caption = '# of simul. points:'
      end
      object Button2: TButton
        Left = 144
        Top = 64
        Width = 41
        Height = 25
        Caption = 'AR'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 144
        Top = 88
        Width = 41
        Height = 25
        Caption = 'MA'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 8
        Top = 168
        Width = 89
        Height = 25
        Caption = 'Simulate'
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 144
        Top = 112
        Width = 41
        Height = 25
        Caption = 'D(init)'
        TabOrder = 4
        OnClick = Button5Click
      end
      object EditAR: TEdit
        Left = 96
        Top = 64
        Width = 33
        Height = 21
        TabOrder = 5
        Text = '2'
        OnChange = EditARChange
      end
      object EditD: TEdit
        Left = 96
        Top = 112
        Width = 33
        Height = 21
        TabOrder = 6
        Text = '1'
        OnChange = EditDChange
      end
      object EditMA: TEdit
        Left = 96
        Top = 88
        Width = 33
        Height = 21
        TabOrder = 7
        Text = '3'
        OnChange = EditMAChange
      end
      object EditN: TEdit
        Left = 96
        Top = 136
        Width = 33
        Height = 21
        TabOrder = 8
        Text = '100'
        OnChange = EditNChange
      end
      object MemoLog: TMemo
        Left = 8
        Top = 280
        Width = 137
        Height = 89
        ScrollBars = ssVertical
        TabOrder = 9
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
        TabOrder = 10
        OnClick = RadioGroupCTClick
      end
      object UpDownAR: TUpDown
        Left = 129
        Top = 64
        Width = 16
        Height = 21
        Associate = EditAR
        Max = 50
        Position = 2
        TabOrder = 11
      end
      object UpDownD: TUpDown
        Left = 129
        Top = 112
        Width = 16
        Height = 21
        Associate = EditD
        Max = 10
        Position = 1
        TabOrder = 12
      end
      object UpDownMA: TUpDown
        Left = 129
        Top = 88
        Width = 16
        Height = 21
        Associate = EditMA
        Max = 50
        Position = 3
        TabOrder = 13
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
        TabOrder = 14
      end
    end
  end
end
