inherited frmLevey: TfrmLevey
  Caption = 'frmLevey'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Chart1: TChart
      Legend.Visible = False
      Title.Text.Strings = (
        '1S3: One value beyond three sigma from the mean.'
        '1S2: One value beyond two sigma from the mean.'
        
          '2S2: Two consecutive values either greater than, or less than, t' +
          'wo sigma from the mean.'
        
          'RS4: A difference between consecutive values greater than four s' +
          'igma.'
        
          '41S: Four consecutive values greater than, or less than, one sig' +
          'ma from the mean.'
        
          '10X: Ten consecutive values all greater than, or less than, the ' +
          'mean. '
        '')
      OnAfterDraw = Chart1AfterDraw
      PrintMargins = (
        15
        7
        15
        7)
      object Series1: TLineSeries
        HoverElement = [heCurrent]
        OnGetPointerStyle = Series1GetPointerStyle
        Marks.Visible = True
        Marks.MultiLine = True
        SeriesColor = clWhite
        OnGetMarkText = Series1GetMarkText
        Brush.BackColor = clDefault
        Pointer.Brush.Gradient.EndColor = clWhite
        Pointer.Gradient.EndColor = clWhite
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    inherited Panel2: TPanel
      object CheckBoxMean: TCheckBox
        Left = 8
        Top = 48
        Width = 97
        Height = 17
        Caption = 'Show mean line'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBoxMeanClick
      end
      object CheckBoxSigma: TCheckBox
        Left = 8
        Top = 72
        Width = 113
        Height = 17
        Caption = 'Show sigma lines'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = CheckBoxSigmaClick
      end
      object Button2: TButton
        Left = 8
        Top = 96
        Width = 75
        Height = 25
        Caption = 'Edit data'
        TabOrder = 3
        OnClick = Button2Click
      end
    end
  end
end
