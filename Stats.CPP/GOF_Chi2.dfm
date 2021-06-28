inherited frmGOFChi2: TfrmGOFChi2
  Caption = 'frmGOFChi2'
  ClientHeight = 538
  ClientWidth = 702
  ExplicitWidth = 718
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 702
    ExplicitWidth = 702
  end
  inherited Panel1: TPanel
    Width = 702
    Height = 409
    ExplicitWidth = 702
    ExplicitHeight = 409
    inherited Chart1: TChart
      Left = 220
      Width = 482
      Height = 261
      BackWall.Color = clGray
      Title.Text.Strings = (
        'Goodnes of fit')
      BottomAxis.Maximum = 24.000000000000000000
      LeftAxis.Maximum = 962.500000000000000000
      LeftAxis.Minimum = 412.500000000000000000
      ExplicitLeft = 220
      ExplicitWidth = 482
      ExplicitHeight = 261
      object Series1: THistogramSeries
        HoverElement = []
        SeriesColor = 8421631
        Title = 'Observed'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        SeriesColor = clYellow
        Title = 'Predicted'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      Width = 220
      Height = 261
      ExplicitWidth = 220
      ExplicitHeight = 261
      object GroupBox1: TGroupBox
        Left = 8
        Top = 134
        Width = 201
        Height = 121
        Caption = 'Fit for :'
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 61
          Height = 13
          Caption = 'Distribution :'
        end
        object Label2: TLabel
          Left = 8
          Top = 40
          Width = 79
          Height = 13
          Caption = 'Number of bins :'
        end
        object Label4: TLabel
          Left = 8
          Top = 64
          Width = 31
          Height = 13
          Caption = 'Alpha:'
        end
        object ComboBox1: TComboBox
          Left = 72
          Top = 16
          Width = 105
          Height = 21
          TabOrder = 0
          Text = 'ComboBox1'
          OnChange = ComboBox1Change
          Items.Strings = (
            'Beta'
            'Chi2'
            'Erlang'
            'Exponential'
            'Gamma'
            'Laplace'
            'Log-Normal'
            'Normal'
            'Rayleigh'
            'Uniform'
            'Weibull')
        end
        object Edit1: TEdit
          Left = 88
          Top = 40
          Width = 33
          Height = 21
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 1
          Text = '25'
          OnChange = Edit1Change
        end
        object UpDown1: TUpDown
          Left = 121
          Top = 40
          Width = 16
          Height = 21
          Associate = Edit1
          Min = 5
          Position = 25
          TabOrder = 2
        end
        object Button3: TButton
          Left = 8
          Top = 88
          Width = 75
          Height = 25
          Caption = 'Chi2 GOF test'
          TabOrder = 3
          OnClick = Button3Click
        end
        object Edit2: TEdit
          Left = 88
          Top = 64
          Width = 57
          Height = 21
          TabOrder = 4
          Text = 'Edit2'
          OnChange = Edit2Change
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 6
        Width = 201
        Height = 129
        Caption = 'Generate data'
        TabOrder = 2
        object Label3: TLabel
          Left = 8
          Top = 16
          Width = 61
          Height = 13
          Caption = 'Distribution :'
        end
        object lblDistName: TLabel
          Left = 8
          Top = 48
          Width = 55
          Height = 13
          Caption = 'lblDistName'
        end
        object lblPar1: TLabel
          Left = 8
          Top = 72
          Width = 32
          Height = 13
          Caption = 'lblPar1'
        end
        object lblPar2: TLabel
          Left = 8
          Top = 96
          Width = 32
          Height = 13
          Caption = 'lblPar2'
        end
        object Button2: TButton
          Left = 120
          Top = 72
          Width = 65
          Height = 25
          Caption = 'Generate'
          TabOrder = 0
          OnClick = Button2Click
        end
        object ComboBox2: TComboBox
          Left = 72
          Top = 16
          Width = 105
          Height = 21
          TabOrder = 1
          Text = 'ComboBox2'
          OnChange = ComboBox2Change
          Items.Strings = (
            'Beta'
            'Chi2'
            'Erlang'
            'Exponential'
            'Gamma'
            'Laplace'
            'Log-Normal'
            'Normal'
            'Rayleigh'
            'Uniform'
            'Weibull')
        end
        object EditPar1: TEdit
          Left = 48
          Top = 72
          Width = 57
          Height = 21
          TabOrder = 2
          Text = 'EditPar1'
        end
        object EditPar2: TEdit
          Left = 48
          Top = 96
          Width = 57
          Height = 21
          TabOrder = 3
          Text = 'EditPar1'
        end
      end
    end
    object Memo2: TMemo
      Left = 0
      Top = 261
      Width = 702
      Height = 148
      Align = alBottom
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        '')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
end
