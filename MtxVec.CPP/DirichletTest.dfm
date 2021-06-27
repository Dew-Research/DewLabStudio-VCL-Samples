inherited frmDirichlet: TfrmDirichlet
  Caption = 'frmDirichlet'
  ClientHeight = 521
  ClientWidth = 682
  OldCreateOrder = True
  ExplicitWidth = 698
  ExplicitHeight = 560
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 682
    ExplicitWidth = 682
    inherited RichEdit1: TRichEdit
      Width = 680
      ExplicitWidth = 680
    end
  end
  inherited Panel2: TPanel
    Top = 463
    Width = 682
    ExplicitTop = 463
    ExplicitWidth = 682
  end
  inherited Panel3: TPanel
    Left = 525
    Width = 157
    Height = 333
    Align = alRight
    ExplicitLeft = 525
    ExplicitWidth = 157
    ExplicitHeight = 333
    object Label1: TLabel
      Left = 16
      Top = 184
      Width = 40
      Height = 13
      Caption = 'X range:'
    end
    object Label2: TLabel
      Left = 16
      Top = 232
      Width = 40
      Height = 13
      Caption = 'Y range:'
    end
    object RadioGroup1: TRadioGroup
      Left = 13
      Top = 7
      Width = 124
      Height = 78
      Caption = 'Function'
      ItemIndex = 0
      Items.Strings = (
        'Riemann Zeta'
        'Dirichlet Eta'
        'Dirichlet Lambda'
        'Dirichlet Beta')
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object RadioGroup2: TRadioGroup
      Left = 13
      Top = 97
      Width = 124
      Height = 72
      Caption = 'Draw'
      ItemIndex = 0
      Items.Strings = (
        'Re'
        'Im'
        'Abs')
      TabOrder = 1
      OnClick = RadioGroup2Click
    end
    object Edit1: TEdit
      Left = 16
      Top = 200
      Width = 49
      Height = 21
      TabOrder = 2
      Text = '-5'
    end
    object Edit2: TEdit
      Left = 72
      Top = 200
      Width = 49
      Height = 21
      TabOrder = 3
      Text = '2'
    end
    object Edit3: TEdit
      Left = 16
      Top = 248
      Width = 49
      Height = 21
      TabOrder = 4
      Text = '-4'
    end
    object Edit4: TEdit
      Left = 72
      Top = 248
      Width = 49
      Height = 21
      TabOrder = 5
      Text = '2'
    end
    object Button2: TButton
      Left = 33
      Top = 287
      Width = 75
      Height = 25
      Caption = 'Recreate'
      TabOrder = 6
      OnClick = Button1Click
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 130
    Width = 525
    Height = 333
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    LeftWall.Brush.Style = bsClear
    Legend.Alignment = laTop
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.EndPosition = 100.000000000000000000
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
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
    OnAfterDraw = Chart1AfterDraw
    Align = alClient
    Color = 14869218
    TabOrder = 3
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
  end
end
