inherited frmQCCP: TfrmQCCP
  Caption = 'frmQCCP'
  ClientHeight = 535
  ClientWidth = 507
  OldCreateOrder = True
  OnDestroy = FormDestroy
  ExplicitWidth = 523
  ExplicitHeight = 574
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 92
    Width = 507
    Height = 443
    ExplicitTop = 92
    ExplicitWidth = 507
    ExplicitHeight = 443
    object Chart1: TChart
      Left = 163
      Top = 0
      Width = 344
      Height = 443
      AllowPanning = pmHorizontal
      Border.Visible = True
      Legend.FontSeriesColor = True
      Legend.Visible = False
      Title.Text.Strings = (
        'CP/CPK Chart')
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'N'
      RightAxis.Grid.Visible = False
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.Title.Angle = 90
      RightAxis.Title.Caption = 'Normal PDF'
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      Zoom.Allow = False
      Zoom.Brush.Color = clSilver
      Zoom.Brush.Style = bsFDiagonal
      Zoom.Pen.Color = clBlack
      Align = alClient
      Color = clWhite
      TabOrder = 0
      DefaultCanvas = ''
      PrintMargins = (
        34
        15
        34
        15)
      ColorPaletteIndex = 0
      object Series1: THistogramSeries
        HoverElement = []
        SeriesColor = clBlue
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        SeriesColor = clBlack
        VertAxis = aRightAxis
        Brush.BackColor = clDefault
        LinePen.Width = 2
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object ChartTool1: TColorLineTool
        Pen.Color = clRed
        Pen.Width = 2
        Value = 1.000000000000000000
        OnEndDragLine = ChartTool1EndDragLine
        AxisID = 0
        object TAnnotationTool
          Shape.Alignment = taCenter
          Shape.Shadow.Visible = False
          Shape.TextAlignment = taCenter
          TextAlignment = taCenter
        end
      end
      object ChartTool2: TColorLineTool
        Pen.Color = clRed
        Pen.Width = 2
        Value = 5.000000000000000000
        OnEndDragLine = ChartTool2EndDragLine
        AxisID = 0
        object TAnnotationTool
          Shape.Alignment = taCenter
          Shape.Shadow.Visible = False
          Shape.TextAlignment = taCenter
          TextAlignment = taCenter
        end
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 163
      Height = 443
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 8
        Top = 16
        Width = 42
        Height = 13
        Caption = 'Alpha  = '
      end
      object Label1: TLabel
        Left = 8
        Top = 48
        Width = 18
        Height = 13
        Caption = 'p = '
      end
      object Label3: TLabel
        Left = 8
        Top = 80
        Width = 18
        Height = 13
        Caption = 'p = '
      end
      object Label4: TLabel
        Left = 8
        Top = 96
        Width = 18
        Height = 13
        Caption = 'p = '
      end
      object Label5: TLabel
        Left = 8
        Top = 120
        Width = 18
        Height = 13
        Caption = 'p = '
      end
      object Label6: TLabel
        Left = 8
        Top = 136
        Width = 18
        Height = 13
        Caption = 'p = '
      end
      object Edit1: TEdit
        Left = 56
        Top = 16
        Width = 41
        Height = 21
        TabOrder = 0
        OnChange = Edit1Change
      end
      object CheckBox1: TCheckBox
        Left = 7
        Top = 169
        Width = 111
        Height = 14
        Caption = 'Draw Bell curve'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox1Click
      end
    end
  end
  inherited Memo1: TMemo
    Width = 507
    Height = 92
    ExplicitWidth = 507
    ExplicitHeight = 92
  end
end
