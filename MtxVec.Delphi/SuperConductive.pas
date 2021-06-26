unit SuperConductive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MtxBaseComp, MtxDialogs, StdCtrls, MtxExpr, MtxComCtrls, Math387,
  MtxVecBase, MtxVec, AbstractMtxVec, SyncObjs, ExtCtrls, TeEngine, TeeProcs, Chart, Series;

type

  TTestMethod = (tmGetMem, tmTVec, tmVector, tmVectorGlobal);

  TSuperConductiveForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Thread1Label: TLabel;
    Label41: TLabel;
    Thread2Label: TLabel;
    Label31: TLabel;
    Bevel1: TBevel;
    FullRunButton: TButton;
    MultithreadBox: TCheckBox;
    VectorLenEdit: TMtxFloatEdit;
    TestBox: TComboBox;
    SuperConductiveMMBox: TCheckBox;
    Thread1: TMtxProgressDialog;
    Chart: TChart;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Thread4Label: TLabel;
    Thread3Label: TLabel;
    Label5: TLabel;
    procedure Thread1Compute(Sender: TObject);
    procedure Thread1ProgressUpdate(Sender: TObject; Event: TMtxProgressEvent);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FullRunButtonClick(Sender: TObject);
  private
    Working: boolean;
    { Private declarations }
    TimeStart: array of Int64;
    TimedThread: array of double;
    FTestMethod: TTestMethod;
    cpuCores: integer;
    procedure SetTestMethod(const Value: TTestMethod);
  public
    Timings: array of array of array [0..2] of double;
    Threads: array of TMtxProgressDialog;
    ak,ac: integer;
    CacheIndex1, CacheIndex2: integer;
    { Public declarations }
    av,bv,cv,dv: array of Vector;
    VectorLen: integer;
    Stage: integer;
    property TestMethod: TTestMethod read FTestMethod write SetTestMethod;
  end;

var
  SuperConductiveForm: TSuperConductiveForm;

implementation

uses StringVar;

{$R *.dfm}

procedure TSuperConductiveForm.FullRunButtonClick(Sender: TObject);
var i,j, k: Integer;
  a,b: Boolean;
  aSeries: TChartSeries;
  threadDim: StringList;
  aSum: TSample;
begin
    if Working then Exit;
    Working := true;

    a := True;
    b := MultithreadBox.Checked;

    threadDim.Add('Single threaded');
    threadDim.Add('Multi-threaded, standard');
    threadDim.Add('Multi-threaded, super-conductive ');

    VectorLen := VectorLenEdit.IntPosition;

    for j := 0 to TestBox.Items.Count - 1 do
    begin
        TestMethod := TTestMethod(j);

        for i := 0 to ThreadDim.Count-1 do
        begin
            for k := 0 to Length(av) - 1 do
            begin
                av[k] := dv[k];
                bv[k] := dv[k];
                cv[k] := dv[k];
            end;

            Stage := i;
            case Stage of
            0: begin //single threaded
               a := True;
               b := false;
               end;
            1: begin //multi-threaded, standard memory manager
               Controller.SuperConductive := False; // ThreadDimension := 1;
               a := True;
               b := True;
               end;
            2: begin   //multi-threaded, super conducting
               Controller.SuperConductive := True; //Controller.ThreadDimension := 4;
               a := True;
               b := True;
               end;
            end;

            ak := 0;
            ac := 0;

            Threads[0].Loops := 1200000 div VectorLen;
            if VectorLen > 20 then Threads[0].Loops := Threads[0].Loops*6;
            if VectorLen > 200 then Threads[0].Loops := Threads[0].Loops*6;
            if VectorLen > 2000 then Threads[0].Loops := Threads[0].Loops*6;

            for k := 1 to Length(Threads) - 1 do Threads[k].Loops := Threads[0].Loops;

            if a then Threads[0].Start;

            if b then
              for k := 1 to Length(Threads) - 1 do
              begin
                   Threads[k].Start;
              end;

            Thread1Label.Caption := 'Please wait...';
            Thread2Label.Caption := 'Please wait...';
            Thread3Label.Caption := 'Please wait...';
            Thread4Label.Caption := 'Please wait...';

            for k := 0 to Length(Threads) - 1 do Threads[k].WaitToFinish;
        end;
    end;

    for i := 0 to TestBox.Items.Count - 1 do
    begin
        if Chart.SeriesCount <= i then
        begin
            aSeries := Chart.AddSeries(TBarSeries);
            TBarSeries(aSeries).Marks.Visible := false;
            aSeries.Title := TestBox.Items[i];
        end else aSeries := Chart.Series[i];

        aSeries.Clear;
