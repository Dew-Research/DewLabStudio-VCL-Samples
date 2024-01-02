inherited frmMtxOptim: TfrmMtxOptim
  Caption = 'frmMtxOptim'
  ClientHeight = 522
  ClientWidth = 651
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 667
  ExplicitHeight = 561
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 651
    Height = 98
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 651
    ExplicitHeight = 98
    inherited RichEdit1: TRichEdit
      Width = 649
      Height = 96
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 649
      ExplicitHeight = 96
    end
  end
  inherited Panel2: TPanel
    Top = 464
    Width = 651
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 464
    ExplicitWidth = 651
    object Button1: TBitBtn
      Left = 24
      Top = 16
      Width = 97
      Height = 25
      Caption = 'Find minimum'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 128
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Show Hessian mtx'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  inherited Panel3: TPanel
    Top = 98
    Width = 651
    Height = 366
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 98
    ExplicitWidth = 651
    ExplicitHeight = 366
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 118
      Height = 13
      Caption = 'Max. number of iterations'
    end
    object Label2: TLabel
      Left = 136
      Top = 62
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 16
      Top = 80
      Width = 48
      Height = 13
      Caption = 'Tolerance'
    end
    object Label4: TLabel
      Left = 136
      Top = 96
      Width = 41
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label4'
    end
    object Label12: TLabel
      Left = 23
      Top = 128
      Width = 87
      Height = 13
      Caption = 'Gradient tolerance'
    end
    object Label13: TLabel
      Left = 136
      Top = 144
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label11'
    end
    object Label10: TLabel
      Left = 16
      Top = 167
      Width = 61
      Height = 13
      Caption = 'Initial lambda'
    end
    object Label11: TLabel
      Left = 136
      Top = 183
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label11'
    end
    object Label5: TLabel
      Left = 192
      Top = 16
      Width = 119
      Height = 13
      Caption = 'Parameters - initial values'
    end
    object Label7: TLabel
      Left = 288
      Top = 40
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label7'
    end
    object Label6: TLabel
      Left = 184
      Top = 40
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object Label9: TLabel
      Left = 184
      Top = 64
      Width = 6
      Height = 13
      Caption = 'b'
    end
    object Label8: TLabel
      Left = 288
      Top = 64
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label8'
    end
    object Label14: TLabel
      Left = 16
      Top = 206
      Width = 84
      Height = 13
      Caption = 'Gradient step size'
    end
    object Label15: TLabel
      Left = 136
      Top = 222
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label11'
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Log'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Memo2: TMemo
      Left = 192
      Top = 150
      Width = 335
      Height = 108
      Anchors = [akLeft, akTop, akRight, akBottom]
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object CheckBox2: TCheckBox
      Left = 348
      Top = 124
      Width = 121
      Height = 17
      Caption = 'Numerical derivative'
      TabOrder = 2
      OnClick = CheckBox2Click
    end
    object RadioGroup1: TRadioGroup
      Left = 345
      Top = 8
      Width = 182
      Height = 110
      Caption = 'Method'
      ItemIndex = 1
      Items.Strings = (
        'Nelder-Mead (Simplex)'
        'Levenberg-Marquardt'
        'Quasi-Newton (BFGS)'
        'Quasi-Newton (DFP)'
        'Conjugate Gradient (Fletcher)'
        'Conjugate Gradient (Polak)')
      TabOrder = 3
      OnClick = RadioGroup1Click
    end
    object TrackBar1: TTrackBar
      Left = 32
      Top = 55
      Width = 105
      Height = 17
      Max = 10000
      Min = 50
      Frequency = 1000
      Position = 400
      TabOrder = 4
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object TrackBar2: TTrackBar
      Left = 32
      Top = 96
      Width = 105
      Height = 16
      Max = 16
      Min = 1
      Frequency = 2
      Position = 6
      TabOrder = 5
      TickMarks = tmTopLeft
      OnChange = TrackBar2Change
    end
    object TrackBar6: TTrackBar
      Left = 32
      Top = 144
      Width = 105
      Height = 17
      Max = 16
      Min = 1
      Frequency = 2
      Position = 10
      TabOrder = 6
      TickMarks = tmTopLeft
      OnChange = TrackBar6Change
    end
    object TrackBar5: TTrackBar
      Left = 32
      Top = 183
      Width = 105
      Height = 17
      Max = 9
      Min = 1
      Position = 5
      TabOrder = 7
      TickMarks = tmTopLeft
      OnChange = TrackBar5Change
    end
    object TrackBar3: TTrackBar
      Left = 192
      Top = 40
      Width = 97
      Height = 17
      Max = 100
      Min = -100
      Frequency = 10
      TabOrder = 8
      TickMarks = tmTopLeft
      OnChange = TrackBar3Change
    end
    object TrackBar4: TTrackBar
      Left = 192
      Top = 64
      Width = 97
      Height = 17
      Max = 100
      Min = -100
      Frequency = 10
      TabOrder = 9
      TickMarks = tmTopLeft
      OnChange = TrackBar4Change
    end
    object TrackBar7: TTrackBar
      Left = 32
      Top = 222
      Width = 105
      Height = 17
      Max = 16
      Min = 1
      Frequency = 2
      Position = 10
      TabOrder = 10
      TickMarks = tmTopLeft
      OnChange = TrackBar7Change
    end
  end
  object MtxOptimization1: TMtxOptimization
    OptimizationMethod = optMarquardt
    MaxIterations = 10000
    Tolerance = 0.000000000100000000
    Lambda0 = 0.000010000000000000
    GradTolerance = 0.000000000100000000
    Left = 32
    Top = 58
    MtxDataValues = {}
  end
end
