inherited YuleLev: TYuleLev
  Left = 316
  Top = 165
  Caption = 'YuleLev'
  ClientHeight = 499
  OldCreateOrder = True
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Top = 425
    ExplicitTop = 425
    object Label5: TLabel [0]
      Left = 312
      Top = 8
      Width = 65
      Height = 13
      Caption = 'Time for LYW'
    end
    object Label6: TLabel [1]
      Left = 312
      Top = 32
      Width = 60
      Height = 13
      Caption = 'Time for FFT'
    end
    object Button1: TBitBtn
      Left = 152
      Top = 16
      Width = 113
      Height = 25
      Caption = 'Calculate spectrum'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  inherited Chart1: TChart
    Left = 153
    Width = 421
    Height = 295
    Legend.Alignment = laTop
    Title.Visible = False
    RightAxis.Visible = False
    TopAxis.Visible = False
    BevelOuter = bvNone
    ExplicitLeft = 153
    ExplicitWidth = 421
    ExplicitHeight = 295
    object Series1: TFastLineSeries
      HoverElement = []
      SeriesColor = clOlive
      Title = 'Yule Walker AR'
      LinePen.Color = clOlive
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      HoverElement = []
      Title = 'FFT'
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 130
    Width = 153
    Height = 295
    Align = alLeft
    BevelOuter = bvNone
    Color = 14869218
    Constraints.MinHeight = 250
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 96
      Width = 61
      Height = 13
      Caption = 'CorrLength : '
    end
    object Label2: TLabel
      Left = 96
      Top = 96
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 16
      Top = 145
      Width = 51
      Height = 13
      Caption = 'LPCCoef : '
    end
    object Label4: TLabel
      Left = 104
      Top = 145
      Width = 41
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label4'
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 8
      Width = 137
      Height = 73
      Caption = 'Zero padding'
      Columns = 2
      ItemIndex = 2
      Items.Strings = (
        '1x'
        '2x'
        '4x'
        '8x'
        '16x')
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 112
      Width = 137
      Height = 17
      Max = 8000
      Min = 50
      Frequency = 500
      Position = 2000
      TabOrder = 1
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object TrackBar2: TTrackBar
      Left = 8
      Top = 168
      Width = 137
      Height = 17
      Max = 8000
      Min = 1
      Frequency = 500
      Position = 2000
      TabOrder = 2
      TickMarks = tmTopLeft
      OnChange = TrackBar2Change
    end
  end
end
