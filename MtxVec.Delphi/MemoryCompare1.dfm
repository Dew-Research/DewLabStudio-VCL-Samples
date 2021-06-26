inherited MemComp1: TMemComp1
  Left = 202
  Top = 97
  Caption = 'Object cache'
  ClientHeight = 611
  ClientWidth = 862
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 878
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 862
    BevelOuter = bvNone
    ExplicitWidth = 862
    inherited RichEdit1: TRichEdit
      Left = 0
      Top = 0
      Width = 862
      Height = 130
      Font.Color = 7105644
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 862
      ExplicitHeight = 130
    end
  end
  inherited Panel2: TPanel
    Top = 573
    Width = 862
    Height = 38
    ExplicitTop = 573
    ExplicitWidth = 862
    ExplicitHeight = 38
    object Button3: TBitBtn
      Left = 328
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Do full comparison'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  inherited Panel3: TPanel
    Width = 202
    Height = 443
    Align = alLeft
    BevelOuter = bvNone
    Constraints.MinHeight = 330
    ExplicitWidth = 202
    ExplicitHeight = 443
    object Label1: TLabel
      Left = 18
      Top = 10
      Width = 64
      Height = 13
      Caption = 'Vector length'
    end
    object Label2: TLabel
      Left = 148
      Top = 10
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 29
      Width = 179
      Height = 17
      Max = 5000
      Min = 1
      Frequency = 200
      Position = 10
      TabOrder = 0
      TickMarks = tmTopLeft
      OnChange = TrackBar1Change
    end
    object Memo2: TMemo
      Left = 15
      Top = 60
      Width = 164
      Height = 295
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7105644
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
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
      ParentFont = False
      TabOrder = 1
    end
  end
  object Chart1: TChart
    Left = 202
    Top = 130
    Width = 660
    Height = 443
    AllowPanning = pmNone
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clWhite
    Gradient.StartColor = clWindow
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
    BottomAxis.Title.Caption = 'SetVecCacheSize'
    LeftAxis.LabelsSize = 35
    LeftAxis.Title.Caption = 'Time [ms]'
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    Color = 14869218
    TabOrder = 3
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.BackColor = 12615680
      Marks.Color = 12615680
      Marks.Font.Color = clWhite
      Marks.Style = smsValue
      Marks.Visible = True
      Title = 'CreateIt/FreeIt'
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
end
