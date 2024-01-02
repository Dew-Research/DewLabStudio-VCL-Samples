inherited Mult1: TMult1
  Left = 212
  Top = 89
  Caption = 'Mult1'
  ClientHeight = 477
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitHeight = 516
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 105
    ExplicitHeight = 105
    inherited RichEdit1: TRichEdit
      Height = 103
      Font.Color = 7105644
      ExplicitHeight = 103
    end
  end
  inherited Panel2: TPanel
    Top = 433
    Height = 44
    ExplicitTop = 433
    ExplicitHeight = 44
    object Button4: TButton
      Left = 8
      Top = 8
      Width = 100
      Height = 28
      Caption = 'Do comparison'
      TabOrder = 0
      OnClick = Button4Click
    end
  end
  inherited Panel3: TPanel
    Top = 105
    Width = 190
    Height = 328
    Align = alLeft
    BevelOuter = bvNone
    ExplicitTop = 105
    ExplicitWidth = 190
    ExplicitHeight = 328
    object Label1: TLabel
      Left = 17
      Top = 21
      Width = 80
      Height = 13
      Caption = 'Matrix dimension'
    end
    object ThreadCountLabel: TLabel
      Left = 17
      Top = 234
      Width = 68
      Height = 13
      Caption = 'Thread count:'
      Visible = False
    end
    object CPUCacheSizeLabel: TLabel
      Left = 17
      Top = 182
      Width = 76
      Height = 13
      Caption = 'CPU cache size:'
    end
    object CPUCoreCountLabel: TLabel
      Left = 17
      Top = 201
      Width = 80
      Height = 13
      Caption = 'CPU Core count:'
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 40
      Width = 169
      Height = 17
      Max = 1000
      Min = 1
      Frequency = 50
      Position = 60
      TabOrder = 0
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object StaticText1: TStaticText
      Left = 108
      Top = 21
      Width = 64
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'StaticText1'
      TabOrder = 1
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 72
      Width = 169
      Height = 94
      Caption = 'Matrix size'
      ItemIndex = 1
      Items.Strings = (
        'Small matrix (eval. 1000 x)'
        'Medium matrix (eval. 100 x)'
        'Large matrix (eval. 1 x)')
      TabOrder = 2
      OnClick = RadioGroup1Click
    end
    object ThreadCountEdit: TMtxFloatEdit
      Left = 95
      Top = 229
      Width = 52
      Height = 22
      RegistryPath = '\Software\Dew Research\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '1'
      MinValue = '1'
      TabOrder = 3
      Value = '1'
      Visible = False
      OnChange = ThreadCountEditChange
    end
  end
  object Chart1: TChart
    Left = 190
    Top = 105
    Width = 384
    Height = 328
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    Legend.Alignment = laTop
    MarginBottom = 5
    MarginLeft = 5
    MarginRight = 5
    MarginTop = 5
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'Dim'
    LeftAxis.Title.Caption = 'time [ms]'
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    BevelOuter = bvNone
    Color = 14869218
    TabOrder = 3
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = 33023
      Title = 'Delphi'
      Brush.BackColor = clDefault
      LinePen.Color = 33023
      Pointer.Brush.Gradient.EndColor = 33023
      Pointer.Gradient.EndColor = 33023
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psDiagCross
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = 12615680
      Title = 'MtxVec'
      Brush.BackColor = clDefault
      LinePen.Color = 12615680
      Pointer.Brush.Gradient.EndColor = 12615680
      Pointer.Gradient.EndColor = 12615680
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psDownTriangle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
