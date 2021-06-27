object SpcAnalyzerForm: TSpcAnalyzerForm
  Left = 0
  Top = 0
  Caption = 'SpcAnalyzerForm'
  ClientHeight = 490
  ClientWidth = 621
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 454
    Width = 621
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 257
      Height = 25
      Align = alNone
      ButtonHeight = 29
      ButtonWidth = 91
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object SpectrumEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '        Edit            '
        DropdownMenu = PopupMenu2
        ImageIndex = 0
        Style = tbsDropDown
      end
      object ToolButton1: TToolButton
        Left = 106
        Top = 0
        Caption = 'Options'
        DropdownMenu = PopupMenu1
        ImageIndex = 2
        Style = tbsDropDown
      end
    end
    object PhaseBox: TCheckBox
      Left = 285
      Top = 15
      Width = 73
      Height = 17
      Caption = 'Phase'
      TabOrder = 1
      OnClick = PhaseBoxClick
    end
  end
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 0
    Width = 621
    Height = 454
    Gradient.Direction = gdFromBottomLeft
    Gradient.EndColor = clWhite
    Gradient.StartColor = 12615680
    Legend.Visible = False
    Title.Text.Strings = (
      'Frequency spectrum')
    BottomAxis.LabelsSeparation = 0
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    TabOrder = 1
    Spectrums = <
      item
        SeriesName = 'Series1'
        Series = Series1
        InputsItemIndex = 0
        Input = SpectrumAnalyzer
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series1: TFastLineSeries
      Marks.Visible = False
      SeriesColor = 10485760
      LinePen.Color = 10485760
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TPointSeries
      Marks.Transparent = True
      Marks.Visible = True
      Marks.Arrow.Visible = False
      Marks.Callout.Arrow.Visible = False
      Marks.Callout.Length = 10
      SeriesColor = clGreen
      ClickableLine = False
      Pointer.Brush.Color = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
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
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
  object OpenDialog: TOpenDialog
    Left = 216
    Top = 198
  end
  object PopupMenu1: TPopupMenu
    Left = 324
    Top = 162
    object Openfile1: TMenuItem
      Caption = 'Open file...'
      OnClick = Openfile1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Copychart1: TMenuItem
      Caption = 'Copy chart'
      OnClick = Copychart1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Saveconfiguration1: TMenuItem
      Caption = 'Save configuration...'
      OnClick = Saveconfiguration1Click
    end
    object Loadconfiguration1: TMenuItem
      Caption = 'Load configuration...'
      OnClick = Loadconfiguration1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 268
    Top = 162
    object Spectrum1: TMenuItem
      Caption = 'Spectrum...'
      OnClick = Spectrum1Click
    end
    object Chart1: TMenuItem
      Caption = 'Chart...'
      OnClick = Chart1Click
    end
    object File1: TMenuItem
      Caption = 'File position...'
      OnClick = File1Click
    end
  end
  object SaveDialog: TSaveDialog
    Left = 255
    Top = 198
  end
  object SignalDemux1: TSignalDemux
    SamplingFrequency = 1.000000000000000000
    Input = SignalRead1
    Left = 384
    Top = 117
    MtxDataValues = {}
  end
  object SignalRead1: TSignalRead
    Continuous = False
    OnParameterUpdate = SignalRead1ParameterUpdate
    Length = 1024
    SamplingFrequency = 1.000000000000000000
    FileFormat = ffSfs
    FileName = 'BZ.SFS'
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    OnProcessAll = SignalRead1ProcessAll
    ForceLength = True
    PostBufferSamples = 0
    Left = 344
    Top = 117
    MtxDataValues = {}
  end
  object SignalReadDialog1: TSignalReadDialog
    StoreInRegistry = True
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SignalRead1
    SourceListIndex = 0
    Left = 341
    Top = 78
    MtxDataValues = {}
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    OnParameterUpdate = SpectrumAnalyzerParameterUpdate
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 8.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
    ZeroPadding = 16
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
    Input = SignalDemux1
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
    UnwrapPhase = True
    SidelobeAtt = 40.000000000000000000
    Window = wtHanning
    Left = 422
    Top = 117
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 422
    Top = 84
    MtxDataValues = {}
  end
end
