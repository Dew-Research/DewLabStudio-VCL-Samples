object ScriptingForm: TScriptingForm
  Left = 0
  Top = 0
  Caption = 'MtxVec scripting'
  ClientHeight = 693
  ClientWidth = 1039
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 379
    Top = 0
    Width = 2
    Height = 674
    ExplicitLeft = 185
    ExplicitHeight = 440
  end
  object Panel1: TPanel
    Left = 381
    Top = 0
    Width = 658
    Height = 674
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 648
      Width = 656
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 255
      ExplicitWidth = 362
    end
    object Splitter4: TSplitter
      Left = 1
      Top = 272
      Width = 656
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 1
      ExplicitWidth = 246
    end
    object RichEdit: TRichEdit
      Left = 1
      Top = 316
      Width = 656
      Height = 332
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
      PlainText = True
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WantTabs = True
      OnMouseEnter = RichEditMouseEnter
      OnMouseMove = RichEditMouseMove
    end
    object ExprEdit: TEdit
      Left = 1
      Top = 652
      Width = 656
      Height = 21
      Align = alBottom
      TabOrder = 1
      Text = 'x = 1'
      OnKeyDown = ExprEditKeyDown
      OnMouseEnter = ExprEditMouseEnter
    end
    object ScriptEdit: TRichEdit
      Left = 1
      Top = 42
      Width = 656
      Height = 230
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
      PlainText = True
      ScrollBars = ssBoth
      TabOrder = 2
      WantTabs = True
      WordWrap = False
      OnMouseEnter = RichEditMouseEnter
      OnMouseMove = RichEditMouseMove
    end
    object Panel3: TPanel
      Left = 1
      Top = 275
      Width = 656
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      DesignSize = (
        656
        41)
      object RunButton: TButton
        Left = 556
        Top = 6
        Width = 83
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Run script'
        TabOrder = 0
        OnClick = RunButtonClick
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 656
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object ScriptLabel: TLabel
        Left = 16
        Top = 14
        Width = 76
        Height = 13
        Caption = 'Script selection:'
      end
      object ScriptBox: TComboBox
        Left = 98
        Top = 11
        Width = 177
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = ScriptBoxChange
        Items.Strings = (
          'If clause'
          'while clause'
          'for-loop')
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 379
    Height = 674
    Align = alLeft
    Caption = 'Panel2'
    TabOrder = 1
    object Label1: TLabel
      Left = 1
      Top = 244
      Width = 377
      Height = 13
      Align = alTop
      Caption = 'Command History'
      ExplicitWidth = 84
    end
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 377
      Height = 13
      Align = alTop
      Caption = 'Workspace variables'
      ExplicitWidth = 99
    end
    object Splitter3: TSplitter
      Left = 1
      Top = 241
      Width = 377
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 185
      ExplicitWidth = 239
    end
    object ListBox: TListBox
      Left = 1
      Top = 257
      Width = 377
      Height = 416
      Align = alClient
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = ListBoxDblClick
      OnMouseEnter = ListBoxMouseEnter
    end
    object VarView: TListView
      Left = 1
      Top = 14
      Width = 377
      Height = 227
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
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 674
    Width = 1039
    Height = 19
    Panels = <
      item
        Width = 400
      end>
  end
end
