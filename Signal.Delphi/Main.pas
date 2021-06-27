unit Main;

{ Some features taken from TeeChart v5.0 demo program }
{ Coded by David Berneda, Steema SL                   }

interface

{$I BdsppDefs.inc}

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons
  {$IFDEF CLR}
  ,System.ComponentModel, ExtCtrls, TeeJPEG, jpeg, TeEngine, TeeProcs, Chart,
  SignalToolsTee
  {$ELSE}
  ,jpeg, ExtCtrls, XPMan
  {$ENDIF}
  ;

type
  TfrmMain = class(TForm)
    TreeView1: TTreeView;
    Panel2: TPanel;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    Image1: TImage;
    PageControl1: TPageControl;
    TabForm: TTabSheet;
    TabSource: TTabSheet;
    btnConfig: TButton;
    Label1: TLabel;
    Image2: TImage;
    btnPrevious: TSpeedButton;
    btnNext: TSpeedButton;
    btnClose: TSpeedButton;
    btnHelp: TSpeedButton;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure btnNextClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnConfigClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    tmpForm : TForm;
    OldCodeFile: String;
    RichEditCode : TRichEdit;
    FormList: TStringList;
    procedure ShowForm;
    procedure ShowFormClass(AClass: TFormClass);
    function  CodeFile:String;
    procedure InitTreeItems;
    { Private declarations }
  public
    { Public declarations }
  end;


type TFormExampleInfo=class
       FormClass : TFormClass;
       UnitName  : String;
    end;

var
  frmMain: TfrmMain;

implementation

Uses Registry, FileCtrl;

