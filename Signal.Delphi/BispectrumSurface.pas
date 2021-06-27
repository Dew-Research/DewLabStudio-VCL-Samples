unit BispectrumSurface;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Types, Dialogs, ComCtrls, ToolWin, ExtCtrls, TeeProcs, TeEngine, Chart,
  SignalToolsTee, TeeEdit, SignalToolsDialogs, SpectrumAna, MtxBaseComp,
  SignalTools, SignalAnalysis, Series, StdCtrls, TeeTools, FileSignal,
  MtxDialogs, MtxVec, MtxComCtrls, TeeSurfa, MtxExpr, TeeGDIPlus;

type
  TBiSpectrumSurfaceForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ChartEditButton: TToolButton;
    ChartEditor: TChartEditor;
    RichEdit1: TRichEdit;
    SignalRead1: TSignalRead;
    BiSpectrumAnalyzer: TBiSpectrumAnalyzer;
    Panel2: TPanel;
    ProgressLabel: TLabel;                                
    Chart1: TChart;
    Series1: TSurfaceSeries;
    SingleLinesOnlyBox: TCheckBox;
    Button1: TToolButton;
    procedure ChartEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SingleLinesOnlyBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BiSpectrumSurfaceForm: TBiSpectrumSurfaceForm;

implementation

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses MtxVecEdit, MtxVecTee, SignalUtils, Math387, AbstractMtxVec;

procedure TBiSpectrumSurfaceForm.ChartEditButtonClick(Sender: TObject);
begin
    ChartEditor.Execute;
end;

procedure TBiSpectrumSurfaceForm.FormCreate(Sender: TObject);
begin
     SignalRead1.IsDouble := DefaultIsDouble; //select processing precision

     SignalRead1.FileName := ExtractFileDir(Application.ExeName) + '\bz.sfs';
     BispectrumAnalyzer.Amplt.SetZero;
     With RichEdit1.Lines, RichEdit1 do
     begin
        Clear;
        Add('Bicoherence shows peaks where the frequency pair is related to a third frequency component ' +
            'defined as e^jw1 * e^jw2 = e^j(w1+w2). Bicoherence  ' +
            'will be 1 for a frequency pair (w1,w2) which has a product of itself (e^jw1*e^jw2) ' +
            'in the frequency spectrum. You can also compute only ' +
            'preselected frequency lines by checking the Single lines only box.');
        Paragraph.FirstIndent := 0;
        Paragraph.Numbering := nsNone;
     end;
     Button1Click(Sender);
end;

procedure TBiSpectrumSurfaceForm.Button1Click(Sender: TObject);
var av: Vector;
    i,j: integer;
begin
    SignalRead1.OpenFile;
    SignalRead1.RecordPosition := 0;
    SignalRead1.OverlappingPercent := 50;
    Screen.Cursor := crHourGlass;
    if SingleLinesOnlyBox.Checked then
    begin
        BispectrumAnalyzer.BiAnalyzer.SingleLinesOnly := True;
        BispectrumAnalyzer.BiAnalyzer.Lines.Length := 32; //compute only 32 lines
        BispectrumAnalyzer.BiAnalyzer.Lines.Ramp(16*SignalRead1.HzRes,SignalRead1.HzRes);
    end else BispectrumAnalyzer.BiAnalyzer.SingleLinesOnly := False;
    BispectrumAnalyzer.ResetAveraging;
    while (BispectrumAnalyzer.Pull <> pipeEnd) do
    begin
        ProgressLabel.Caption := 'Progress: ' + FormatSample('0',SignalRead1.FrameNumber/SignalRead1.MaxFrames*100) + ' [%]';
        Update;
    end;
    BispectrumAnalyzer.BiAnalyzer.Update; //compute bicoherence

    ClearFPU; //Required only for Delphi 4 and 5

    Series1.Clear;
    Series1.IrregularGrid := True;
    av.Size(0); //required by CLR only
    with BispectrumAnalyzer,BiAnalyzer do
    for i := 0 to Length div 2 - 1 do
    begin
         Frequency := i*HzRes;
         if not SingleLinesOnly then DecodeBispectrumMatrix(av) else DecodeSingleLineMatrix(av);
         for j := 0 to Length-1 do
         begin
             if av[j] <> 0 then
             Series1.AddXYZ(j*HzRes,av[j],i*HzRes);
         end;
    end;
    Screen.Cursor := crDefault;
end;

procedure TBiSpectrumSurfaceForm.SingleLinesOnlyBoxClick(Sender: TObject);
begin
     Button1Click(Sender);
end;

initialization
RegisterClass(TBiSpectrumSurfaceForm);

end.
