object DifferentiatorForm: TDifferentiatorForm
  Left = 369
  Top = 176
  Caption = 'Differentiator'
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
    Top = 76
    Width = 688
    Height = 244
    Gradient.EndColor = 12615680
    Legend.Brush.Gradient.StartColor = 12615680
    Legend.CheckBoxes = True
    Legend.Visible = False
    Title.Font.Color = clWhite
    Title.Text.Strings = (
      'Frequency response of optimal FIR filter')
    BottomAxis.LabelsSeparation = 20
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
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
    LeftAxis.AxisValuesFormat = '#,##0.00###'
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 712.500000000000000000
    LeftAxis.Minimum = 155.000000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    LeftAxis.Title.Caption = 'Amplitude'
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
    Color = 12636883
    TabOrder = 0
    Spectrums = <
      item
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Input = SpectrumAnalyzer
      end>
    ConfidenceIntervalIndex = 0
    ConfidenceIntervalVisible = False
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TFastLineSeries
      SeriesColor = 10485760
      Title = 'Response'
      LinePen.Color = 10485760
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      Title = 'Error'
      LinePen.Color = clRed
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
      CursorActive = False
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
    Top = 320
    Width = 688
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object FirLengthLabel: TLabel
      Left = 540
      Top = 12
      Width = 52
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
      Left = 342
      Top = 15
      Width = 25
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
      MaxValue = '0'
      MinValue = '0'
      TabOrder = 1
      Value = '0.05'
      OnChange = TransBWEditChange
    end
    object DiffBox: TComboBox
      Left = 372
      Top = 9
      Width = 161
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = TransBWEditChange
      Items.Strings = (
        'Differentiate type III (window)'
        'Differentiate type IV (window)'
        'Differentiate type III (remez)'
        'Differentiate type IV (remez)'
        'Differentiate twice type III (remez)'
        'Differentiate twice type IV (remez)'
        'Integrate type III (remez)'
        'Integrate type IV (remez)'
        'Integrate twice type III (remez)'
        'Integrate twice type IV (remez)'
        'Differentiate in frequency 1x'
        'Differentiate in frequency 2x'
        'Integrate in frequency 1x'
        'Integrate in frequency 2x')
    end
    object PhaseBox: TCheckBox
      Left = 630
      Top = 12
      Width = 55
      Height = 17
      Caption = 'Phase'
      TabOrder = 3
      OnClick = PhaseBoxClick
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 688
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
    TabOrder = 2
  end
  object SpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
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
    Peaks.Interpolation.RecursiveHarmonics = rhNone
    Peaks.LargestRatio = 1000000000000000.000000000000000000
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
  object ChartEditor: TChartEditor
    Chart = SpectrumChart
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 424
    Top = 159
  end
end
