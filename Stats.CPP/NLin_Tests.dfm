inherited frmNonLinTest: TfrmNonLinTest
  Caption = 'frmNonLinTest'
  ClientHeight = 636
  ClientWidth = 717
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 733
  ExplicitHeight = 675
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 717
    ExplicitLeft = 0
    ExplicitWidth = 717
  end
  inherited Panel1: TPanel
    Width = 717
    Height = 507
    ExplicitLeft = 0
    ExplicitTop = 129
    ExplicitWidth = 717
    ExplicitHeight = 507
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 196
      Height = 507
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 108
        Height = 13
        Caption = 'Optimization method : '
      end
      object Label2: TLabel
        Left = 16
        Top = 64
        Width = 134
        Height = 13
        Caption = 'Max. number of iterations : '
      end
      object Label3: TLabel
        Left = 16
        Top = 112
        Width = 85
        Height = 13
        Caption = 'Regression test : '
      end
      object Label5: TLabel
        Left = 23
        Top = 158
        Width = 96
        Height = 13
        Caption = '||Grad||C Tolerance'
      end
      object SpeedButton1: TSpeedButton
        Left = 16
        Top = 236
        Width = 95
        Height = 22
        Caption = 'Recalculate'
        OnClick = SpeedButton1Click
      end
      object Label6: TLabel
        Left = 3
        Top = 184
        Width = 114
        Height = 13
        Caption = 'Convergence Tolerance'
      end
      object Label4: TLabel
        Left = 3
        Top = 210
        Width = 116
        Height = 13
        Caption = 'Numerical grad step size'
      end
      object ComboBox1: TComboBox
        Left = 16
        Top = 32
        Width = 145
        Height = 21
        TabOrder = 0
        Text = 'ComboBox1'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Simplex'
          'Marquardt'
          'Quasi-Newton (BFGS)'
          'Quasi-Newton (DFP)'
          'Conjugate Grad (Fletcher)'
          'Conjugate Grad (Polak)')
      end
      object Edit1: TEdit
        Left = 16
        Top = 80
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '20000'
        OnChange = Edit1Change
      end
      object UpDown1: TUpDown
        Left = 65
        Top = 80
        Width = 16
        Height = 21
        Associate = Edit1
        Min = 1
        Max = 20000
        Increment = 100
        Position = 20000
        TabOrder = 2
        Thousands = False
      end
      object ComboBox2: TComboBox
        Left = 16
        Top = 128
        Width = 145
        Height = 21
        TabOrder = 3
        Text = 'ComboBox2'
        OnChange = ComboBox2Change
        Items.Strings = (
          'Eckerle4 (high difficulty)'
          'Thurber (high difficulty)'
          'Rat42 (average difficulty)'
          'Misra1c (average difficulty)'
          'MGH09 (high difficulty)'
          'Chwirut2 (low difficulty)'
          'MGH10 (high difficulty)'
          'Roszman1(average difficulty)'
          'Rat43 (high difficulty)')
      end
      object Edit3: TEdit
        Left = 125
        Top = 158
        Width = 58
        Height = 21
        TabOrder = 4
        Text = '1e-3'
        OnChange = Edit3Change
      end
      object CheckBox1: TCheckBox
        Left = 20
        Top = 267
        Width = 78
        Height = 13
        Caption = 'Coefficients'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = CheckBox1Click
      end
      object Edit4: TEdit
        Left = 125
        Top = 184
        Width = 58
        Height = 21
        TabOrder = 6
        Text = '1e-3'
        OnChange = Edit4Change
      end
      object Edit2: TEdit
        Left = 125
        Top = 210
        Width = 58
        Height = 21
        TabOrder = 7
        Text = '1e-3'
        OnChange = Edit2Change
      end
    end
    object Panel3: TPanel
      Left = 196
      Top = 0
      Width = 521
      Height = 507
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 521
        Height = 157
        Align = alTop
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Chart1: TChart
        Left = 0
        Top = 157
        Width = 521
        Height = 350
        Legend.Alignment = laTop
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.LogarithmicBase = 10.000000000000000000
        BottomAxis.EndPosition = 100.000000000000000000
        DepthAxis.LogarithmicBase = 10.000000000000000000
        DepthAxis.EndPosition = 100.000000000000000000
        DepthTopAxis.LogarithmicBase = 10.000000000000000000
        DepthTopAxis.EndPosition = 100.000000000000000000
        LeftAxis.LogarithmicBase = 10.000000000000000000
        LeftAxis.EndPosition = 100.000000000000000000
        RightAxis.Grid.ZPosition = 100.000000000000000000
        RightAxis.LogarithmicBase = 10.000000000000000000
        RightAxis.EndPosition = 100.000000000000000000
        RightAxis.ZPosition = 100.000000000000000000
        TopAxis.Grid.ZPosition = 100.000000000000000000
        TopAxis.LogarithmicBase = 10.000000000000000000
        TopAxis.EndPosition = 100.000000000000000000
        TopAxis.ZPosition = 100.000000000000000000
        View3D = False
        Zoom.Brush.Style = bsFDiagonal
        Zoom.Pen.Color = clBlack
        Align = alClient
        BevelOuter = bvNone
        Color = clSilver
        TabOrder = 1
        DefaultCanvas = 'TTeeCanvas3D'
        ColorPaletteIndex = 0
        object Series1: TPointSeries
          HoverElement = [heCurrent]
          SeriesColor = clYellow
          Title = 'Data'
          ClickableLine = False
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Pen.Color = clYellow
          Pointer.Pen.Width = 2
          Pointer.Style = psDiagCross
          Pointer.VertSize = 2
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series2: TLineSeries
          HoverElement = [heCurrent]
          SeriesColor = 8421631
          Title = 'Fitted values'
          Brush.BackColor = clDefault
          LinePen.Color = 8421631
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
  end
end
