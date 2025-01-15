unit Differentiator;

interface
             
uses
  System.Types,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxComCtrls, Math387, MtxVec, MtxExpr, TeeGDIPlus;
                                               
type
  TDifferentiatorForm = class(TForm)
    SpectrumChart: TSpectrumChart;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpectrumEditButton: TToolButton;
    ChartEditButton: TToolButton;
    SpectrumAnalyzerDialog: TSpectrumAnalyzerDialog;
    ChartEditor: TChartEditor;
    Series1: TFastLineSeries;
    RichEdit1: TRichEdit;                                         
    ChartTool1: TAxisScaleTool;
    FirLengthLabel: TLabel;                             
    TransBWEdit: TMtxFloatEdit;
    Label1: TLabel;
    DiffBox: TComboBox;
    Label2: TLabel;
    Series2: TFastLineSeries;
    PhaseBox: TCheckBox;
    SpectrumAnalyzer: TSpectrumAnalyzer;
    procedure SpectrumEditButtonClick(Sender: TObject);
    procedure ChartEditButtonClick(Sender: TObject);
    procedure SpectrumAnalyzerParameterUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TransBWEditChange(Sender: TObject);
    procedure PhaseBoxClick(Sender: TObject);
  private
    procedure FillSeries(TransBW, Ripple: TSample; PINdex: integer);
    procedure ComputeError(h: TVec; Integration: TIntegration; Err: TVec; FS: TSample);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DifferentiatorForm: TDifferentiatorForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses OptimalFir, SignalUtils, MTxVecTee, SignalProcessing, AbstractMtxVec, MtxVecBase;

procedure TDifferentiatorForm.SpectrumEditButtonClick(Sender: TObject);
begin
     SpectrumAnalyzerDialog.Execute;
end;

procedure TDifferentiatorForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TDifferentiatorForm.SpectrumAnalyzerParameterUpdate(
  Sender: TObject);
begin
    SpectrumAnalyzer.Update;
end;

procedure TDifferentiatorForm.FormCreate(Sender: TObject);
begin
    DiffBox.ItemIndex := 0;
    TransBWEditChange(Sender);
    SpectrumChart.Legend.Visible := True;    
    With RichEdit1.Lines, RichEdit1 do
    begin
      Clear;
      Add('Differentiation is often required to obtain velocity and acceleration ' +
          'from a sensor returning displacement. Likewise, integration ' +
          'is required to obtain velocity and displacement from acceleration as returned by ' +
          'the accelerometers. ' +
          'If the integrated/differentiated signal is not required, ' +
          'the integration/differentiation can be performed in frequency domain only ' +
          'while analyzing the frequency spectrum. The advantage of using a FIR filter ' +
          'over numerical differentiation/integration methods is the linear phase. '+
          'The Integrator filter also filters the DC component.');
      Add('');
      Paragraph.FirstIndent := 0;
      Paragraph.Numbering := nsNone;
    end;
end;

procedure TDifferentiatorForm.ComputeError(h: TVec; Integration: TIntegration; Err: TVec; FS: TSample);
var H1,A1: Vector;
    Int: TIntegration;
begin
     H1.Size(H);
     H1.SetZero;
     H1[0] := 1; //simple impulse for testing
     int := SpectrumAnalyzer.Integration;
     SpectrumAnalyzer.Integration := Integration;
     with SpectrumAnalyzer do
     begin
         DCDump := False;
         Window := wtRectangular;
         ZeroPadding := 8;
         Process(H1,nil,nil,nil,FS);
         A1.Copy(Amplt);
         SpectrumAnalyzer.Integration := inNone;
         Process(H,nil,nil,nil,FS);
         Err.Copy(A1 - Amplt);
     end;
     SpectrumAnalyzer.Integration := int;
end;


procedure TDifferentiatorForm.FillSeries(TransBW,Ripple: TSample; Pindex: integer);
var h,Err: Vector;
    Title: string;
    FS: double;
begin
    FS := 2;
    Err.Size(0, false, DefaultIsDouble);
    H.Size(0, false, DefaultIsDouble);
