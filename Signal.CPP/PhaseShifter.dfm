object PhaseShifterForm: TPhaseShifterForm
  Left = 0
  Top = 0
  Caption = 'PhaseShifterForm'
  ClientHeight = 448
  ClientWidth = 656
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
    Top = 409
    Width = 656
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object FirLengthLabel: TLabel
      Left = 536
      Top = 12
      Width = 54
      Height = 13
      Caption = 'FIR length:'
    end
    object Label1: TLabel
      Left = 210
      Top = 15
      Width = 70
      Height = 13
      Caption = 'Transition BW:'
    end
    object Label2: TLabel
      Left = 356
      Top = 15
      Width = 28
      Height = 13
      Caption = 'Filter:'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 195
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 88
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object SpectrumEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = '      Spectrum      '
        ImageIndex = 0
        OnClick = SpectrumEditButtonClick
      end
      object ChartEditButton: TToolButton
        Left = 88
        Top = 0
        AllowAllUp = True
        Caption = 'Chart'
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
    end
    object TransBWEdit: TMtxFloatEdit
      Left = 284
      Top = 9
      Width = 53
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = True
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.001'
      MaxValue = '0.5'
      MinValue = '0'
      TabOrder = 1
      Value = '0.05'
      OnChange = TransBWEditChange
    end
    object DiffBox: TComboBox
      Left = 390
      Top = 9
      Width = 141
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = TransBWEditChange
      Items.Strings = (
        'Hilbert type III (window)'
        'Hilbert type IV (window)'
        'Hilbert type III (remez)'
        'Hilbert type IV (remez)')
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 656
    Height = 76
    Align = alTop
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object SpectrumChart: TSpectrumChart
    Left = 0
    Top = 76
    Width = 656
    Height = 333
    Gradient.EndColor = 12615680
    Legend.Brush.Gradient.StartColor = 12615680
    Legend.CheckBoxes = True
    Legend.Visible = False
    Title.Font.Color = clWhite
    Title.Text.Strings = (
      'Frequency response of optimal FIR filter')
    BottomAxis.LabelsSeparation = 0
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    LeftAxis.AxisValuesFormat = '#,##0.00###'
    LeftAxis.Title.Caption = 'Amplitude'
    Zoom.Pen.Color = clBlack
    Align = alClient
    Color = 12636883
    TabOrder = 2
    Spectrums = <
      item
        InputsItemIndex = 0
        Input = SpectrumAnalyzer
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TTeeCanvas3D'
    ColorPaletteIndex = 0
    object Series1: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      SeriesColor = 10485760
      Title = 'Response'
      LinePen.Color = 10485760
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      Title = 'Error'
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TPointSeries
      Marks.Arrow.Visible = False
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = False
      Marks.Callout.Length = 10
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = True
      ShowInLegend = False
      Title = 'Marks'
      ClickableLine = False
      Pointer.Brush.Color = clRed
      Pointer.Brush.Gradient.EndColor = clGreen
      Pointer.Gradient.EndColor = clGreen
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
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
      MarkSeries = Series3
      DoubleClickClear = True
      Series = Series1
      PeakFilterMode = False
      MarkMode = mmFreeStyle
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
  object SpectrumAnalyzer: TSpectrumAnalyzer
    OnParameterUpdate = SpectrumAnalyzerParameterUpdate
    PhaseRange = prPiPi
    SamplingFrequency = 1.000000000000000000
    SamplingTime = 128.000000000000000000
    HzRes = 0.007812500000000000
    Dt = 1.000000000000000000
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
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    ExpWindow = 0.010000000000000000
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
