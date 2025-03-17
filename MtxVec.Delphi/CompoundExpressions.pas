unit CompoundExpressions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MtxBaseComp, MtxDialogs, StdCtrls, MtxExpr, MtxComCtrls, Math387,
  MtxVecBase, MtxVec, AbstractMtxVec, SyncObjs, ExtCtrls, TeEngine, TeeProcs, Chart, Series,
  Vcl.ComCtrls;

type

  TTestMethod = (tmGetMem, tmTVec, tmVector, tmVectorGlobal);

  TCompoundExpressionsForm = class(TForm)
    Panel1: TPanel;
    RunButton: TButton;
    Chart: TChart;
    Memo: TRichEdit;
    Series1: TBarSeries;
    Series2: TBarSeries;
    PrecisionGroup: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
    procedure PrecisionGroupClick(Sender: TObject);
  private
    procedure DoublePrecisionMath;
    procedure ComplexDoublePrecisionMath;
    procedure SaturatedIntegerMath;
    procedure SaturatedSmallIntMath;
    procedure SaturatedByteMath;
    { Private declarations }
  public
    Timings: array [0..1,0..5] of double;
    ak,ac: integer;
    VectorLen: integer;
    Stage: integer;
  end;

var
  CompoundExpressionsForm: TCompoundExpressionsForm;

implementation

uses StringVar, MtxExprInt, MtxVecInt, AbstractMtxVecInt;

{$R *.dfm}


procedure TCompoundExpressionsForm.DoublePrecisionMath;
var i, loops: Integer;
    labels: StringList;
    aDst, bDst,x,y,z: Vector;
begin
    loops := 10000;

    Series1.Title := 'Double Compound';
    Series2.Title := 'Double Sequenced';
    Labels.Clear;
    x.Size(1000);
    x.Ramp;
    y.Size(x);
    y.SetVal(2.1);
    z.Size(x);
    z.SetVal(3.5);

