inherited frmTSPACF: TfrmTSPACF
  Caption = 'frmTSPACF'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Chart1: TChart
      Left = 169
      Width = 454
      AllowPanning = pmNone
      Legend.Visible = False
      BottomAxis.ExactDateTime = False
      BottomAxis.Increment = 1.000000000000000000
      BottomAxis.Title.Caption = 'Lag'
      BottomAxis.Visible = False
      Zoom.Allow = False
      OnAfterDraw = Chart1AfterDraw
      OnBeforeDrawSeries = Chart1BeforeDrawSeries
      ExplicitLeft = 169
      ExplicitWidth = 454
      PrintMargins = (
        15
        12
        15
        12)
      object Series1: TLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.ShapeStyle = fosRoundRectangle
        Marks.Visible = False
        SeriesColor = clYellow
        Brush.BackColor = clDefault
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.VertSize = 2
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      Width = 169
      ExplicitWidth = 169
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
        TabOrder = 2
        OnClick = RadioGroupPTClick
      end
      object EditLags: TEdit
        Left = 40
        Top = 192
        Width = 41
        Height = 21
        TabOrder = 3
        Text = '50'
        OnChange = EditLagsChange
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
