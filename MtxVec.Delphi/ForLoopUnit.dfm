inherited ForLoopForm: TForLoopForm
  Caption = 'ForLoopForm'
  ClientHeight = 372
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitHeight = 411
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 106
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 106
    inherited RichEdit1: TRichEdit
      Height = 104
      StyleElements = [seFont, seClient, seBorder]
      ExplicitHeight = 104
    end
  end
  inherited Panel2: TPanel
    Top = 314
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 299
  end
  inherited Panel3: TPanel
    Top = 106
    Height = 208
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 106
    ExplicitHeight = 193
    object Label1: TLabel
      Left = 16
      Top = 66
      Width = 61
      Height = 13
      Caption = 'Thread time:'
    end
    object Label5: TLabel
      Left = 16
      Top = 183
      Width = 406
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 
        'All multithreading timing tests show meaningfull results only wh' +
        'en run outside of IDE!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      ExplicitTop = 167
    end
    object Button1: TButton
      Left = 16
      Top = 24
      Width = 120
      Height = 25
      Caption = 'Start threaded for-loop'
      TabOrder = 0
      OnClick = Button1Click
    end
    object ThreadedBox: TCheckBox
      Left = 168
      Top = 28
      Width = 97
      Height = 17
      Caption = 'Multi-threaded'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object Timer: TTimer
    Interval = 100
    OnTimer = TimerTimer
    Left = 513
    Top = 126
  end
end
