unit BlockProcessing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Basic2, StdCtrls, ComCtrls, ExtCtrls, MtxVec, MtxComCtrls, Probabilities,
  Math387, Basic1, TeeProcs, TeEngine, Chart, Series, MtxExpr, AbstractMtxVec;

type
  TfrmBlockProc = class(TBasicForm1)      
    Button1: TButton;
    Label1: TLabel;                                  
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;                       
    Series4: TLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Res, X, tmp: Vector;
    Len: Integer;
    procedure MaxwellBlock(Iter: integer; var Result: double);
    procedure MaxwellNoBlock(Iter: integer; var Result: double);
    procedure MaxwellFunction(Iter: integer; var Result: double);
    procedure MaxwellExpression(Iter: integer; var Result: double);
    function  MaxwellVecExpression(a: TSample; X: TVec): Vector; inline;
//    procedure MaxwellExpression2(Iter: integer; var Result: double);
  public
    { Public declarations }
  end;

var
  frmBlockProc: TfrmBlockProc;

implementation

{$IFDEF CLR}
{$R *.NFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

{ Block process }

procedure TfrmBlockProc.MaxwellBlock(Iter: integer; var Result: double);
var i: Integer;
    a: TSample;
begin
  StartTimer;
  a := 1;
  for i := 1 to Iter do
  begin
    Res.BlockInit;
    X.BlockInit;
    while not X.BlockEnd do
    begin
      tmp.Sqr(X);
      Res.Copy(tmp);
      Res.Mul(-0.5*a);
      Res.Exp;
      Res.Mul(tmp);
      Res.Mul(Sqrt(4*INVTWOPI)*a);
      Res.BlockNext;
      X.BlockNext;
    end;
  end;
  Result := StopTimer*1000;
end;

procedure TfrmBlockProc.FormCreate(Sender: TObject);
begin
  inherited;
  With RichEdit1.Lines do
  begin
    Clear;
    Add('Block processing tests the speed of processing of various vector sizes. '
      + 'In the "block" example it also breaks down the vector in to smaller '
      + 'pieces to make it fit the size of CPU cache. '
      + 'Notice that Vector expressions are only marginally slower '
      + 'than TVec and that substantial performance gains depend '
      + 'upon the vector length. The "block" example is faster than other only '
      + 'for very long vectors due to large CPU cache sizes of '
      + 'modern CPUs. The function being benchmarked is Maxwell PDF.');
    Add('');
    Add('Block length (size of the sub vector) is automatically set '
      + 'by MtxVec to match the CPU cache size and so is the number of '
      + 'iterations required to process the entire vector length.');
  end;
  X.Size(Len,False);
  Res.Size(X);
end;

procedure TfrmBlockProc.MaxwellFunction(Iter: integer; var Result: double);
var i,j: integer;
    a: TSample;
    ar,ax: TSampleArray;
begin
 { Maxwell distribution, a = 1.0 }
  a := 1;
  SetLength(ar,x.Length);
  x.CopyToArray(ax);
  StartTimer;
  for i := 1 to Iter do
  begin
       for j := 0 to x.Length-1 do ar[j] := MaxwellPdf(ax[j],a);
  end;
  Result := StopTimer*1000;
end;

procedure TfrmBlockProc.MaxwellNoBlock(Iter: integer; var Result: double);
var i,j: integer;
    a: TSample;
begin
  { Maxwell distribution, a = 1.0 }
  a := 1;
  StartTimer;
  j := Iter;
  for i := 1 to j do
  begin
    tmp.Sqr(X);
    Res.Copy(tmp);
    Res.Mul(-0.5*a);
    Res.Exp;
    Res.Mul(tmp);
    Res.Mul(Sqrt(4*INVTWOPI)*a);
  end;
  Result := StopTimer*1000;
end;

function TfrmBlockProc.MaxwellVecExpression(a: TSample; x: TVec): Vector;
var tmp: Vector;
begin
  tmp := Sqr(x);
  Result := Sqrt(4 * a * INVTWOPI) * a * tmp * Exp(-0.5 * a * tmp);
end;

procedure TfrmBlockProc.MaxwellExpression(Iter: integer; var Result: double);
var i: integer;
    a: TSample;
begin
  { Maxwell distribution, a = 1.0 }
  a := 1;
  StartTimer;
  for i := 1 to Iter do
  begin
      MaxwellVecExpression(a,x);
  end;
  Result := StopTimer*1000;
end;

//procedure TfrmBlockProc.MaxwellExpression2(Iter: integer; var Result: double);
//var i: integer;
//    a: TSample;
//begin
//  { Maxwell distribution, a = 1.0 }
//  a := 1;
//  StartTimer;
//  for i := 1 to Iter do
//  begin
//      tmp := Sqr(x);
//      Res := Sqrt(4 * a * INVTWOPI) * a * tmp * Exp(-0.5 * a * tmp);
//  end;
//  Result := StopTimer*1000;
//end;

function FindMax(var a: array of double): double;
var i: integer;
begin
     Result := MINNUM;
     for i := 1 to High(a) do
     begin
          if a[i] > Result then Result := a[i];
     end;
end;

procedure TfrmBlockProc.Button1Click(Sender: TObject);
var a1,a2,a3,a4: array of double;
    i,Iters, Points, TotalIters: integer;
    Step: double;
begin
  Step := 2;
  Points := Round(LogN(Step,100000)) - 1;
  TotalIters := Round(Power(Step,Points));
  Iters := TotalIters;
  SetLength(a1,Points);
  SetLength(a2,Points);
  SetLength(a3,Points);
  SetLength(a4,Points);

  Screen.Cursor := crHourGlass;
  X.Size(4, False);
  X.SetVal(2);
  Res.Size(X);
  for i := 0 to Points-1 do
  begin
       Res.SetZero;
       MaxwellFunction(Iters,a1[i]);
       Label1.Caption := 'Progress: ' + FormatFloat('0',(i+0.33)/Points*100) + '%';
       Update;

       Res.SetZero;
       MaxwellNoBlock(Iters,a2[i]);
       Label1.Caption := 'Progress: ' + FormatFloat('0',(i+0.66)/Points*100) + '%';
       Update;

       Res.SetZero;
       MaxwellBlock(Iters,a3[i]);
       Label1.Caption := 'Progress: ' + FormatFloat('0',(i+0.99)/Points*100) + '%';
       Update;

       Res.SetZero;
       MaxwellExpression(Iters,a4[i]);
       Label1.Caption := 'Progress: ' + FormatFloat('0',(i+0.99)/Points*100) + '%';
       Update;

       Iters := Round(TotalIters/Power(Step,i+2));
       X.Length := Round(2*Power(Step,i+2));
       Res.Size(X);
       X.SetVal(2);
  end;
  Label1.Caption := 'Progress: 100%';
  Chart1.LeftAxis.Automatic := false;
  for i := 0 to Chart1.SeriesCount-1 do Chart1.Series[i].Clear;
  for i := 1 to High(a1) do Chart1.Series[0].AddY(a1[i],FormatFloat('0',Power(Step,(i+2))));
  for i := 1 to High(a2) do
  begin
       if a2[i] <> 0 then Chart1.Series[1].AddY(a2[i])
{                     else Chart1.Series[1].AddNull(''); }
  end;
  for i := 1 to High(a3) do
  begin
       if a3[i] <> 0 then Chart1.Series[2].AddY(a3[i])
{                     else Chart1.Series[2].AddNull(''); }
  end;
  for i := 1 to High(a4) do
  begin
      if a4[i] <> 0 then Chart1.Series[3].AddY(a4[i])
{                    else Chart1.Series[3].AddNull(''); }
  end;

  Chart1.LeftAxis.Automatic := False;
  Chart1.LeftAxis.SetMinMax(0,1.1*Max(Max(Max(FindMax(a1),FindMax(a2)),FindMax(a3)),FindMax(a4)));
  Screen.Cursor := crDefault;
end;

initialization
  RegisterClass(TfrmBlockProc)

end.
