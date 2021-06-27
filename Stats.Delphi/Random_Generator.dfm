inherited frmRandomGen: TfrmRandomGen
  Left = 268
  Top = 133
  Caption = 'frmRandomGen'
  ClientHeight = 436
  ClientWidth = 594
  OldCreateOrder = True
  OnShow = FormShow
  ExplicitWidth = 610
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 105
    Width = 594
    Height = 331
    ExplicitTop = 105
    ExplicitWidth = 594
    ExplicitHeight = 331
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 209
      Height = 331
      Align = alLeft
      Color = 14869218
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 97
        Height = 13
        Caption = 'Random generator : '
      end
      object Label2: TLabel
        Left = 8
        Top = 66
        Width = 105
        Height = 13
        Caption = 'How many numbers ? '
      end
      object SpeedButton1: TSpeedButton
        Left = 106
        Top = 209
        Width = 65
        Height = 22
        Caption = 'Generate'
        OnClick = SpeedButton1Click
      end
      object Label3: TLabel
        Left = 120
        Top = 66
        Width = 78
        Height = 13
        Caption = 'Histogram bins : '
      end
      object CBRandomG: TComboBox
        Left = 1
        Top = 35
        Width = 144
        Height = 21
        TabOrder = 0
        Text = 'CBRandomG'
        OnChange = CBRandomGChange
        Items.Strings = (
          'Beta'
          'Binomial'
          'Cauchy'
          'Chi-Squared'
          'Erlang'
          'Exponential'
          'F (Fisher)'
          'Gamma'
          'Geometric'
          'Generalized extreme value'
          'Gumbel (Min)'
          'Hypergeometric'
          'Laplace'
          'Logistic'
          'LogNormal'
          'Maxwell'
          'Negative Binomial'
          'Normal'
          'Poisson'
          'Rayleigh'
          'Student'
          'Triangular'
          'Uniform (continuous)'
          'Uniform (discrete)'
          'Weibull')
      end
      object EditNumber: TEdit
        Left = 8
        Top = 81
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '1000'
      end
      object UpDown1: TUpDown
        Left = 57
        Top = 81
        Width = 16
        Height = 21
        Associate = EditNumber
        Min = 10
        Max = 10000
        Increment = 100
        Position = 1000
        TabOrder = 2
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 107
        Width = 137
        Height = 97
        Caption = 'Distribution parameters : '
        TabOrder = 3
        object lblPar1: TLabel
          Left = 8
          Top = 24
          Width = 32
          Height = 13
          Caption = 'lblPar1'
        end
        object lblPar2: TLabel
          Left = 8
          Top = 48
          Width = 32
          Height = 13
          Caption = 'lblPar2'
        end
        object lblPar3: TLabel
          Left = 8
          Top = 72
          Width = 32
          Height = 13
          Caption = 'lnlPar3'
        end
        object Edit1: TEdit
          Left = 48
          Top = 24
          Width = 49
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
        end
        object Edit2: TEdit
          Left = 48
          Top = 48
          Width = 49
          Height = 21
          TabOrder = 1
          Text = 'Edit2'
        end
        object Edit3: TEdit
          Left = 48
          Top = 72
          Width = 49
          Height = 21
          TabOrder = 2
          Text = 'Edit3'
        end
      end
      object Edit4: TEdit
        Left = 120
        Top = 81
        Width = 49
        Height = 21
        TabOrder = 4
        Text = '70'
      end
      object UpDown2: TUpDown
        Left = 169
        Top = 81
        Width = 16
        Height = 21
        Associate = Edit4
        Min = 20
        Max = 150
        Increment = 5
        Position = 70
        TabOrder = 5
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 211
        Width = 97
        Height = 17
        Caption = 'Estimate'
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = CheckBox1Click
      end
    end
    object Chart1: TChart
      Left = 209
      Top = 0
      Width = 385
      Height = 331
      BackWall.Brush.Style = bsClear
      Gradient.EndColor = 8404992
      Gradient.StartColor = 16744448
      Legend.Alignment = laBottom
      Title.Font.Color = clWhite
      Title.Text.Strings = (
        'Histogram')
      OnUndoZoom = Chart1UndoZoom
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'Count'
      LeftAxis.Title.Font.Color = clWhite
      RightAxis.Grid.Visible = False
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.Title.Caption = 'PDF'
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      Align = alClient
      Color = 12615808
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 0
      object Series1: TBarSeries
        HoverElement = []
        Marks.Visible = False
        Title = 'Histogram'
        BarWidthPercent = 100
        Dark3D = False
        MultiBar = mbNone
        SideMargins = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        SeriesColor = clYellow
        Title = 'PDF'
        VertAxis = aRightAxis
        Brush.BackColor = clDefault
        LinePen.Color = clYellow
        LinePen.Width = 2
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
    Width = 594
    Height = 105
    Lines.Strings = (
      
        'The StatisticRandom unit offers random generators  for 25 differ' +
        'ent distributions.'
      ''
      'Uses MtxExpr, StatRandom;'
      ''
      'var v1: Vector;'
      'begin'
      '  v1.Size(100);'
      '  RandomBeta(2,2.5,v1); '
      '  // generate 100 beta distribution [a=2, b=2.5] random  numbers'
      ''
      
        'For some distributions you can also estimate parameter values. T' +
        'ry generating '
      
        'random numbers (the  "Generate" button), then estimate distribut' +
        'ion parameters by clicking on '
      '""Estimate" button.')
    ExplicitWidth = 594
    ExplicitHeight = 105
  end
end
