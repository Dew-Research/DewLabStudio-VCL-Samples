inherited frmTRDemo: TfrmTRDemo
  Caption = 'frmTRDemo'
  ClientHeight = 425
  OnCreate = FormCreate
  ExplicitHeight = 464
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Top = 367
    ExplicitTop = 367
  end
  inherited Panel3: TPanel
    Height = 237
    ExplicitHeight = 237
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 6
      Width = 185
      Height = 76
      Caption = 'Show'
      ItemIndex = 0
      Items.Strings = (
        'Number of iterations'
        'Time needed')
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object Button1: TButton
      Left = 8
      Top = 188
      Width = 90
      Height = 28
      Caption = 'Run tests'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Chart1: TChart
      Left = 216
      Top = 15
      Width = 335
      Height = 216
      Legend.Alignment = laTop
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      BottomAxis.Axis.SmallSpace = 1
      BottomAxis.LabelsAngle = 90
      DepthAxis.Automatic = False
      DepthAxis.AutomaticMaximum = False
      DepthAxis.AutomaticMinimum = False
      DepthAxis.Maximum = 0.830000000000000300
      DepthAxis.Minimum = -0.169999999999999800
      DepthTopAxis.Automatic = False
      DepthTopAxis.AutomaticMaximum = False
      DepthTopAxis.AutomaticMinimum = False
      DepthTopAxis.Maximum = 0.830000000000000300
      DepthTopAxis.Minimum = -0.169999999999999800
      RightAxis.Automatic = False
      RightAxis.AutomaticMaximum = False
      RightAxis.AutomaticMinimum = False
      Zoom.Pen.Mode = pmNotXor
      TabOrder = 2
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColorPaletteIndex = 13
      object Series1: TBarSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Style = smsValue
        Marks.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
      end
      object Series2: TBarSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Style = smsValue
        Marks.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 88
      Width = 185
      Height = 90
      Caption = 'Initial values'
      TabOrder = 3
      object Label1: TLabel
        Left = 16
        Top = 27
        Width = 24
        Height = 13
        Caption = 'x[0]:'
      end
      object Label2: TLabel
        Left = 16
        Top = 57
        Width = 24
        Height = 13
        Caption = 'x[1]:'
      end
      object Edit1: TEdit
        Left = 42
        Top = 24
        Width = 76
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object Edit2: TEdit
        Left = 42
        Top = 54
        Width = 76
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
      end
    end
  end
end
