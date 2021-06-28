inherited frmExpSmooth: TfrmExpSmooth
  Caption = 'frmExpSmooth'
  ClientHeight = 663
  ClientWidth = 741
  ExplicitWidth = 757
  ExplicitHeight = 702
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Width = 741
    ExplicitWidth = 741
  end
  inherited Panel1: TPanel
    Width = 741
    Height = 534
    ExplicitWidth = 741
    ExplicitHeight = 534
    inherited Chart1: TChart
      Width = 552
      Height = 534
      BackWall.Color = 15263976
      Legend.Alignment = laBottom
      Title.Text.Strings = (
        'Single, double and triple'
        'exponential smoothing')
      BottomAxis.Maximum = 24.000000000000000000
      LeftAxis.Maximum = 680.000000000000000000
      LeftAxis.Minimum = 17.439125000000050000
      OnAfterDraw = Chart1AfterDraw
      ExplicitWidth = 552
      ExplicitHeight = 534
      object Series1: TLineSeries
        HoverElement = [heCurrent]
        Marks.Callout.Length = 0
        Title = 'Raw data'
        Brush.BackColor = clDefault
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = 42495
        Pointer.Gradient.EndColor = 42495
        Pointer.HorizSize = 2
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.VertSize = 2
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series3: TLineSeries
        HoverElement = [heCurrent]
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series4: TLineSeries
        HoverElement = [heCurrent]
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      Height = 534
      ExplicitHeight = 534
      object Label1: TLabel [0]
        Left = 8
        Top = 80
        Width = 82
        Height = 13
        Caption = 'Forecast period :'
      end
      object Button2: TButton
        Left = 8
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Edit data'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 8
        Top = 408
        Width = 75
        Height = 25
        Caption = 'Smooth data'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Edit1: TEdit
        Left = 8
        Top = 96
        Width = 81
        Height = 21
        TabOrder = 3
        Text = '0'
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 128
        Width = 137
        Height = 57
        Caption = 'Single exp - initial values'
        TabOrder = 4
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 27
          Height = 13
          Caption = 'Alpha'
        end
        object EditAlphaS: TEdit
          Left = 40
          Top = 24
          Width = 57
          Height = 21
          TabOrder = 0
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 192
        Width = 137
        Height = 73
        Caption = 'Double exp - initial values'
        TabOrder = 5
        object Label3: TLabel
          Left = 8
          Top = 24
          Width = 27
          Height = 13
          Caption = 'Alpha'
        end
        object Label4: TLabel
          Left = 8
          Top = 48
          Width = 35
          Height = 13
          Caption = 'Gamma'
        end
        object EditAlphaD: TEdit
          Left = 56
          Top = 24
          Width = 65
          Height = 21
          TabOrder = 0
        end
        object EditGammaD: TEdit
          Left = 56
          Top = 48
          Width = 65
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 272
        Width = 137
        Height = 129
        Caption = 'Triple exp - initial values'
        TabOrder = 6
        object Label5: TLabel
          Left = 8
          Top = 24
          Width = 27
          Height = 13
          Caption = 'Alpha'
        end
        object Label6: TLabel
          Left = 8
          Top = 48
          Width = 22
          Height = 13
          Caption = 'Beta'
        end
        object Label7: TLabel
          Left = 8
          Top = 72
          Width = 35
          Height = 13
          Caption = 'Gamma'
        end
        object Label8: TLabel
          Left = 8
          Top = 96
          Width = 30
          Height = 13
          Caption = 'Period'
        end
        object EditAlphaT: TEdit
          Left = 56
          Top = 24
          Width = 65
          Height = 21
          TabOrder = 0
        end
        object EditBetaT: TEdit
          Left = 56
          Top = 48
          Width = 65
          Height = 21
          TabOrder = 1
        end
        object EditGammaT: TEdit
          Left = 56
          Top = 72
          Width = 65
          Height = 21
          TabOrder = 2
        end
        object EditPeriod: TEdit
          Left = 56
          Top = 96
          Width = 65
          Height = 21
          TabOrder = 3
        end
      end
      object UpDown1: TUpDown
        Left = 89
        Top = 96
        Width = 16
        Height = 21
        Associate = Edit1
        TabOrder = 7
      end
    end
  end
end
