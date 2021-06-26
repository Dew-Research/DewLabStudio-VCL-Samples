inherited frmMtxGridSeries: TfrmMtxGridSeries
  Left = 308
  Top = 167
  Caption = 'frmMtxGridSeries'
  ClientHeight = 499
  ClientWidth = 661
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 677
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 661
    Height = 85
    ExplicitWidth = 661
    ExplicitHeight = 85
    inherited RichEdit1: TRichEdit
      Width = 659
      Height = 83
      ExplicitWidth = 659
      ExplicitHeight = 83
    end
  end
  inherited Panel2: TPanel
    Top = 441
    Width = 661
    ExplicitTop = 441
    ExplicitWidth = 661
  end
  inherited Panel3: TPanel
    Top = 85
    Width = 661
    Height = 356
    ExplicitTop = 85
    ExplicitWidth = 661
    ExplicitHeight = 356
    object Splitter1: TSplitter
      Left = 567
      Top = 1
      Height = 354
      Align = alRight
    end
    object Chart1: TChart
      Left = 169
      Top = 1
      Width = 398
      Height = 354
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Font.Color = 12222282
      Title.Font.Height = -13
      Title.Font.Style = [fsBold]
      Title.Text.Strings = (
        'Matrix values')
      Chart3DPercent = 100
      View3D = False
      View3DOptions.Perspective = 24
      Zoom.Pen.Mode = pmNotXor
      OnAfterDraw = Chart1AfterDraw
      OnGetAxisLabel = Chart1GetAxisLabel
      Align = alClient
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 0
      OnMouseMove = Chart1MouseMove
      PrintMargins = (
        15
        5
        15
        5)
      ColorPaletteIndex = 13
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 168
      Height = 354
      Align = alLeft
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 1
      object Label1: TLabel
        Left = 137
        Top = 33
        Width = 3
        Height = 13
      end
      object Label2: TLabel
        Left = 10
        Top = 306
        Width = 69
        Height = 13
        Caption = 'Color balance:'
      end
      object CheckBox2: TCheckBox
        Left = 7
        Top = 13
        Width = 72
        Height = 14
        Caption = 'Animate'
        TabOrder = 0
        OnClick = CheckBox2Click
      end
      object Button2: TButton
        Left = 7
        Top = 228
        Width = 91
        Height = 20
        Caption = '&Edit GridSeries'
        TabOrder = 1
        OnClick = Button2Click
      end
      object RadioGroup1: TRadioGroup
        Left = 7
        Top = 81
        Width = 150
        Height = 133
        Caption = ' DownSample method : '
        ItemIndex = 0
        Items.Strings = (
          'Non-zero pattern'
          'Average'
          'Average magnitude'
          'Peak'
          'Peak magnitude')
        TabOrder = 2
        OnClick = RadioGroup1Click
      end
      object CheckBox1: TCheckBox
        Left = 7
        Top = 33
        Width = 124
        Height = 13
        Caption = 'Matrix value at cursor'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object PaletteBar: TScrollBar
        Left = 10
        Top = 327
        Width = 155
        Height = 17
        Max = 99
        Min = -99
        PageSize = 0
        TabOrder = 4
        OnScroll = PaletteBarScroll
      end
      object ThreeColorBox: TCheckBox
        Left = 10
        Top = 260
        Width = 114
        Height = 14
        Caption = 'Three colors'
        TabOrder = 5
        OnClick = ThreeColorBoxClick
      end
      object PixelResampleBox: TCheckBox
        Left = 7
        Top = 54
        Width = 124
        Height = 13
        Caption = 'Pixel resample'
        TabOrder = 6
        OnClick = PixelResampleBoxClick
      end
      object SharpContrastBox: TCheckBox
        Left = 10
        Top = 280
        Width = 114
        Height = 14
        Caption = 'Sharp contrast'
        Enabled = False
        TabOrder = 7
        OnClick = SharpContrastBoxClick
      end
    end
    object ColorChart: TChart
      Left = 570
      Top = 1
      Width = 90
      Height = 354
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Legend.Visible = False
      MarginBottom = 20
      MarginRight = 35
      MarginTop = 5
      Title.Font.Color = 12222282
      Title.Font.Height = -13
      Title.Font.Style = [fsBold]
      Title.Text.Strings = (
        '')
      Title.Visible = False
      BottomAxis.Visible = False
      Chart3DPercent = 100
      LeftAxis.AxisValuesFormat = '#,##0.0###'
      LeftAxis.Title.Caption = 'Color scale'
      View3D = False
      View3DOptions.Perspective = 24
      Zoom.Pen.Mode = pmNotXor
      OnGetAxisLabel = Chart1GetAxisLabel
      Align = alRight
      BevelOuter = bvNone
      Color = 14869218
      TabOrder = 2
      OnMouseMove = Chart1MouseMove
      ColorPaletteIndex = 13
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 18
    Top = 12
  end
end