// X*xScale + Y*yScale + Z*zScale
    Labels.Add('X*xScale + Y*yScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddScaled(x, 2.0, y, 3.0, z, 4.0);
    end;
    Timings[0, 0] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(x, 2.0);
        bDst.AddScaled(y, 3.0);
        bDst.AddScaled(z, 4.0)
    end;
    Timings[1, 0] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

// X + Y + Z
    Labels.Add('X + Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.Add(x, y, z);
    end;
    Timings[0, 1] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(x, y);
        bDst.Add(z);
    end;
    Timings[1, 1] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

// (X*xScale + Y*yScale)*Z*zScale
    Labels.Add('(X*xScale + Y*yScale)*Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, 2.0, y, 3.0, z, 4.0);
    end;
    Timings[0, 2] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(X, 2.0);
        bDst.AddScaled(Y, 3.0);
        bDst.Mul(Z);
        bDst.Mul(4.0);
    end;
    Timings[1, 2] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

//  (X + Y)*Z
    Labels.Add('(X + Y)*Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, y, z);
    end;
    Timings[0, 3] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(X, Y);
        bDst.Mul(Z);
    end;
    Timings[1, 3] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

//  X*Y*xyScale + Z*zScale
    Labels.Add('X*Y*xyScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, 3.0, z, 4.0);
    end;
    Timings[0, 4] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(X, Y);
        bDst.Mul(3.0);
        bDst.AddScaled(z, 4.0);
    end;
    Timings[1, 4] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

// X*Y + Z
    Labels.Add('X*Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, z);
    end;
    Timings[0, 5] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(X, Y);
        bDst.Add(Z);
    end;
    Timings[1, 5] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

    Series1.Clear;
    Series2.Clear;
    for i := 0 to Length(Timings[0])-1 do
    begin
        Series1.AddY(Timings[0,i], labels[i]);
        Series2.AddY(Timings[1,i], labels[i]);
    end;
end;

procedure TCompoundExpressionsForm.ComplexDoublePrecisionMath;
var i, loops: Integer;
    labels: StringList;
    aDst, bDst,x,y,z: Vector;
begin
    loops := 10000;

    Series1.Title := 'Complex Compound';
    Series2.Title := 'Complex Sequenced';
    Labels.Clear;
    x.Size(1000,true); //adjusted length to half, because of upgrade to complex
    x.Ramp;
    y.Size(x);
    y.SetVal(Cplx(2.1,1.9));
    z.Size(x);
    z.SetVal(Cplx(3.5, 2.5));

// X*xScale + Y*yScale + Z*zScale
    Labels.Add('X*xScale + Y*yScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddScaled(x, Cplx(2.0, 1.3), y, Cplx(3.0, 1.2), z, Cplx(4.0, 1.8));
    end;
    Timings[0, 0] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(x, Cplx(2.0, 1.3));
        bDst.AddScaled(y, Cplx(3.0, 1.2));
        bDst.AddScaled(z, Cplx(4.0, 1.8))
    end;
    Timings[1, 0] := StopTimer*1000;

//    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');


// X + Y + Z
    Labels.Add('X + Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.Add(x, y, z);
    end;
    Timings[0, 1] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(x, y);
        bDst.Add(z);
    end;
    Timings[1, 1] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

// (X*xScale + Y*yScale)*Z*zScale
    Labels.Add('(X*xScale + Y*yScale)*Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, Cplx(2.0, 1.3), y, Cplx(3.0, 1.2), z, Cplx(4.0, 1.8));
    end;
    Timings[0, 2] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(X, Cplx(2.0, 1.3));
        bDst.AddScaled(Y, Cplx(3.0, 1.2));
        bDst.Mul(Z);
        bDst.Mul(Cplx(4.0, 1.8));
    end;
    Timings[1, 2] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

//  (X + Y)*Z
    Labels.Add('(X + Y)*Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, y, z);
    end;
    Timings[0, 3] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(X, Y);
        bDst.Mul(Z);
    end;
    Timings[1, 3] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

//  X*Y*xyScale + Z*zScale
    Labels.Add('X*Y*xyScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, Cplx(3.0, 1.2), z, Cplx(4.0, 1.8));
    end;
    Timings[0, 4] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(X, Y);
        bDst.Mul(Cplx(3.0, 1.2));
        bDst.AddScaled(z, Cplx(4.0, 1.8));
    end;
    Timings[1, 4] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

// X*Y + Z
    Labels.Add('X*Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, z);
    end;
    Timings[0, 5] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Mul(X, Y);
        bDst.Add(Z);
    end;
    Timings[1, 5] := StopTimer*1000;

    if not aDst.IsEqual(bDst, 1E-5) then ERaise('Not equal');

    Series1.Clear;
    Series2.Clear;
    for i := 0 to Length(Timings[0])-1 do
    begin
        Series1.AddY(Timings[0,i], labels[i]);
        Series2.AddY(Timings[1,i], labels[i]);
    end;
end;

procedure TCompoundExpressionsForm.SaturatedIntegerMath;
var i, loops: Integer;
    labels: StringList;
    aDst, bDst, cDst,x,y,z: VectorInt;
begin
    loops := 10000;

    Series1.Title := 'Integer Compound';
    Series2.Title := 'Integer Sequenced';
    Labels.Clear;
    x.Size(1000, TIntPrecision.prInt32);
    x.SetVal(1);
    y.Size(x);
    y.SetVal(2);
    z.Size(x);
    z.SetVal(3);

// X*xScale + Y*yScale + Z*zScale
    Labels.Add('X*xScale + Y*yScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddScaled(x, 2, y, 3, z, 4);
    end;
    Timings[0, 0] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(x, 2);
        cDst.Multiply(y, 3);
        bDst.Add(cDst);
        cDst.Multiply(z, 4);
        bDst.Add(cDst);
    end;
    Timings[1, 0] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');


// X + Y + Z
    Labels.Add('X + Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.Add(x, y, z);
    end;
    Timings[0, 1] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(x, y);
        bDst.Add(z);
    end;
    Timings[1, 1] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

// (X*xScale + Y*yScale)*Z*zScale
    Labels.Add('(X*xScale + Y*yScale)*Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, 2, y, 3, z, 4);
    end;
    Timings[0, 2] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, 2);
        cDst.Multiply(Y, 3);
        bDst.Add(cDst);
        bDst.Multiply(Z);
        bDst.Multiply(4);
    end;
    Timings[1, 2] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

//  (X + Y)*Z
    Labels.Add('(X + Y)*Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, y, z);
    end;
    Timings[0, 3] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(X, Y);
        bDst.Multiply(Z);
    end;
    Timings[1, 3] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

//  X*Y*xyScale + Z*zScale
    Labels.Add('X*Y*xyScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, 3, z, 4);
    end;
    Timings[0, 4] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, Y);
        bDst.Multiply(3);
        cDst.Multiply(z, 4);
        bDst.Add(cDst);
    end;
    Timings[1, 4] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

// X*Y + Z
    Labels.Add('X*Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, z);
    end;
    Timings[0, 5] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, Y);
        bDst.Add(Z);
    end;
    Timings[1, 5] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

    Series1.Clear;
    Series2.Clear;
    for i := 0 to Length(Timings[0])-1 do
    begin
        Series1.AddY(Timings[0,i], labels[i]);
        Series2.AddY(Timings[1,i], labels[i]);
    end;
end;

procedure TCompoundExpressionsForm.SaturatedSmallIntMath;
var i, loops: Integer;
    labels: StringList;
    aDst, bDst, cDst,x,y,z: VectorInt;
begin
    loops := 10000;

    Series1.Title := 'SmallInt Compound';
    Series2.Title := 'SmallInt Sequenced';
    Labels.Clear;
    x.Size(1000, TIntPrecision.prInt16);
    x.SetVal(1);
    y.Size(x);
    y.SetVal(2);
    z.Size(x);
    z.SetVal(3);

// X*xScale + Y*yScale + Z*zScale
    Labels.Add('X*xScale + Y*yScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddScaled(x, 2, y, 3, z, 4);
    end;
    Timings[0, 0] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(x, 2);
        cDst.Multiply(y, 3);
        bDst.Add(cDst);
        cDst.Multiply(z, 4);
        bDst.Add(cDst);
    end;
    Timings[1, 0] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');


// X + Y + Z
    Labels.Add('X + Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.Add(x, y, z);
    end;
    Timings[0, 1] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(x, y);
        bDst.Add(z);
    end;
    Timings[1, 1] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

// (X*xScale + Y*yScale)*Z*zScale
    Labels.Add('(X*xScale + Y*yScale)*Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, 2, y, 3, z, 4);
    end;
    Timings[0, 2] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, 2);
        cDst.Multiply(Y, 3);
        bDst.Add(cDst);
        bDst.Multiply(Z);
        bDst.Multiply(4);
    end;
    Timings[1, 2] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

//  (X + Y)*Z
    Labels.Add('(X + Y)*Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, y, z);
    end;
    Timings[0, 3] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(X, Y);
        bDst.Multiply(Z);
    end;
    Timings[1, 3] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

//  X*Y*xyScale + Z*zScale
    Labels.Add('X*Y*xyScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, 3, z, 4);
    end;
    Timings[0, 4] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, Y);
        bDst.Multiply(3);
        cDst.Multiply(z, 4);
        bDst.Add(cDst);
    end;
    Timings[1, 4] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

// X*Y + Z
    Labels.Add('X*Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, z);
    end;
    Timings[0, 5] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, Y);
        bDst.Add(Z);
    end;
    Timings[1, 5] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

    Series1.Clear;
    Series2.Clear;
    for i := 0 to Length(Timings[0])-1 do
    begin
        Series1.AddY(Timings[0,i], labels[i]);
        Series2.AddY(Timings[1,i], labels[i]);
    end;
end;

procedure TCompoundExpressionsForm.SaturatedByteMath;
var i, loops: Integer;
    labels: StringList;
    aDst, bDst, cDst,x,y,z: VectorInt;
begin
    loops := 10000;

    Series1.Title := 'Byte Compound';
    Series2.Title := 'Byte Sequenced';
    Labels.Clear;
    x.Size(1000, TIntPrecision.prInt8);
    x.SetVal(1);
    y.Size(x);
    y.SetVal(2);
    z.Size(x);
    z.SetVal(3);

// X*xScale + Y*yScale + Z*zScale
    Labels.Add('X*xScale + Y*yScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddScaled(x, 2, y, 3, z, 4);
    end;
    Timings[0, 0] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(x, 2);
        cDst.Multiply(y, 3);
        bDst.Add(cDst);
        cDst.Multiply(z, 4);
        bDst.Add(cDst);
    end;
    Timings[1, 0] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');


// X + Y + Z
    Labels.Add('X + Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.Add(x, y, z);
    end;
    Timings[0, 1] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(x, y);
        bDst.Add(z);
    end;
    Timings[1, 1] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

// (X*xScale + Y*yScale)*Z*zScale
    Labels.Add('(X*xScale + Y*yScale)*Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, 2, y, 3, z, 4);
    end;
    Timings[0, 2] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, 2);
        cDst.Multiply(Y, 3);
        bDst.Add(cDst);
        bDst.Multiply(Z);
        bDst.Multiply(4);
    end;
    Timings[1, 2] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

//  (X + Y)*Z
    Labels.Add('(X + Y)*Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.AddAndMul(x, y, z);
    end;
    Timings[0, 3] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Add(X, Y);
        bDst.Multiply(Z);
    end;
    Timings[1, 3] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

//  X*Y*xyScale + Z*zScale
    Labels.Add('X*Y*xyScale + Z*zScale');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, 3, z, 4);
    end;
    Timings[0, 4] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, Y);
        bDst.Multiply(3);
        cDst.Multiply(z, 4);
        bDst.Add(cDst);
    end;
    Timings[1, 4] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

// X*Y + Z
    Labels.Add('X*Y + Z');
    StartTimer;
    for i := 0 to loops-1 do
    begin
        aDst.MulAndAdd(x, y, z);
    end;
    Timings[0, 5] := StopTimer*1000;

    StartTimer;
    for i := 0 to loops-1 do
    begin
        bDst.Multiply(X, Y);
        bDst.Add(Z);
    end;
    Timings[1, 5] := StopTimer*1000;

    if not aDst.IsEqual(bDst) then ERaise('Not equal');

    Series1.Clear;
    Series2.Clear;
    for i := 0 to Length(Timings[0])-1 do
    begin
        Series1.AddY(Timings[0,i], labels[i]);
        Series2.AddY(Timings[1,i], labels[i]);
    end;
end;

procedure TCompoundExpressionsForm.RunButtonClick(Sender: TObject);
begin
    case PrecisionGroup.ItemIndex of
    0: DoublePrecisionMath;
    1: ComplexDoublePrecisionMath;
    2: SaturatedIntegerMath;
    3: SaturatedSmallIntMath;
    4: SaturatedByteMath;
    end;
end;

procedure TCompoundExpressionsForm.FormCreate(Sender: TObject);
begin
    Memo.Clear;
    Memo.Lines.Add('Compound expressions join together multiple (+,-,/,*) math operations in to a single loop thus increasing the possibility to vectorize code and lower the ' +
                   'use of main memory bandwidth. The functions are available for TVec/TMtx and Vector/Matrix types. Check below the performance advantage by pressing Run. ' +
                   'In this benchmark only 6 different variants are compared, but a total of 162 distinct overloads have been added with version 6.31 to the TVec and the same also to TMtx.');

    Memo.Lines.Add('');
    Memo.Lines.Add('Note that the more complex expressions take about equal time as the simpler math operations.');
end;


procedure TCompoundExpressionsForm.PrecisionGroupClick(Sender: TObject);
begin
    RunButtonClick(Sender);
end;

initialization
   RegisterClass(TCompoundExpressionsForm);

end.
