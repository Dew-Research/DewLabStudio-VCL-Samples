object ScriptingGridForm: TScriptingGridForm
  Left = 0
  Top = 0
  ActiveControl = ExprEdit
  Caption = 'MtxVec scripting'
  ClientHeight = 763
  ClientWidth = 1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 358
    Top = 0
    Width = 5
    Height = 744
    ExplicitLeft = 352
  end
  object Splitter6: TSplitter
    Left = 690
    Top = 0
    Width = 6
    Height = 744
    Align = alRight
  end
  object Panel1: TPanel
    Left = 696
    Top = 0
    Width = 392
    Height = 744
    Align = alRight
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 689
      Width = 390
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 255
      ExplicitWidth = 362
    end
    object Splitter4: TSplitter
      Left = 1
      Top = 439
      Width = 390
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 1
      ExplicitWidth = 246
    end
    object RichEdit: TRichEdit
      Left = 1
      Top = 463
      Width = 390
      Height = 226
      Hint = 'Command line output'
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier'
      Font.Style = []
      HideSelection = False
      Lines.Strings = (
        'RichEdit')
      ParentFont = False
      ParentShowHint = False
      PlainText = True
      ReadOnly = True
      ScrollBars = ssBoth
      ShowHint = True
      TabOrder = 0
      WantTabs = True
      OnMouseEnter = RichEditMouseEnter
    end
    object ExprEdit: TEdit
      Left = 1
      Top = 722
      Width = 390
      Height = 21
      Hint = 'Enter expression to be evaluated here'
      Align = alBottom
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'x = 1'
      OnKeyUp = ExprEditKeyUp
      OnMouseEnter = ExprEditMouseEnter
    end
    object ScriptEdit: TRichEdit
      Left = 1
      Top = 64
      Width = 390
      Height = 375
      Hint = 'Modify the script and press "Run Script"'
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier'
      Font.Style = []
      HideSelection = False
      Lines.Strings = (
        'a = 2'
        'if (a < 0)'
        '   c = sin(12)'
        '   c = 2*c'
        'else'
        '   c = 2'
        'end')
      ParentFont = False
      ParentShowHint = False
      PlainText = True
      ScrollBars = ssBoth
      ShowHint = True
      TabOrder = 2
      WantTabs = True
      WordWrap = False
      OnKeyUp = ScriptEditKeyUp
      OnMouseEnter = RichEditMouseEnter
      OnMouseMove = ScriptEditMouseMove
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 390
      Height = 63
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      DesignSize = (
        390
        63)
      object ScriptLabel: TLabel
        Left = 10
        Top = 6
        Width = 76
        Height = 13
        Caption = 'Script selection:'
      end
      object Bevel1: TBevel
        Left = 5
        Top = 30
        Width = 380
        Height = 7
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsTopLine
        ExplicitHeight = 4
      end
      object ScriptBox: TComboBox
        Left = 98
        Top = 3
        Width = 145
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        OnChange = ScriptBoxChange
      end
      object RunButton: TButton
        Left = 255
        Top = 35
        Width = 45
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'Run'
        TabOrder = 1
        OnClick = RunButtonClick
      end
      object ResetButton: TButton
        Left = 344
        Top = 35
        Width = 41
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'Reset'
        TabOrder = 2
        OnClick = ResetButtonClick
      end
      object StepButton: TButton
        Left = 302
        Top = 35
        Width = 40
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'Step'
        TabOrder = 3
        OnClick = StepButtonClick
      end
      object SaveAsButton: TButton
        Left = 254
        Top = 3
        Width = 67
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'Save As'
        TabOrder = 4
        OnClick = SaveAsButtonClick
      end
      object DeleteScriptButton: TButton
        Left = 327
        Top = 2
        Width = 58
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = 'Delete'
        TabOrder = 5
        OnClick = DeleteScriptButtonClick
      end
      object GridInsertScriptButton: TButton
        Left = 8
        Top = 35
        Width = 67
        Height = 22
        Caption = 'Grid insert'
        TabOrder = 6
        OnClick = GridInsertScriptButtonClick
      end
      object GridAssignScriptButton: TButton
        Left = 78
        Top = 35
        Width = 67
        Height = 22
        Caption = 'Grid assign'
        TabOrder = 7
        OnClick = GridAssignScriptButtonClick
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 442
      Width = 390
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object LineLabel: TLabel
        Left = 5
        Top = 3
        Width = 26
        Height = 13
        Caption = 'Line: '
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 693
      Width = 390
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 5
      object GridInsertEditButton: TButton
        Left = 2
        Top = 2
        Width = 67
        Height = 22
        Caption = 'Grid insert'
        TabOrder = 0
        OnClick = GridInsertEditButtonClick
      end
      object GridAssignEditButton: TButton
        Left = 72
        Top = 2
        Width = 67
        Height = 22
        Caption = 'Grid assign'
        TabOrder = 1
        OnClick = GridAssignEditButtonClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 358
    Height = 744
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 1
      Top = 453
      Width = 356
      Height = 13
      Align = alTop
      Caption = 'Command History'
      ExplicitWidth = 84
    end
    object Splitter3: TSplitter
      Left = 1
      Top = 450
      Width = 356
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 185
      ExplicitWidth = 239
    end
    object ListBox: TListBox
      Left = 1
      Top = 466
      Width = 356
      Height = 277
      Align = alClient
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 0
      OnClick = ListBoxClick
      OnDblClick = ListBoxDblClick
      OnMouseEnter = ListBoxMouseEnter
    end
    object VarView: TListView
      Left = 1
      Top = 64
      Width = 356
      Height = 386
      Align = alTop
      BorderStyle = bsNone
      Columns = <
        item
          Caption = 'Name'
        end
        item
          Caption = 'Type'
          Width = 100
        end
        item
          Caption = 'Value'
          Width = 200
        end>
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
      OnDblClick = VarViewDblClick
      OnMouseEnter = VarViewMouseEnter
    end
    object Panel8: TPanel
      Left = 1
      Top = 1
      Width = 356
      Height = 63
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        356
        63)
      object Label3: TLabel
        Left = 7
        Top = 6
        Width = 57
        Height = 13
        Caption = 'Workspace:'
      end
      object Bevel2: TBevel
        Left = 2
        Top = 30
        Width = 349
        Height = 5
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsTopLine
      end
      object Label2: TLabel
        Left = 7
        Top = 38
        Width = 99
        Height = 13
        Caption = 'Workspace variables'
      end
      object WorkspaceBox: TComboBox
        Left = 70
        Top = 3
        Width = 135
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        OnChange = WorkspaceBoxChange
      end
      object SaveWorkButton: TButton
        Left = 211
        Top = 2
        Width = 67
        Height = 22
        Anchors = [akTop, akRight]
        Caption = 'Save As'
        TabOrder = 1
        OnClick = SaveWorkButtonClick
      end
      object DeleteWorkButton: TButton
        Left = 284
        Top = 2
        Width = 58
        Height = 22
        Anchors = [akTop, akRight]
        Caption = 'Delete'
        TabOrder = 2
        OnClick = DeleteWorkButtonClick
      end
      object ResetWorkspaceButton: TButton
        Left = 284
        Top = 35
        Width = 58
        Height = 22
        Hint = 'Clear variables from workspace'
        Anchors = [akTop, akRight]
        Caption = 'Reset'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ResetWorkspaceButtonClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 744
    Width = 1088
    Height = 19
    Panels = <
      item
        Width = 400
      end>
  end
  object Panel5: TPanel
    Left = 363
    Top = 0
    Width = 327
    Height = 744
    Align = alClient
    Caption = 'Panel5'
    TabOrder = 3
    object PageControl: TPageControl
      Left = 1
      Top = 42
      Width = 325
      Height = 701
      ActivePage = Sheet1
      Align = alClient
      TabOrder = 0
      object Sheet1: TTabSheet
        Caption = 'Grid 1'
        object Grid1: TStringGrid
          Left = 0
          Top = 0
          Width = 317
          Height = 673
          Align = alClient
          ColCount = 1000
          DefaultRowHeight = 20
          RowCount = 1000
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
          TabOrder = 0
          OnDrawCell = Grid1DrawCell
          OnKeyUp = Grid1KeyUp
          ColWidths = (
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64
            64)
          RowHeights = (
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20
            20)
        end
      end
      object Sheet2: TTabSheet
        Caption = 'Grid 2'
        ImageIndex = 1
        object Grid2: TStringGrid
          Left = 0
          Top = 0
          Width = 317
          Height = 673
          Align = alClient
          DefaultRowHeight = 20
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
          TabOrder = 0
          ColWidths = (
            64
            64
            64
            64
            64)
          RowHeights = (
            20
            20
            20
            20
            20)
        end
      end
      object Chart: TTabSheet
        Caption = 'Chart'
        ImageIndex = 2
        object Splitter5: TSplitter
          Left = 0
          Top = 346
          Width = 317
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 250
          ExplicitWidth = 428
        end
        object Chart1: TChart
          Left = 0
          Top = 0
          Width = 317
          Height = 346
          BackWall.Transparent = False
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Gradient.Direction = gdBottomTop
          Gradient.EndColor = clWhite
          Gradient.MidColor = 15395562
          Gradient.StartColor = 15395562
          Gradient.Visible = True
          LeftWall.Color = 14745599
          Legend.Font.Name = 'Verdana'
          Legend.Visible = False
          RightWall.Color = 14745599
          Title.Font.Name = 'Verdana'
          Title.Text.Strings = (
            'Chart 1')
          BottomAxis.Axis.Color = 4210752
          BottomAxis.Grid.Color = 11119017
          BottomAxis.TicksInner.Color = 11119017
          BottomAxis.Title.Font.Name = 'Verdana'
          DepthAxis.Axis.Color = 4210752
          DepthAxis.Grid.Color = 11119017
          DepthAxis.TicksInner.Color = 11119017
          DepthAxis.Title.Font.Name = 'Verdana'
          DepthTopAxis.Axis.Color = 4210752
          DepthTopAxis.Grid.Color = 11119017
          DepthTopAxis.TicksInner.Color = 11119017
          DepthTopAxis.Title.Font.Name = 'Verdana'
          LeftAxis.Axis.Color = 4210752
          LeftAxis.Grid.Color = 11119017
          LeftAxis.TicksInner.Color = 11119017
          LeftAxis.Title.Font.Name = 'Verdana'
          RightAxis.Axis.Color = 4210752
          RightAxis.Grid.Color = 11119017
          RightAxis.TicksInner.Color = 11119017
          RightAxis.Title.Font.Name = 'Verdana'
          TopAxis.Axis.Color = 4210752
          TopAxis.Grid.Color = 11119017
          TopAxis.TicksInner.Color = 11119017
          TopAxis.Title.Font.Name = 'Verdana'
          View3D = False
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          ColorPaletteIndex = 13
          object Series1: TFastLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            LinePen.Color = 10708548
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
        object Chart2: TChart
          Left = 0
          Top = 349
          Width = 317
          Height = 324
          BackWall.Transparent = False
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Gradient.Direction = gdBottomTop
          Gradient.EndColor = clWhite
          Gradient.MidColor = 15395562
          Gradient.StartColor = 15395562
          Gradient.Visible = True
          LeftWall.Color = 14745599
          Legend.Font.Name = 'Verdana'
          Legend.Visible = False
          RightWall.Color = 14745599
          Title.Font.Name = 'Verdana'
          Title.Text.Strings = (
            'Chart 2')
          BottomAxis.Axis.Color = 4210752
          BottomAxis.Grid.Color = 11119017
          BottomAxis.TicksInner.Color = 11119017
          BottomAxis.Title.Font.Name = 'Verdana'
          DepthAxis.Axis.Color = 4210752
          DepthAxis.Grid.Color = 11119017
          DepthAxis.TicksInner.Color = 11119017
          DepthAxis.Title.Font.Name = 'Verdana'
          DepthTopAxis.Axis.Color = 4210752
          DepthTopAxis.Grid.Color = 11119017
          DepthTopAxis.TicksInner.Color = 11119017
          DepthTopAxis.Title.Font.Name = 'Verdana'
          LeftAxis.Axis.Color = 4210752
          LeftAxis.Grid.Color = 11119017
          LeftAxis.TicksInner.Color = 11119017
          LeftAxis.Title.Font.Name = 'Verdana'
          RightAxis.Axis.Color = 4210752
          RightAxis.Grid.Color = 11119017
          RightAxis.TicksInner.Color = 11119017
          RightAxis.Title.Font.Name = 'Verdana'
          TopAxis.Axis.Color = 4210752
          TopAxis.Grid.Color = 11119017
          TopAxis.TicksInner.Color = 11119017
          TopAxis.Title.Font.Name = 'Verdana'
          View3D = False
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          ColorPaletteIndex = 13
          object Series2: TFastLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            LinePen.Color = 10708548
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 325
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object EditModeButton: TSpeedButton
        Left = 5
        Top = 2
        Width = 65
        Height = 25
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'Edit mode'
        OnClick = EditModeButtonClick
      end
    end
  end
end