//        for j := 0 to 2 do
//        begin
//            Timings[0,i,j] := Max(Timings[0,i,j], Timings[1,i,j]);
//            aSeries.AddY(Timings[0,i,j]*1000,ThreadDim[j]);
//        end;
        for j := 0 to 2 do
        begin
            aSum := 0;
            for k := 0 to Length(timings)-1 do
            begin
                aSum := aSum + Timings[k,i,j];
            end; //j = 0, single thread, only one thread was running
            if j > 0 then aSum := aSum/Length(timings); //compute the average
            aSeries.AddY(aSum*1000,ThreadDim[j]);
        end;
    end;

    Sleep(100);  //allow the threads to start
    Working := false;
end;

procedure TSuperConductiveForm.Button2Click(Sender: TObject);
var a,b: Boolean;
    i: integer;
begin
    if Working then Exit;
    Working := true;

    a := True;
    b := MultithreadBox.Checked;

    TestMethod := TTestMethod(TestBox.ItemIndex);
    VectorLen := VectorLenEdit.IntPosition;

    for i := 0 to Length(av) - 1 do
    begin
        av[i] := dv[i];
        bv[i] := dv[i];
        cv[i] := dv[i];
    end;

    Controller.SuperConductive := SuperConductiveMMBox.Checked;

    ak := 0;
    ac := 0;

    Thread1.Loops := 1200000 div VectorLen;
    if VectorLen > 20 then Threads[0].Loops := Threads[0].Loops*6;
    if VectorLen > 200 then Threads[0].Loops := Threads[0].Loops*6;
    if VectorLen > 2000 then Threads[0].Loops := Threads[0].Loops*6;

    for i := 1 to Length(Threads) - 1 do Threads[i].Loops := Threads[0].Loops;

    StartTimer(TimeStart[0]);
    if a then Threads[0].Start;

    if b then
      for i := 1 to Length(Threads) - 1 do
      begin
          StartTimer(TimeStart[i]);      
          Threads[i].Start;
      end;

    Thread1Label.Caption := 'Please wait...';
    Thread2Label.Caption := 'Please wait...';
    Thread3Label.Caption := 'Please wait...';
    Thread4Label.Caption := 'Please wait...';

    for i := 0 to Length(Threads) - 1 do Threads[i].WaitToFinish;

    Sleep(100);  //allow the threads to start
    Working := false;
end;

procedure TSuperConductiveForm.FormCreate(Sender: TObject);
var i: integer;
begin
    TestBox.ItemIndex := 0;

    cpuCores := Controller.CpuCores div 2;
    SetLength(Timings, cpuCores, TestBox.Items.Count);
    SetLength(Threads, cpuCores);
    SetLength(TimedThread, cpuCores);

    for I := 0 to Length(Threads)-1 do
    begin
        Threads[i] := TMtxProgressDialog.Create(Self);
        Threads[i].OnCompute := Thread1Compute;
        Threads[i].OnProgressUpdate := Thread1ProgressUpdate;
        Threads[i].Loops := Thread1.Loops;
        Threads[i].Min := Thread1.Min;
        Threads[i].Max := Thread1.Max;
        Threads[i].FreeOnTerminate := False;
        Threads[i].InfiniteLoop := False;
        Threads[i].InternalLoop := True;
        Threads[i].ShowDialog := False;
        Threads[i].UpdateInterval := 80;
        Threads[i].Tag := i;
    end;

    SetLength(av, cpuCores);
    SetLength(bv, Length(av));
    SetLength(cv, Length(av));
    SetLength(dv, Length(av));
    SetLength(TimeStart, cpuCores);
