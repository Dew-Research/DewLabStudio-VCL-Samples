inherited CopyComp: TCopyComp
  Top = 165
  Caption = 'CopyComp'
  ClientHeight = 468
  ClientWidth = 670
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 686
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 670
    ExplicitWidth = 670
    inherited RichEdit1: TRichEdit
      Width = 668
      ExplicitWidth = 668
    end
  end
  inherited Panel2: TPanel
    Top = 410
    Width = 670
    ExplicitTop = 410
    ExplicitWidth = 670
    object Button1: TBitBtn
      Left = 16
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Do comparison'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  inherited Panel3: TPanel
    Width = 178
    Height = 280
    Align = alLeft
    ExplicitWidth = 178
    ExplicitHeight = 280
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 90
      Height = 13
      Caption = 'Matrix dimension : '
    end
    object Label2: TLabel
      Left = 120
      Top = 16
      Width = 39
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 35
      Width = 143
      Height = 17
      Max = 1300
      Min = 2
      Frequency = 100
      Position = 30
      TabOrder = 0
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
  end
  object Chart1: TChart
    Left = 178
    Top = 130
    Width = 492
    Height = 280
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    LeftWall.Brush.Color = clWhite
    LeftWall.Brush.Style = bsClear
    Legend.Alignment = laTop
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    Chart3DPercent = 1
    LeftAxis.AxisValuesFormat = '#,##0.0##'
    View3D = False
    View3DOptions.Elevation = 360
    View3DOptions.OrthoAngle = 75
    View3DOptions.Rotation = 360
    View3DOptions.Zoom = 93
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    Color = 14869218
    TabOrder = 3
    PrintMargins = (
      15
      22
      15
      22)
    ColorPaletteIndex = 0
    object Series1: TBarSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Style = smsValue
      Marks.Visible = True
      SeriesColor = 33023
      Title = 'Delphi'
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
      SeriesColor = 16711808
      Title = 'MtxVec'
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
end
