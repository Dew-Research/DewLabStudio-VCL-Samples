object BiSpectrumGridForm: TBiSpectrumGridForm
  Left = 0
  Top = 0
  Caption = 'BiSpectrumGridForm'
  ClientHeight = 445
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
    Top = 406
    Width = 621
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object ProgressLabel: TLabel
      Left = 307
      Top = 12
      Width = 77
      Height = 13
      Caption = 'Progress: 0 [%]'
    end
    object ToolBar1: TToolBar
      Left = 10
      Top = 9
      Width = 285
      Height = 25
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 62
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object ChartEditButton: TToolButton
        Left = 0
        Top = 0
        AllowAllUp = True
        Caption = 'Chart'
        ImageIndex = 1
        OnClick = ChartEditButtonClick
      end
      object Button1: TToolButton
        Left = 62
        Top = 0
        Caption = 'Recalculate'
        ImageIndex = 2
        OnClick = Button1Click
      end
    end
    object SingleLinesOnlyBox: TCheckBox
      Left = 193
      Top = 12
      Width = 97
      Height = 17
      Caption = 'Only a few lines'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = SingleLinesOnlyBoxClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 621
    Height = 330
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
    object Chart1: TChart
      Left = 0
      Top = 0
      Width = 617
      Height = 326
      Gradient.EndColor = clWhite
      Gradient.StartColor = 12615680
      Title.Text.Strings = (
        'Bicoherence')
      BottomAxis.Title.Caption = 'Frequency [Hz]'
      Chart3DPercent = 80
      DepthAxis.Title.Caption = 'Frequency [Hz]'
      DepthAxis.Visible = True
      LeftAxis.Title.Caption = 'Frequency [Hz]'
      View3D = False
      View3DOptions.OrthoAngle = 60
      Align = alClient
      BevelOuter = bvNone
      Color = 12636883
      TabOrder = 0
      DefaultCanvas = 'TTeeCanvas3D'
      ColorPaletteIndex = 0
      object Series1: TMtxGridSeries
        XStep = 1.000000000000000000
        YStep = 1.000000000000000000
        PixelResample = False
        PixelResampleMethod = pdsPattern
        LegendItemsCount = 11
        ColorPalette.TopColor = clWhite
        ColorPalette.BottomColor = clNavy
        ColorPalette.ColorBalance = -0.500000000000000000
        ColorPalette.SharpContrast = False
        ColorPalette.TopClipOffColor = clNone
        ColorPalette.BottomClipOffColor = clNone
        ColorPalette.UseMidColor = False
      end
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 621
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
  object BiSpectrumAnalyzer: TBiSpectrumAnalyzer
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
    SidelobeAtt = 40.000000000000000000
    Window = wtHanning
    BiAnalyzer.Recursive = False
    BiAnalyzer.Transform = hoBicoherence
    BiAnalyzer.Lines.DataValues = {
      0000000000000000000000000000803F000000000000D2430000004100000000
      00137A47000000000000000000000000}
    Left = 421
    Top = 129
    MtxDataValues = {}
  end
  object ChartEditor: TChartEditor
    Chart = Chart1
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 421
    Top = 165
  end
  object SignalRead1: TSignalRead
    Length = 2048
    SamplingFrequency = 4666.666666666669000000
    FileFormat = ffSfs
    FileName = 'D:\CommonObjects\SignalProcessing\Demo\BZ.SFS'
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 379
    Top = 129
    MtxDataValues = {}
  end
end
