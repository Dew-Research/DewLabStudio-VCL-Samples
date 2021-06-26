unit IfThenUnit;

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
    procedure FormCreate(Sender: TObject);
    procedure MaskThreadButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IfThenForm: TIfThenForm;

implementation

uses MtxVecBase, AbstractMtxVec;

const DPOS_FRAC: double =0.5;
const SPOS_FRAC: single =0.5;

{$R *.dfm}

procedure ForLoopR(IdxMin, IdxMax: integer; const Context: TObjectArray; ThreadIndex: integer);
var ag,bg: Vector;
    a,b: Vector;
    ai: VectorInt;
    c: Vector;
begin
    ag.SetSubRange(TVec(Context[0]), IdxMin, IdxMax - idxMin + 1);
    bg.SetSubRange(TVec(Context[1]), IdxMin, IdxMax - idxMin + 1);

    a.BlockInit(ag);
    b.BlockInit(bg);

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

        if not b1.IsEqual(b2, 0.001) then memo1.Lines.Add('Not equal');
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


        if not b1.IsEqual(b2, 0.001) then memo1.Lines.Add('Not equal');
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

        if not b1.IsEqual(b2, 0.001) then memo1.Lines.Add('Not equal');
        b2.SetVal(1); // reset
    end;

    if MaskBlockThreadBox.Checked then //5
    begin
        StartTimer;
        DoForLoop(0, a.Length-1, ForLoopR, GlobalThreads, [TVec(a),TVec(b2)]);
        ar[4] := StopTimer*1000;
        BarSeries.Add(ar[4], 'Vectorized, bp and threaded');

        if not b1.IsEqual(b2, 0.001) then memo1.Lines.Add('Not equal');
        b2.SetVal(1); // reset
    end;

    if PlainThreadBox.Checked then //6
    begin
        StartTimer;
        DoForLoop(0, a.Length-1, ForLoopRI, GlobalThreads, [TVec(a),TVec(b2)]);
        ar[5] := StopTimer*1000;
        BarSeries.Add(ar[5], TeeLineSeparator + 'Plain and threaded');

        if not b1.IsEqual(b2, 0.001) then memo1.Lines.Add('Not equal');
    end;
end;

procedure TIfThenForm.FormCreate(Sender: TObject);
begin
    if not Assigned(GlobalThreads) then  GlobalThreads := TMtxForLoop.Create;
    GlobalThreads.ThreadCount := 4;
    GlobalThreads.ThreadAffinityMode := tamSplit4;
//    GlobalThreads.ResponseTime := 0;
//    GlobalThreads.ThreadWaitBeforeSleep := 500;

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
