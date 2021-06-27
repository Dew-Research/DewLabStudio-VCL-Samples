inherited frmARAR: TfrmARAR
  Caption = 'frmARAR'
  ClientHeight = 508
  OnDestroy = FormDestroy
  ExplicitHeight = 547
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 411
    ExplicitHeight = 411
    inherited Chart1: TChart
      Left = 209
      Width = 414
      Height = 411
      Legend.Alignment = laBottom
      Title.Text.Strings = (
        'ARAR fiting and forecasting')
      ExplicitLeft = 209
      ExplicitWidth = 414
      ExplicitHeight = 411
      PrintMargins = (
        15
        7
        15
        7)
      object Series1: TLineSeries
        HoverElement = [heCurrent]
        Title = 'Time series'
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
        SeriesColor = clWhite
        Title = 'Forecasts'
        Brush.BackColor = clDefault
        Pointer.Brush.Gradient.EndColor = clWhite
        Pointer.Gradient.EndColor = clWhite
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.VertSize = 2
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      Width = 209
      Height = 411
      ExplicitWidth = 209
      ExplicitHeight = 411
      object Label1: TLabel [0]
        Left = 8
        Top = 112
        Width = 65
        Height = 13
        Caption = '# of forecasts'
      end
      object btnLoad: TButton
        Left = 8
        Top = 57
        Width = 75
        Height = 25
        Caption = 'Load data'
        TabOrder = 1
        OnClick = btnLoadClick
      end
      object chkShorten: TCheckBox
        Left = 8
        Top = 88
        Width = 129
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Shorten memory filter'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = chkShortenClick
      end
      object Edit1: TEdit
        Left = 80
        Top = 112
        Width = 41
        Height = 21
        TabOrder = 3
        Text = '24'
        OnChange = Edit1Change
      end
      object UpDown1: TUpDown
        Left = 121
        Top = 112
        Width = 16
        Height = 21
        Associate = Edit1
        Min = 1
        Position = 24
        TabOrder = 4
      end
      object MemoLog: TMemo
        Left = 8
        Top = 144
        Width = 193
        Height = 257
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 5
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = '*.vec (vector)|*.vec'
    Left = 136
    Top = 145
  end
end
