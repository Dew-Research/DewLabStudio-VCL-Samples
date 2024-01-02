inherited LQRPoly: TLQRPoly
  Left = 252
  Top = 107
  Caption = 'LQRPoly'
  ClientHeight = 453
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 111
    ExplicitHeight = 111
    inherited RichEdit1: TRichEdit
      Height = 109
      Font.Color = 7105644
      ExplicitHeight = 109
    end
  end
  inherited Panel2: TPanel
    Top = 336
    Height = 117
    ExplicitTop = 336
    ExplicitHeight = 117
    object Label1: TLabel [0]
      Left = 16
      Top = 32
      Width = 79
      Height = 13
      Caption = 'Polynomial order'
    end
    object Label2: TLabel [1]
      Left = 120
      Top = 48
      Width = 33
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object Label3: TLabel [2]
      Left = 120
      Top = 88
      Width = 33
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object Label4: TLabel [3]
      Left = 184
      Top = 16
      Width = 71
      Height = 13
      Caption = 'Time needed : '
    end
    object Label5: TLabel [4]
      Left = 256
      Top = 16
      Width = 24
      Height = 13
      Caption = 'XXXX'
    end
    object Label6: TLabel [5]
      Left = 16
      Top = 72
      Width = 31
      Height = 13
      Caption = 'Factor'
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 48
      Width = 113
      Height = 17
      Max = 100
      Min = 1
      Frequency = 10
      Position = 20
      TabOrder = 1
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object Button1: TButton
      Left = 184
      Top = 64
      Width = 57
      Height = 25
      Caption = 'Fit'
      TabOrder = 2
      OnClick = Button1Click
    end
    object TrackBar2: TTrackBar
      Left = 8
      Top = 88
      Width = 113
      Height = 17
      Max = 20
      Min = 1
      Position = 5
      TabOrder = 3
      TickMarks = tmTopLeft
      OnChange = TrackBar2Change
    end
    object Button2: TButton
      Left = 248
      Top = 64
      Width = 97
      Height = 25
      Caption = 'View coefficients'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 352
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Delta'
      TabOrder = 5
      OnClick = Button3Click
    end
  end
  inherited Chart1: TChart
    Top = 111
    Height = 225
    Foot.Visible = False
    Gradient.Direction = gdFromTopLeft
    Legend.Alignment = laTop
    Title.Visible = False
    BevelOuter = bvLowered
    ExplicitTop = 111
    ExplicitHeight = 225
    object Series1: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Title = 'Original data'
      ClickableLine = False
      Pointer.Brush.Gradient.EndColor = clRed
      Pointer.Gradient.EndColor = clRed
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Pen.Visible = False
      Pointer.Style = psDownTriangle
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
      SeriesColor = 12222282
      Title = 'Fitted polynomial'
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
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
      SeriesColor = clBlack
      Title = 'YCalc + Delta'
      Brush.BackColor = clDefault
      LinePen.Style = psDot
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
      Title = 'YCalc - Delta'
      Brush.BackColor = clDefault
      LinePen.Style = psDot
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
