inherited frmParetoChart: TfrmParetoChart
  Caption = 'frmParetoChart'
  ClientHeight = 540
  ClientWidth = 715
  OnShow = FormShow
  ExplicitWidth = 731
  ExplicitHeight = 579
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 715
    ExplicitWidth = 715
  end
  inherited Panel1: TPanel
    Width = 715
    Height = 411
    ExplicitWidth = 715
    ExplicitHeight = 411
    inherited Chart1: TChart
      Width = 526
      Height = 411
      Legend.Alignment = laBottom
      Legend.LegendStyle = lsSeries
      Title.Text.Strings = (
        'Pareto Chart')
      BottomAxis.Maximum = 5.000000000000000000
      LeftAxis.Maximum = 945.000000000000000000
      LeftAxis.Title.Caption = 'Values'
      RightAxis.ExactDateTime = False
      RightAxis.Grid.Visible = False
      RightAxis.Increment = 10.000000000000000000
      RightAxis.Maximum = 535.000000000000000000
      RightAxis.Title.Caption = 'Cumulative [%]'
      ExplicitWidth = 526
      ExplicitHeight = 411
      object Series1: TBarSeries
        HoverElement = []
        SeriesColor = 16735838
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
      Height = 411
      ExplicitHeight = 411
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
