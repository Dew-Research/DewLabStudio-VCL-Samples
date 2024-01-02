inherited BenchmarkXForm: TBenchmarkXForm
  Top = 128
  Caption = 'BenchmarkXForm'
  ClientHeight = 540
  ClientWidth = 759
  OldCreateOrder = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 775
  ExplicitHeight = 579
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 759
    ExplicitWidth = 759
    inherited RichEdit1: TRichEdit
      Width = 757
      ExplicitWidth = 757
    end
  end
  inherited Panel2: TPanel
    Top = 482
    Width = 759
    Alignment = taLeftJustify
    ExplicitTop = 482
    ExplicitWidth = 759
    object Label1: TLabel
      Left = 257
      Top = 21
      Width = 68
      Height = 13
      Anchors = []
      Caption = '&Vector length:'
      FocusControl = cbVectorLength
    end
    object Label2: TLabel
      Left = 443
      Top = 24
      Width = 98
      Height = 13
      Anchors = []
      Caption = '&Iterations (DblClick):'
      FocusControl = cbIterationCount
    end
    object btnRun: TButton
      Left = 23
      Top = 18
      Width = 96
      Height = 25
      Anchors = []
      Caption = '&Run'
      TabOrder = 0
      OnClick = btnRunClick
    end
    object btnOpen: TButton
      Left = 125
      Top = 18
      Width = 96
      Height = 25
      Anchors = []
      Caption = '&Open'
      TabOrder = 1
      OnClick = btnOpenClick
    end
    object cbVectorLength: TComboBox
      Left = 329
      Top = 19
      Width = 96
      Height = 21
      Anchors = []
      TabOrder = 2
      Text = '1000'
    end
    object cbIterationCount: TComboBox
      Left = 544
      Top = 19
      Width = 98
      Height = 21
      Anchors = []
      TabOrder = 3
      Text = '300'
      OnDblClick = cbIterationCountDblClick
    end
  end
  inherited Panel3: TPanel
    Width = 759
    Height = 352
    ExplicitWidth = 759
    ExplicitHeight = 352
    object chartResults: TChart
      Left = 175
      Top = 1
      Width = 583
      Height = 350
      Legend.Inverted = True
      Title.Text.Strings = (
        'Comparison')
      BottomAxis.AxisValuesFormat = '#,##0.###ms'
      LeftAxis.MaximumOffset = 24
      LeftAxis.MinimumOffset = 24
      View3D = False
      Align = alClient
      Color = 14869218
      PopupMenu = ChartMenu
      TabOrder = 0
      ColorPaletteIndex = 13
      object Series4: THorizBarSeries
        BarBrush.Gradient.Direction = gdLeftRight
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = 16756912
        Title = 'Complex Math387'
        Gradient.Direction = gdLeftRight
        XValues.Name = 'Bar'
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series3: THorizBarSeries
        BarBrush.Gradient.Direction = gdLeftRight
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = clBlue
        Title = 'Sample Math387'
        Gradient.Direction = gdLeftRight
        XValues.Name = 'Bar'
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: THorizBarSeries
        BarBrush.Gradient.Direction = gdLeftRight
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = 11579647
        Title = 'Complex MtxVec'
        Gradient.Direction = gdLeftRight
        XValues.Name = 'Bar'
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series1: THorizBarSeries
        BarBrush.Gradient.Direction = gdLeftRight
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        Title = 'Sample MtxVec'
        Gradient.Direction = gdLeftRight
        XValues.Name = 'Bar'
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 174
      Height = 350
      Align = alLeft
      Color = 14869218
      TabOrder = 1
      DesignSize = (
        174
        350)
      object Label3: TLabel
        Left = 16
        Top = 8
        Width = 50
        Height = 13
        Caption = '&Functions:'
        FocusControl = clbFuncs
      end
      object clbFuncs: TCheckListBox
        Left = 16
        Top = 27
        Width = 133
        Height = 299
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        PopupMenu = PopupMenu
        TabOrder = 0
        OnDblClick = clbFuncsDblClick
      end
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
    Left = 212
    Top = 88
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Saving results'
    Left = 157
    Top = 55
  end
  object ChartMenu: TPopupMenu
    Left = 279
    Top = 91
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