end;

procedure TSuperConductiveForm.SetTestMethod(const Value: TTestMethod);
begin
  FTestMethod := Value;
end;

procedure TSuperConductiveForm.Thread1Compute(Sender: TObject);
var a,b,c: Vector;
    av1,bv1,cv1: TVec;
    ap, bp, cp: PByte; ///TByteArray;
    ByteLen, k: integer;
    aThread: TMtxProgressDialog;
begin
    aThread := TMtxProgressDialog(Sender);
    k := aThread.Tag;
    if aThread.Counter = aThread.Min then
    begin
        StartTimer(TimeStart[k]);
    end;

    case TestMethod of
      tmGetMem: begin
                    ByteLen := VectorLen*sizeof(TSample);
//                    SetLength(ap, ByteLen);
//                    SetLength(bp, ByteLen);
//                    SetLength(cp, ByteLen);
                    GetMem(ap,ByteLen);
                    GetMem(bp,ByteLen);
                    GetMem(cp,ByteLen);
                    FreeMem(ap);
                    FreeMem(bp);
                    FreeMem(cp);

//                    ap := nil;
//                    bp := nil;
//                    cp := nil;
                end;
      tmTVec:   begin
                    CreateIt(av1,bv1,cv1);

                    av1.Size(VectorLen);
                    bv1.Size(VectorLen);
                    cv1.Size(VectorLen);

                    FreeIt(av1,bv1,cv1);

                end;
      tmVector: begin
                    a.Size(VectorLen);
                    b.Size(VectorLen);
                    c.Size(VectorLen);

                    a := dv[k];
                    b := dv[k];
                    c := dv[k];
                end;
      tmVectorGlobal:
                begin
                    av[k].Size(VectorLen);
                    bv[k].Size(VectorLen);
                    cv[k].Size(VectorLen);

                    av[k] := dv[k]; //free the memory
                    bv[k] := dv[k];
                    cv[k] := dv[k];
                end;
    end;

    if aThread.Counter = aThread.Max then
    begin
        TimedThread[Integer(aThread.Tag)] := StopTimer(TimeStart[Integer(aThread.Tag)]);
        Timings[Integer(aThread.Tag), integer(TestMethod), Stage] := TimedThread[Integer(aThread.Tag)];
    end;
end;

procedure TSuperConductiveForm.Thread1ProgressUpdate(Sender: TObject;
  Event: TMtxProgressEvent);
var aThread: TMtxProgressDialog;
var strCycle: string;
    strCleanUp: string;
begin
    aThread := TMtxProgressDialog(Sender);
    StrCycle := 'Thread ' + IntToStr(aThread.Tag) + ' counter: ' + IntToStr(aThread.Counter);
    strCleanUp := 'Thread ' + IntToStr(aThread.Tag) + ' time needed: ' + FormatSample(TimedThread[Integer(aThread.Tag)]*1000, '0.0') + 'ms';
    case Event of
      peInit: ;
      peCycle: case Integer(aThread.Tag) of
               0: label1.Caption := StrCycle;
               1: label2.Caption := StrCycle;
               2: label3.Caption := StrCycle;
               3: label4.Caption := StrCycle;
               end;
      peCleanUp:
              case Integer(aThread.Tag) of
              0:  Thread1Label.Caption := strCleanUp;
              1:  Thread2Label.Caption := strCleanUp;
              2:  Thread3Label.Caption := strCleanUp;
              3:  Thread4Label.Caption := strCleanUp;
              end;
    end;
end;

{ TThread2 }

initialization
   RegisterClass(TSuperConductiveForm);

end.
