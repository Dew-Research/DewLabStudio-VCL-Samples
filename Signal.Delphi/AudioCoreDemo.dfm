object AudioCoreDemoForm: TAudioCoreDemoForm
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  Caption = 'AudioCoreDemoForm'
  ClientHeight = 714
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 966
    Height = 542
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 181
      Width = 964
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 251
      ExplicitWidth = 132
    end
    object SignalChart: TSignalChart
      Left = 1
      Top = 184
      Width = 964
      Height = 357
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      Legend.Visible = False
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TSignalChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 905.000000000000000000
      LeftAxis.Minimum = 137.500000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TopAxis.ZPosition = 100.000000000000000000
      Align = alClient
      TabOrder = 0
      Signals = <
        item
          InputsItemIndex = 0
          UnitScaleXAxis = 1.000000000000000000
        end>
      ComplexSignalPart = cspReal
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: TMtxFastLineSeries
        HoverElement = []
        LinePen.Color = 10708548
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object ChartTool1: TAxisScaleTool
        UpperMargin = 10
        LowerMargin = 10
        AxisScaleMode = amPeakHold
        DataIsSpectrum = False
        AxisID = 2
      end
    end
    object SpectrumChart: TSpectrumChart
      Left = 1
      Top = 1
      Width = 964
      Height = 180
      BackWall.Brush.Gradient.Direction = gdBottomTop
      BackWall.Brush.Gradient.EndColor = clWhite
      BackWall.Brush.Gradient.StartColor = 15395562
      BackWall.Brush.Gradient.Visible = True
      BackWall.Transparent = False
      Foot.Font.Color = clBlue
      Foot.Font.Name = 'Verdana'
      Gradient.Direction = gdBottomTop
      Gradient.EndColor = clWhite
      Gradient.MidColor = 15395562
      Gradient.StartColor = 15395562
      Gradient.Visible = True
      LeftWall.Color = 14745599
      Legend.Font.Name = 'Verdana'
      Legend.Shadow.Transparency = 0
      Legend.Visible = False
      RightWall.Color = 14745599
      Title.Font.Name = 'Verdana'
      Title.Text.Strings = (
        'TSpectrumChart')
      BottomAxis.Axis.Color = 4210752
      BottomAxis.Grid.Color = 11119017
      BottomAxis.LabelsFormat.Font.Name = 'Verdana'
      BottomAxis.LogarithmicBase = 10.000000000000000000
      BottomAxis.Maximum = 24.000000000000000000
      BottomAxis.EndPosition = 100.000000000000000000
      BottomAxis.TicksInner.Color = 11119017
      BottomAxis.Title.Font.Name = 'Verdana'
      DepthAxis.Axis.Color = 4210752
      DepthAxis.Grid.Color = 11119017
      DepthAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthAxis.LogarithmicBase = 10.000000000000000000
      DepthAxis.Maximum = 0.500000000000000000
      DepthAxis.Minimum = -0.500000000000000000
      DepthAxis.EndPosition = 100.000000000000000000
      DepthAxis.TicksInner.Color = 11119017
      DepthAxis.Title.Font.Name = 'Verdana'
      DepthTopAxis.Axis.Color = 4210752
      DepthTopAxis.Grid.Color = 11119017
      DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
      DepthTopAxis.LogarithmicBase = 10.000000000000000000
      DepthTopAxis.Maximum = 0.500000000000000000
      DepthTopAxis.Minimum = -0.500000000000000000
      DepthTopAxis.EndPosition = 100.000000000000000000
      DepthTopAxis.TicksInner.Color = 11119017
      DepthTopAxis.Title.Font.Name = 'Verdana'
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Axis.Color = 4210752
      LeftAxis.Grid.Color = 11119017
      LeftAxis.LabelsFormat.Font.Name = 'Verdana'
      LeftAxis.LogarithmicBase = 10.000000000000000000
      LeftAxis.Maximum = 698.000000000000000000
      LeftAxis.EndPosition = 100.000000000000000000
      LeftAxis.TicksInner.Color = 11119017
      LeftAxis.Title.Font.Name = 'Verdana'
      RightAxis.Axis.Color = 4210752
      RightAxis.Grid.Color = 11119017
      RightAxis.Grid.ZPosition = 100.000000000000000000
      RightAxis.LabelsFormat.Font.Name = 'Verdana'
      RightAxis.LogarithmicBase = 10.000000000000000000
      RightAxis.EndPosition = 100.000000000000000000
      RightAxis.TicksInner.Color = 11119017
      RightAxis.Title.Font.Name = 'Verdana'
      RightAxis.ZPosition = 100.000000000000000000
      TopAxis.Axis.Color = 4210752
      TopAxis.Grid.Color = 11119017
      TopAxis.Grid.ZPosition = 100.000000000000000000
      TopAxis.LabelsFormat.Font.Name = 'Verdana'
      TopAxis.LogarithmicBase = 10.000000000000000000
      TopAxis.EndPosition = 100.000000000000000000
      TopAxis.TicksInner.Color = 11119017
      TopAxis.Title.Font.Name = 'Verdana'
      TopAxis.ZPosition = 100.000000000000000000
      Align = alTop
      TabOrder = 1
      Spectrums = <
        item
          InputsItemIndex = -1
          UnitScaleXAxis = 1.000000000000000000
          Input = RecordingSpectrumAnalyzer
        end>
      ConfidenceIntervalIndex = 0
      ConfidenceIntervalVisible = False
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series2: TMtxFastLineSeries
        HoverElement = []
        LinePen.Color = 10708548
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object ChartTool2: TAxisScaleTool
        UpperMargin = 10
        LowerMargin = 0
        AxisScaleMode = amPeakHold
        DataIsSpectrum = True
        AxisID = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 542
    Width = 966
    Height = 172
    Align = alBottom
    TabOrder = 1
    object LatencyLabel: TLabel
      Left = 6
      Top = 136
      Width = 42
      Height = 13
      Caption = 'Latency:'
    end
    object ElapsedTimeLabel: TLabel
      Left = 156
      Top = 136
      Width = 64
      Height = 13
      Caption = 'Elapsed time:'
    end
    object ElapsedSamplesLabel: TLabel
      Left = 335
      Top = 138
      Width = 82
      Height = 13
      Caption = 'Elapsed samples:'
    end
    object PlaybackButton: TButton
      Left = 781
      Top = 130
      Width = 75
      Height = 25
      Caption = 'Playback'
      TabOrder = 0
      OnClick = PlaybackButtonClick
    end
    object Button2: TButton
      Left = 877
      Top = 130
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = Button2Click
    end
    object RecordButton: TButton
      Left = 681
      Top = 130
      Width = 75
      Height = 25
      Caption = 'Record'
      TabOrder = 2
      OnClick = RecordButtonClick
    end
    object ChannelNumberGroup: TRadioGroup
      Left = 867
      Top = 6
      Width = 77
      Height = 94
      Caption = 'Ch display'
      ItemIndex = 0
      Items.Strings = (
        'Left'
        'Right')
      TabOrder = 3
    end
    object GroupBox1: TGroupBox
      Left = 423
      Top = 6
      Width = 430
      Height = 116
      Caption = 'Playback'
      TabOrder = 4
      object Label2: TLabel
        Left = 20
        Top = 24
        Width = 39
        Height = 13
        Caption = 'Device :'
      end
      object Label5: TLabel
        Left = 45
        Top = 60
        Width = 21
        Height = 13
        Caption = 'Bits:'
      end
      object Label6: TLabel
        Left = 172
        Top = 60
        Width = 16
        Height = 13
        Caption = 'FS:'
      end
      object Label7: TLabel
        Left = 297
        Top = 60
        Width = 42
        Height = 13
        Caption = 'Latency:'
      end
      object ExtBufferLabel: TLabel
        Left = 16
        Top = 90
        Width = 108
        Height = 13
        Caption = 'Ext buffer length: 0ms'
      end
      object PlaybackDeviceEdit: TComboBox
        Left = 74
        Top = 21
        Width = 248
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = PlaybackDeviceEditChange
      end
      object PlaybackFSEdit: TComboBox
        Left = 194
        Top = 57
        Width = 68
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = PlaybackFSEditChange
      end
      object PlaybackBitsEdit: TComboBox
        Left = 75
        Top = 57
        Width = 82
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = PlaybackBitsEditChange
      end
      object PlaybackExclusiveBox: TCheckBox
        Left = 339
        Top = 21
        Width = 70
        Height = 17
        Caption = 'Exclusive'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = PlaybackExclusiveBoxClick
      end
      object PlaybackLatencyEdit: TMtxFloatEdit
        Left = 345
        Top = 57
        Width = 63
        Height = 22
        RegistryPath = '\Software\Dew Research\MtxVec'
        StoreInRegistry = False
        IntegerIncrement = True
        Scientific = False
        ReFormat = '0'
        ImFormat = '+0.00#i;-0.00#i'
        Increment = '1'
        MaxValue = '200'
        MinValue = '2'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Value = '2'
        OnChange = PlaybackLatencyEditChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 12
      Top = 5
      Width = 400
      Height = 116
      Caption = 'Recording'
      TabOrder = 5
      object Label1: TLabel
        Left = 18
        Top = 27
        Width = 36
        Height = 13
        Caption = 'Device:'
      end
      object Label3: TLabel
        Left = 33
        Top = 60
        Width = 21
        Height = 13
        Caption = 'Bits:'
      end
      object Label4: TLabel
        Left = 163
        Top = 60
        Width = 16
        Height = 13
        Caption = 'FS:'
      end
      object Label8: TLabel
        Left = 275
        Top = 60
        Width = 42
        Height = 13
        Caption = 'Latency:'
      end
      object ExtBufferInLabel: TLabel
        Left = 19
        Top = 93
        Width = 108
        Height = 13
        Caption = 'Ext buffer length: 0ms'
      end
      object RecordDeviceEdit: TComboBox
        Left = 63
        Top = 24
        Width = 235
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = RecordDeviceEditChange
      end
      object RecordBitsEdit: TComboBox
        Left = 63
        Top = 57
        Width = 82
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = RecordBitsEditChange
      end
      object RecordFSEdit: TComboBox
        Left = 185
        Top = 57
        Width = 68
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = RecordFSEditChange
      end
      object RecordingExclusiveBox: TCheckBox
        Left = 316
        Top = 27
        Width = 70
        Height = 17
        Caption = 'Exclusive'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = RecordingExclusiveBoxClick
      end
      object RecordingLatencyEdit: TMtxFloatEdit
        Left = 323
        Top = 57
        Width = 63
        Height = 22
        RegistryPath = '\Software\Dew Research\MtxVec'
        StoreInRegistry = False
        IntegerIncrement = True
        Scientific = False
        ReFormat = '0'
        ImFormat = '+0.00#i;-0.00#i'
        Increment = '1'
        MaxValue = '200'
        MinValue = '2'
        TabOrder = 4
        Value = '2'
        OnChange = RecordingLatencyEditChange
      end
    end
  end
  object SignalCoreAudioIn: TSignalCoreAudioIn
    PropagateTemplate = False
    Count = 2
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    SettingsWin.Exclusive = True
    Ripple = 0.000001000000000000
    TransBW = 0.100000000000000000
    ChannelCount = 2
    ChannelCountHw = 2
    SamplingFrequency = 96000.000000000000000000
    ExtendedBufferTime = 1000
    OnStop = SignalCoreAudioInStop
    OnInputBufferReady = SignalCoreAudioInInputBufferReady
    SamplingFrequencyHW = 44100.000000000000000000
    Left = 72
    Top = 63
    MtxDataValues = {
      0E000000545369676E616C4368616E6E656C545046300E545369676E616C4368
      616E6E656C00084973446F75626C65080E466C6F6174507265636973696F6E07
      086D7653696E676C6506416374697665080A436F6E74696E756F7573080F4461
      74612E4461746156616C7565730A300200000000000000000043000000000000
      803F0000803F00001644000080400000000000137A4700000000000000000000
      00000000000000000000D500000016000000AC00200000000000000001010106
      00000000010300000000000000000F0000FF00000000000000000000F4FF0000
      000000000000F4FFFFFF1C000100000000000000000000000000000000000000
      00000000000000000000C4CABD50000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000100000000000000000000000000000001000000C4C66425070000006000
      00000000000000000000000000006A0000000B00000000000000000000000000
      000000000000540000001600000000000000006CE93400000000609F8434089A
      861F00000000020000000100000002000000000000000A000000000000000000
      00000A0000001E0000000100000036000000100000000000000000000000609F
      843400000000E8FFFFFF00000000EBFFFFFF0F00000014000000000000000000
      0000000000000000000016000000160000001600000000000000190000001600
      00001153616D706C696E674672657175656E6379050000000000000080FF3F0D
      4D74784461746156616C7565730A00000000105369676E616C42696E61727944
      6174610A20000000000000000000000000000000000000000000000000000000
      000000000000000000000E000000545369676E616C4368616E6E656C54504630
      0E545369676E616C4368616E6E656C00084973446F75626C65080E466C6F6174
      507265636973696F6E07086D7653696E676C6506416374697665080A436F6E74
      696E756F7573080F446174612E4461746156616C7565730A3002000000000000
      00000043000000000000803F0000803F00001644000080400000000000137A47
      0000000000000000000000000000010300000000000000000F0000FF00000000
      000000000000F4FF0000000000000000F4FFFFFF1C0001000000000000000000
      0000000000000000000000000000000000000000C4CABD500000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000009CF34100
      30316F0300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000100000000000000000000000000000001000000
      447B603407000000600000000000000000000000000000006A00000021000000
      00000000000000000000000000000000620000001600000000000000B071E934
      00000000609F843488980A350000000002000000010000000200000000000000
      0A00000000000000000000000A0000001E000000010000004400000010000000
      0000000000000000609F843400000000E8FFFFFF00000000EBFFFFFF0F000000
      1400000000000000000000000000000000000000160000001600000016000000
      0000000019000000160000000000000000000000D500000016000000F0FFFFFF
      05000000F9FFFFFF0E0000001153616D706C696E674672657175656E63790500
      00000000000080FF3F0D4D74784461746156616C7565730A0000000010536967
      6E616C42696E617279446174610A200000000000000000000000000000000000
      0000000000000000000000000000000000000000}
  end
  object SignalCoreAudioOut: TSignalCoreAudioOut
    PropagateTemplate = False
    Count = 2
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    SettingsWin.Exclusive = True
    Ripple = 0.000001000000000000
    TransBW = 0.100000000000000000
    ChannelCount = 2
    ChannelCountHw = 2
    Inputs = SignalDemuxList
    SamplingFrequency = 44100.000000000000000000
    ExtendedBufferTime = 1000
    Left = 363
    Top = 18
    MtxDataValues = {
      0E000000545369676E616C4368616E6E656C545046300E545369676E616C4368
      616E6E656C00084973446F75626C65080E466C6F6174507265636973696F6E07
      086D7653696E676C6506416374697665080A436F6E74696E756F7573080F4461
      74612E4461746156616C7565730A300200000000000000000043000000000000
      803F0000803F00001644000080400000000000137A4700000000000000000000
      0000000000000000000000000000080000000000000000000000000000000000
      00000100000000000000F49F135004A013500000000000000000DC37AA21F023
      CD0A000000002C000000D500000016000000AC80200000000000000001010106
      00000000010300000000000000000F0000FF00000000000000000000F4FF0000
      000000000000F4FFFFFF1C000100000000000000000000000000000000000000
      00000000000000000000C4CABD50000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002801420030316F03000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000100000000000000000000000000000001000000C45FF032070000006000
      00000000000000000000000000006A0000003700000000000000000000000000
      000000000000B40000001600000000000000E065E93400000000609F843478A8
      0A3500000000020000000100000002000000000000000A000000000000000000
      00000A0000001E000000010000006C000000100000000000000000000000609F
      84341153616D706C696E674672657175656E6379050000000000000080FF3F0D
      4D74784461746156616C7565730A00000000105369676E616C42696E61727944
      6174610A20000000000000000000000000000000000000000000000000000000
      000000000000000000000E000000545369676E616C4368616E6E656C54504630
      0E545369676E616C4368616E6E656C00084973446F75626C65080E466C6F6174
      507265636973696F6E07086D7653696E676C6506416374697665080A436F6E74
      696E756F7573080F446174612E4461746156616C7565730A3002000000000000
      00000043000000000000803F0000803F00001644000080400000000000137A47
      0000000000000000000000000000000042000000D500000016000000AC802000
      0000000000000101010600000000010300000000000000000F0000FF00000000
      000000000000F4FF0000000000000000F4FFFFFF1C0001000000000000000000
      0000000000000000000000000000000000000000C4CABD500000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000CF04100
      30316F0300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000100000000000000000000000000000001000000
      AC0FB23207000000600000000000000000000000000000006A0000004D000000
      00000000000000000000000000000000D50000001600000000000000B032E934
      00000000609F843490D40A350000000002000000010000000200000000000000
      0A00000000000000000000000A0000001E00000001000000B700000010000000
      0000000000000000609F843400000000E8FFFFFF00000000EBFFFFFF0F000000
      1400000000000000000000000000000000000000160000001600000016000000
      0000000019000000160000001153616D706C696E674672657175656E63790500
      00000000000080FF3F0D4D74784461746156616C7565730A0000000010536967
      6E616C42696E617279446174610A200000000000000000000000000000000000
      0000000000000000000000000000000000000000}
  end
  object SignalRead: TSignalRead
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 44100.000000000000000000
    FileFormat = ffWav
    FileName = 'D:\SingleTone.wav'
    SelectionStop = -1
    SelectionStart = 0
    ScaleFactor = 1.000000000000000000
    ForceLength = True
    PostBufferSamples = 0
    Left = 361
    Top = 169
    MtxDataValues = {}
  end
  object SignalDemuxList: TSignalDemuxList
    PropagateTemplate = False
    Count = 2
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    Input = SignalRead
    Left = 361
    Top = 118
    MtxDataValues = {
      0C000000545369676E616C44656D7578545046300C545369676E616C44656D75
      7800084973446F75626C65080E466C6F6174507265636973696F6E07086D7653
      696E676C650F446174612E4461746156616C7565730A30020000000000000000
      0043000000000000803F0000803F00001644000080400000000000137A470000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001153616D706C696E674672657175656E637905000000
      0000000080FF3F0D4D74784461746156616C7565730A00000000105369676E61
      6C42696E617279446174610A2000000000000000000000000000000000000000
      0000000000000000000000000000000000000C000000545369676E616C44656D
      7578545046300C545369676E616C44656D757800084973446F75626C65080E46
      6C6F6174507265636973696F6E07086D7653696E676C650F446174612E446174
      6156616C7565730A300200000000000000000043000000000000803F0000803F
      00001644000080400000000000137A47000000000000000000000000FFFF7FFF
      150000E00000008000000000000000000000000000000000FFFF7F7F00000000
      00000000B2F9FFFF00000000FFFF7F7FFFFF7F7FFFFF7FFFFFFF7F7FFFFF7FFF
      FFFF7FFF000000000000000000000000F9FFFFFF00000000FFFF7F7FFFFF7F7F
      FFFF7FFF000000000000000048D1F9FF6247D1B9000000000000008000000000
      00000000C01F4D11E01C4D11000000000000000000000000D1F9FFFF00000000
      000000000000000000000000000000802E53D1B1FFFF7FFF8069511100000000
      00000000F9FFFFFF000000000000000000000000000000800000000000000000
      59D1F9FF000000000000000000000000000000000000000080335D11E0FC5C11
      000000000000000000000000D1F9FFFF00000000000000000000000000000080
      FFFF7F7FFFFF7F7FFFFF7FFF807561110000000000000000F9FFFFFF00000000
      FFFF7F7FFFFF7F7FFFFF7F7F0000000000000000F7B2F9FFFFFF7F7FFFFF7FFF
      0000000000000000000000000000000000000000FFFF7F7F0000000000000000
      B2F9FFFF00000000FFFF7FFFFFFF7FFFFFFF7FFF000000807301B379FFFF7FFF
      000000000000000000000000F9FFFFFF00000000FFFF7F7FFFFF7F7FFFFF7F7F
      000000000000000007B3F9FF00000000FFFF7FFF000000800000000000000000
      0000000000000000FFFF7F7F0000000000000000B3F9FFFF000000001153616D
      706C696E674672657175656E6379050000000000000080FF3F0D4D7478446174
      6156616C7565730A00000000105369676E616C42696E617279446174610A2000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000}
  end
  object SignalWrite: TSignalWrite
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    FileFormat = ffWav
    FileName = 'D:\TestingCoreAudio.wav'
    AuthorInfo = 'Unknown'
    Input = SignalMux
    Precision = prSmallInt
    Left = 70
    Top = 175
    MtxDataValues = {}
  end
  object SignalMux: TSignalMux
    IsDouble = False
    FloatPrecision = mvSingle
    SamplingFrequency = 1.000000000000000000
    Inputs = <>
    InputList = SignalCoreAudioIn
    Left = 73
    Top = 124
    MtxDataValues = {}
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 642
    Top = 150
  end
  object RecordingList: TSignalList
    PropagateTemplate = False
    Count = 0
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    Left = 166
    Top = 151
    MtxDataValues = {}
  end
  object PlaybackSpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
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
    Left = 169
    Top = 91
    MtxDataValues = {}
  end
  object RecordingSpectrumAnalyzer: TSpectrumAnalyzer
    IsDouble = False
    FloatPrecision = mvSingle
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
    Left = 502
    Top = 106
    MtxDataValues = {}
  end
  object TeeGDIPlus1: TTeeGDIPlus
    Active = True
    Antialias = False
    TeePanel = SignalChart
    Left = 264
    Top = 90
  end
  object TeeGDIPlus2: TTeeGDIPlus
    Active = True
    Antialias = False
    TeePanel = SpectrumChart
    Left = 54
    Top = 21
  end
  object PlaybackList: TSignalList
    PropagateTemplate = False
    Count = 0
    FloatPrecision = mvSingle
    FloatPrecisionLock = False
    Left = 505
    Top = 172
    MtxDataValues = {}
  end
  object OpenDialog: TOpenDialog
    Filter = 'Uncompressed PCM|*.wav'
    FilterIndex = 0
    Left = 640
    Top = 67
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Uncompressed PCM|*.wav'
    Left = 169
    Top = 37
  end
end
