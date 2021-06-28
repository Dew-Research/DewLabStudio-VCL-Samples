inherited frmANOVA1Box: TfrmANOVA1Box
  Caption = 'frmANOVA1Box'
  ClientHeight = 497
  ClientWidth = 619
  OnShow = FormShow
  ExplicitWidth = 635
  ExplicitHeight = 536
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 619
    ExplicitLeft = 0
    ExplicitWidth = 619
  end
  inherited Panel1: TPanel
    Width = 619
    Height = 368
    ExplicitLeft = 0
    ExplicitTop = 129
    ExplicitWidth = 619
    ExplicitHeight = 368
    object Chart1: TChart
      Left = 113
      Top = 0
      Width = 506
      Height = 294
      Gradient.EndColor = 8404992
      Gradient.StartColor = 16744448
      Legend.Visible = False
      Title.Font.Color = clWhite
      Title.Font.InterCharSize = 2
      Title.Font.Shadow.HorizSize = 1
      Title.Text.Strings = (
        'One-way ANOVA (Box plot)')
      BottomAxis.LabelsFormat.Font.Color = clWhite
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.Title.Caption = 'Values'
      BottomAxis.Title.Font.Color = clWhite
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      LeftAxis.LabelsFormat.Font.Color = clWhite
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.Title.Caption = 'Group'
      LeftAxis.Title.Font.Color = clWhite
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.ZPosition = 100.000000000000000000
      View3D = False
      Align = alClient
      Color = 12615808
      TabOrder = 0
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 113
      Height = 294
      Align = alLeft
      Color = 14869218
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 37
        Height = 13
        Caption = 'Alpha : '
      end
      object Button1: TButton
        Left = 8
        Top = 104
        Width = 73
        Height = 25
        Caption = '&Edit data'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Edit1: TEdit
        Left = 48
        Top = 16
        Width = 49
        Height = 21
        TabOrder = 1
        OnChange = Edit1Change
      end
      object Button2: TButton
        Left = 8
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Recalculate'
        TabOrder = 2
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 8
        Top = 136
        Width = 75
        Height = 25
        Caption = 'Edit Chart'
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object StringGrid1: TStringGrid
      Left = 0
      Top = 294
      Width = 430
      Height = 74
      Align = alBottom
      ColCount = 7
      DefaultColWidth = 60
      DefaultRowHeight = 16
      RowCount = 4
      TabOrder = 2
    end
  end
  object MtxAnova: TMtxAnova
    Alpha = 0.050000000000000000
    FmtString = '0.0000'
    ResultDest = StringGrid1
    Left = 112
    Top = 17
    MtxDataValues = {}
  end
end
