object CoherenceTest2Form: TCoherenceTest2Form
  Left = 330
  Top = 281
  Caption = 'Cross-spectrum analyzer'
  ClientHeight = 359
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 0
    Width = 688
    Height = 299
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    Legend.Visible = False
    Title.Text.Strings = (
      'Frequency spectrum')
    BottomAxis.LabelsSeparation = 0
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.EndPosition = 100.000000000000000000
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 625.010000000000100000
    LeftAxis.Minimum = -25.833750000000010000
    LeftAxis.EndPosition = 100.000000000000000000
    LeftAxis.Title.Caption = 'Amplitude [dB]'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    TabOrder = 0
    Spectrums = <
      item
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = CrossAnalyzer
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series1: TFastLineSeries
      HoverElement = []
      SeriesColor = 10485760
      LinePen.Color = 10485760
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TPointSeries
      HoverElement = [heCurrent]
      Marks.Transparent = True
      Marks.Visible = True
      Marks.Arrow.Visible = False
      Marks.Callout.Arrow.Visible = False
      Marks.Callout.Length = 10
      SeriesColor = clGreen
      ClickableLine = False
      Pointer.Brush.Color = clRed
      Pointer.Brush.Gradient.EndColor = clGreen
      Pointer.Gradient.EndColor = clGreen
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object ChartTool1: TAxisScaleTool
      UpperMargin = 20
      LowerMargin = 5
      AxisScaleMode = amAuto
      DataIsSpectrum = True
      AxisID = 2
    end
    object ChartTool2: TSpectrumMarkTool
      CursorActive = True
      MarkSeries = Series2
      DoubleClickClear = True
      Series = Series1
      PeakFilterMode = False
      MarkMode = mmSingle
      MarkType = mtAmplt
      AmpltFormat = '0.00#'
      PhaseFormat = '0.00#'
      FreqFormat = '0.00#'
      LabelHeaders = True
      PeakZoomBand = False
      ConfLabels = cnfNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 299
    Width = 688
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 106
      Top = 42
      Width = 43
      Height = 13
      Caption = 'Samples:'
    end
    object ProgressLabel: TLabel
      Left = 267
      Top = 42
      Width = 70
      Height = 13
      Caption = 'Progress: 0 [%]'
    end
    object ToolBar1: TToolBar
      Left = 8
      Top = 9
      Width = 395
      Height = 25
      Align = alNone
      ButtonHeight = 29
      ButtonWidth = 89
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '         Chart        '
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
      object EditSpectrumButton: TToolButton
        Left = 89
        Top = 0
        Caption = 'Spectrum'
        ImageIndex = 2
        OnClick = EditSpectrumButtonClick
      end
      object UpdateButton: TToolButton
        Left = 178
        Top = 0
        Caption = 'Process all'
        ImageIndex = 3
        OnClick = UpdateButtonClick
      end
      object FirstFileButton: TToolButton
        Left = 267
        Top = 0
        Caption = 'Options'
        DropdownMenu = PopupMenu1
        ImageIndex = 4
        PopupMenu = PopupMenu1
        Style = tbsDropDown
      end
    end
    object PhaseBox: TCheckBox
      Left = 20
      Top = 39
      Width = 75
      Height = 17
      Caption = 'Phase'
      TabOrder = 1
      OnClick = PhaseBoxClick
    end
    object SamplesBox: TComboBox
      Left = 161
      Top = 36
      Width = 93
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = SamplesBoxChange
      Items.Strings = (
        '16'
        '32'
        '64'
        '128'
        '256'
        '512'
        '1024'
        '2048'
        '4096'
        '8192'
        '16384'
        '32768')
    end
  end
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
  object SignalRead1: TSignalRead
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 2048
    SamplingFrequency = 4666.666666666669000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 356
    Top = 102
    MtxDataValues = {}
  end
  object CrossAnalyzer: TCrossSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
    OnParameterUpdate = CrossAnalyzerParameterUpdate
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 16.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 8
    Report.ReportItems.GeneralInfo = False
    Report.ReportItems.MarkedPeaks = False
    Report.ReportItems.FrequencyLines = False
    Report.ReportItems.Phase = False
    Report.ReportItems.THD = False
    Report.ReportItems.THDN = False
    Report.ReportItems.NF = False
    Report.ReportItems.SFDR = False
    Report.ReportItems.BandsRMS = False
    Report.ReportItems.SINAD = False
    Report.ReportItems.RMS = False
    Report.ReportItems.SNR = False
    Report.ReportItems.DateTime = False
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    ScaleFactor = 1.000000000000000000
    Input = SignalRead1
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    Stats.Averaging = avLinearInf
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    UnwrapPhase = True
    SidelobeAtt = 40.000000000000000000
    Window = wtHanning
    Left = 422
    Top = 120
    MtxDataValues = {}
  end
  object CrossSpectrumAnalyzerDialog: TCrossSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = CrossAnalyzer
    SourceListIndex = 0
    Left = 420
    Top = 87
    MtxDataValues = {}
  end
  object OpenDialog: TOpenDialog
    Left = 273
    Top = 252
  end
  object SignalRead2: TSignalRead
    IsDouble = False
    FloatPrecision = mvSingle
    Length = 2048
    SamplingFrequency = 4666.666666666669000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 359
    Top = 150
    MtxDataValues = {}
  end
  object PopupMenu1: TPopupMenu
    Left = 465
    Top = 204
    object Openfile1: TMenuItem
      Caption = 'Open file 1...'
      OnClick = Openfile1Click
    end
    object OpenFile2: TMenuItem
      Caption = 'Open file 2...'
      OnClick = OpenFile2Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Copychart: TMenuItem
      Caption = 'Copy chart'
      OnClick = CopychartClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Saveconfiguration: TMenuItem
      Caption = 'Save configuration'
      OnClick = SaveconfigurationClick
    end
    object Loadconfiguration: TMenuItem
      Caption = 'Load configuration'
      OnClick = LoadconfigurationClick
    end
  end
  object SaveDialog: TSaveDialog
    Left = 348
    Top = 252
  end
end
