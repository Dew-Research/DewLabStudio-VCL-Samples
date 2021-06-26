inherited frmBlockProc: TfrmBlockProc
  Top = 181
  Caption = 'frmBlockProc'
  ClientHeight = 403
  ClientWidth = 596
  OldCreateOrder = True
  OnCreate = FormCreate
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
    Top = 363
    Width = 596
    Height = 40
    ExplicitTop = 363
    ExplicitWidth = 596
    ExplicitHeight = 40
    object Label1: TLabel [0]
      Left = 220
      Top = 12
      Width = 66
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
    Height = 258
    Title.Text.Strings = (
      'Block vectorization')
    BottomAxis.Axis.SmallSpace = 1
    BottomAxis.MaximumOffset = 4
    BottomAxis.MinimumOffset = 4
    BottomAxis.Title.Caption = 'Vector length'
    LeftAxis.AxisValuesFormat = '#,##0.0##'
    LeftAxis.MaximumOffset = 4
    LeftAxis.MinimumOffset = 4
    LeftAxis.Title.Caption = 'Time [ms]'
    ExplicitTop = 105
    ExplicitWidth = 596
    ExplicitHeight = 258
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
    object Series4: TLineSeries
      HoverElement = [heCurrent]
      Marks.BackColor = clHotLight
      Marks.Color = clHotLight
      Title = 'Vectorized expression'
      Brush.BackColor = clDefault
      LinePen.Color = clBlue
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
  end
end
