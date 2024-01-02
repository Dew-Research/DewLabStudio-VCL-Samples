inherited Interpolating1: TInterpolating1
  Left = 257
  Top = 144
  Caption = 'Interpolating points'
  ClientHeight = 515
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited RichEdit1: TRichEdit
      Font.Color = 7105644
    end
  end
  inherited Panel2: TPanel
    Top = 396
    Height = 119
    ExplicitTop = 396
    ExplicitHeight = 119
    object Label1: TLabel [0]
      Left = 297
      Top = 38
      Width = 71
      Height = 13
      Caption = 'Time needed : '
    end
    object Label2: TLabel [1]
      Left = 8
      Top = 37
      Width = 72
      Height = 13
      Caption = 'Interpolation : '
    end
    object Label3: TLabel [2]
      Left = 9
      Top = 62
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data points : '
    end
    object Label4: TLabel [3]
      Left = 31
      Top = 86
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Factor : '
    end
    object Label5: TLabel [4]
      Left = 369
      Top = 38
      Width = 42
      Height = 13
      Caption = 'XXXXXXX'
    end
    inherited CheckDownSample: TCheckBox
      TabOrder = 6
    end
    object ComboBox1: TComboBox
      Left = 86
      Top = 35
      Width = 116
      Height = 21
      TabOrder = 0
      OnChange = ComboBox1Change
      Items.Strings = (
        'Linear'
        'Cubic')
    end
    object TrackBar1: TTrackBar
      Left = 81
      Top = 62
      Width = 127
      Height = 17
      Max = 100000
      Min = 60
      ParentShowHint = False
      Frequency = 5000
      Position = 5000
      ShowHint = False
      TabOrder = 1
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object StaticText2: TStaticText
      Left = 219
      Top = 62
      Width = 49
      Height = 17
      AutoSize = False
      Caption = 'StaticText2'
      Color = clHighlightText
      ParentColor = False
      TabOrder = 2
    end
    object TrackBar2: TTrackBar
      Left = 81
      Top = 86
      Width = 127
      Height = 17
      Min = 1
      ParentShowHint = False
      Position = 8
      ShowHint = False
      TabOrder = 3
      TickMarks = tmTopLeft
      OnChange = TrackBar2Change
    end
    object StaticText3: TStaticText
      Left = 219
      Top = 86
      Width = 49
      Height = 17
      AutoSize = False
      Caption = 'StaticText2'
      Color = clHighlightText
      ParentColor = False
      TabOrder = 4
    end
    object Button1: TButton
      Left = 297
      Top = 6
      Width = 129
      Height = 25
      Caption = 'Recreate'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  inherited Chart1: TChart
    Height = 266
    Legend.Alignment = laTop
    Title.Visible = False
    BevelOuter = bvLowered
    ExplicitHeight = 266
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
      Pointer.Style = psDiagCross
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = 12222282
      Title = 'Fitted values'
      LinePen.Color = 12222282
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
