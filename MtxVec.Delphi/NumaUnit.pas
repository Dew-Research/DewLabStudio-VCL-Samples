unit NumaUnit;

interface

uses
  System.Types,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls,
  MtxExpr, MtxVec, math387, TeEngine, Series, ExtCtrls,
  TeeProcs, Chart
  ;

type
  TNumaForm = class(TForm)
    RunButton: TButton;
    Memo1: TMemo;
    Chart1: TChart;
    Series1: TBarSeries;
    ComputeKindGroup: TRadioGroup;
    Memo: TMemo;
    CountEdit: TEdit;
    Label1: TLabel;
    MemoryGroup: TRadioGroup;
    procedure RunButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    aLength, Count: Int64;
  end;

var
  NumaForm: TNumaForm;

implementation

uses MtxForLoop, AbstractMtxVec, MtxVecBase;

{$R *.dfm}

procedure DoThreading(LoopIndex: integer; const Context: TObjectArray; ThreadIndex: integer);
var a,b: Vector;
    i: integer;
    aSum: Double;
    aSelf: TNumaForm;
begin
    aSelf := TNumaForm(Context[0]);
    a.Size(aSelf.aLength);
    aSum := 0;
    case aSelf.ComputeKindGroup.ItemIndex of
    0:  for i := 0 to aSelf.Count-1 do
        begin
            b.Copy(a);
        end;
    1:  for i := 0 to aSelf.Count-1 do
        begin
            aSum := a.Sum;
        end;
    end;
    a[0] := aSum;
end;

procedure TNumaForm.RunButtonClick(Sender: TObject);
var k, channelCount: integer;
    aTime: array of double;
    aBandwidth, Factor: double;
begin
    if not Assigned(GlobalThreads) then GlobalThreads := TMtxForLoop.Create;
  //  GlobalThreads.ThreadCount := 16;
//    GlobalThreads.ThreadAffinityMode := TThreadAffinityMode.tamSplit4;
    Memo1.Lines.Clear;

    SetLength(aTime, GlobalThreads.ThreadCount);
    Series1.Clear;

    Factor := 0;
    case ComputeKindGroup.ItemIndex of
    0: Factor := 2;  //need to count both read and write
    1: Factor := 1; //counting only reads
    end;

    Count := StrToInt(CountEdit.Text);
    case MemoryGroup.ItemIndex of
    0: begin
       aLength := 1000;  //allocate up to 8KBytes large arrays
       Count := 10*1000*1000;
       end;
    1: begin
       aLength := 64 * 1000;  //allocate up to 500KBytes large arrays
       Count := 4*1000;
       end;
    2: begin
       aLength := 10 * 1000 * 1000;  //allocate up to 80MBytes large arrays
       Count := 7;
       end;
    end;

    Memo1.Lines.Add('Memory block size: ' + IntToStr(aLength*sizeof(TSample) div (1024*1024))  + 'MB');

    for k := 1 to Length(aTime) do
    begin
        channelCount := k;

        StartTimer;
        DoForLoop(0, channelCount-1, DoThreading, GlobalThreads, [Self]);
        aTime[k-1] := StopTimer;
        Memo1.Lines.Add('Time (Thread count = ' + IntToStr(k) + '): ' + FormatSample('0.00s', aTime[k-1]));
        aBandwidth := aLength*sizeof(TSample)*Count*channelCount*Factor/(aTime[k-1]*(1024*1024*1024));
        Memo1.Lines.Add('Bandwidth (Thread count = ' + IntToStr(k) + '): ' + FormatSample('0.0GB/s', aBandwidth));
        Series1.Add(aBandwidth, IntToStr(k)); //FormatSample('0.0', aBandwidth));
    end;
end;

procedure TNumaForm.FormCreate(Sender: TObject);
begin
    Memo.Lines.Add('When data blocks are too big to make them fit in to CPU cache and block processesing cant be applied, ' +
                   'then the performance depends upon the raw main memory bandwidth. Main memory bandwidth is defined ' +
                   'with its data rate per memory channel and with memory channel count. A single thread can use at ' +
                   'most a single main memory channel. For an application to use more than one memory channel, it ' +
                   'needs to distribute the processing across multiple threads. ' +
                   'At a minimum, the thread count needs to match memory channel count. For a two socket system with 6 memory channels ' +
                   'per CPU, the memory bandwidth will come to be fully used only with 2x6 = 12 threads. ' +
                   'About 30% more performance can sometimes be gained by allocating two threads per memory channel to work ' +
                   'over any inefficencies in data prefetching. Typical desktop computers today have two memory channels with ' +
                   'typical memory bandwidth per channel around 15GB/s. Recommendations for multi-socket HPC machines (servers): ' +
                   '1.) Always allocate working memory from within the thread, which will use that memory. That ' +
                   'will make it much easier for the OS to keep that memory on the same NUMA node as the thread. ' +
                   '2.) Install more memory per NUMA node than what will be needed to avoid memory being swapped out ' +
                   'to disk or moved to another NUMA node.');
end;

procedure TNumaForm.FormDestroy(Sender: TObject);
begin
    if Assigned(GlobalThreads) then
    begin
        GlobalThreads.Free;
        GlobalThreads := nil;
    end;
end;

initialization
   RegisterClass(TNumaForm);

end.
