unit ForLoopExample;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MtxForLoop, MtxVec, MtxExpr, ExtCtrls, TeEngine, Series,
  TeeProcs, Chart, Math387;

type
  TForLoopExampleForm = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    MultiThreadedBox: TCheckBox;
    Button2: TButton;
    Chart: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Chart1: TChart;                                             
    FastLineSeries1: TFastLineSeries;
    Splitter1: TSplitter;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure OnComputationEnded2(Sender: TObject);
    procedure MyLoop3(LoopIndex: integer; const Context: TObjectArray; ThreadIndex: integer);
    { Private declarations }
  public
    { Public declarations }
    TimingResults: array of array of double;
  end;

  TExecuteThread = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  ForLoopExampleForm: TForLoopExampleForm;

implementation

uses MtxVecEdit, AbstractMtxVec;
var  ForLoop: TMtxForLoop;

{$R *.dfm}

procedure TForLoopExampleForm.FormCreate(Sender: TObject);
begin
    forLoop := TMtxForLoop.Create;
    ForLoopExampleForm := Self;
end;

procedure TForLoopExampleForm.FormDestroy(Sender: TObject);
begin
    forLoop.Free;
end;

procedure TForLoopExampleForm.FormResize(Sender: TObject);
begin
    Chart.Height := (ClientHeight - Panel1.Height) div 2;
end;

procedure TForLoopExampleForm.Timer1Timer(Sender: TObject);
begin
    if Assigned(forLoop) then
    begin
        Label1.Caption := 'Loop running time: ' + FormatSample(ForLoop.LoopRunningTime,'0.0') + 'ms';
    end;
end;

{ EXAMPLE 2 }

procedure TForLoopExampleForm.OnComputationEnded2(Sender: TObject);
var i, j, Len: integer;
begin
    if ForLoop.HasRaisedErrors then ShowMessage('Exceptions raised within threads: ' + ForLoop.ErrorMessages);

    for j := 0 to Length(TimingResults) - 1 do
    begin
        Len := 8;
        Chart.Series[j].Clear;
        for i := 0 to length(TimingResults[j])-1 do
        begin
            Chart.Series[j].AddXY(Len,TimingResults[j,i]);
            Len := 2*Len;
        end;
    end;

    Chart1.Series[0].Clear;
    Len := 8;
    for i := 0 to length(TimingResults[0])-1 do
    begin
        Chart1.Series[0].AddXY(Len,TimingResults[0,i]/TimingResults[1,i]);
        Len := 2*Len;
    end;

    for i := 0 to Length(MtxVec.Controller.Pool)-1 do //error checking
    begin
        Controller.Pool[i].Vec.DebugReport; //report any memory leaks
    end;

    Screen.Cursor := crDefault;
end;

{$IFDEF CLR}  { Vector not supported, need TVec }
procedure TestFunction(x,m,b, Result: TVec);
var c1,c2,c3: TVec;
begin
    CreateIt(c1,c2,c3); { allocate temporary variable (!!) }
    try
       c1.Sub(x, m);
       c2.Abs(c1);
       c2.Divide(b);
       c2.Scale(-1);
       c3.Exp(c2);
       c3.SubFrom(1);

       c1.sgn;
       c1.Add(1);
       c1.Mul(c3);
       c1.Scale(0.5);

       Result.Copy(c1);
    finally
       FreeIt(c1,c2,c3);
    end;
end;
{$ELSE}
function TestFunction(x,m,b: TVec): Vector;
var xm: Vector;
begin
     xm.Adopt(x); { convert to Vector to allow use of expressions }
     Result := 0.5*(1.0+ sgn(xm-m)*(1.0-Exp(-Abs(xm-m)/b)));
end;
{$ENDIF}

procedure TForLoopExampleForm.MyLoop3(LoopIndex: integer; const Context: TObjectArray; ThreadIndex: integer);
var k, LoopCount: integer;
    aResult: TVecList;
{    x,m,b: Vector; }
    c: Vector;
begin
{ Alternative for expression, not function, inside the loop:
    x.Adopt(TVec(Context[0]));
    m.Adopt(TVec(Context[1]));
    b.Adopt(TVec(Context[2])); }

    aResult := TVecList(Context[3]);

    LoopCount := (1024 *32) div TVec(Context[0]).Length; { adjust loopcount to match number of elements for each run }

    for k := 0 to LoopCount-1 do { do loop to make some work for the CPU }
    begin
        {$IFDEF CLR}
        c.Size(TVec(Context[0]));        
        TestFunction(TVec(Context[0]),TVec(Context[1]),TVec(Context[2]),c);
        {$ELSE}
        c := TestFunction(TVec(Context[0]),TVec(Context[1]),TVec(Context[2]));
        {$ENDIF}

      {  c := 0.5*(1.0+ sgn(x-m)*(1.0-Exp(-Abs(x-m)/b))); }

    end;
    aResult[LoopIndex].Copy(c); { use loopIndex, to indicate that all results should be distinct for each iteration. }
end;

procedure TForLoopExampleForm.Button2Click(Sender: TObject);
var aThread: TThread;    { needed only to allow monitoring of execution }
begin
    if not ForLoop.IsProcessingIdle then Exit;
    Screen.Cursor := crHourGlass;

    if MultiThreadedBox.Checked then ForLoop.ThreadCount := Controller.CpuCores
                                else ForLoop.ThreadCount := 1;
//    ForLoop.ResponseTime := 0;
//    ForLoop.ThreadWaitBeforeSleep := 100;

    aThread := TExecuteThread.Create(true);
    aThread.FreeOnTerminate := True;
    aThread.OnTerminate := OnComputationEnded2;
    aThread.Suspended := false;
end;

{ TExecuteThread2 }

procedure TExecuteThread.Execute;
var x,b,m: Vector;
    Results: TVecList;
    vecLen: integer;
    i, LoopCount, TestIdx: Integer;
begin
    LoopCount := 10;
    SetLength(ForLoopExampleForm.TimingResults, 2);
    SetLength(ForLoopExampleForm.TimingResults[0], LoopCount);
    SetLength(ForLoopExampleForm.TimingResults[1], LoopCount);

    Controller.SuperConductive := false;
    for TestIdx := 0 to 1 do
    begin
        VecLen := 8;
        for i := 0 to LoopCount - 1 do
        begin
            x.Size(VecLen);
            x.Ramp;
            b.Size(x);
            b.SetVal(1);
            m.Size(x);
            m.Ramp(0.5,1);

            Results := TVecList.Create;
            Results.Count := 401;
            DoForLoop(0,400, ForLoopExampleForm.MyLoop3, forLoop, [TVec(x),TVec(m),TVec(b),Results]);  //blocking calls
            Results.Free; { just forget the results in this case }

            ForLoopExampleForm.TimingResults[TestIdx,i] := forLoop.LoopRunningTime;
            vecLen := vecLen*2;
        end;
        Controller.SuperConductive := true;
    end;
end;

initialization
 RegisterClass(TForLoopExampleForm);

end.
