unit Main;

{ Some features taken from TeeChart v5.0 demo program }
{ Coded by David Berneda, Steema SL                   }

interface

{$I BdsppDefs.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, jpeg, ExtCtrls
  {$IFDEF CLR}
  ,System.ComponentModel,Borland.Vcl.ExtCtrls, TeeJPEG
  {$ELSE}
//  ,jpeg, ExtCtrls WinAPI.Windows
  {$ENDIF}
  ;

type
  TfrmMain = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    Label1: TLabel;
    Image1: TImage;
    PageControl1: TPageControl;
    TabForm: TTabSheet;
    TabSource: TTabSheet;
    btnConfig: TButton;
    btnClose: TSpeedButton;
    btnPrevious: TSpeedButton;
    btnNext: TSpeedButton;
    Image3: TImage;
    Image2: TImage;
    TreeView1: TTreeView;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure btnNextClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    tmpForm : TForm;
    OldCodeFile: String;
    RichEditCode : TRichEdit;
    FormList: TStringList;
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
{$IFDEF CLR}
{$R *.nfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

Uses Registry, FileCtrl, MtxVec, Math387;

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

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    tmpForm.Free;
    tmpForm := nil;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var i, t     : Integer;
    tmpClass : String;
    tmpUnit  : String;
    tmp      : {$IFDEF CLR}TStream{$ELSE}TStringStream{$ENDIF};
    ExampleForm : TFormExampleInfo;
begin
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

//  {$IFDEF CLR}
//  Application.Title := 'Dew Research MtxVec ' + FormatSample('0.0',MtxVecVersion/100) +  ' .NET VCL demo';
//  {$ELSE}
//  Application.Title := 'Dew Research MtxVec ' + FormatSample('0.0',MtxVecVersion/100) + ' W32 demo';
//  {$ENDIF}

  {$IFDEF CPUX86}
  Application.Title := 'Dew Lab Studio for Delphi - MtxVec v' + FormatSample('0.00',MtxVecVersion/100) + ' W32 demo';
  {$ENDIF}

  {$IFDEF CPUX64}
  Application.Title := 'Dew Lab Studio for Delphi - MtxVec v' + FormatSample('0.00',MtxVecVersion/100) + ' W64 demo';
  {$ENDIF}

  Caption := Forms.Application.Title;
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

Const MtxVecRegKey='\Software\Dew Research';

Function CodePath:String;
begin
  result:='';
  With TRegistry.Create do
  try
    if OpenKeyReadOnly(MtxVecRegKey) then
       result:=ReadString('MtxVecDemoPath');
  finally
    Free;
  end;
  if result='' then
     if FileExists('MtxVecDemoW32_D16.dpr') then
        result:=GetCurrentDir;
end;

Procedure HighLight(const RichEdit:TCustomRichEdit; const ACommentColor:TColor);
var p   : Integer;
    Len : Integer;
    tmp : String;


  Function IsKeyword(Const S:String):Boolean;
  Const Keywords:Array[0..50] of String=
         ('UNIT','INTERFACE','BEGIN','IMPLEMENTATION','PROCEDURE','INHERITED',
          'INITIALIZATION','END','CLASS','TYPE','VAR','PRIVATE','PUBLIC',
          'IF','ELSE','WHILE','FOR','REPEAT','RECORD','OBJECT','FUNCTION',
          'STRING','CONST','AND','NOT','IN','DO','THEN','WITH','USES',
          'TRY','FINALLY','EXCEPT','PACKED','CASE','OF','OVERLOAD','DEPRECATED',
          'AS','IS','FINALIZATION','OVERRIDE','SEALED','STATIC','OPERATOR',
          'STRICT','NIL','TRUE','FALSE','REFERENCE','VIRTUAL');


  var t:Integer;
  begin
    for t:=0 to High(Keywords) do
    if Keywords[t]=S then
    begin
      result:=True;
      exit;
    end;


    result:=False;
  end;


  Function NextWordIsKeyword:Boolean;

    Procedure HighLightComment(const EndChar:Char);
    begin
      RichEdit.SelStart:=p-1;
      Inc(p);
      While (p<=Len) and (tmp[p]<>EndChar) do
        Inc(p);

      With RichEdit do
      begin
        SelLength:=p-SelStart;
        With SelAttributes do
        begin
          Style:=[fsItalic];
          Color:=ACommentColor;
        end;

        SelStart:=0;
        SelLength:=0;
      end;
    end;

  Const Valid=['A'..'Z','a'..'z','_'];
  var p2  : Integer;
      Key : String;
  begin
    While p<=Len do
    begin
      if {$IFDEF D12}CharInSet({$IFDEF CLR}AnsiChar{$ENDIF}(tmp[p]), Valid){$ELSE}({$IFDEF CLR}AnsiChar{$ENDIF}(tmp[p]) in Valid){$ENDIF} then
         break
      else
      if tmp[p]='{' then
         HighLightComment('}')
      else
      if (tmp[p]='/') and ((p+1)<=Len) and (tmp[p+1]='/') then
         HighLightComment(#13)
      else
         Inc(p);
    end;
    p2:=p;
    While (p<=Len) and {$IFDEF D12}CharInSet({$IFDEF CLR}AnsiChar{$ENDIF}(tmp[p]), Valid){$ELSE}({$IFDEF CLR}AnsiChar{$ENDIF}(tmp[p]) in Valid){$ENDIF} do Inc(p);
    if p=Len then
       Inc(p);

    if p>p2 then
    begin
      key:=Copy(tmp,p2,p-p2);
      result:=IsKeyword(UpperCase(Key));

      RichEdit.SelStart:=p2-1;
      RichEdit.SelLength:=p-p2;
      Inc(p);
    end
    else
      result:=False;
  end;

  function RemoveCRLF(const S:String):String;
  var i : Integer;
  begin
    result:=S;
    repeat
//       i:=Pos(#13#10,result);
       i:=Pos(#10,result);
       if i>0 then
          Delete(result,i,1);
    until i=0;
  end;

begin
  RichEdit.Lines.BeginUpdate;
  try
    p:=1;

    {$IFDEF D12} // D2009 an up, remove #10
    tmp:=RemoveCRLF(RichEdit.Lines.Text);
    {$ELSE}
    tmp:=RichEdit.Lines.Text;
    {$ENDIF}

    Len:=Length(tmp);
    While p<Len do
       if NextWordIsKeyword then
          RichEdit.SelAttributes.Style:=[fsBold];

    RichEdit.SelStart:=0;
    RichEdit.SelLength:=0;
  finally
    RichEdit.Lines.EndUpdate;
  end;
end;

(*
Procedure HighLight(RichEdit:TCustomRichEdit);
var p   : Integer;
    tmp : String;

  Function IsKeyword(Const S:String):Boolean;
  Const Keywords:Array[0..46] of String=
         ('UNIT','INTERFACE','IMPLEMENTATION','USES',
          'INITIALIZATION','FINALIZATION','INHERITED','OBJECT','RECORD','PACKED','ARRAY',
          'BEGIN','END','CLASS','INTERFACE','TYPE','VAR','CONST','IN','OUT',
          'PRIVATE','PUBLIC','PROTECTED','PUBLISHED','FUNCTION','PROCEDURE','CONSTRUCTOR','DESTRUCTOR',
          'IF','ELSE','WHILE','FOR','REPEAT','UNTIL','AND','NOT','IN','DO','THEN','WITH','CASE','OF',
          'TRY','FINALLY','EXCEPT',
          'STRING','NIL');

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
      if CharInSet(tmp[p], Valid) then
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
            Color:=clGreen;
          end;
          SelStart:=0;
          SelLength:=0;
        end;
      end
      else Inc(p);
    end;

    p2:=p;
    While (p<=Length(tmp)) and CharInSet(tmp[p], Valid) do Inc(p);
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
*)

procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabSource then
  begin
    if not FileExists(CodePath+'\MtxVecDemoW32_D16.dpr') then
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
        HighLight(RichEditCode, clGreen);
        OldCodeFile:=CodeFile;
      end;
    end
    else RichEditCode.Free;
  end;
end;

procedure TfrmMain.btnConfigClick(Sender: TObject);
var tmpDir : String;
begin
  if SelectDirectory('Folder with MtxVec demo source',
                     '',tmpDir) then
  begin
    With TRegistry.Create do
    try
      if OpenKey(MtxVecRegKey,True) then
         WriteString('MtxVecDemoPath',tmpDir);
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
    Add('Introduction;TIntroduction');
    Add(' Why MtxVec;TIntroWhyMtxVecForm');
    Add('What is new;TfrmChanges30');
    Add('How to use the demo;TfrmDemoHowTo');
    Add('Matrix operations;TIntroMtx');
    Add(' Multiplying large matrices;TMult1;Multiply1');
    Add(' Multiplying small matrices;TfrmSmallMatrix;SmallMatrixMul');
    Add(' Copy and  transpose operation;TCopyComp;CopyCompare');
    Add(' Calculating the inverse of squared matrix;TInvMtx;InverseMtx');
    Add(' Calculating squared root of matrix;TfrmSqrtMtx;CalcSqrtMtx');
    Add(' Eigenvalues and eigenvectors;TEigVec1;EigenVectors1');
    Add(' LQ and QR decomposition;TLQRDemo;LQR1');
    Add(' Solving system of equations;TLinearSystem1;SysLinear1');
    Add(' Viewing matrix values;TfrmMtxGridSeries;MtxGridSeries_Demo');
    Add('Vector operations;TIntroVec');
    Add(' Levinson Yule Walker;TYuleLev;YuleLevinson');
    Add(' Displaying large amounts of data;TDownS;PixelDownS');
    Add(' Block Processing;TfrmBlockProc;BlockProcessing');
    Add(' Dirichlet and Riemann functions;TfrmDirichlet;DirichletTest');
    Add(' Benchmarks;TBenchmarkXForm;BenchmarkX');
    Add(' New fastline series;TMtxFastLineForm;MtxFastlineDemo');
    Add(' Threaded for-loop;TForLoopForm;ForLoopUnit');
    Add(' Efficient multithreading;TMtxVecThreadingForm;MtxVecThreading');
    Add(' Vectorizing if-then;TIfThenForm;IfThenUnit');
    Add(' Compound expressions;TCompoundExpressionsForm;CompoundExpressions');
    Add('Exporting/Importing;TIntroExpImp');
    Add(' Saving/Loading;TFileH1;FileHandling1');
    Add(' MSOffice;TMSOffice;ClipboardMSOffice');
    Add(' Editing matrix or vector values;TfrmGridDemo;MtxVecGridDemo');
//    Add(' Different file formats;TfrmFileFormats;DemoFileFormats');
    Add('Memory management;TIntroMemMan');
    Add(' Comparing CreateIt/FreeIt with Create/Destroy;TMemComp1;MemoryCompare1');
    Add(' Super conductive multi-threaded memory alloc;TSuperConductiveForm;SuperConductive');
    Add(' Threading concurrency;TForLoopExampleForm;ForLoopExample');
    Add(' Using default arrays;TDefArray;DefaultArray');
    Add(' Memory channels;TNumaForm;NumaUnit');
    Add('Open CL support;TIntroOpenCLForm');
    Add(' Benchmarks;TclFunctionForm;clFunction');
    Add(' Custom function;TclCustomFunctionForm;clCustomFunction');
    Add(' Multi device benchmark;TclMultiDeviceFunctionForm;clMultiDeviceFunction');
    Add('Numerical integration');
    Add(' Numerical integration: f(x);TfrmInt1D;NumInt1D');
    Add('Polynomial routines;TIntroPoly');
    Add(' Linear and cubic interpolation;TInterpolating1;Interp1');
    Add(' Least-square fitting;TLQRPoly;QRPoly1');
    Add('Optimization problems');
    Add(' Bounded optimization (Simplex);TfrmOptimBounded;Optim_Bounded');
    Add(' Trust Region algorithm;TfrmTRDemo;Optim_TR');
    Add(' Linear Programming;TfrmLP;Optim_LP');
    Add(' Unconstrained global minimization;TfrmMtxOptim;MtxOptim');
    Add('Probabilities unit;TfrmProbCalc;DewProbCalc');
    Add('Sparse matrices;TIntroSparseMtx');
    Add(' Sparse solvers;TfrmSparseTest;SparseTest');
    Add('MtxVec Components');
    Add(' Unconstrained global minimization;TfrmMtxOptim;MtxOptim');
    Add(' TMtxFloatEdit control;TfrmFloatEdit1;FloatEdit1');
    Add(' Progress Dialog;TfrmProgDialog;ProgDialog');
    Add(' TMtxVecGrid control;TfrmGridDemo;MtxVecGridDemo');
    {$IFNDEF CLR}
    Add(' Math Parser;TfrmParser;ParserDemo');
    {$ENDIF}
    Add('MtxVec Parser;TIntroParserForm');
    Add(' Scripting;TScriptingForm;Scripting');
    Add(' Scripting with grid;TScriptingGridForm;ScriptingGrid');
    Add(' Parser usage;TfrmParserUsage;ParserUsage');
    Add(' Vectorized performance;TfrmParserPerformance;ParserPerformance');
    Add('MtxVec package function list;TfrmListFunc');
    Add('List of changes');
    Add(' Version 3.x;TfrmChanges30');
//    Add(' Version 4.0;TfrmChanges40');
    Add(' Older versions');
    Add('  Version 2.1.5;TfrmChanges15');
    Add('  Version 1.02;TfrmChanges102');
    Add('  Version 1.01;TfrmChanges101');
    Add('Registering MtxVec;TRegisterM');
    Add('Quick Start;TQStart');
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage:=TabForm;
  TreeView1.Select(TreeView1.Items[0]);

  ShowMessageBox('Each form in the demo is a stand-alone application which can ' +
              'be added to a new project to form a self contained application. ' +
              'There are no code dependancies between individual forms!');
end;

end.
