inherited frmMtxGridSeries: TfrmMtxGridSeries
  Left = 180
  Top = 249
  Caption = 'frmMtxGridSeries'
  ClientHeight = 529
  ClientWidth = 753
  OldCreateOrder = True
  OnDestroy = FormDestroy
  ExplicitWidth = 769
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 753
    Height = 85
    ExplicitWidth = 753
    ExplicitHeight = 85
    inherited RichEdit1: TRichEdit
      Width = 751
      Height = 83
      ExplicitWidth = 751
      ExplicitHeight = 83
    end
  end
  inherited Panel2: TPanel
    Top = 471
    Width = 753
    ExplicitTop = 471
    ExplicitWidth = 753
  end
  inherited Panel3: TPanel
    Top = 85
    Width = 753
    Height = 386
    ExplicitTop = 85
    ExplicitWidth = 753
    ExplicitHeight = 386
    object Chart1: TChart
      Left = 163
      Top = 1
      Width = 589
      Height = 384
      BackWall.Brush.Style = bsClear
      Title.Text.Strings = (
        'Matrix values')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      OnGetAxisLabel = Chart1GetAxisLabel
      Align = alClient
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 0
      OnMouseMove = Chart1MouseMove
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 162
      Height = 384
      Align = alLeft
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 1
      object Label1: TLabel
        Left = 137
        Top = 33
        Width = 3
        Height = 13
      end
      object CheckBox2: TCheckBox
        Left = 7
        Top = 13
        Width = 72
        Height = 14
        Caption = 'Animate'
        TabOrder = 0
        OnClick = CheckBox2Click
      end
      object RadioGroup1: TRadioGroup
        Left = 7
        Top = 72
        Width = 150
        Height = 72
        Caption = ' DownSample method : '
        ItemIndex = 0
        Items.Strings = (
          'Pattern'
          'Peak'
          'Average')
        TabOrder = 1
        OnClick = RadioGroup1Click
      end
      object CheckBox1: TCheckBox
        Left = 7
        Top = 33
        Width = 124
        Height = 13
        Caption = 'Matrix value at cursor = '
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object Button1: TButton
        Left = 8
        Top = 160
        Width = 89
        Height = 25
        Caption = 'Edit series'
        TabOrder = 3
        OnClick = Button1Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 150
    Top = 98
  end
end
