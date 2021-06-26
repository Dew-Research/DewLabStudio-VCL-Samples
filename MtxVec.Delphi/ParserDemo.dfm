inherited frmParser: TfrmParser
  Left = 339
  Top = 148
  Caption = 'frmParser'
  ClientHeight = 495
  ClientWidth = 747
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 763
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 747
    Height = 59
    ExplicitWidth = 755
    ExplicitHeight = 59
    inherited RichEdit1: TRichEdit
      Width = 745
      Height = 57
      Font.Color = 7105644
      ExplicitWidth = 745
      ExplicitHeight = 57
    end
  end
  inherited Panel2: TPanel
    Top = 437
    Width = 747
    ExplicitTop = 441
    ExplicitWidth = 755
  end
  inherited Panel3: TPanel
    Top = 59
    Width = 747
    Height = 378
    ExplicitTop = 59
    ExplicitWidth = 755
    ExplicitHeight = 382
    object Label2: TLabel
      Left = 20
      Top = 7
      Width = 164
      Height = 13
      Caption = 'Mathematical or logical expression:'
    end
    object Label3: TLabel
      Left = 313
      Top = 65
      Width = 49
      Height = 13
      Caption = 'Functions:'
    end
    object Label1: TLabel
      Left = 123
      Top = 265
      Width = 42
      Height = 13
      Caption = 'Result = '
    end
    object Label4: TLabel
      Left = 313
      Top = 116
      Width = 46
      Height = 13
      Caption = 'Variables:'
      Visible = False
    end
    object helplabel: TLabel
      Left = 367
      Top = 116
      Width = 3
      Height = 13
    end
    object NEvalLabel: TLabel
      Left = 372
      Top = 241
      Width = 3
      Height = 13
    end
    object Label6: TLabel
      Left = 313
      Top = 92
      Width = 50
      Height = 13
      Caption = 'Constants:'
    end
    object ResultEdit: TEdit
      Left = 169
      Top = 261
      Width = 170
      Height = 21
      TabOrder = 0
    end
    object Evaluate: TButton
      Left = 13
      Top = 248
      Width = 98
      Height = 32
      Caption = 'Evaluate'
      TabOrder = 1
      OnClick = EvaluateClick
    end
    object XEdit: TEdit
      Left = 351
      Top = 135
      Width = 118
      Height = 21
      TabOrder = 42
      Text = '0'
      OnExit = XEditChange
    end
    object GroupBox1: TGroupBox
      Left = 13
      Top = 53
      Width = 293
      Height = 188
      Caption = 'Operands: '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object PointButton: TButton
      Left = 65
      Top = 182
      Width = 33
      Height = 20
      Hint = 'decimal point'
      Caption = '.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object ExpressionEdit: TEdit
      Left = 20
      Top = 20
      Width = 481
      Height = 21
      PopupMenu = PopupMenu1
      TabOrder = 4
      OnKeyDown = ExpressionEditKeyDown
    end
    object Button4: TButton
      Left = 24
      Top = 150
      Width = 34
      Height = 20
      Hint = 'digit 1'
      Caption = '1'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button5: TButton
      Left = 64
      Top = 150
      Width = 34
      Height = 20
      Hint = 'digit 2'
      Caption = '2'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button6: TButton
      Left = 103
      Top = 150
      Width = 34
      Height = 20
      Hint = 'digit 3'
      Caption = '3'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button7: TButton
      Left = 143
      Top = 182
      Width = 33
      Height = 20
      Hint = 'divide'
      Caption = ' / '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button8: TButton
      Left = 221
      Top = 182
      Width = 33
      Height = 20
      Hint = 'not equal'
      Caption = ' <> '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button9: TButton
      Left = 260
      Top = 182
      Width = 33
      Height = 20
      Hint = 'logical not'
      Caption = ' not '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button10: TButton
      Left = 182
      Top = 182
      Width = 33
      Height = 20
      Hint = 'percentage'
      Caption = '%'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button11: TButton
      Left = 24
      Top = 121
      Width = 34
      Height = 20
      Hint = 'digit 4'
      Caption = '4'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button14: TButton
      Left = 65
      Top = 121
      Width = 33
      Height = 20
      Hint = 'digit 5'
      Caption = '5'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button15: TButton
      Left = 104
      Top = 121
      Width = 33
      Height = 20
      Hint = 'digit 6'
      Caption = '6'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button16: TButton
      Left = 143
      Top = 121
      Width = 33
      Height = 20
      Hint = 'add'
      Caption = ' + '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button17: TButton
      Left = 221
      Top = 121
      Width = 33
      Height = 20
      Hint = 'less than'
      Caption = ' < '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button18: TButton
      Left = 260
      Top = 121
      Width = 33
      Height = 20
      Hint = 'logical or'
      Caption = ' or '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button19: TButton
      Left = 182
      Top = 121
      Width = 33
      Height = 20
      Hint = 'faculty'
      Caption = '!'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button24: TButton
      Left = 24
      Top = 91
      Width = 34
      Height = 20
      Hint = 'digit 7'
      Caption = '7'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 19
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button25: TButton
      Left = 65
      Top = 91
      Width = 33
      Height = 20
      Hint = 'digit 8'
      Caption = '8'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 20
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button26: TButton
      Left = 104
      Top = 91
      Width = 33
      Height = 20
      Hint = 'digit 9'
      Caption = '9'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button27: TButton
      Left = 143
      Top = 91
      Width = 33
      Height = 20
      Hint = 'subtract'
      Caption = ' - '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 22
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button28: TButton
      Left = 221
      Top = 91
      Width = 33
      Height = 20
      Hint = 'greater than'
      Caption = ' > '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 23
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button29: TButton
      Left = 260
      Top = 91
      Width = 33
      Height = 20
      Hint = 'logical and'
      Caption = ' and '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 24
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button31: TButton
      Left = 182
      Top = 91
      Width = 33
      Height = 20
      Hint = 'power'
      Caption = '^'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 25
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button35: TButton
      Left = 24
      Top = 182
      Width = 34
      Height = 20
      Hint = 'digit 0'
      Caption = '0'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 26
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button38: TButton
      Left = 143
      Top = 150
      Width = 33
      Height = 20
      Hint = 'multiply'
      Caption = ' * '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 27
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button39: TButton
      Left = 222
      Top = 150
      Width = 33
      Height = 20
      Hint = 'equal'
      Caption = ' = '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 28
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button40: TButton
      Left = 260
      Top = 150
      Width = 33
      Height = 20
      Hint = 'exclusive or'
      Caption = ' xor '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 29
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button12: TButton
      Left = 183
      Top = 150
      Width = 33
      Height = 20
      Hint = 'modulus (remainder of division 9 mod 4 = 1)'
      Caption = ' mod '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 30
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button13: TButton
      Left = 182
      Top = 215
      Width = 33
      Height = 20
      Hint = 'less equal'
      Caption = ' <= '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 31
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button21: TButton
      Left = 221
      Top = 215
      Width = 33
      Height = 20
      Hint = 'greater equal'
      Caption = ' >= '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 32
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button22: TButton
      Left = 104
      Top = 215
      Width = 33
      Height = 20
      Hint = 'integer devide (truncate result)'
      Caption = ' div '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 33
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button23: TButton
      Left = 104
      Top = 182
      Width = 33
      Height = 20
      Hint = 'Exponent in scientific notation of numbers'
      Caption = 'E'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 34
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button30: TButton
      Left = 143
      Top = 215
      Width = 33
      Height = 20
      Hint = 'delimiter for string constants'
      Caption = #39
      ParentShowHint = False
      ShowHint = True
      TabOrder = 35
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button33: TButton
      Left = 65
      Top = 215
      Width = 33
      Height = 20
      Hint = 'bracket'
      Caption = ')'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 36
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button34: TButton
      Left = 24
      Top = 215
      Width = 34
      Height = 20
      Hint = 'bracket'
      Caption = '('
      ParentShowHint = False
      ShowHint = True
      TabOrder = 37
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object FunctionsCombo: TComboBox
      Left = 372
      Top = 60
      Width = 84
      Height = 21
      Style = csDropDownList
      Sorted = True
      TabOrder = 38
      OnChange = FunctionsComboChange
      OnKeyPress = Button24KeyPress
    end
    object Button32: TButton
      Left = 462
      Top = 60
      Width = 39
      Height = 20
      Caption = 'Add'
      TabOrder = 39
      OnClick = Button32Click
      OnKeyPress = Button24KeyPress
    end
    object yEdit: TEdit
      Left = 351
      Top = 158
      Width = 118
      Height = 21
      TabOrder = 43
      Text = '0'
      OnExit = yEditChange
    end
    object ZEdit: TEdit
      Left = 351
      Top = 181
      Width = 118
      Height = 21
      TabOrder = 44
      Text = '0'
      OnExit = ZEditChange
    end
    object Button1: TButton
      Left = 313
      Top = 135
      Width = 32
      Height = 20
      Caption = 'x'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 45
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button36: TButton
      Left = 313
      Top = 158
      Width = 32
      Height = 21
      Caption = 'y'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 46
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button37: TButton
      Left = 313
      Top = 181
      Width = 32
      Height = 20
      Caption = 'z'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 47
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object Button42: TButton
      Left = 260
      Top = 215
      Width = 33
      Height = 20
      Hint = 'assign to variable'
      Caption = ' := '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 48
      OnClick = Button24Click
      OnKeyPress = Button24KeyPress
    end
    object ConstantsCombo: TComboBox
      Left = 372
      Top = 87
      Width = 84
      Height = 21
      Style = csDropDownList
      Sorted = True
      TabOrder = 40
      OnKeyPress = Button24KeyPress
    end
    object Button2: TButton
      Left = 462
      Top = 87
      Width = 39
      Height = 20
      Caption = 'Add'
      TabOrder = 41
      OnClick = Button2Click
      OnKeyPress = Button24KeyPress
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 517
    Top = 364
    object Undo1: TMenuItem
      Caption = '&Undo'
      ShortCut = 16474
    end
    object Redo1: TMenuItem
      Caption = '&Redo '
      ShortCut = 16473
    end
  end
end
