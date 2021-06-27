inherited BenchmarkXForm: TBenchmarkXForm
  Left = 473
  Top = 148
  Caption = 'BenchmarkXForm'
  ClientHeight = 545
  ClientWidth = 713
  OldCreateOrder = True
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  ExplicitWidth = 729
  ExplicitHeight = 583
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 713
    ExplicitWidth = 713
    inherited RichEdit1: TRichEdit
      Width = 711
      ExplicitWidth = 711
    end
  end
  inherited Panel2: TPanel
    Top = 487
    Width = 713
    ExplicitTop = 487
    ExplicitWidth = 713
    object Label3: TLabel
      Left = 272
      Top = 21
      Width = 66
      Height = 13
      Anchors = []
      Caption = '&Vector length:'
      FocusControl = cbVectorLength
    end
    object Label4: TLabel
      Left = 468
      Top = 24
      Width = 94
      Height = 13
      Anchors = []
      Caption = '&Iterations (DblClick):'
      FocusControl = cbIterationCount
    end
    object btnRun: TButton
      Left = 19
      Top = 18
      Width = 96
      Height = 25
      Anchors = []
      Caption = '&Run'
      TabOrder = 0
      OnClick = btnRunClick
    end
    object btnOpen: TButton
      Left = 134
      Top = 18
      Width = 96
      Height = 25
      Anchors = []
      Caption = '&Open'
      TabOrder = 1
      OnClick = btnOpenClick
    end
    object cbVectorLength: TComboBox
      Left = 348
      Top = 19
      Width = 96
      Height = 21
      Anchors = []
      TabOrder = 2
      Text = '1000'
    end
    object cbIterationCount: TComboBox
      Left = 575
      Top = 19
      Width = 98
      Height = 21
      Anchors = []
      TabOrder = 3
      Text = '3000'
      OnDblClick = cbIterationCountDblClick
    end
  end
  inherited Panel3: TPanel
    Width = 157
    Height = 357
    Align = alLeft
    ExplicitWidth = 157
    ExplicitHeight = 357
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 49
      Height = 13
      Caption = '&Functions:'
      FocusControl = clbFuncs
    end
    object clbFuncs: TCheckListBox
      Left = 16
      Top = 32
      Width = 129
      Height = 307
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
      OnClick = clbFuncsClick
    end
  end
  object chartResults: TChart
    Left = 157
    Top = 130
    Width = 556
    Height = 357
    Legend.Inverted = True
    Title.Text.Strings = (
      'TChart')
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    Color = 14869218
    TabOrder = 3
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series4: THorizBarSeries
      BarBrush.Gradient.Direction = gdLeftRight
      Marks.Visible = False
      SeriesColor = 16756912
      Title = 'Complex Math387'
      Gradient.Direction = gdLeftRight
      XValues.Name = 'Bar'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loAscending
    end
    object Series3: THorizBarSeries
      BarBrush.Gradient.Direction = gdLeftRight
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Sample Math387'
      Gradient.Direction = gdLeftRight
      XValues.Name = 'Bar'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loAscending
    end
    object Series2: THorizBarSeries
      BarBrush.Gradient.Direction = gdLeftRight
      Marks.Visible = False
      SeriesColor = 11579647
      Title = 'Complex MtxVec'
      Gradient.Direction = gdLeftRight
      XValues.Name = 'Bar'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loAscending
    end
    object Series1: THorizBarSeries
      BarBrush.Gradient.Direction = gdLeftRight
      Marks.Visible = False
      Title = 'Sample MtxVec'
      Gradient.Direction = gdLeftRight
      XValues.Name = 'Bar'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loAscending
    end
  end
  object PopupMenu: TPopupMenu
    Left = 60
    Top = 64
    object miSelectAllFuncs: TMenuItem
      Caption = '&Select all funcs'
      OnClick = miSelectAllFuncsClick
    end
    object miUnselectAllFuncs: TMenuItem
      Caption = '&Unselect all funcs'
      OnClick = miUnselectAllFuncsClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Loading results'
    Left = 100
    Top = 64
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Saving results'
    Left = 132
    Top = 64
  end
  object ChartMenu: TPopupMenu
    Left = 196
    Top = 71
    object LoadFromFileItem: TMenuItem
      Caption = 'Load from file...'
      OnClick = LoadFromFileItemClick
    end
    object SaveToFileItem: TMenuItem
      Caption = 'Save to file...'
      OnClick = SaveToFileItemClick
    end
  end
end
