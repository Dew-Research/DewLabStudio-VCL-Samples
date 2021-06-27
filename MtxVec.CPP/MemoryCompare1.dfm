inherited MemComp1: TMemComp1
  Left = 237
  Top = 6
  Caption = 'Object cache'
  ClientHeight = 534
  ClientWidth = 663
  OldCreateOrder = True
  ExplicitWidth = 679
  ExplicitHeight = 573
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 663
    BevelOuter = bvNone
    ExplicitWidth = 663
    inherited RichEdit1: TRichEdit
      Left = 0
      Top = 0
      Width = 663
      Height = 130
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 663
      ExplicitHeight = 130
    end
  end
  inherited Panel2: TPanel
    Top = 496
    Width = 663
    Height = 38
    ExplicitTop = 496
    ExplicitWidth = 663
    ExplicitHeight = 38
    object Button3: TBitBtn
      Left = 328
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Do full comparison'
      TabOrder = 0
      OnClick = Button3Click
    end
  end
  inherited Panel3: TPanel
    Width = 189
    Height = 366
    Align = alLeft
    BevelOuter = bvNone
    Constraints.MinHeight = 330
    ExplicitWidth = 189
    ExplicitHeight = 366
    object Label1: TLabel
      Left = 18
      Top = 8
      Width = 63
      Height = 13
      Caption = 'Vector length'
    end
    object Label2: TLabel
      Left = 136
      Top = 28
      Width = 32
      Height = 13
      Caption = 'Label2'
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 24
      Width = 125
      Height = 17
      Max = 1500
      Min = 1
      Frequency = 50
      Position = 4
      TabOrder = 0
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object Memo2: TMemo
      Left = 16
      Top = 48
      Width = 153
      Height = 217
      Lines.Strings = (
        'Vec(32,1024) - preallocate 32 '
        'objects each with 1024 '
        'elements. Requires 32 calls to '
        'Create/Destroy and '
        'GetMem/FreeMem.'
        ''
        'Vec(32,0)- preallocated 32 '
        'objects with no memory in '
        'advance.'
        ''
        'Vec(0,0) - do not preallocated '
        'objects or memory.'
        ''
        'Create/Destroy-  direct call to'
        'Create/Destroy and '
        'GetMem/FreeMem.')
      TabOrder = 1
    end
  end
  object Chart1: TChart
    Left = 189
    Top = 130
    Width = 474
    Height = 366
    AllowPanning = pmNone
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    Legend.Alignment = laBottom
    Legend.TextStyle = ltsPlain
    Legend.TopPos = 0
    MarginBottom = 5
    MarginLeft = 5
    MarginRight = 5
    MarginTop = 5
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Title.Caption = 'SetVecCacheSize'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.LabelsSize = 35
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Title.Caption = 'Time [ms]'
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    Color = 14869218
    TabOrder = 3
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      Marks.Font.Color = clWhite
      Marks.Style = smsValue
      Marks.BackColor = 12615680
      Marks.Callout.Length = 10
      Marks.Color = 12615680
      Title = 'CreateIt/FreeIt'
      MultiBar = mbNone
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
end
