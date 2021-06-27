unit SpectrogramDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, MtxBaseComp,
  SignalTools, FileSignal, MtxDialogs, SignalProcessing, SignalAnalysis,
  MtxComCtrls, MtxGridSerEdit, MtxVecTee, TeeEdit, TeeGDIPlus;

type
  TSpectrogramDemoForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Chart1: TChart;
    OpenDialog: TOpenDialog;
    SignalRead: TSignalRead;                                          
    Spectrogram: TSpectrogram;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    SignalDemux1: TSignalDemux;                            
    ComputeSpectrogramThread: TMtxProgressDialog;
    ProgressPanel: TMtxPositionPanel;
    Series1: TMtxGridSeries;
    ChartEditor1: TChartEditor;
    TeeGDIPlus1: TTeeGDIPlus;
    TopClipBox: TCheckBox;
    BottomClipBox: TCheckBox;
    CustomButton: TButton;
    LogarithmicBox: TCheckBox;
    procedure OKButtonClick(Sender: TObject);
    procedure ComputeSpectrogramThreadCompute(Sender: TObject);
    procedure ComputeSpectrogramThreadProgressUpdate(Sender: TObject;
      Event: TMtxProgressEvent);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SignalDemux1AfterUpdate(Sender: TObject);
    procedure SpectrumAnalyzerAfterUpdate(Sender: TObject);
    procedure SpectrogramAfterUpdate(Sender: TObject);
    procedure Chart1DblClick(Sender: TObject);
    procedure TopClipBoxClick(Sender: TObject);
    procedure BottomClipBoxClick(Sender: TObject);
    procedure CustomButtonClick(Sender: TObject);
    procedure LogarithmicBoxClick(Sender: TObject);
  private
    procedure UpdateSpectrogram(Src: TSpectrogram; Series: TMtxGridSeries);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SpectrogramDemoForm: TSpectrogramDemoForm;

implementation

