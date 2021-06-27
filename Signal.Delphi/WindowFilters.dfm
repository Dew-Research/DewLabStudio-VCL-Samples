object WindowFiltersForm: TWindowFiltersForm
  Left = 294
  Top = 184
  Caption = 'Low pass filter designed with windows'
  ClientHeight = 357
  ClientWidth = 680
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
    Width = 680
    Height = 242
    Gradient.Direction = gdFromTopLeft
    Gradient.EndColor = 12615680
    Legend.CheckBoxes = True
    Legend.Visible = False
    Title.Text.Strings = (
      'Frequency response')
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.MinorTicks.Visible = False
    BottomAxis.Title.Caption = 'Frequency [Hz]'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 0.500000000000000000
    DepthAxis.Minimum = -0.500000000000000000
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 0.500000000000000000
    DepthTopAxis.Minimum = -0.500000000000000000
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Title.Caption = 'Amplitude [dB]'
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Brush.Gradient.Direction = gdFromTopLeft
    Zoom.Brush.Gradient.EndColor = clSilver
    Zoom.Brush.Gradient.MidColor = clWhite
    Zoom.Brush.Gradient.StartColor = clSilver
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
    ColorPaletteIndex = 0
    object ChartTool1: TAxisScaleTool
      UpperMargin = 20
      LowerMargin = 5
      AxisScaleMode = amNone
      DataIsSpectrum = True
      AxisID = 2
    end
    object ChartTool2: TSpectrumMarkTool
      CursorActive = True
      DoubleClickClear = True
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
    Top = 318
    Width = 680
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 230
      Top = 15
      Width = 52
      Height = 13
      Caption = 'Cutoff freq:'
    end
    object Label2: TLabel
      Left = 360
      Top = 12
      Width = 79
      Height = 13
      Caption = 'Attenuation [dB]:'
    end
    object Label3: TLabel
      Left = 500
      Top = 12
      Width = 54
      Height = 13
      Caption = 'Filter length'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 217
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
    object FreqEdit: TMtxFloatEdit
      Left = 288
      Top = 9
      Width = 59
      Height = 22
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = False
      Scientific = False
      ReFormat = '0.00#;-0.00#'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '0.02'
      MaxValue = '1'
      MinValue = '0'
      TabOrder = 1
      Value = '0.20'
      OnChange = FreqEditChange
    end
    object TransEdit: TMtxFloatEdit
      Left = 444
      Top = 9
      Width = 47
      Height = 22
      Hint = 'Applies only to Kaiser and Chebyshev'
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '200'
      MinValue = '13'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = '40'
      OnChange = FreqEditChange
    end
    object FilterLengthEdit: TMtxFloatEdit
      Left = 562
      Top = 9
      Width = 49
      Height = 22
      Hint = 'Applies only to Kaiser and Chebyshev'
      RegistryPath = '\Software\DewResearch\MtxVec'
      StoreInRegistry = False
      IntegerIncrement = True
      Scientific = False
      ReFormat = '0'
      ImFormat = '+0.00#i;-0.00#i'
      Increment = '1'
      MaxValue = '5000'
      MinValue = '4'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      Value = '128'
      OnChange = FreqEditChange
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 680
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
    IsDouble = True
    FloatPrecision = mvDouble
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
    Peaks.Interpolation.RecursiveHarmonics = rhNone
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    Logarithmic = True
    ScaleFactor = 1.000000000000000000
    Stats.CalcMinMax = False
    Stats.CalcLimits = False
    Stats.ConfidenceInterval = 99.000000000000000000
    CZT.StopFrequency = 0.500000000000000000
    CZT.FrequencyStep = 0.007812500000000000
    CZT.StartRadius = 1.000000000000000000
    CZT.StopRadius = 1.000000000000000000
    DCDump = False
    ExpWindow = 0.010000000000000000
    SidelobeAtt = 40.000000000000000000
    Left = 422
    Top = 117
    MtxDataValues = {}
  end
  object SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog
    ShowLive = True
    RegistryPath = '\Software\DewResearch\MtxVec'
    Source = SpectrumAnalyzer
    SourceListIndex = 0
    Left = 422
    Top = 78
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
  object TeeGDIPlus1: TTeeGDIPlus
    Active = True
    Antialias = False
    AntiAliasText = gpfNormal
    TeePanel = SpectrumChart
    Left = 472
    Top = 236
  end
end
