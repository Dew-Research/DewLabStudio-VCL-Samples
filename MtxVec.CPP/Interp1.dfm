inherited Interpolating1: TInterpolating1
  Top = 106
  Caption = 'Interpolating points'
  ClientHeight = 515
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 554
  TextHeight = 13
  inherited Panel1: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited RichEdit1: TRichEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited Panel2: TPanel
    Top = 405
    Height = 110
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 405
    ExplicitHeight = 110
    object Label1: TLabel [0]
      Left = 264
      Top = 40
      Width = 71
      Height = 13
      Caption = 'Time needed : '
    end
    object Label2: TLabel [1]
      Left = 8
      Top = 32
      Width = 67
      Height = 13
      Caption = 'Interpolation : '
    end
    object Label3: TLabel [2]
      Left = 10
      Top = 56
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data points : '
    end
    object Label4: TLabel [3]
      Left = 32
      Top = 80
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Factor : '
    end
    object Label5: TLabel [4]
      Left = 336
      Top = 40
      Width = 49
      Height = 13
      Caption = 'XXXXXXX'
    end
    inherited CheckDownSample: TCheckBox
      TabOrder = 6
    end
    object ComboBox1: TComboBox
      Left = 80
      Top = 32
      Width = 73
      Height = 21
      TabOrder = 0
      OnChange = ComboBox1Change
      Items.Strings = (
        'Linear'
        'Cubic')
    end
    object TrackBar1: TTrackBar
      Left = 80
      Top = 56
      Width = 113
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
      Left = 200
      Top = 56
      Width = 49
      Height = 17
      AutoSize = False
      Caption = 'StaticText2'
      Color = clHighlightText
      ParentColor = False
      TabOrder = 2
    end
    object TrackBar2: TTrackBar
      Left = 80
      Top = 80
      Width = 113
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
      Left = 200
      Top = 80
      Width = 49
      Height = 17
      AutoSize = False
      Caption = 'StaticText2'
      Color = clHighlightText
      ParentColor = False
      TabOrder = 4
    end
    object Button1: TButton
      Left = 264
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Recreate'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  inherited Chart1: TChart
    Height = 275
    Legend.Alignment = laTop
    Title.Visible = False
    BevelOuter = bvLowered
    ExplicitHeight = 275
    object Series1: TPointSeries
      HoverElement = [heCurrent]
      Marks.Callout.Length = 8
      Title = 'Original data'
      ClickableLine = False
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psDiagCross
      Pointer.VertSize = 2
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      HoverElement = []
      Title = 'Fitted values'
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
