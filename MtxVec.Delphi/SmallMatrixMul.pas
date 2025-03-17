unit SmallMatrixMul;

{$I bdsppdefs.inc}

interface

uses
  System.Types, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxVec, MtxComCtrls, Probabilities,
  Math387, Basic1, TeeProcs, TeEngine, Chart, Series, MtxExpr, AbstractMtxVec
  {$IFDEF MKLDLL_DOUBLE}
  ,nmkl
  {$ENDIF}
  {$IFDEF MKLDLL_SINGLE}
  ,nmklSingle
  {$ENDIF}
  ;

type
  TfrmSmallMatrix = class(TBasicForm1)
    Button1: TButton;
    jitLabel: TLabel;
    ComplexBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    jit: TSmallMatrixMultiply;
  public
    { Public declarations }
  end;

var
  frmSmallMatrix: TfrmSmallMatrix;

implementation

uses MtxVecBase;

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}

{$ENDIF}

procedure TfrmSmallMatrix.FormDestroy(Sender: TObject);
begin
    jit.Free;
    inherited;
end;

procedure PascalMul(const A, B, C: Math387.TDoubleArray; n: integer); overload;
var i, j, k: Integer;
    sum: Double;
begin
  for i := 0 to n - 1 do
    for j := 0 to n - 1 do
    begin
      sum := 0.0;
      for k := 0 to n - 1 do
        sum := sum + A[i * n + k] * B[k * n + j];
      C[i * n + j] := sum;
    end;
end;

procedure PascalMul(const A, B, C: Math387.TCplxDoubleArray; n: integer); overload;
var i, j, k: Integer;
    sum: TCplx;
begin
  for i := 0 to n - 1 do
    for j := 0 to n - 1 do
    begin
      sum := C_ZERO;
      for k := 0 to n - 1 do
        sum := sum + A[i * n + k] * B[k * n + j];
      C[i * n + j] := sum;
    end;
end;


procedure TfrmSmallMatrix.FormCreate(Sender: TObject);
var i: integer;
begin
    inherited;
    With RichEdit1.Lines do
    begin
      Clear;
      Add('Multiplying small matrices is challenging, because any error checking or layout detection code, will '
        + 'easily take more time than the computation itself. Hence the error checking needs to be reduced. For these reason the small matrix multiply routines '
        + 'are to be used with due care, with the code properly tested before deployed. ');
      Add('');
      Add('Although we would expect that the overhead would be mostly visible for matrices 2x2 and 3x3, a considerable overhead exists all the way up to sizes of 30x30.'+
          'It would appear that the multiplication kernel is so efficient, that if we are able to work without error checking, the performance benefit is considerable.' +
          'It is true that at the matrix size 2x2 the maximum performance improvement is 100x, but even at 50x50 it is still 30%.');
      Add('');
      Add('Another interesting observation are the breaks at matrix sizes 24, 32, 40 and 48, which are most efficient sizes to use and recommended to match ' +
          'when used for block processing. Furthermore, by looking at the ratios of time between matrix 16x16 and 4x4, even though the bigger matrix has (16/4)^3 = 64x more processing ' +
          'requirement, it is roughly only 8-14x slower. This points to the next small matrix optimization possibility. Batched processing of small matrices should be even more ' +
          'performance efficient, aiming for another factor of 10x improvement, for very small matrices over what JIT can deliver, if of course we can rearange our own code in such a way, that we can take advantage of that.');
      Add('');
      Add('Press run to run the benchmark, which compares different APIs for small matrix multiply.' +
          'Check the benchmark source code to determine how individual api interfaces look. Smaller values in the chart below are better.');
      Add('');
      Add('The recommended api to start with is TMtx.MulSmallInit and TMtx.MulSmall. This api maintains some of the error checking and ease of use, but still delivers decent ' +
          'performance in most cases.');
    end;

    Chart1.SeriesList.Clear;
    for i := 0 to 6 do
    begin
        Chart1.AddSeries(TLineSeries.Create(Chart1));
        TLineSeries(chart1.Series[i]).Pointer.Visible := True;
        TLineSeries(Chart1.Series[i]).Pointer.Style := TSeriesPointerStyle(i+1);
    end;
    Chart1.Series[0].Title := 'Matrix.Mul (dgemm)';
    Chart1.Series[1].Title := 'Delphi pascal';
    Chart1.Series[2].Title := 'jitted array';
    Chart1.Series[3].Title := 'Jitted pointer';
    Chart1.Series[4].Title := 'Jitted TMtx';
    Chart1.Series[5].Title := 'Jitted Matrix';
    Chart1.Series[6].Title := 'jitted Matrix.MulSmall';

    jit := TSmallMatrixMultiply.Create;
end;


procedure TfrmSmallMatrix.Button1Click(Sender: TObject);
var aTimings: Matrix;
    i, j, Iters, MaxSize, aRows, aCols: integer;
    am, bm, cm: Matrix;
    a,b,c: Math387.TDoubleArray;
    ac,bc,cc: Math387.TCplxDoubleArray;
    ap, bp, cp: TMtx;
begin
    Iters := 15000;
    if ComplexBox.Checked then Iters := 3000;
    MaxSize := 50;
    aTimings.Size(Chart1.SeriesCount, MaxSize);
    Screen.Cursor := crHourGlass;
    jitLabel.Caption := 'JIT kernel used for all sizes';