uses Math387, MtxVec;
{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TSpectrogramDemoForm.CustomButtonClick(Sender: TObject);
var dv, vmax, vmin: TSample;
begin
    vmax := spectrogram.MaxAmplt;
    vmin := 0;

    dv := ( vmax - vmin )/3;                                    
    Series1.ColorPalette.Clear;
    Series1.ColorPalette.Add(vmax*0.01,clWhite); // <vmin
    Series1.ColorPalette.Add(vmin+dv,clBlue);
    Series1.ColorPalette.Add(vmin+2*dv,clRed);
    Series1.ColorPalette.Add(vmax,clAqua);  // >vmax

    Series1.ColorPalette.PaletteScale := {$IFDEF D12}TPaletteScale.{$ENDIF}ppsNone;
    series1.ColorPalette.PaletteStyle := {$IFDEF D12}TGridPaletteStyle.{$ENDIF}palCustom;
    Series1.UpdateColor;
end;

procedure TSpectrogramDemoForm.Chart1DblClick(Sender: TObject);
begin
    ChartEditor1.Execute;
end;

procedure TSpectrogramDemoForm.ComputeSpectrogramThreadCompute(Sender: TObject);
begin
    if not SignalRead.IsEndOfFile then
    begin
         Spectrogram.Pull;
    end else ComputeSpectrogramThread.Cancel := True;
end;

procedure TSpectrogramDemoForm.ComputeSpectrogramThreadProgressUpdate(
  Sender: TObject; Event: TMtxProgressEvent);
var bDst: TSignalRead;
    a: TSpectrumAnalyzer;
begin
     bDst := SignalRead;
     a := SpectrumAnalyzer;
     case Event of
     peInit:    begin
                with ProgressPanel do
                begin
                     SliderMin := 0;
                     SliderMax := 100;
                     SliderPosition := 0;
                     SliderSpan := 0;
                     Caption := 'Spectrogram 0%';
                     Visible := True;
                     Screen.Cursor := crHourGlass;
                end;

                ComputeSpectrogramThread.UpdateInterval := 50;
                Spectrogram.Reset;                
                Spectrogram.MaxSpectrumCount := bDst.MaxFrames;

                a.Stats.Averaging := avNone;
                a.Rotation := 0;
                a.Logarithmic := false; //because then it can be applied later.
                a.LogType := ltAbsolute;
                a.ResetAveraging;
                a.SuspendNotifyUpdate := true;
                end;
     peCycle:   begin
                ProgressPanel.SliderSpan := bDst.FrameNumber/bDst.MaxFrames*100;
                ProgressPanel.Caption := 'Spectrogram ' + FormatFloat('0%',ProgressPanel.SliderSpan);
                end;
     peCleanUp: begin
                bDst.CloseFile;
                ProgressPanel.Visible := False;
                Screen.Cursor := crDefault;
                Spectrogram.SpectralSamplingFrequency := bDst.FramesPerSecond;

                Series1.ColorPalette.ResetPeakScale;
                UpdateSpectrogram(Spectrogram, Series1);
                end;
     end;
end;

procedure TSpectrogramDemoForm.FormCreate(Sender: TObject);
begin
    Series1.ColorPalette.UseMidColor := true;
    Series1.ColorPalette.Rainbow.BottomToMid := True;
    Series1.ColorPalette.Rainbow.MidToTop := true;
    Series1.ColorPalette.ColorBalanceMid := -0.85; //10%
    series1.ColorPalette.PaletteScale := ppsPeakHold; //do not adapt palette on zoom
    Series1.PixelResampleMethod := pdsAverage; //reduce spectrogram bitmap by averaging mask
    series1.PixelResample := true; //enable bitmap size reduction before drawing.

    Signalread.IsDouble := DefaultIsDouble;
    SignalRead.FileName := ExtractFilePath(Application.ExeName) + 'bz.sfs';
    SignalRead.OpenFile;
    SignalRead.Length := 1024*SignalRead.ChannelCount;
    SignalRead.OverlappingPercent := 98;
    SignalRead.RecordPosition := 0;

    //limit the size of spectrogram so that we don't run out of mem
//    SignalRead.SelectionStop := Min(SignalRead.RecordLength, 10000 * 100);

    ComputeSpectrogramThread.Start;
end;

procedure TSpectrogramDemoForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = vk_ESCAPE then
    begin
        ComputeSpectrogramThread.Cancel := True;
    end;
end;

procedure TSpectrogramDemoForm.LogarithmicBoxClick(Sender: TObject);
begin
    Spectrogram.Logarithmic := LogarithmicBox.Checked;
    if Spectrogram.Logarithmic then Series1.ColorPalette.ColorBalance := +0.5
                               else Series1.ColorPalette.ColorBalance := -0.5;

    if Spectrogram.Logarithmic then Series1.ColorPalette.ColorBalanceMid := 0
                               else Series1.ColorPalette.ColorBalanceMid := -0.85;

    Series1.ColorPalette.ResetPeakScale;
    UpdateSpectrogram(Spectrogram, Series1);
end;

procedure TSpectrogramDemoForm.UpdateSpectrogram(Src: TSpectrogram; Series: TMtxGridSeries);
begin
     if not Assigned(Src) then
     begin
         Series.Clear;
         Exit;
     end;

     if Src.Count > 0 then
     begin
         Src.CopyAmpltTransposed(Series.Matrix);

         Series.XOffset := 0;
         Series.YOffset := 0;
         if Src.Count > 0 then
         begin
             Series.YStep := Src.Spectrum[0].HzRes;
             Series.XStep := Src.SpectralDt;
         end;

         Series.ShowInLegend := false;
         Series.Update;
     end else
     begin
        Series.Clear;
     end;
end;

procedure TSpectrogramDemoForm.OKButtonClick(Sender: TObject);
begin
    OpenDialog.Filter := SignalDialogFilter;
    OpenDialog.FilterIndex := 8;
    if OpenDialog.Execute then
    begin
        if FileExists(OpenDialog.FileName) then
        begin
            SignalRead.FileName := OpenDialog.FileName;
            SignalRead.OpenFile;
            SignalRead.Length := 1024*SignalRead.ChannelCount;
            SignalRead.OverlappingPercent := 0;
            SignalRead.RecordPosition := 0;

            //limit the size of spectrogram so that we don't run out of mem
            SignalRead.SelectionStop := Min(SignalRead.RecordLength, 10000 * 100);

            ComputeSpectrogramThread.Start;
        end;
    end;
end;

procedure TSpectrogramDemoForm.SignalDemux1AfterUpdate(Sender: TObject);
begin
    //
end;

procedure TSpectrogramDemoForm.SpectrogramAfterUpdate(Sender: TObject);
begin
        //
end;

procedure TSpectrogramDemoForm.SpectrumAnalyzerAfterUpdate(Sender: TObject);
begin
    //
end;

procedure TSpectrogramDemoForm.TopClipBoxClick(Sender: TObject);
begin
    Series1.ColorPalette.PaletteStyle := {$IFDEF D12}TGridPaletteStyle.{$ENDIF}palAuto;
    Series1.ColorPalette.PaletteScale := ppsPeakHold;
    if TopClipBox.Checked then Series1.ColorPalette.TopClipOffColor := clWhite
                          else Series1.ColorPalette.TopClipOffColor := clNone;

    Series1.UpdateColor;
end;

procedure TSpectrogramDemoForm.BottomClipBoxClick(Sender: TObject);
begin
    Series1.ColorPalette.PaletteStyle := {$IFDEF D12}TGridPaletteStyle.{$ENDIF}palAuto;
    Series1.ColorPalette.PaletteScale := ppsPeakHold;
    if BottomClipBox.Checked then Series1.ColorPalette.BottomClipOffColor := clBlack
                             else Series1.ColorPalette.BottomClipOffColor := clNone;

    Series1.UpdateColor;
end;

initialization
  RegisterClass(TSpectrogramDemoForm);

end.
