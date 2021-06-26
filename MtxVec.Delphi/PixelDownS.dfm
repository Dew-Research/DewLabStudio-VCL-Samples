inherited DownS: TDownS
  Left = 255
  Top = 158
  Caption = 'DownS'
  ClientHeight = 401
  ClientWidth = 607
  OldCreateOrder = True
  OnCreate = FormCreate
  OnResize = FormResize
  ExplicitWidth = 623
  ExplicitHeight = 440
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 607
    Height = 100
    ExplicitWidth = 607
    ExplicitHeight = 100
    inherited RichEdit1: TRichEdit
      Width = 605
      Height = 98
      Font.Color = 7105644
      ExplicitWidth = 605
      ExplicitHeight = 98
    end
  end
  inherited Panel2: TPanel
    Top = 327
    Width = 607
    Height = 74
    Constraints.MinWidth = 607
    ExplicitTop = 327
    ExplicitWidth = 607
    ExplicitHeight = 74
    object Label1: TLabel
      Left = 112
      Top = 16
      Width = 131
      Height = 13
      Caption = 'Time for "normal" plotting : '
    end
    object Label2: TLabel
      Left = 112
      Top = 48
      Width = 136
      Height = 13
      Caption = 'Time for optimized plotting : '
    end
    object Label3: TLabel
      Left = 248
      Top = 16
      Width = 49
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0000'
    end
    object Label4: TLabel
      Left = 248
      Top = 48
      Width = 49
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0000'
    end
    object Label5: TLabel
      Left = 376
      Top = 24
      Width = 92
      Height = 13
      Caption = 'Number of points : '
    end
    object Label6: TLabel
      Left = 473
      Top = 24
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label6'
    end
    object DrawNormalButton: TSpeedButton
      Left = 312
      Top = 12
      Width = 41
      Height = 22
      Caption = 'Draw'
      OnClick = DrawNormalButtonClick
    end
    object DrawFastButton: TSpeedButton
      Left = 312
      Top = 43
      Width = 41
      Height = 22
      Caption = 'Draw'
      OnClick = DrawFastButtonClick
    end
    object TrackBar1: TTrackBar
      Left = 376
      Top = 40
      Width = 169
      Height = 17
      Max = 10000000
      Min = 100000
      Frequency = 300000
      Position = 600000
      TabOrder = 1
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object Button1: TBitBtn
      Left = 8
      Top = 24
      Width = 97
      Height = 25
      Caption = 'Compare'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  inherited Panel3: TPanel
    Top = 100
    Width = 607
    Height = 227
    ExplicitTop = 100
    ExplicitWidth = 607
    ExplicitHeight = 227
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 605
      Height = 78
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      MarginBottom = 0
      MarginTop = 0
      Title.Text.Strings = (
        'Normal')
      View3D = False
      Align = alTop
      Color = 14671839
      TabOrder = 0
      object Series1: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = 12222282
        LinePen.Color = 12222282
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chart2: TChart
      Left = 1
      Top = 79
      Width = 605
      Height = 147
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      MarginBottom = 0
      MarginTop = 0
      Title.Text.Strings = (
        'Using PixelDownSample')
      View3D = False
      Align = alClient
      Color = 14671839
      TabOrder = 1
      object Series2: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = 12222282
        LinePen.Color = 12222282
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
end
