inherited GetMemC: TGetMemC
  Left = 252
  Top = 107
  Width = 654
  Height = 456
  Caption = 'GetMemC'
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 646
    inherited RichEdit1: TRichEdit
      Width = 644
      Font.Color = 7105644
    end
  end
  inherited Panel2: TPanel
    Top = 364
    Width = 646
    object Button1: TBitBtn
      Left = 24
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Do comparison'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  inherited Panel3: TPanel
    Width = 209
    Height = 234
    Align = alLeft
    BevelOuter = bvNone
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 42
      Height = 13
      Caption = 'Length : '
    end
    object Label2: TLabel
      Left = 144
      Top = 24
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 24
      Width = 129
      Height = 20
      Max = 2000
      Min = 16
      Orientation = trHorizontal
      Frequency = 100
      Position = 1500
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmTopLeft
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
  end
  object Chart1: TChart
    Left = 209
    Top = 130
    Width = 437
    Height = 234
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = 12615680
    Legend.Alignment = laTop
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'Length'
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Title.Caption = 'time [ms] (50.000 executions)'
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    Color = 14869218
    TabOrder = 3
    object Series1: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = 33023
      Title = 'GetMem'
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psTriangle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = 16744576
      Title = 'SliceIt'
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psDiamond
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = clFuchsia
      Title = 'SetLength'
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
