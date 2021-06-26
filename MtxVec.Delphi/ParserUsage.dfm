inherited frmParserUsage: TfrmParserUsage
  Left = 279
  Top = 194
  Caption = 'frmParserUsage'
  ClientHeight = 659
  ClientWidth = 753
  OldCreateOrder = True
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 769
  ExplicitHeight = 698
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 753
    ExplicitWidth = 753
    inherited RichEdit1: TRichEdit
      Width = 751
      ExplicitWidth = 751
    end
  end
  inherited Panel2: TPanel
    Top = 601
    Width = 753
    ExplicitTop = 601
    ExplicitWidth = 753
    object memoErrMsg: TMemo
      Left = 16
      Top = 8
      Width = 733
      Height = 41
      Hint = 'Message box'
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited Panel3: TPanel
    Width = 753
    Height = 471
    ExplicitWidth = 753
    ExplicitHeight = 471
    object Label1: TLabel
      Left = 16
      Top = 56
      Width = 56
      Height = 13
      Caption = 'E&xpression:'
      FocusControl = memoExpr
    end
    object Label4: TLabel
      Left = 16
      Top = 160
      Width = 47
      Height = 13
      Caption = '&Variables:'
      FocusControl = lbVars
    end
    object Label5: TLabel
      Left = 16
      Top = 296
      Width = 39
      Height = 13
      Caption = '&Results:'
      FocusControl = lbResults
    end
    object Label6: TLabel
      Left = 16
      Top = 8
      Width = 104
      Height = 13
      Caption = '&Predefined examples:'
      FocusControl = cbExamples
    end
    object btn0: TSpeedButton
      Left = 352
      Top = 144
      Width = 33
      Height = 21
      Hint = 'digit 2'
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btnDot: TSpeedButton
      Left = 392
      Top = 144
      Width = 33
      Height = 21
      Hint = 'decimal point'
      Caption = '.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn1: TSpeedButton
      Left = 312
      Top = 120
      Width = 33
      Height = 21
      Hint = 'digit 1'
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn2: TSpeedButton
      Left = 352
      Top = 120
      Width = 33
      Height = 21
      Hint = 'digit 2'
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn3: TSpeedButton
      Left = 392
      Top = 120
      Width = 33
      Height = 21
      Hint = 'digit 3'
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn4: TSpeedButton
      Left = 312
      Top = 96
      Width = 33
      Height = 21
      Hint = 'digit 4'
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn5: TSpeedButton
      Left = 352
      Top = 96
      Width = 33
      Height = 21
      Hint = 'digit 5'
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn6: TSpeedButton
      Left = 392
      Top = 96
      Width = 33
      Height = 21
      Hint = 'digit 6'
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn7: TSpeedButton
      Left = 312
      Top = 72
      Width = 33
      Height = 21
      Hint = 'digit 7'
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn8: TSpeedButton
      Left = 352
      Top = 72
      Width = 33
      Height = 21
      Hint = 'digit 8'
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btn9: TSpeedButton
      Left = 392
      Top = 72
      Width = 33
      Height = 21
      Hint = 'digit 9'
      Caption = '9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btnCloseBracket: TSpeedButton
      Left = 392
      Top = 168
      Width = 33
      Height = 21
      Hint = 'closed bracket'
      Caption = ')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btnOpenBracket: TSpeedButton
      Left = 352
      Top = 168
      Width = 33
      Height = 21
      Hint = 'opened bracket'
      Caption = '('
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object btnI: TSpeedButton
      Left = 312
      Top = 144
      Width = 33
      Height = 21
      Hint = 'image part of coplex number'
      Caption = 'i '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object SpeedButton1: TSpeedButton
      Left = 432
      Top = 72
      Width = 33
      Height = 21
      Hint = 'digit 7'
      Caption = ' + '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object SpeedButton2: TSpeedButton
      Left = 432
      Top = 96
      Width = 33
      Height = 21
      Hint = 'digit 4'
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object SpeedButton3: TSpeedButton
      Left = 432
      Top = 120
      Width = 33
      Height = 21
      Hint = 'digit 1'
      Caption = ' * '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object SpeedButton4: TSpeedButton
      Left = 432
      Top = 144
      Width = 33
      Height = 21
      Hint = 'image part of coplex number'
      Caption = ' / '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymClick
    end
    object memoExpr: TMemo
      Left = 16
      Top = 72
      Width = 273
      Height = 57
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object lbVars: TListBox
      Left = 16
      Top = 176
      Width = 273
      Height = 89
      ItemHeight = 13
      Sorted = True
      TabOrder = 4
      OnDblClick = lbVarsDblClick
      OnMouseMove = lbVarsMouseMove
    end
    object btnAddVar: TButton
      Left = 88
      Top = 266
      Width = 65
      Height = 21
      Hint = 'Add a new variable to the list'
      Caption = '&Add'
      TabOrder = 6
      OnClick = btnAddVarClick
    end
    object btnDelVar: TButton
      Left = 152
      Top = 266
      Width = 65
      Height = 21
      Hint = 'Remove the selected variable from the list'
      Caption = 'Dele&te'
      TabOrder = 7
      OnClick = btnDelVarClick
    end
    object btnClearVarList: TButton
      Left = 16
      Top = 266
      Width = 65
      Height = 21
      Hint = 'Clear the variable list'
      Caption = 'Clear'
      TabOrder = 5
      OnClick = btnClearVarListClick
    end
    object btnSetVar: TButton
      Left = 224
      Top = 266
      Width = 65
      Height = 21
      Hint = 'Set type and value of the selected variable'
      Caption = '&Set'
      TabOrder = 8
      OnClick = btnSetVarClick
    end
    object cbExamples: TComboBox
      Left = 16
      Top = 24
      Width = 673
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbExamplesChange
      Items.Strings = (
        'a + b'
        'sin(a)'
        'x := y')
    end
    object lbResults: TListBox
      Left = 16
      Top = 312
      Width = 273
      Height = 89
      ItemHeight = 13
      TabOrder = 9
      OnMouseMove = lbVarsMouseMove
    end
    object PageControl1: TPageControl
      Left = 488
      Top = 72
      Width = 201
      Height = 337
      ActivePage = tsOperators
      TabOrder = 11
      object tsConstants: TTabSheet
        Caption = 'Constants'
        object lbConstants: TListBox
          Left = 0
          Top = 0
          Width = 193
          Height = 309
          Align = alClient
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
          OnDblClick = lbSymbolsDblClick
          OnMouseMove = lbConstantsMouseMove
        end
      end
      object tsFunctions: TTabSheet
        Caption = 'Functions'
        ImageIndex = 1
        object lbFunctions: TListBox
          Left = 0
          Top = 0
          Width = 193
          Height = 309
          Align = alClient
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
          OnDblClick = lbSymbolsDblClick
          OnMouseMove = lbFunctionsMouseMove
        end
      end
      object tsOperators: TTabSheet
        Caption = 'Operators'
        ImageIndex = 2
        object lbOperators: TListBox
          Left = 0
          Top = 0
          Width = 193
          Height = 309
          Align = alClient
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
          OnDblClick = lbSymbolsDblClick
          OnMouseMove = lbOperatorsMouseMove
        end
      end
    end
    object btnDetect: TButton
      Left = 88
      Top = 129
      Width = 65
      Height = 21
      Hint = 'Build variable list'
      Caption = '&Detect'
      TabOrder = 3
      OnClick = btnDetectClick
    end
    object btnEvaluate: TButton
      Left = 312
      Top = 264
      Width = 153
      Height = 25
      Hint = 'Evaluate the expression'
      Caption = '&Evaluate'
      TabOrder = 10
      OnClick = btnEvaluateClick
    end
    object btnClearExpr: TButton
      Left = 16
      Top = 129
      Width = 65
      Height = 21
      Hint = 'Clear the variable list'
      Caption = 'Clear'
      TabOrder = 2
      OnClick = btnClearExprClick
    end
  end
  object eval1: TMtxFunctionEvaluator
    Context.Expression = 'a+b'
    Context.Variables = <
      item
        VarName = 'a'
        Value.Data = {010000000000000040}
      end
      item
        VarName = 'b'
        Value.Data = {010000000000000840}
      end>
    Left = 24
    Top = 24
    MtxDataValues = {}
  end
end