//     TransBW := TransBW*FS/2;
    case PIndex of
    0: begin  //differentiate in time
       Title := 'Frequency response of a type III differentiator filter (Kaiser).';
       KaiserImpulse(H,[FS/2-TransBW,FS/2],Ripple, ftDifferentiatorIII,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,diffOnce,err,FS);
       end;
    1: begin  //differentiate in time
       Title := 'Frequency response of a type IV linear phase differentiator filter (Kaiser).';
       KaiserImpulse( H,[FS/2-TransBW,FS/2],Ripple, ftDifferentiatorIV,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,diffOnce,err,FS);
       end;
    2: begin  //differentiate in time (certified)
       Title := 'Frequency response of a type III differentiator filter (remez).';
       RemezImpulse(H,[0,FS/2-TransBW],Ripple, ftDifferentiatorIII,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,diffOnce,err,FS);
       end;
    3: begin  //differentiate in time (certified)
       Title := 'Frequency response of a type IV differentiator filter (remez).';
       RemezImpulse( H,[0,FS/2-TransBW],Ripple, ftDifferentiatorIV,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,diffOnce,err,FS);
       end;
    4: begin
       Title := 'Frequency response of a type III 2x differentiator filter (remez).';
       RemezImpulse(H,[TransBW,FS/2-TransBW],Ripple, ftDoubleDifferentiatorIII,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,diffTwice,err,FS);
       end;
    5: begin
       Title := 'Frequency response of a type IV 2x differentiator filter (remez).';
       RemezImpulse(H,[TransBW,FS/2-TransBW],Ripple, ftDoubleDifferentiatorIV,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,diffTwice,err,FS);
       end;
    6: begin
       Title := 'Frequency response of a type III integrator  filter (remez).';
       RemezImpulse(H,[TransBW,FS/2-TransBW],Ripple, ftIntegratorIII,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,inOnce,err,FS);
       end;
    7: begin
       Title := 'Frequency response of a type IV integrator  filter (remez).';
       RemezImpulse(H,[TransBW,FS/2],Ripple, ftIntegratorIV,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,inOnce,err,FS);
       end;
    8: begin
       Title := 'Frequency response of a type III 2x integrator  filter (remez).';
       RemezImpulse(H,[TransBW,FS/2-TransBW],Ripple, ftDoubleIntegratorIII,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,inTwice,err,FS);
       end;
    9: begin
       Title := 'Frequency response of a type IV 2x integrator  filter (remez).';
       RemezImpulse(H,[TransBW,FS/2],Ripple, ftDoubleIntegratorIV,1,FS);
       SpectrumAnalyzer.Integration := inNone;
       FirLengthLabel.Caption := 'Fir length = ' + IntToStr(H.Length);
       ComputeError(h,inTwice,err,FS);
       end;
    10:begin //differentiate in frequency
       Title := 'Differentiator applied in frequency domain.';
       H.Length := 128;
       H.SetZero;
       H[0] := 1;  //simple impulse for testing.
       SpectrumAnalyzer.Integration := diffOnce;
       FirLengthLabel.Caption := 'Fir length = 0';
       end;
    11:begin //differentiate in frequency twice
       Title := 'Differentiator applied twice in frequency domain.';
       H.Length := 128;
       H.SetZero;
       H[0] := 1;  //simple impulse for testing.
       SpectrumAnalyzer.Integration := diffTwice;
       FirLengthLabel.Caption := 'Fir length = 0';
       end;
    12:begin  //integrate in frequency
       Title := 'Integrator applied in frequency domain.';
       H.Length := 128;
       H.SetZero;
       H[0] := 1; //simple impulse for testing
       SpectrumAnalyzer.Integration := inOnce;
       FirLengthLabel.Caption := 'Fir length = 0';
       end;
    13:begin  //integrate in frequency twice
       Title := 'Integrator applied twice in frequency domain.';
       H.Length := 128;
       H.SetZero;
       H[0] := 1; //simple impulse for testing
       SpectrumAnalyzer.Integration := inTwice;
       FirLengthLabel.Caption := 'Fir length = 0';
       end
    end;
    SpectrumChart.Title.Text.Clear;
    SpectrumChart.Title.Text.Add(Title);
    with SpectrumAnalyzer do
    begin
         DCDump := False;
         Window := wtRectangular;
         ZeroPadding := 8;
         Process(H,nil,nil,nil,FS);
    end;
    DrawValues(err,SpectrumChart.Series[1],0,SpectrumAnalyzer.HzRes);
end;

procedure TDifferentiatorForm.TransBWEditChange(Sender: TObject);
begin
     //Ripple is preset to 80dB
     FillSeries(TransBWEdit.Position,0.0001, DiffBox.ItemIndex);
end;

procedure TDifferentiatorForm.PhaseBoxClick(Sender: TObject);
begin
     SpectrumChart.SpectrumPart := TSpectrumPart(PhaseBox.Checked);
     Case SpectrumChart.SpectrumPart of
     sppAmplt: begin
               SpectrumChart.LeftAxis.Title.Caption := 'Amplitude';
               Series2.Active := true;
               end;
     sppPhase: begin
               SpectrumChart.LeftAxis.Title.Caption := 'Phase [degress]';
               Series2.Active := False;               
               end;
     end;     
end;

initialization
RegisterClass(TDifferentiatorForm);

end.
