inherited frmTSPACF: TfrmTSPACF
  Caption = 'frmTSPACF'
  ClientHeight = 532
  ClientWidth = 653
  ExplicitWidth = 669
  ExplicitHeight = 571
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 653
    ExplicitWidth = 653
  end
  inherited Panel1: TPanel
    Width = 653
    Height = 403
    ExplicitWidth = 653
    ExplicitHeight = 403
    inherited Chart1: TChart
      Width = 464
      Height = 403
      AllowPanning = pmNone
      Legend.Visible = False
      BottomAxis.ExactDateTime = False
      BottomAxis.Increment = 1.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.Title.Caption = 'Lag'
      BottomAxis.Visible = False
      LeftAxis.Maximum = 337.500000000000000000
      LeftAxis.Minimum = 15.000000000000000000
      Zoom.Allow = False
      OnAfterDraw = Chart1AfterDraw
      OnBeforeDrawSeries = Chart1BeforeDrawSeries
      ExplicitWidth = 464
      ExplicitHeight = 403
      PrintMargins = (
        15
        12
        15
        12)
      object Series1: TLineSeries
        HoverElement = [heCurrent]
        SeriesColor = clYellow
        Brush.BackColor = clDefault
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.VertSize = 2
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      Height = 403
      ExplicitHeight = 403
      object Label1: TLabel [0]
        Left = 8
        Top = 192
        Width = 29
        Height = 13
        Caption = 'Lags :'
      end
      object Button2: TButton
        Left = 8
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Edit data'
        TabOrder = 1
        OnClick = Button2Click
      end
      object EditLags: TEdit
        Left = 40
        Top = 192
        Width = 41
        Height = 21
        TabOrder = 2
        Text = '50'
        OnChange = EditLagsChange
      end
      object RadioGroupPT: TRadioGroup
        Left = 8
        Top = 80
        Width = 105
        Height = 97
        Caption = 'Plot'
        ItemIndex = 0
        Items.Strings = (
          'Data'
          'Lag plot'
          'ACF plot'
          'PACF plot'
          'Histogram')
        TabOrder = 3
        OnClick = RadioGroupPTClick
      end
      object UpDown1: TUpDown
        Left = 81
        Top = 192
        Width = 16
        Height = 21
        Associate = EditLags
        Position = 50
        TabOrder = 4
      end
    end
  end
end
