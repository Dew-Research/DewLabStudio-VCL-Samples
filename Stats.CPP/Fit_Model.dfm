inherited frmModels: TfrmModels
  Caption = 'frmModels'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Memo1: TMemo
    Lines.Strings = (
      
        'Statistics includes several basic fitting models. The following ' +
        '"linear" models are supported:'
      '(+) Simple exponential model : y=a*Exp[b*x]'
      '(+) Simple linear mode : y=k*x+n'
      '(+) Simple power model: y=a*x^b'
      
        '(+) Simple polynomial model : y=a[n]*x^n + a[n-1]*x^(n-1) + ... ' +
        '+ a[1]*x + a[0]'
      
        '(+) Rational function model: y=(p0 + p1.x + p2.x^2 + ...)/(1 + q' +
        '1.x + q2.x^2 + ...)'
      '(+) Logistic function model: y=A+(B-A)/(1+Exp(-a*x+b))'
      '(+) Natural logarithm model: y=A+B*Ln(x)'
      ''
      
        'These models are located in RegModels.pas unit. You can easily a' +
        'dd new models. Using '
      
        'Statistics procedures you can construct new models.  To construc' +
        't fitted values you need:'
      
        '1) Evaluate function : evaluates model for given parameters at s' +
        'pecific value'
      '2) Fit function : fits model to given values'
      ''
      'An example : Power function :  y = B[0] * X ^ B[1]'
      '1) Evaluate function :'
      ' function PowerEval(B: Array of TSample; X: TSample): TSample;'
      ' begin'
      '   Result := B[0] * Power(X,B[1]);'
      ' end;'
      ''
      '2) Fit function :'
      ' procedure PowerFit(B: TVec; X,Y: TVec; Weights: TVec = nil);'
      ' var X1,Y1,W1 : TVec;'
      '     i,n      : Integer;'
      ' begin'
      
        '   if X.Length <> Y.Length then raise Exception.Create('#39'X.Lenght' +
        ' <> Y.Length'#39');'
      '   CreateIt(X1,Y1,W1);'
      '   X1.Size(X);'
      '   Y1.Size(X);'
      '   W1.Size(X);'
      '   try'
      '     n := 0;'
      '     for i := 0 to X.Length-1 do'
      '       if (X.Values[i] > 0) and (Y.Values[i] > 0) then'
      '       begin'
      '         { linearize equation }'
      '         X1.Values[n] := Ln(X.Values[i]);'
      '         Y1.Values[n] := Ln(Y.Values[i]);'
      '         W1.Values[n] := Sqr(Y.Values[i]);'
      
        '         if Weights <> nil then W1.Values[n] := W1.Values[n]*Wei' +
        'ghts.Values[i];'
      '         Inc(n);'
      '       end;'
      '     X1.Resize(n);'
      '     Y1.Resize(n);'
      '     W1.Resize(n);'
      '     if n > 0 then'
      '     begin'
      '       { now do least-square fit }'
      '       LinRegress(X1,Y1,B,W1,nil,nil);'
      '       B.Exp(0,1);'
      '     end;'
      '   finally'
      '     FreeIt(X1,Y1,W1);'
      '   end;'
      ' end;'
      ''
      'Click on "X" and "Y" buttons to change x and y values.'
      
        'If you cannot linearize your model, you can try using TMtxNonLin' +
        'Reg  component and calculate '
      
        'model parameters by using several  optimization methods (Marquar' +
        'dt, several Quasi-Newton '
      'methods, Simplex, ...')
  end
  inherited Panel1: TPanel
    object Label1: TLabel [0]
      Left = 8
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Model : '
    end
    object Label2: TLabel [1]
      Left = 11
      Top = 90
      Width = 142
      Height = 13
      AutoSize = False
    end
    inherited Chart1: TChart
      BackWall.Color = 14145495
      Title.Text.Strings = (
        'Fitting models')
      BottomAxis.Maximum = 24.000000000000000000
      LeftAxis.Maximum = 705.000000000000000000
      LeftAxis.Minimum = 195.000000000000000000
      Zoom.Brush.Style = bsFDiagonal
      Zoom.Pen.Color = clBlack
      object Series1: TPointSeries
        HoverElement = [heCurrent]
        SeriesColor = 4227327
        Title = 'Data'
        ClickableLine = False
        Pointer.Brush.Gradient.EndColor = 4227327
        Pointer.Gradient.EndColor = 4227327
        Pointer.HorizSize = 3
        Pointer.InflateMargins = True
        Pointer.Style = psDiamond
        Pointer.VertSize = 3
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
        Left = 112
        Top = 88
      end
      object Series2: TLineSeries
        HoverElement = [heCurrent]
        SeriesColor = clYellow
        Title = 'Fitted'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
        Left = 72
        Top = 72
      end
    end
    object Button2: TButton
      Left = 8
      Top = 112
      Width = 65
      Height = 16
      Caption = 'X...'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 75
      Top = 112
      Width = 65
      Height = 16
      Caption = 'Y...'
      TabOrder = 3
      OnClick = Button3Click
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 63
      Width = 145
      Height = 21
      TabOrder = 4
      Text = 'ComboBox1'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Simple exponential'
        'Simple linear'
        'Simple power'
        'Simple polynomial'
        'Rational'
        'Logistic'
        'Logarithm')
    end
  end
end
