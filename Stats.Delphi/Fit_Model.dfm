inherited frmModels: TfrmModels
  Left = 110
  Top = 0
  Caption = 'frmModels'
  ClientHeight = 323
  ClientWidth = 593
  Position = poDesigned
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 609
  ExplicitHeight = 362
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 593
    Height = 226
    ExplicitWidth = 593
    ExplicitHeight = 226
    inherited Panel2: TPanel [0]
      Width = 163
      Height = 226
      BevelOuter = bvNone
      Color = 14869218
      ExplicitWidth = 163
      ExplicitHeight = 226
      object Label2: TLabel [0]
        Left = 8
        Top = 90
        Width = 3
        Height = 13
      end
      object Label1: TLabel [1]
        Left = 8
        Top = 48
        Width = 38
        Height = 13
        Caption = 'Model : '
      end
      object Button2: TButton
        Left = 8
        Top = 112
        Width = 65
        Height = 16
        Caption = 'X...'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 75
        Top = 112
        Width = 65
        Height = 16
        Caption = 'Y...'
        TabOrder = 2
        OnClick = Button3Click
      end
      object ComboBox1: TComboBox
        Left = 8
        Top = 64
        Width = 145
        Height = 21
        TabOrder = 3
        Text = 'ComboBox1'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Simple exponential'
          'Simple linear'
          'Simple power'
          'Simple polynomial'
          'Rational'
          'Logistic'
          'Natural logarithm')
      end
    end
    inherited Chart1: TChart [1]
      Left = 163
      Width = 430
      Height = 226
      Title.Text.Strings = (
        'Fitting models')
      Zoom.Brush.Style = bsFDiagonal
      Zoom.Pen.Color = clBlack
      ExplicitLeft = 163
      ExplicitWidth = 430
      ExplicitHeight = 226
      PrintMargins = (
        15
        7
        15
        7)
      object Series1: TPointSeries
        HoverElement = [heCurrent]
        SeriesColor = 4227327
        Title = 'Data'
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = 4227327
        Pointer.Gradient.EndColor = 4227327
        Pointer.HorizSize = 3
        Pointer.InflateMargins = True
        Pointer.Style = psDiamond
        Pointer.VertSize = 3
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        SeriesColor = clYellow
        Title = 'Fitted'
        Brush.BackColor = clDefault
        LinePen.Color = clYellow
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  inherited Memo1: TMemo
    Width = 593
    Anchors = [akBottom]
    ExplicitWidth = 593
  end
end
