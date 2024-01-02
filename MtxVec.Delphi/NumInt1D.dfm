inherited frmInt1D: TfrmInt1D
  Caption = 'frmInt1D'
  ClientHeight = 408
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitHeight = 447
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 118
    ExplicitHeight = 118
    inherited RichEdit1: TRichEdit
      Height = 116
      ExplicitHeight = 116
    end
  end
  inherited Panel2: TPanel
    Top = 379
    Height = 29
    ExplicitTop = 379
    ExplicitHeight = 29
  end
  inherited Panel3: TPanel
    Top = 118
    Height = 261
    ExplicitTop = 118
    ExplicitHeight = 261
    object Label1: TLabel
      Left = 17
      Top = 16
      Width = 45
      Height = 13
      Caption = 'Function:'
    end
    object Label4: TLabel
      Left = 17
      Top = 147
      Width = 40
      Height = 13
      Caption = 'Method:'
    end
    object Label5: TLabel
      Left = 17
      Top = 182
      Width = 115
      Height = 13
      Caption = 'Number of subintervals:'
    end
    object Edit1: TEdit
      Left = 68
      Top = 13
      Width = 197
      Height = 21
      TabOrder = 0
      Text = 'sin(x)/exp(-x)'
    end
    object Button1: TButton
      Left = 8
      Top = 216
      Width = 107
      Height = 25
      Caption = 'Evaluate'
      TabOrder = 1
      OnClick = Button1Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 44
      Width = 257
      Height = 81
      Caption = 'Bounds'
      TabOrder = 2
      object Label2: TLabel
        Left = 15
        Top = 22
        Width = 33
        Height = 13
        Caption = 'Lower:'
      end
      object Label3: TLabel
        Left = 15
        Top = 49
        Width = 33
        Height = 13
        Caption = 'Upper:'
      end
      object Editlb: TEdit
        Left = 60
        Top = 19
        Width = 117
        Height = 21
        TabOrder = 0
        Text = '-3'
      end
      object Editub: TEdit
        Left = 60
        Top = 46
        Width = 117
        Height = 21
        TabOrder = 1
        Text = '1'
      end
    end
    object Chart1: TChart
      Left = 288
      Top = 6
      Width = 285
      Height = 256
      Legend.Visible = False
      Title.Text.Strings = (
        'f(x)')
      View3D = False
      Color = 14869218
      TabOrder = 3
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColorPaletteIndex = 0
      object Series1: TLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object ComboBox1: TComboBox
      Left = 68
      Top = 144
      Width = 150
      Height = 21
      Style = csDropDownList
      ItemIndex = 3
      TabOrder = 4
      Text = 'Boole'#39's rule'
      Items.Strings = (
        'Trapezoidal rule'
        'Simpson rule'
        'Simpson 3/8 rule'
        'Boole'#39's rule'
        '10 point Gauss quadrature'
        '16 point Gauss quadrature')
    end
    object EditIntervals: TEdit
      Left = 158
      Top = 179
      Width = 44
      Height = 21
      TabOrder = 5
      Text = '10'
    end
    object UpDown1: TUpDown
      Left = 202
      Top = 179
      Width = 16
      Height = 21
      Associate = EditIntervals
      Min = 1
      Max = 1000
      Position = 10
      TabOrder = 6
    end
  end
end
