inherited CopyComp: TCopyComp
  Left = 1497
  Top = 230
  Caption = 'CopyComp'
  ClientHeight = 470
  ClientWidth = 678
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 694
  ExplicitHeight = 509
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 678
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 678
    inherited RichEdit1: TRichEdit
      Width = 676
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 676
    end
  end
  inherited Panel2: TPanel
    Top = 412
    Width = 678
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 412
    ExplicitWidth = 678
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
    Width = 157
    Height = 282
    Align = alLeft
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 157
    ExplicitHeight = 282
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 87
      Height = 13
      Caption = 'Matrix dimension : '
    end
    object Label2: TLabel
      Left = 119
      Top = 16
      Width = 25
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Label2'
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 32
      Width = 121
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
    Left = 157
    Top = 130
    Width = 521
    Height = 282
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    LeftWall.Brush.Style = bsClear
    Legend.Alignment = laTop
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    Align = alClient
    Color = 14869218
    TabOrder = 3
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      Marks.Style = smsValue
      Marks.OnTop = True
      SeriesColor = clFuchsia
      Title = 'C++'
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series2: TBarSeries
      Marks.Style = smsValue
      Marks.OnTop = True
      SeriesColor = 12615808
      Title = 'MtxVec'
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
end
