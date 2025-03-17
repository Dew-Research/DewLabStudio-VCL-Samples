inherited DefArray: TDefArray
  Left = 91
  Top = 175
  Caption = 'DefArray'
  ClientHeight = 469
  ClientWidth = 632
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 648
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 632
    ExplicitWidth = 632
    inherited RichEdit1: TRichEdit
      Width = 630
      ExplicitWidth = 630
    end
  end
  inherited Panel2: TPanel
    Top = 411
    Width = 632
    ExplicitTop = 411
    ExplicitWidth = 632
    object Button1: TBitBtn
      Left = 16
      Top = 16
      Width = 105
      Height = 25
      Caption = 'Do comparison'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  inherited Panel3: TPanel
    Width = 176
    Height = 281
    Align = alLeft
    BevelOuter = bvNone
    ExplicitWidth = 176
    ExplicitHeight = 281
    object Label1: TLabel
      Left = 104
      Top = 106
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 24
      Top = 106
      Width = 77
      Height = 13
      Caption = 'Vector  length : '
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 122
      Width = 137
      Height = 17
      Max = 10000
      Min = 1
      Frequency = 500
      Position = 1000
      TabOrder = 0
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object RadioGroup1: TRadioGroup
      Left = 16
      Top = 16
      Width = 137
      Height = 78
      Caption = 'Pick your test'
      ItemIndex = 0
      Items.Strings = (
        'test vector'
        'test matrix')
      TabOrder = 1
      OnClick = RadioGroup1Click
    end
  end
  object Chart1: TChart
    Left = 176
    Top = 130
    Width = 456
    Height = 281
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Gradient.Direction = gdRightLeft
    Gradient.EndColor = 12615680
    Legend.Alignment = laTop
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'dimension'
    LeftAxis.AxisValuesFormat = '#,##0.#####'
    LeftAxis.Title.Caption = 'time  [ms]'
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    BevelOuter = bvNone
    Color = 14869218
    TabOrder = 3
    ColorPaletteIndex = 0
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Default Array'
      Brush.BackColor = clDefault
      Pointer.Brush.Gradient.EndColor = clBlue
      Pointer.Gradient.EndColor = clBlue
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
    object Series2: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Title = 'Values Array'
      Brush.BackColor = clDefault
      Pointer.Brush.Gradient.EndColor = clRed
      Pointer.Gradient.EndColor = clRed
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psTriangle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = 16744703
      Title = 'Values1D array'
      Brush.BackColor = clDefault
      Pointer.Brush.Gradient.EndColor = 16744703
      Pointer.Gradient.EndColor = 16744703
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psDiamond
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