//    Controller.BlasThreadCount := Controller.CpuCoresPhysical;
//    Controller.ThreadWaitBeforeSleep := 40;

    for i := 0 to aTimings.Cols - 1 do
    begin
        aRows := i + 2;
        aCols := aRows;

        if not ComplexBox.Checked then
        begin
            SetLength(a, aRows*aCols);
            SetLength(b, aRows*aCols);
            SetLength(c, aRows*aCols);
        end else
        begin
            SetLength(ac, aRows*aCols);
            SetLength(bc, aRows*aCols);
            SetLength(cc, aRows*aCols);
        end;

        am.Size(aRows, aCols, ComplexBox.Checked);
        bm.Size(am);
        cm.Size(am);

        ap := am;
        bp := bm;
        cp := cm;

        //Matrix.Mul
        StartTimer;
        for j := 0 to Iters do cm.Mul(am, bm);
        aTimings[0, i] := StopTimer*1000;

        if not ComplexBox.Checked then
        begin
        //Pascal unrolled loop
//        if aRows = 2 then
//        begin
//            StartTimer; //pascal code
//            for j := 0 to Iters do dgemm2(a,b,c);
//            aTimings[1, i] := StopTimer*1000;
//        end else if aRows = 3 then
//        begin
//            StartTimer; //pascal code
//            for j := 0 to Iters do dgemm3(a,b,c);
//            aTimings[1, i] := StopTimer*1000;
//        end else if aRows = 4 then
//        begin
//            StartTimer; //pascal code
//            for j := 0 to Iters do dgemm4(a,b,c);
//            aTimings[1, i] := StopTimer*1000;
//        end else
//        begin
            if aRows  < 10 then
            begin
                StartTimer; //pascal code
                for j := 0 to Iters do PascalMul(ap.Values1D, bp.Values1D, cp.Values1D, aRows);
                aTimings[1, i] := StopTimer*1000;
            end else
            begin
                aTimings[1, i] := 0;
            end;
//        end;
        end else
        begin
        //Pascal unrolled loop
//        if aRows = 2 then
//        begin
//            StartTimer; //pascal code
//            for j := 0 to Iters do zgemm2x(a,b,c);
//            aTimings[1, i] := StopTimer*1000;
//        end else if aRows = 3 then
//        begin
//            StartTimer; //pascal code
//            for j := 0 to Iters do zgemm3x(a,b,c);
//            aTimings[1, i] := StopTimer*1000;
//        end else if aRows = 4 then
//        begin
//            StartTimer; //pascal code
//            for j := 0 to Iters do zgemm4x(a,b,c);
//            aTimings[1, i] := StopTimer*1000;
//        end else
//        begin
            if aRows  < 10 then
            begin
                StartTimer; //pascal code
                for j := 0 to Iters do PascalMul(ap.CValues1D, bp.CValues1D, cp.CValues1D, aRows);
                aTimings[1, i] := StopTimer*1000;
            end else
            begin
                aTimings[1, i] := 0;
            end;
//        end;
        end;

        if not jit.Init(am, bm, cm, opNone, opNone, 1, 0) then
        begin
            jitLabel.Caption := 'JIT worked up to size: ' + IntToStr(aRows) + 'x' + IntToStr(aCols);
        end;

        {$IFDEF MKLDLL_DOUBLE}
        // jit with arrays as params
        if not ComplexBox.Checked then
        begin
            StartTimer;
            for j := 0 to Iters do jit.MulKernelDouble(jit.Jitter, a, b, c);
            aTimings[2, i] := StopTimer*1000;
        end else
        begin
            StartTimer;
            for j := 0 to Iters do jit.MulKernelComplexDouble(jit.Jitter, ac, bc, cc);
            aTimings[2, i] := StopTimer*1000;
        end;
        {$ENDIF}

        // jit with fixed memory pointers as params
        StartTimer;
        for j := 0 to Iters do jit.Mul;
        aTimings[3, i] := StopTimer*1000;

        ap := am;
        bp := bm;
        cp := cm;

        // Jitted TMtx
        StartTimer;
        for j := 0 to Iters do jit.Mul(ap, bp, cp);
        aTimings[4, i] := StopTimer*1000;

        // Jitted Matrix
        StartTimer;
        for j := 0 to Iters do jit.Mul(am, bm, cm);
        aTimings[5, i] := StopTimer*1000;

        // Jitted Matrix.MulSmall
        cm.MulSmallInit(am, bm);
        StartTimer;
        for j := 0 to Iters do cm.MulSmall(am, bm);
        aTimings[6, i] := StopTimer*1000;
    end;

    if ComplexBox.Checked then aTimings.Scale(5);

    Chart1.LeftAxis.Automatic := false;
    for i := 0 to aTimings.Rows-1 do
    begin
        Chart1.Series[i].Clear;
        for j := 0 to aTimings.Cols-1 do
        begin
            if aTimings[i, j] <> 0 then
              Chart1.Series[i].AddY(aTimings[i, j], IntToStr(2+j) + 'x' + IntToStr(2+j) );
        end;
    end;

    Chart1.LeftAxis.Automatic := False;
    Chart1.LeftAxis.SetMinMax(0,1.1*aTImings.Max);
    Screen.Cursor := crDefault;
end;

initialization
  RegisterClass(TfrmSmallMatrix)

end.
