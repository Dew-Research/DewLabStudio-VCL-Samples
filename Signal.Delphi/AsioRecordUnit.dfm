object AsioRecordForm: TAsioRecordForm
  Left = 0
  Top = 0
  Caption = 'AsioRecordForm'
  ClientHeight = 587
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 232
    Width = 771
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 259
  end
  object TopChart: TSignalChart
    Left = 0
    Top = 0
    Width = 771
    Height = 232
    Legend.Visible = False
    Title.Text.Strings = (
      'Channel 0')
    BottomAxis.AxisValuesFormat = '#,##0.00##'
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.EndPosition = 100.000000000000000000
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
    LeftAxis.Maximum = 204.625000000000000000
    LeftAxis.Minimum = -7.125000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Animated = True
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alTop
    TabOrder = 0
    Signals = <
      item
        SeriesName = 'Series3'
        Series = Series3
        InputsItemIndex = 0
        UnitScaleXAxis = 1.000000000000000000
        Inputs = SignalList
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series3: TFastLineSeries
      HoverElement = []
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object ChartTool1: TAxisScaleTool
      UpperMargin = 5
      LowerMargin = 5
      AxisScaleMode = amPeakHold
      DataIsSpectrum = False
      AxisID = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 417
    Width = 771
    Height = 170
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 34
      Height = 13
      Caption = 'Drivers'
    end
    object Label1: TLabel
      Left = 175
      Top = 7
      Width = 92
      Height = 13
      Caption = 'Supported FS [Hz]:'
    end
    object Label3: TLabel
      Left = 315
      Top = 7
      Width = 83
      Height = 13
      Caption = 'Output channels:'
    end
    object Label4: TLabel
      Left = 487
      Top = 7
      Width = 75
      Height = 13
      Caption = 'Input channels:'
    end
    object StatusLabel: TLabel
      Left = 8
      Top = 149
      Width = 31
      Height = 13
      Caption = 'Status'
    end
    object Label5: TLabel
      Left = 351
      Top = 126
      Width = 132
      Height = 13
      Caption = 'Recording to: '#39'C:\Test.wav'#39
    end
    object DriverNameListBox: TListBox
      Left = 8
      Top = 26
      Width = 161
      Height = 83
      ItemHeight = 13
      TabOrder = 0
      OnClick = DriverNameListBoxClick
    end
    object FSListBox: TListBox
      Left = 175
      Top = 26
      Width = 96
      Height = 84
      ItemHeight = 13
      TabOrder = 1
    end
    object OutputChBox: TListBox
      Left = 315
      Top = 26
      Width = 166
      Height = 84
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 2
    end
    object InputChBox: TListBox
      Left = 487
      Top = 26
      Width = 163
      Height = 84
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 3
    end
    object StartButton: TButton
      Left = 8
      Top = 118
      Width = 102
      Height = 25
      Caption = 'Start'
      TabOrder = 4
      OnClick = StartButtonClick
    end
    object StopButton: TButton
      Left = 116
      Top = 119
      Width = 102
      Height = 25
      Caption = 'Stop'
      TabOrder = 5
      OnClick = StopButtonClick
    end
    object Button1: TButton
      Left = 224
      Top = 120
      Width = 102
      Height = 25
      Caption = 'Control panel'
      TabOrder = 6
      OnClick = Button1Click
    end
  end
  object BottomChart: TSignalChart
    Left = 0
    Top = 235
    Width = 771
    Height = 182
    Legend.Visible = False
    Title.Text.Strings = (
      'Channel 1')
    BottomAxis.AxisValuesFormat = '#,##0.00##'
    BottomAxis.LogarithmicBase = 10.000000000000000000
    BottomAxis.Maximum = 24.000000000000000000
    BottomAxis.MaximumOffset = 1
    BottomAxis.MinimumOffset = 1
    BottomAxis.EndPosition = 100.000000000000000000
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.AxisValuesFormat = '#,##0.00##'
    DepthAxis.LogarithmicBase = 10.000000000000000000
    DepthAxis.Maximum = 3.799999999999990000
    DepthAxis.Minimum = 2.799999999999993000
    DepthAxis.EndPosition = 100.000000000000000000
    DepthTopAxis.Automatic = False
    DepthTopAxis.AutomaticMaximum = False
    DepthTopAxis.AutomaticMinimum = False
    DepthTopAxis.LogarithmicBase = 10.000000000000000000
    DepthTopAxis.Maximum = 3.799999999999990000
    DepthTopAxis.Minimum = 2.799999999999993000
    DepthTopAxis.EndPosition = 100.000000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.LogarithmicBase = 10.000000000000000000
    LeftAxis.Maximum = 760.250000000000000000
    LeftAxis.Minimum = -15.250000000000000000
    LeftAxis.EndPosition = 100.000000000000000000
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Grid.ZPosition = 100.000000000000000000
    RightAxis.LogarithmicBase = 10.000000000000000000
    RightAxis.EndPosition = 100.000000000000000000
    RightAxis.ZPosition = 100.000000000000000000
    TopAxis.Grid.ZPosition = 100.000000000000000000
    TopAxis.LogarithmicBase = 10.000000000000000000
    TopAxis.EndPosition = 100.000000000000000000
    TopAxis.ZPosition = 100.000000000000000000
    Zoom.Animated = True
    Zoom.Pen.Color = clBlack
    Zoom.Pen.Mode = pmNotXor
    Align = alClient
    TabOrder = 2
    Signals = <
      item
        SeriesName = 'Series2'
        Series = Series2
        InputsItemIndex = 1
        UnitScaleXAxis = 1.000000000000000000
        Inputs = SignalList
      end>
    ComplexSignalPart = cspReal
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 0
    object Series2: TMtxFastLineSeries
      HoverElement = []
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object ChartTool2: TAxisScaleTool
      UpperMargin = 5
      LowerMargin = 5
      AxisScaleMode = amPeakHold
      DataIsSpectrum = False
      AxisID = 2
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = TimerTimer
    Left = 321
    Top = 150
  end
  object SignalList: TSignalList
    PropagateTemplate = False
    Count = 2
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    Left = 378
    Top = 153
    MtxDataValues = {
      07000000545369676E616C5450463007545369676E616C00084973446F75626C
      65080E466C6F6174507265636973696F6E07086D7653696E676C651153616D70
      6C696E674672657175656E6379050000000000000080FF3F0D4D747844617461
      56616C7565730A00000000000007000000545369676E616C5450463007545369
      676E616C00084973446F75626C65080E466C6F6174507265636973696F6E0708
      6D7653696E676C651153616D706C696E674672657175656E6379050000000000
      000080FF3F0D4D74784461746156616C7565730A000000000000}
  end
  object ChartEditor1: TChartEditor
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    Left = 597
    Top = 162
  end
  object SignalMux: TSignalMux
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    Inputs = <
      item
      end>
    InputList = SignalAsio
    Left = 447
    Top = 87
    MtxDataValues = {}
  end
  object SignalWrite1: TSignalWrite
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    AuthorInfo = 'Unknown'
    Input = SignalMux
    Left = 513
    Top = 87
    MtxDataValues = {}
  end
  object SignalRead: TSignalRead
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 91
    Top = 92
    MtxDataValues = {}
  end
  object SignalDemuxList: TSignalDemuxList
    PropagateTemplate = False
    Count = 0
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    Input = SignalRead
    Left = 176
    Top = 92
    MtxDataValues = {}
  end
  object SignalRateConverterList: TSignalRateConverterList
    PropagateTemplate = False
    Count = 0
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    OnBeforeUpdate = SignalRateConverterListBeforeUpdate
    Inputs = SignalDemuxList
    Left = 288
    Top = 88
    MtxDataValues = {}
  end
  object SignalAsio: TSignalAsio
    PropagateTemplate = False
    Count = 0
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    Inputs = SignalRateConverterList
    SamplingFrequency = 48000.000000000000000000
    OnProcessRealTime = SignalAsioProcessRealTime
    OnInputBufferReady = SignalAsioInputBufferReady
    OnStop = SignalAsioStop
    Left = 384
    Top = 88
    MtxDataValues = {}
  end
  object OpenDialog: TOpenDialog
    Filter = 'Uncompressed WAV files.|*.wav'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Select uncompressed wav file to open'
    Left = 384
    Top = 255
  end
  object SaveDialog: TSaveDialog
    Filter = 'Uncompressed WAV files.|*.wav'
    Title = 'Select wav file name to save to'
    Left = 536
    Top = 299
  end
end
