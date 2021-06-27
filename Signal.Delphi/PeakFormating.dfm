inherited PeakFormatingForm: TPeakFormatingForm
  Left = 301
  Top = 200
  Caption = 'Peak mark formating'
  PixelsPerInch = 96
  TextHeight = 13
  inherited SpectrumChart: TSpectrumChart
    LeftAxis.Maximum = 850.800000000000000000
    LeftAxis.Minimum = 139.550000000000000000
    Spectrums = <
      item
        Input = SpectrumAnalyzer
      end>
    inherited ChartTool1: TAxisScaleTool
      AxisID = 2
    end
  end
  inherited SpectrumAnalyzer: TSpectrumAnalyzer
    Bands.Templates.Strings = ()
    Bands.Templates.StreamBinaryData = {}
    SpectrumBinaryData = {
      0000000000000000000000000000000000000000000000000000000000000000}
  end
end
