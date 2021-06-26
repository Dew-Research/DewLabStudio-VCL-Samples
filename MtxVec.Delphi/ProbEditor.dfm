object FrameDist: TFrameDist
  Left = 0
  Top = 0
  Width = 495
  Height = 368
  TabOrder = 0
  TabStop = True
  object Panel1: TPanel
    Left = 121
    Top = 0
    Width = 374
    Height = 368
    Align = alClient
    TabOrder = 0
    object LabelDec: TLabel
      Left = 14
      Top = 113
      Width = 68
      Height = 13
      Caption = 'Format string:'
    end
    object ListViewParams: TListView
      Left = 1
      Top = 1
      Width = 372
      Height = 104
      Align = alTop
      Columns = <
        item
          Caption = 'Parameter'
          Width = 65
        end
        item
          Caption = 'Type'
        end
        item
          Caption = 'Valid range'
          Width = 115
        end
        item
          Caption = 'Value'
          Width = 58
        end>
      FlatScrollBars = True
      HotTrack = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      TabStop = False
      ViewStyle = vsReport
      OnDblClick = ListViewParamsDblClick
    end
    object RadioGroupOut: TRadioGroup
      Left = 14
      Top = 145
      Width = 200
      Height = 75
      Caption = 'Calculation'
      ItemIndex = 1
      Items.Strings = (
        'Calculate for single value'
        'Calculate for range')
      TabOrder = 1
      OnClick = RadioGroupOutClick
    end
    object GroupBoxRange: TGroupBox
      Left = 14
      Top = 226
      Width = 200
      Height = 129
      Caption = 'Options'
      TabOrder = 2
      object Label1: TLabel
        Left = 8
        Top = 27
        Width = 82
        Height = 13
        Caption = 'Number of points'
      end
      object Label2: TLabel
        Left = 24
        Top = 54
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Lower bound'
      end
      object Label3: TLabel
        Left = 24
        Top = 81
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Upper bound'
      end
      object EditNumPoints: TEdit
        Left = 96
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 0
        Text = '50'
        OnChange = EditNumPointsChange
      end
      object EditLB: TEdit
        Left = 96
        Top = 51
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = EditLBChange
      end
      object EditUB: TEdit
        Left = 96
        Top = 78
        Width = 41
        Height = 21
        TabOrder = 2
        Text = '1'
        OnChange = EditUBChange
      end
      object UpDown1: TUpDown
        Left = 137
        Top = 24
        Width = 16
        Height = 21
        Associate = EditNumPoints
        Position = 50
        TabOrder = 3
      end
    end
    object Edit1: TEdit
      Left = 88
      Top = 111
      Width = 126
      Height = 21
      TabOrder = 3
      Text = '0.000000'
      OnChange = Edit1Change
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 368
    Align = alLeft
    Caption = 'Panel2'
    TabOrder = 1
    object ListBoxDist: TListBox
      Left = 1
      Top = 1
      Width = 119
      Height = 345
      TabStop = False
      Align = alClient
      BevelOuter = bvNone
      ItemHeight = 13
      Items.Strings = (
        'Beta'
        'Bernoulli'
        'Binomial'
        'Bose-Einstein'
        'Cauchy'
        'ChiSquared'
        'Erlang'
        'Exponential'
        'Fisher'
        'Fatigue Life'
        'Fermi-Dirac'
        'Gamma'
        'Geometric'
        'Gumbel (max)'
        'Gumbel (min)'
        'HyperGeometric'
        'Inverse Gaussian'
        'Johnson SB'
        'Johsnon UB'
        'Laplace'
        'Logarithmic'
        'Logistic'
        'Log-normal'
        'Log-Weibull'
        'Maxwell'
        'Negative Binomial'
        'Normal'
        'Pareto'
        'Poisson'
        'Power'
        'Rayleigh'
        'Student'
        'Triangular'
        'Uniform'
        'Uniform (discrete)'
        'Weibull'
        'Zipf')
      TabOrder = 0
      OnClick = ListBoxDistClick
    end
    object Panel3: TPanel
      Left = 1
      Top = 346
      Width = 119
      Height = 21
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Button1: TButton
        Left = 2
        Top = 2
        Width = 15
        Height = 15
        Caption = '<'
        TabOrder = 0
        TabStop = False
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 22
        Top = 2
        Width = 15
        Height = 15
        Caption = '>'
        TabOrder = 1
        TabStop = False
        OnClick = Button2Click
      end
    end
  end
end
