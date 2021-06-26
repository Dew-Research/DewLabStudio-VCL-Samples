inherited frmMtxOptim: TfrmMtxOptim
  Left = 253
  Top = 128
  Caption = 'frmMtxOptim'
  ClientHeight = 597
  ClientWidth = 813
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 829
  ExplicitHeight = 636
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 813
    Height = 98
    ExplicitWidth = 651
    ExplicitHeight = 98
    inherited RichEdit1: TRichEdit
      Width = 811
      Height = 96
      Font.Color = 7105644
      ExplicitWidth = 811
      ExplicitHeight = 96
    end
  end
  inherited Panel2: TPanel
    Top = 539
    Width = 813
    Font.Height = -12
    ParentFont = False
    ExplicitTop = 464
    ExplicitWidth = 651
    object Button1: TBitBtn
      Left = 24
      Top = 16
      Width = 113
      Height = 28
      Caption = 'Find minimum'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TBitBtn
      Left = 143
      Top = 16
      Width = 131
      Height = 28
      Caption = 'Show Hessian mtx'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  inherited Panel3: TPanel
    Top = 98
    Width = 813
    Height = 441
    ParentFont = False
    ExplicitLeft = 1
    ExplicitTop = 103
    ExplicitWidth = 762
    ExplicitHeight = 366
    object Label1: TLabel
      Left = 16
      Top = 57
      Width = 140
      Height = 14
      Caption = 'Max. number of iterations'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 169
      Top = 80
      Width = 35
      Height = 14
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 109
      Width = 54
      Height = 14
      Caption = 'Tolerance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 169
      Top = 132
      Width = 35
      Height = 14
      Caption = 'Label4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 16
      Top = 162
      Width = 101
      Height = 14
      Caption = 'Gradient tolerance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 169
      Top = 185
      Width = 42
      Height = 14
      Caption = 'Label11'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 16
      Top = 214
      Width = 70
      Height = 14
      Caption = 'Initial lambda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 169
      Top = 238
      Width = 42
      Height = 14
      Caption = 'Label11'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 264
      Top = 16
      Width = 136
      Height = 14
      Caption = 'Parameters - initial values'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 400
      Top = 36
      Width = 35
      Height = 14
      Caption = 'Label7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 256
      Top = 40
      Width = 6
      Height = 14
      Caption = 'a'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 256
      Top = 73
      Width = 7
      Height = 14
      Caption = 'b'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 400
      Top = 69
      Width = 35
      Height = 14
      Caption = 'Label8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 16
      Top = 267
      Width = 97
      Height = 14
      Caption = 'Gradient step size'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 169
      Top = 291
      Width = 42
      Height = 14
      Caption = 'Label11'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Log'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Memo2: TMemo
      Left = 256
      Top = 238
      Width = 540
      Height = 180
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object CheckBox2: TCheckBox
      Left = 497
      Top = 201
      Width = 200
      Height = 17
      Caption = 'Numerical derivative'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CheckBox2Click
    end
    object RadioGroup1: TRadioGroup
      Left = 489
      Top = 17
      Width = 256
      Height = 178
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
      Left = 16
      Top = 77
      Width = 140
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
      Left = 16
      Top = 129
      Width = 140
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
      Left = 16
      Top = 182
      Width = 140
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
      Left = 16
      Top = 234
      Width = 140
      Height = 17
      Max = 9
      Min = 1
      Position = 5
      TabOrder = 7
      TickMarks = tmTopLeft
      OnChange = TrackBar5Change
    end
    object TrackBar3: TTrackBar
      Left = 264
      Top = 40
      Width = 130
      Height = 17
      Max = 100
      Min = -100
      Frequency = 10
      TabOrder = 8
      TickMarks = tmTopLeft
      OnChange = TrackBar3Change
    end
    object TrackBar4: TTrackBar
      Left = 264
      Top = 73
      Width = 130
      Height = 17
      Max = 100
      Min = -100
      Frequency = 10
      TabOrder = 9
      TickMarks = tmTopLeft
      OnChange = TrackBar4Change
    end
    object TrackBar7: TTrackBar
      Left = 16
      Top = 287
      Width = 140
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
end
