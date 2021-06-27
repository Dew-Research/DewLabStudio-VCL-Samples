inherited frmParetoChart: TfrmParetoChart
  Caption = 'frmParetoChart'
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Chart1: TChart
      Left = 137
      Width = 486
      Legend.Alignment = laBottom
      Legend.LegendStyle = lsSeries
      Title.Text.Strings = (
        'Pareto Chart')
      LeftAxis.Title.Caption = 'Values'
      RightAxis.ExactDateTime = False
      RightAxis.Grid.Visible = False
      RightAxis.Increment = 10.000000000000000000
      RightAxis.Title.Caption = 'Cumulative [%]'
      ExplicitLeft = 137
      ExplicitWidth = 486
      PrintMargins = (
        15
        7
        15
        7)
      object Series1: TBarSeries
        HoverElement = []
        SeriesColor = 8454143
        Title = 'Pareto'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        Marks.Visible = True
        Marks.Style = smsValue
        SeriesColor = 4227327
        Title = 'Cumulative Pareto'
        VertAxis = aRightAxis
        OnGetMarkText = Series2GetMarkText
        Brush.BackColor = clDefault
        Pointer.Brush.Gradient.EndColor = 4227327
        Pointer.Gradient.EndColor = 4227327
        Pointer.HorizSize = 3
        Pointer.InflateMargins = False
        Pointer.Style = psTriangle
        Pointer.VertSize = 3
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      Width = 137
      ExplicitWidth = 137
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 88
        Width = 97
        Height = 73
        Caption = ' Pareto Chart '
        ItemIndex = 0
        Items.Strings = (
          'Regular'
          'Cumulative')
        TabOrder = 1
        OnClick = RadioGroup1Click
      end
    end
    object Button2: TButton
      Left = 8
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Edit Data'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
end
