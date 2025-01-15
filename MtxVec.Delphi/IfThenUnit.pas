unit IfThenUnit;

{$I bdsppdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Types,
  Controls, Forms, Dialogs, StdCtrls, MtxVec, MtxExpr, Math387, MtxExprInt,
  MtxVecTee, MtxVecInt, MtxForLoop, ippspl,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TIfThenForm = class(TForm)
    Memo1: TMemo;
    MaskThreadButton: TButton;                                     
    Chart: TChart;
    barSeries: TBarSeries;
    PlainBox: TCheckBox;                               
    VecBox: TCheckBox;
    FindIndexBlockBox: TCheckBox;
    MaskBlockThreadBox: TCheckBox;
    PlainThreadBox: TCheckBox;
    MaskBlockBox: TCheckBox;
    DataLenBox: TComboBox;
    Label1: TLabel;
    GranBox: TComboBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure MaskThreadButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TThreadStats = record
    TotalTime: double;
    PoolIndex: integer;
    aCI: integer;
    bCI: integer;
    agCI: integer;
    bgCI: integer;
    aiCI: integer;
    cCI: integer;
    TotalLength: integer;
    BlockLength: integer;
  end;

var
  IfThenForm: TIfThenForm;

implementation

uses MtxVecBase, AbstractMtxVec;

const DPOS_FRAC: double =0.5;
const SPOS_FRAC: single =0.5;

var stats: array of TThreadStats;

{$R *.dfm}

procedure DoAssign(var Dst: integer; const Src: integer);
begin
    if Dst = -2 then Dst := Src else
    begin
//        if Dst <> Src then ERaise('Problem');
    end;
end;

procedure ForLoopR(IdxMin, IdxMax: integer; const Context: TObjectArray; ThreadIndex: integer);
var ag,bg: Vector;
    a,b: Vector;
    ai: VectorInt;
    c: Vector;
    aTimer: Int64;
begin
    StartTimer(aTimer);

    ag.SetSubRange(TVec(Context[0]), IdxMin, IdxMax - idxMin + 1);
    bg.SetSubRange(TVec(Context[1]), IdxMin, IdxMax - idxMin + 1);

    a.BlockInit(ag);
    b.BlockInit(bg);

    stats[ThreadIndex].BlockLength := TVec(a).Length;

    while not a.BlockEnd do
    begin
        ai.FindMask(a, '>=', dpos_frac);
        c.GatherByMask(b, ai);

//        d.Normalize(c,-1,0.5);
        c.Add(1);
        c.Mul(2);
        b.ScatterByMask(c, ai);

        a.BlockNext;
        b.BlockNext;
    end;

    DoAssign(stats[ThreadIndex].PoolIndex, TVec(ag).PoolIndex);
    DoAssign(stats[ThreadIndex].TotalLength, TVec(ag).Length);
    DoAssign(stats[ThreadIndex].aCI, TVec(a).CacheIndex);
    DoAssign(stats[ThreadIndex].bCI, TVec(b).CacheIndex);
    DoAssign(stats[ThreadIndex].cCI, TVec(c).CacheIndex);
    DoAssign(stats[ThreadIndex].agCI, TVec(ag).CacheIndex);
    DoAssign(stats[ThreadIndex].bgCI, TVec(bg).CacheIndex);
    DoAssign(stats[ThreadIndex].aiCI, TVecInt(ai).CacheIndex);

    // not needed, because it is cleaned up by the compiler at the end of the function,
    // but included here to include this in to the timing
    ag.Adopt(nil);
    bg.Adopt(nil);
    a.Adopt(nil);
    b.Adopt(nil);
    c.Adopt(nil);
    ai.Adopt(nil);

    stats[ThreadIndex].TotalTime := StopTimer(aTimer);
end;


procedure ForLoopRI(IdxMin, IdxMax: integer; const Context: TObjectArray; ThreadIndex: integer);
var ag,bg: Vector;
    i: integer;
    a, b: TVec;
begin
    ag.SetSubRange(TVec(Context[0]), IdxMin, IdxMax - idxMin + 1);
    bg.SetSubRange(TVec(Context[1]), IdxMin, IdxMax - idxMin + 1);

    a := ag;
    b := bg;

    if a.IsDouble then
    begin
        for i := 0 to a.Length-1 do
        begin
            if a.Values[i] >= DPOS_FRAC then b.Values[i] := (b.Values[i] + 1.0)*2.0;
        end;
    end else
    begin
        for i := 0 to a.Length-1 do
        begin
            if a.SValues[i] >= SPOS_FRAC then b.SValues[i] := (b.SValues[i] + 1)*2;
        end;
    end;
end;

procedure TIfThenForm.MaskThreadButtonClick(Sender: TObject);
var a,b1,b2,c: Vector;
    ai: VectorInt;
    ar: TDoubleArray;
    i, DataLen: integer;
begin
    SetLength(stats, GlobalThreads.ThreadCount);
    for i := 0 to Length(Stats)-1 do
    begin
        Stats[i].TotalTime := -2;
        Stats[i].PoolIndex := -2;
        Stats[i].TotalLength := -2;
        Stats[i].BlockLength := -2;
        Stats[i].aCI := -2;
        Stats[i].bCI := -2;
        Stats[i].cCI := -2;
        Stats[i].agCI := -2;
        Stats[i].bgCI := -2;
        Stats[i].aiCI := -2;
    end;

    BarSeries.Clear;
    SetLength(ar, 6);

    DataLen := 100000 * Round(Exp10(DataLenBox.ItemIndex));

    a.Size(DataLen);
    a.RandUniform(0,1);
    b1.Size(a);
    b1.SetVal(1);
    b2.Copy(b1);

    StartTimer;

    for i := 0 to a.Length-1 do  //always need b1 for reference
    begin
        if a[i] >= dpos_frac then b1[i] := (b1[i]+1)*2;
    end;

    ar[0] := Round(StopTimer*1000);

    if PlainBox.Checked then
    begin
        BarSeries.Add(ar[0], 'Plain');
    end;

    if VecBox.Checked then
    begin
        StartTimer;

        ai.FindMask(a, '>=', dpos_frac);
        c.GatherByMask(b2, ai);

        c.Add(1);
        c.Mul(2);
        b2.ScatterByMask(c, ai);

        ar[1] := StopTimer*1000;
        BarSeries.Add(ar[1], TeeLineSeparator + 'Vectorized');

        if not b1.IsEqual(b2, 0.001) then ERaise('Not equal');
        b2.SetVal(1); // reset
    end;

    if FindIndexBlockBox.Checked then
    begin
        StartTimer;

        a.BlockInit;
        b2.BlockInit;
        while not a.BlockEnd do
        begin
            ai.FindIndexes(a, '>=', dpos_frac);
            c.GatherByIndex(b2, ai);

            c.Add(1);
            c.Mul(2);
            b2.ScatterByIndexes(c, ai);

            a.BlockNext;
            b2.BlockNext;
        end;
        b2.SetFullRange;
        ai.SetFulLRange;

        ar[2] := StopTimer*1000;
        BarSeries.Add(ar[2], 'Vectorized with bp (FindIndexes)');


        if not b1.IsEqual(b2, 0.001) then ERaise('Not equal');
        b2.SetVal(1); // reset
    end;


    if MaskBlockBox.Checked then
    begin
        StartTimer;

        a.BlockInit;
        b2.BlockInit;
        while not a.BlockEnd do
        begin
            ai.FindMask(a, '>=', dpos_frac);
            c.GatherByMask(b2, ai);

            c.Add(1);
            c.Mul(2);
            b2.ScatterByMask(c, ai);

            a.BlockNext;
            b2.BlockNext;
        end;
        b2.SetFullRange;

        ar[3] := StopTimer*1000;
        BarSeries.Add(ar[3], TeeLineSeparator +  'Vectorized with bp (FindMask)');

        if not b1.IsEqual(b2, 0.001) then ERaise('Not equal');
        b2.SetVal(1); // reset
    end;

    if not Assigned(GlobalThreads) then GlobalThreads := TMtxForLoop.Create;

    GlobalThreads.BlockGranularity := System.Round(Exp2(GranBox.ItemIndex));

    if MaskBlockThreadBox.Checked then //5
    begin
        StartTimer;
        DoForLoop(0, a.Length-1, ForLoopR, GlobalThreads, [TVec(a),TVec(b2) ]);
        ar[4] := StopTimer*1000;
        BarSeries.Add(ar[4], 'Vectorized, bp and threaded');

        if not b1.IsEqual(b2, 0.001) then ERaise('Not equal');
        b2.SetVal(1); // reset
    end;

    if PlainThreadBox.Checked then //6
    begin
        StartTimer;
        DoForLoop(0, a.Length-1, ForLoopRI, GlobalThreads, [TVec(a),TVec(b2) ]);
        ar[5] := StopTimer*1000;
        BarSeries.Add(ar[5], TeeLineSeparator + 'Plain and threaded');

        if not b1.IsEqual(b2, 0.001) then ERaise('Not equal');
    end;

    Memo1.Clear;
    Memo1.Lines.Add('ThrdIdx' + chr(9) + 'Time' + Chr(9) + 'Pool'  + Chr(9) + 'Length' + Chr(9) + Chr(9) + 'bLength' +
                                    Chr(9) + 'a_cIdx' +
                                    Chr(9) + 'b_cIdx' +
                                    Chr(9) + 'c_cIdx' +
                                    Chr(9) + 'ag_cIdx' +
                                    Chr(9) + 'bg_cIdx' +
                                    Chr(9) + 'ai_cIdx');
    for i := 0 to Length(stats)-1 do
    begin

        Memo1.Lines.Add(IntToStr(i) + chr(9) + FormatSample('0.00ms',stats[i].TotalTime*1000) +
                                      Chr(9) + IntToStr(stats[i].PoolIndex) +
                                      Chr(9) + IntToStr(stats[i].TotalLength) + Chr(9) +
                                      Chr(9) + IntToStr(stats[i].BlockLength) +
                                      Chr(9) + IntToStr(stats[i].agCI) +
                                      Chr(9) + IntToStr(stats[i].bgCI) +
                                      Chr(9) + IntToStr(stats[i].aCI) +
                                      Chr(9) + IntToStr(stats[i].bCI) +
                                      Chr(9) + IntToStr(stats[i].cCI) +
                                      Chr(9) + IntToStr(stats[i].aiCI));
    end;
end;


procedure TIfThenForm.FormCreate(Sender: TObject);
begin
    if not Assigned(GlobalThreads) then  GlobalThreads := TMtxForLoop.Create;
    GlobalThreads.ThreadCount := Controller.CpuCores;
    Controller.ThreadDimension := GlobalThreads.ThreadCount + 1;

    Memo1.Lines.Clear;

    Memo1.Lines.Add('Efficient if-then vectorization is possible with the use of masks. Using sparse indexes does not allow for vectorization.' +
                    'The example below handles memory block much larger than CPU cache and applies:');
    Memo1.Lines.Add('');
    Memo1.Lines.Add('if a[i] >= 0.5 then b[i] := (b[i] + 1)*2;');
    Memo1.Lines.Add('');
    Memo1.Lines.Add('The different cases start with Delphi and end with multithreaded vectorized code. The performance of multi-threaded '+
                    'variants depends heavily on active CPU memory channel count (typically 1, 2 or 4).');
    Memo1.Lines.Add('The example demonstrates two features: ability to vectorize if-then and ability to thread code, which takes less than 20ms to execute.');

    DataLenBox.ItemIndex := 2;
end;

procedure TIfThenForm.FormDestroy(Sender: TObject);
begin
    if Assigned(GlobalThreads) then
    begin
        GlobalThreads.Free;
        GlobalThreads := nil;
    end;
end;

initialization
  RegisterClass(TIfThenForm);

end.
