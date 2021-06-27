inherited frmBlockProc: TfrmBlockProc
  Left = 229
  Top = 178
  Caption = 'frmBlockProc'
  ClientHeight = 403
  ClientWidth = 596
  OldCreateOrder = True
  ExplicitWidth = 612
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 596
    Height = 105
    ExplicitWidth = 596
    ExplicitHeight = 105
    inherited RichEdit1: TRichEdit
      Width = 594
      Height = 103
      ExplicitWidth = 594
      ExplicitHeight = 103
    end
  end
  inherited Panel2: TPanel
    Top = 329
    Width = 596
    ExplicitTop = 329
    ExplicitWidth = 596
    object Label1: TLabel [0]
      Left = 220
      Top = 12
      Width = 61
      Height = 13
      Caption = 'Progress: 0%'
    end
    inherited CheckDownSample: TCheckBox
      Visible = False
    end
    object Button1: TButton
      Left = 116
      Top = 8
      Width = 75
      Height = 21
      Caption = 'Run test'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  inherited Chart1: TChart
    Top = 105
    Width = 596
    Height = 224
    BottomAxis.Title.Caption = 'Vector length'
    LeftAxis.Title.Caption = 'Time [ms] for 10000000 elements'
    ExplicitTop = 105
    ExplicitWidth = 596
    ExplicitHeight = 224
    object Series1: TLineSeries
      HoverElement = [heCurrent]
      Title = 'Plain function'
      Brush.BackColor = clDefault
      LinePen.Color = clRed
      Pointer.Brush.Gradient.EndColor = clRed
      Pointer.Gradient.EndColor = clRed
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
      HoverElement = [heCurrent]
      Title = 'Vectorized'
      Brush.BackColor = clDefault
      LinePen.Color = clGreen
      Pointer.Brush.Gradient.EndColor = clGreen
      Pointer.Gradient.EndColor = clGreen
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psDownTriangle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      HoverElement = [heCurrent]
      Title = 'Block vectorized'
      Brush.BackColor = clDefault
      LinePen.Color = clYellow
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
  end
end
