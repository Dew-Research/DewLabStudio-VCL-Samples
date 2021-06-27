unit Main;

{ Some features taken from TeeChart v5.0 demo program     }
{ Coded by David Berneda, Steema SL                       }
{ Demo compiled and tested with Delphi 7, 2005-2007       }
{$I BdsppDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls,Buttons
  {$IFDEF CLR}
  ,System.ComponentModel, Borland.Vcl.ExtCtrls, TeeJPEG, Borland.Vcl.XPMan
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
    btnClose: TSpeedButton;
    btnNext: TSpeedButton;
    btnPrevious: TSpeedButton;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    XPManifest1: TXPManifest;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure btnConfigClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FormList: TStringList;
    tmpForm : TForm;
    OldCodeFile: String;
    RichEditCode : TRichEdit;
    procedure InitTreeItems;
    procedure ShowForm;
    procedure ShowFormClass(AClass: TFormClass);
    function  CodeFile:String;
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
{$R *.NFM}
{$ELSE}
{$R *.DFM}
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

procedure TfrmMain.FormCreate(Sender: TObject);
var i,
    t        : Integer;
    tmpClass : String;
    tmpUnit  : String;
    tmp      : {$IFDEF CLR}TStream{$ELSE}TStringStream{$ENDIF};
    ExampleForm : TFormExampleInfo;
begin
  InitTreeItems;
  Caption  :=  Application.Title;

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
     TreeView1.HotTrack:=True;
     TreeView1.Select(TreeView1.Items[0]);
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

Const StatisticsRegKey='\Software\Dew Research';

Function CodePath:String;
begin
  result:='';
  With TRegistry.Create do
  try
    if OpenKeyReadOnly(StatisticsRegKey) then
       result:=ReadString('StatsMasterDemoPath');
  finally
    Free;
  end;
  if result='' then
     if FileExists('StatDemo.dpr') then
        result:=GetCurrentDir;
end;

Procedure HighLight(RichEdit:TCustomRichEdit);
var p   : Integer;
    tmp : String;

  Function IsKeyword(Const S: String):Boolean;
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
      if (tmp[p] in Valid) then
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
    CharInSet(tmp[p], Valid)
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
    if not FileExists(CodePath+'\StatDemo.dpr') then
    With TRegistry.Create do
    try
      DeleteKey(StatisticsRegKey);
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
  if SelectDirectory('Folder with Stats Master demo source',
                     '',tmpDir) then
  begin
    With TRegistry.Create do
    try
      if OpenKey(StatisticsRegKey,True) then
         WriteString('StatsMasterDemoPath',tmpDir);
    finally
      Free;
    end;
    PageControl1Change(Self);
  end;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
     Self.Close;
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
     With TreeView1 do Items[Selected.AbsoluteIndex+1].Selected := true;
end;

procedure TfrmMain.btnPreviousClick(Sender: TObject);
begin
     With TreeView1 do Items[Selected.AbsoluteIndex-1].Selected := true;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var i: Integer;
begin
  FormList.Free;
  for i := 0 to TreeView1.Items.Count-1 do
    if Assigned(TreeView1.Items[i].Data) then TFormExampleInfo(TreeView1.Items[i].Data).Free;
end;

procedure TfrmMain.InitTreeItems;
begin
  FormList := TStringList.Create;
  With FormList do
  begin
    Clear;
    Add('Welcome to Stats Master;TfrmWelcome');
    Add(' What''s new;TfrmWhatsNew');
    Add(' Function List;TfrmListFunc');
    Add('Random number generators;TfrmRandomGen;Random_Generator');
    Add('Fitting various models;TfrmModels;Fit_Model');
    Add('Hypothesis testing');
    Add(' Hypothesis testing editor;TfrmHypTest;Hypothesis_Test');
    Add(' Goodnes of Fit - Chi2 test;TfrmGOFChi2;GOF_Chi2');
    Add(' Goodnes of Fit - Kolmogorov-Smirnov test;TFrmGOFKS;GOF_KS');
    Add('Multivariate Analysis');
    Add(' Principal Component Analysis;TfrmShowPCAWizard;Wizard_PCA');
    Add(' Multidimensional scaling;TfrmShowMDSWizard;Wizard_MDS');
    Add(' Hotelling T2;TfrmShowHotellingWizard;Wizard_Hotelling');
    Add(' Item Analysis;TfrmItemAnalysis;Item_Analysis');
    Add('ANOVA (Analysis of variance)');
    Add(' Doing one way ANOVA;TfrmANOVA1Box;ANOVA1_Box');
    Add('Regression');
    Add(' Multiple linear regression;TfrmShowMLRWizard;Wizard_MLReg');
    Add(' Multiple linear regression Design-time Editor;TfrmMLREditor;MLR_Editor');
    Add(' Stepwise multiple linear regression;TMultiStepRegForm;MultiStepReg');
    Add(' Non-linear Regression;TfrmNonLinTest;NLin_Tests');
    Add(' Multiple Non-linear regression;TfrmMultiNonLinTest;MultiNLin_Tests');
    Add(' Logistic Regression;TfrmLogReg;LogReg_Demo');
    Add(' Principal Component Regression;TfrmShowPCRegWizard;Wizard_PCReg');
//    Add(' Ridge Regression;TfrmShowRidgeReg;Wizard_RidgeReg');
    Add('NIST Statistical Tests;TfrmNISTIntro');
    Add(' Non-linear regression;TfrmNonLinTest;NLin_Tests');
    Add(' Multiple Non-linear regression;TfrmMultiNonLinTest;MultiNLin_Tests');
    Add(' Analysis of variance;TfrmANOVATest;ANOVA_Tests');
    Add('Time series analysis');
    Add(' ACF and PACF plots;TfrmTSPACF;TS_PACF');
    Add(' Exponential smoothing;TfrmExpSmooth;TS_ExpSmooth');
    Add(' Decomposition forecasting;TfrmDecompDemo;Wizard_Decomp');
    Add(' Simulating ARMA/ARIMA models;TfrmARIMASim;TS_ARIMASim');
    Add(' ARMA and ARIMA models;TfrmWizardARIMA;WizardARIMA');
    Add(' Using ARAR model;TfrmARAR;TS_ARAR');
    Add('Quality Control Charts');
    Add(' Variables Control Charts;TfrmQCXR;QC_XR');
    Add(' Attribute Charts;TfrmQCAttr;QC_Attr');
    Add(' CP and CPK Charts;TfrmQCCP;QC_CP');
    Add(' Pareto Chart;TfrmParetoChart;QC_Pareto');
    Add(' EWMA Chart;TfrmEWMA;EWMA_Chart');
    Add(' Levey-Jennings Chart;TfrmLevey;QC_Levey');
    Add('Special statistical plots');
    Add(' Quantile-Quantile plot;TfrmQQPlot;QQPlot');
    Add(' Normal plot;TfrmNormalProb;NormalProbPlot');
    Add(' Weibull plot;TfrmWeibullProb;WeibullProbPlot');
    Add('TeeChart tools');
    Add(' Box Plot Chart;TfrmANOVA1Box;ANOVA1_Box');
    Add(' Histogram;TfrmRandomGen;Random_Generator');
    Add(' Pareto Chart;TfrmParetoChart;QC_Pareto');
    Add(' Using TColorLineTool;TfrmQCCP;QC_CP');
    Add(' New custom series');
    Add('  TStatSpecialSeries;TfrmQQPlot;QQPlot');
    Add('  TQCSeries;TfrmQCXR;QC_XR');
    Add('  TBiPlotSeries;TfrmBiPlot;BiPlotDemo');
    Add('List of Changes');
    Add(' Release 4.0');
    Add('  List of changes;TfrmChanges30');
    Add('  Principal Component Regression;TfrmShowPCRegWizard;Wizard_PCReg');
    Add(' Older versions');
//    Add('  Ridge Regression;TfrmShowRidgeReg;Wizard_RidgeReg');
    Add('  Release 2.1');
    Add('   List of changes;TfrmChanges21');
    Add('   Goodnes of Fit - Kolmogorov-Smirnov test;TFrmGOFKS;GOF_KS');
    Add('   Levey-Jennings Chart;TfrmLevey;QC_Levey');
    Add('   Hotelling T2;TfrmShowHotellingWizard;Wizard_Hotelling');
    Add('   Multidimensional scaling;TfrmShowMDSWizard;Wizard_MDS');
    Add('   Item Analysis;TfrmItemAnalysis;Item_Analysis');
    Add('   Biplot;TfrmBiPlot;BiPlotDemo');
    Add('   Time series analysis');
    Add('    ACF and PACF plots;TfrmTSPACF;TS_PACF');
    Add('    Exponential smoothing;TfrmExpSmooth;TS_ExpSmooth');
    Add('    Simulating ARMA/ARIMA models;TfrmARIMASim;TS_ARIMASim');
    Add('    ARMA and ARIMA models;TfrmWizardARIMA;WizardARIMA');
    Add('    ARAR model;TfrmARAR;TS_ARAR');
    Add('    Decomposition forecasting;TfrmDecompDemo;Wizard_Decomp');
    Add('  Release 1.1');
    Add('   List of changes;TfrmChanges11');
    Add('   EWMA Chart;TfrmEWMA;EWMA_Chart');
    Add('   Logistic regression;TfrmLogReg;LogReg_Demo');
    Add('   Goodnes of Fit - Chi2 test;TfrmGOFChi2;GOF_Chi2');
    Add('How to order;TfrmOrder');
    Add('Quick Start;TfrmQuickStart');
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage:=TabForm;
  TreeView1.Select(TreeView1.Items[0]);
end;

end.
