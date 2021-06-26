inherited YuleLev: TYuleLev
  Left = 201
  Top = 134
  Caption = 'YuleLev'
  ClientHeight = 514
  ClientWidth = 692
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 708
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 692
    ExplicitWidth = 692
    inherited RichEdit1: TRichEdit
      Width = 690
      ExplicitWidth = 690
    end
  end
  inherited Panel2: TPanel
    Top = 440
    Width = 692
    ExplicitTop = 440
    ExplicitWidth = 692
    object Label5: TLabel [0]
      Left = 312
      Top = 8
      Width = 63
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
    inherited CheckDownSample: TCheckBox
      Top = 14
      ExplicitTop = 14
    end
    object Button1: TBitBtn
      Left = 153
      Top = 10
      Width = 113
      Height = 28
      Caption = 'Calculate spectrum'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  inherited Chart1: TChart
    Left = 153
    Width = 539
    Height = 310
    Legend.Alignment = laTop
    Title.Visible = False
    RightAxis.Visible = False
    TopAxis.Visible = False
    BevelOuter = bvNone
    ExplicitLeft = 153
    ExplicitWidth = 539
    ExplicitHeight = 310
    object Series1: TFastLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      SeriesColor = 12222282
      Title = 'Yule Walker AR'
      LinePen.Color = 12222282
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
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
    Height = 310
    Align = alLeft
    BevelOuter = bvNone
    Color = 14869218
    Constraints.MinHeight = 250
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 105
      Width = 64
      Height = 13
      Caption = 'CorrLength : '
    end
    object Label2: TLabel
      Left = 96
      Top = 105
      Width = 41
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 16
      Top = 154
      Width = 51
      Height = 13
      Caption = 'LPCCoef : '
    end
    object Label4: TLabel
      Left = 96
      Top = 153
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
      Height = 86
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
      Top = 121
      Width = 137
      Height = 17
      Max = 8000
      Min = 50
      Frequency = 500
      Position = 1000
      TabOrder = 1
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object TrackBar2: TTrackBar
      Left = 8
      Top = 177
      Width = 137
      Height = 17
      Max = 8000
      Min = 1
      Frequency = 500
      Position = 500
      TabOrder = 2
      TickMarks = tmTopLeft
      OnChange = TrackBar2Change
    end
  end
end