{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TfrmMain.ShowFormClass(AClass: TFormClass);
begin
     tmpForm := AClass.Create(Self);
     With tmpForm do
     begin
          Visible := false;
          BorderStyle := bsNone;
          Parent := TabForm;
          Align := alClient;
          Show;
     end;
end;

procedure TfrmMain.ShowForm;
begin
  if TreeView1.Selected<>nil then
  begin
    if Assigned(TreeView1.Selected) and Assigned (TreeView1.Selected.Data) then
    begin
      FreeAndNil(tmpForm);
      ShowFormClass(TFormExampleInfo(TreeView1.Selected.Data).FormClass);
    end;
    Label1.Caption := TreeView1.Selected.Text;
    StatusBar1.SimpleText := TreeView1.Selected.Text;
  end;
end;

procedure TfrmMain.InitTreeItems;
begin
  FormList := TStringList.Create;
  With FormList do
  begin
    Clear;
    Add('Introduction;TIntroduction');
    Add('What is new;TWhatIsNewForm');
    Add('Spectral analysis;TIntroSpectralForm');
    Add(' Windows;TWindowsDemoForm;WindowsDemo');
    Add(' Cross-spectrum;TCoherenceTestForm;CoherenceTest');
    Add(' Spectrum estimation;TAutoregressDemoForm;AutoregressDemo');
    Add(' Chirp-Z-transform;TCZTDemoForm;CZTDemo');
    Add(' Signal browsing;TBrowseDemoForm;BrowseDemo');
    Add(' Energy of bands;TFrequencyBandsForm;FrequencyBands');
    Add(' Cepstral analysis;TCepstrumDemoForm;CepstrumDemo');
    Add(' Spectrogram;TSpectrogramDemoForm;SpectrogramDemo');    
    Add('Spectrum peak analysis;TIntroPeakSpectralForm');
    Add(' Peak marking;TPeakMarkingBasicForm;PeakMarkingBasic');
    Add(' Peak formating;TPeakMarkingFormatingForm;PeakMarkingFormating');
    Add(' Peak filtering;TPeakFilteringForm;PeakFiltering');
    Add(' Peak interpolation;TPeakInterpolateForm;PeakInterpolate');
    Add(' Order tracking;TPeakMarkingOrderForm;PeakMarkingOrder');
    Add(' Amplt ratios;TAmpltRatiosForm;AmpltRatios');
    Add('Higher order spectral analysis;TIntroHigherSpectralForm');
    Add(' Bicoherence;TBispectrumTestForm;BispectrumTest');
    Add(' Bicoherence surface;TBispectrumSurfaceForm;BispectrumSurface');
    Add(' Bicoherence grid;TBispectrumGridForm;BispectrumColorGrid');
    Add(' Bicoherence test;TBicoherenceTestForm;BicoherenceTest');
    Add('Rate conversion;TIntroSignalRateForm');
    Add(' Decimation/interpolation;TInterpolateDecimateForm;InterpolateDecimate');
    Add(' Zoom-spectrum;TDemodulatorForm;Demodulator');
    Add(' Signal Modulator;TModulatorForm;Modulator');
    Add(' Narrow bandpass;TNarrowBandpassForm;NarrowBandpass');
    Add(' Envelope detection;TEnvelopeDemoForm;EnvelopeDemo');
    Add(' Rate conversion;TRateConvertForm;RateConvertUnit');
//    Add(' Variable rate conversion;TVarResampleForm;VarResample');
//    Add(' Variable rate conversion;TVariableRateConverterForm;VariableRateConverter');
    Add('Signal processing;TIntroSignalForm');
    Add(' Window based filters;TWindowFiltersForm;WindowFilters');
    Add(' Parks McClellan;TOptimalFiltersForm;OptimalFilters');
    Add(' IIR filters;TIirFilteringForm;IIRFiltering');
    Add(' Pole-Zero;TIirZerosForm;IIRZeros');                      
    Add(' Group delay;TIirGroupDelayForm;IirGroupDelay');
    Add(' Integration/Differentiation;TDifferentiatorForm;Differentiator');
    Add(' Phase shifters;TPhaseShifterForm;PhaseShifter');
    Add(' Savitzky-Golay filter;TSavGolayDemoForm;SavGolayDemo');
    Add(' Median filter;TMedianDemoForm;MedianDemo');
    Add(' Discrete series;TDiscreteSeriesDemoForm;DiscreteSeriesDemo');
    Add(' Phase demo;TPhaseDemoForm;PhaseDemo');
    Add(' Filter editor;TFiltersDemoForm;FiltersDemo');
    Add(' Signal analysis;TSignalAnalysisDemoForm;SignalAnalysisDemo');
    Add(' Circular buffer;TBufferForm;BufferUnit');
    Add(' Fractional filters;TFractionalFilteringForm;FractionalFiltering');
    Add('Signal generation;TIntroSignalGenerationForm');
    Add(' Signal generator;TGeneratorDemoForm;GeneratorDemo');
    Add(' Noise generation filters;TPinkNoiseForm;PinkNoise');
    Add(' Audio signal generator;TNoiseGeneratorForm;NoiseGenerator');
    Add(' Signal forecasting;TSpectralDecomposition;SpectralDecompositionForecast');

    Add('Kalman filter;TIntroKalmanForm');
    Add(' Kalman Basic filter;TBasicKalmanForm;BasicKalman');
    Add(' Kalman Standard filter;TKalmanFilterForm2;KalmanDemo2');
    Add(' Kalman Extended filter;TKalmanFilterForm3;KalmanDemo3');

    Add('WASAPI Support;TIntroWASAPIForm');
    Add(' Playback and recording;TAudioCoreDemoForm;AudioCoreDemo');
    Add('ASIO Support;TIntroASIOForm');
    Add(' Playback;TAsioPlaybackForm;AsioPlaybackUnit');
    Add(' Recording;TAsioRecordForm;AsioRecordingUnit');
    Add('Playback and Recording;TIntroPlaybackForm');
    Add(' Monitor playback;TPlaybackDemoForm;PlaybackDemo');
    Add(' Monitor recording;TMonitorDemoForm;MonitorDemo');
    Add(' Recording trigger;TTriggerDemoForm;TriggerDemo');
    Add(' Cross spectrum;TOnLineCoherenceForm;OnLineCoherence');
    Add(' Bicoherence;TOnLineBicoherenceForm;OnLineBicoherence');
    Add(' Phase scope;TPhaseScopeForm;PhaseScope');
    Add(' Lissajous;TLissajousScopeForm;LissajousScope');
    Add('Applications;TIntroApplicationForm');
    Add(' Spectrum analyzer;TSpcAnalyzerForm;SpcAnalyzer');
    Add(' Transfer function;TCoherenceTest2Form;CoherenceTest2');
    Add(' Bicoherence analyzer;TBiSpcAnalyzerForm;BiSpcAnalyzer');
    Add('Design;TIntroDesignForm');
    Add('Performance;TIntroPerformanceForm');
    Add('Function list;TIntroFunList');
    Add('Component list;TIntroCompListForm');
    Add('Registration;TRegisterSignalForm');
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var i,
    t        : Integer;
    tmpClass : String;
    tmpUnit  : String;
    tmp      : {$IFDEF CLR}TStream{$ELSE}TStringStream{$ENDIF};
    ExampleForm : TFormExampleInfo;
begin
  Caption := Application.Title;
  InitTreeItems;

  {$IFDEF CLR}  // Workaround for Classes.pas TStringStream bug...
  tmp:=TMemoryStream.Create;
  FormList.SaveToStream(tmp);
  tmp.Position:=0;
  {$ELSE}
  tmp:=TStringStream.Create(FormList.Text);
  {$ENDIF}

  try
    TreeView1.Visible := False;
    TreeView1.LoadFromStream(tmp);
    TreeView1.Visible := True;
  finally
    tmp.Free;
  end;

  with TreeView1 do
  begin
    for t:=0 to Items.Count-1 do
    with Items[t] do
    begin
      i:=Pos(';', Text);
      if i>0 then
      begin
        tmpClass:=Copy(Text, i+1, Length(Text));
        Text:=Copy(Text, 1, i-1);
        tmpUnit:='';
        i:=Pos(';',tmpClass);
        if i>0 then
        begin
          tmpUnit:=Copy(tmpClass,i+1,Length(tmpClass));
          tmpClass:=Copy(tmpClass,1,i-1);
        end;
        ExampleForm := TFormExampleInfo.Create;
        ExampleForm.FormClass:=TFormClass(FindClass(tmpClass));
        ExampleForm.UnitName:=tmpUnit;
        Data:=ExampleForm;
      end;
    end;
    Items[0].Expand(False);
  end;
  TreeView1.Visible := True;
  TreeView1.HotTrack:=True;
end;

Function TfrmMain.CodeFile:String;
begin
if Assigned(TreeView1.Selected) and
     Assigned(TreeView1.Selected.Data) then
     result:= TFormExampleInfo(TreeView1.Selected.Data).UnitName
  else
     result:='';
end;


procedure TfrmMain.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  PageControl1.ActivePage:=TabForm;
  ShowForm;
  with TreeView1 do
  begin
    btnPrevious.Enabled := Assigned(Selected) and (Selected.AbsoluteIndex>0);
    btnNext.Enabled := Assigned(Selected) and (Selected.AbsoluteIndex<Items.Count-1);
    TabSource.TabVisible:= CodeFile <> '';
  end;
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
  With TreeView1 do Items[Selected.AbsoluteIndex+1].Selected := true;
end;

procedure TfrmMain.Label3Click(Sender: TObject);
begin
//     ShellExecute(Handle,'open',PChar(TLabel(Sender).Caption),nil,nil,SW_SHOW);
end;

procedure TfrmMain.Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     TLabel(Sender).Font.Style := [fsUnderline];
end;

Const MtxVecRegKey='\Software\Dew Research';

Function CodePath:String;
begin
  result:='';
  With TRegistry.Create do
  try
    if OpenKeyReadOnly(MtxVecRegKey) then
       result:=ReadString('DSPDemoPath');
  finally
    Free;
  end;
  if result='' then
     if FileExists('BasicDemo.dpr') then
        result:=GetCurrentDir;
end;

Procedure HighLight(RichEdit:TCustomRichEdit);
var p   : Integer;
    tmp : String;

  Function IsKeyword(Const S:String):Boolean;
  Const Keywords:Array[0..33] of String=
         ('UNIT','INTERFACE','BEGIN','IMPLEMENTATION','PROCEDURE','INHERITED',
          'INITIALIZATION','END','CLASS','TYPE','VAR','PRIVATE','PUBLIC',
          'IF','ELSE','WHILE','FOR','REPEAT','RECORD','OBJECT','FUNCTION',
          'STRING','CONST','AND','NOT','IN','DO','THEN','WITH','USES',
          'TRY','FINALLY','EXCEPT','PACKED');

  var t:Integer;
  begin
    result:=False;
    for t:=0 to High(Keywords) do
    if Keywords[t]=S then
    begin
      result:=True;
      break;
    end;
  end;

  Function NextWordIsKeyword:Boolean;
  Const Valid=['A'..'Z','a'..'z','_'];
  var p2  : Integer;
      Key : String;
  begin
    While p<=Length(tmp) do
    begin
      {$IFDEF D12}
      if CharInSet(tmp[p], Valid) then
      {$ELSE}
      if tmp[p] in Valid then
      {$ENDIF}
         break
      else      
      if tmp[p]='{' then
      begin
        RichEdit.SelStart:=p-1;
        Inc(p);
        While tmp[p]<>'}' do Inc(p);
        With RichEdit do
        begin
          SelLength:=p-SelStart;
          With SelAttributes do
          begin
            Style:=[fsItalic];
            Color:=clNavy;
          end;
          SelStart:=0;
          SelLength:=0;
        end;
      end
      else Inc(p);
    end;

    p2:=p;
    While (p<=Length(tmp)) and
    {$IFDEF D12}
    (CharInSet(tmp[p], Valid))
    {$ELSE}
    (tmp[p] in Valid) 
    {$ENDIF}
    do Inc(p);
    if p=Length(tmp) then Inc(p);
    if p>p2 then
    begin
      key:=Copy(tmp,p2,p-p2);
      result:=IsKeyword(UpperCase(Key));
      RichEdit.SelStart:=p2-1;
      RichEdit.SelLength:=p-p2;
      Inc(p);
    end
    else result:=False;
  end;

begin
  p:=1;
  tmp:=RichEdit.Lines.Text;
  While p<Length(tmp) do
     if NextWordIsKeyword then
        RichEdit.SelAttributes.Style:=[fsBold];
  RichEdit.SelStart:=0;
  RichEdit.SelLength:=0;
end;


procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabSource then
  begin
    if not FileExists(CodePath+'\BasicDemo.dpr') then
    With TRegistry.Create do
    try
      DeleteKey(MtxVecRegKey);
    finally
      Free;
    end;

    btnConfig.Visible := CodePath='';
    if (CodePath<>'') and (CodeFile<>'') then
    begin
      if OldCodeFile<>CodeFile then
      begin
        RichEditCode.Free;
        RichEditCode:=TRichEdit.Create(Self);
        With RichEditCode do
        begin
          Align:=alClient;
          ReadOnly:=True;
          WordWrap:=False;
          ScrollBars:=ssBoth;
          Font.Name:='Courier New';
          Font.Size:=9;
          Parent:=TabSource;
          Lines.LoadFromFile(CodePath+'\'+CodeFile+'.pas');
        end;
        HighLight(RichEditCode);
        OldCodeFile:=CodeFile;
      end;
    end
    else RichEditCode.Free;
  end;
end;

procedure TfrmMain.btnConfigClick(Sender: TObject);
var tmpDir : String;
begin
  if SelectDirectory('Folder with DSP demo source',
                     '',tmpDir) then
  begin
    With TRegistry.Create do
    try
      if OpenKey(MtxVecRegKey,True) then
         WriteString('DSPDemoPath',tmpDir);
    finally
      Free;
    end;
    PageControl1Change(Self);
  end;
end;

procedure TfrmMain.btnPreviousClick(Sender: TObject);
begin
     With TreeView1 do Items[Selected.AbsoluteIndex-1].Selected := true;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
     Self.Close
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var i: integer;
begin
  FormList.Free;
  for i := 0 to TreeView1.Items.Count-1 do
    if Assigned(TreeView1.Items[i].Data) then TFormExampleInfo(TreeView1.Items[i].Data).Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage:=TabForm;
  TreeView1.Select(TreeView1.Items[0]);
end;

end.
