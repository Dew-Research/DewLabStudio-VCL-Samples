unit BenchmarkFramework;

interface
{$I bdsppdefs.inc}
uses
  Classes,
  Math387,
  AbstractMtxVec,
  MtxVec,
  BenchmarkResults;            

type
  TVecMethod = function (const src: TMtxVec): TMtxVec of object;
  TSmplFunc  = function (const x: double): double;
  TCplxFunc  = function (const x: TCplx): TCplx;

type
  TFuncInfo = record
    func_name: string;
    smpl_func: TSmplFunc;
    cplx_func: TCplxFunc;
    vec_method: TVecMethod;
    smpl_val: TSample;
    cplx_val: TCplx;
  end;

type
  TCalcProc = procedure of object;
  TBenchmarkFramework = class
  private
    fSrc, fDst: TVec;
    fSrca, fDsta: TSampleArray;
    fSrcac, fDstac: TCplxArray;
    fIterationCount: integer;
    fVectorLength: integer;

    fFuncs: array of TFuncInfo;
    fFuncCount: integer;
    fSelectedFunc: TFuncInfo;

    procedure InitFuncs;
    function GetFuncCount: integer;
    function GetFuncName(idx: integer): string;
    function FindFuncByName (const func_name: string): integer;
    procedure InitSmplVecs (const val: TSample);
    procedure InitCplxVecs (const cval: TCplx);

    procedure CalcVector;
    procedure CalcSample;
    procedure CalcComplex;

    function DoUnderTimer (calc_proc: TCalcProc): double;

  public
    constructor Create;
    destructor Destroy; override;

    function RecalcIterationCount: integer;

    procedure Run (const func_name: string; var results: TBenchmarkResults);

    property VectorLength: integer read fVectorLength write fVectorLength;
    property IterationCount: integer read fIterationCount write fIterationCount;

    property FuncCount: integer read GetFuncCount;
    property FuncName[idx: integer]: string read GetFuncName;
  end;

implementation
uses
  Windows,
  SysUtils
  {$IFDEF CLR}
  ,Math
  {$ENDIF}
  ;

{$IFDEF CLR}
type
  TFuncHelper = class helper for TMtxVec
  private
    function Sin1 (src: TMtxVec): TMtxVec;
    function Cos1 (src: TMtxVec): TMtxVec;
    function Exp1 (src: TMtxVec): TMtxVec;
    function Ln1 (src: TMtxVec): TMtxVec;

    function Log101 (src: TMtxVec): TMtxVec;
    function Tan1 (src: TMtxVec): TMtxVec;
    function ArcTan1 (src: TMtxVec): TMtxVec;
    function ArcSin1 (src: TMtxVec): TMtxVec;

    function ArcCos1 (src: TMtxVec): TMtxVec;
    function ArcTanh1 (src: TMtxVec): TMtxVec;
    function ArcSinh1 (src: TMtxVec): TMtxVec;

    function Sinh1 (src: TMtxVec): TMtxVec;
    function Tanh1 (src: TMtxVec): TMtxVec;
    function Cosh1 (src: TMtxVec): TMtxVec;
  end;

{ TFuncHelper }

function TFuncHelper.Sin1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Sin (src);
end;

function TFuncHelper.Cos1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Cos (src);
end;

function TFuncHelper.Exp1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Exp (src);
end;

function TFuncHelper.Ln1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Ln (src);
end;

function TFuncHelper.Log101(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Log10 (src);
end;

function TFuncHelper.Tan1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Tan (src);
end;

function TFuncHelper.ArcTan1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited ArcTan (src);
end;

function TFuncHelper.ArcSin1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited ArcSin (src);
end;

function TFuncHelper.ArcCos1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited ArcCos (src);
end;

function TFuncHelper.ArcTanh1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited ArcTanh (src);
end;

function TFuncHelper.ArcSinh1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited ArcSinh (src);
end;

function TFuncHelper.Tanh1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Tanh (src);
end;

function TFuncHelper.Sinh1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Sinh (src);
end;

function TFuncHelper.Cosh1(src: TMtxVec): TMtxVec;
begin
  Result:= inherited Cosh (src);
end;

{$ENDIF}

{ TBenchmarksFramework }

constructor TBenchmarkFramework.Create;
begin
  inherited;
  fSrc := TVec.Create;
  fDst := TVec.Create;
  InitFuncs;
end;

destructor TBenchmarkFramework.Destroy;
begin
  fSrc.Free;
  fDst.Free;
  inherited;
end;

function TBenchmarkFramework.FindFuncByName (const func_name: string): integer;
begin
  for Result:= 0 to fFuncCount-1 do
    if SameText (fFuncs[Result].func_name, func_name) then
      Exit;

  raise Exception.CreateFmt ('TBenchmarkFramework.FindFuncByName: Name of function was not found', [func_name]);
end;

//type TMathFunction = function (a: double): double;

function TBenchmarkFramework.GetFuncCount: integer;
begin
  Result:= fFuncCount;
end;

function TBenchmarkFramework.GetFuncName(idx: integer): string;
begin
  Assert (idx < fFuncCount, Format('TBenchmarkFramework.GetFuncName: Index out of range: %d', [idx]));
  Result:= fFuncs[idx].func_name;
end;

{$IFDEF CLR} //needed because of compiler error when linking directly to System.Math.Sin

function Sin(a: double): double;
begin
    REsult := System.Math.Sin(a);
end;

function Cos(a: double): double;
begin
    REsult := System.Math.Cos(a);
end;

function Exp(a: double): double;
begin
    REsult := System.Math.Exp(a);
end;

function Ln(a: double): double;
begin
    Result := Sin(a);
end;

{$ENDIF}


procedure TBenchmarkFramework.InitFuncs;
const
  VAL1: TSample = 0.5;
  CVAL1: TCplx  = (Re:0.5; Im:0.5);


  procedure Add (const func_name: string; smpl_val: TSample; const cplx_val: TCplx;
                 smpl_func: TSmplFunc; cplx_func: TCplxFunc; vec_method: TVecMethod); overload;
  begin
    if fFuncCount >= Length(fFuncs) then
      SetLength (fFuncs, fFuncCount + 20);

    fFuncs[fFuncCount].func_name:= func_name;
    fFuncs[fFuncCount].smpl_func:= smpl_func;
    fFuncs[fFuncCount].cplx_func:= cplx_func;
    fFuncs[fFuncCount].vec_method:= vec_method;
    fFuncs[fFuncCount].smpl_val:= smpl_val;
    fFuncs[fFuncCount].cplx_val:= cplx_val;

    Inc (fFuncCount);
  end;

begin
  fFuncCount:= 0;

  {$IFNDEF CLR}

    {$IFNDEF CPUX64}

        Add ('Sin', VAL1, CVAL1, Math387.Sin, Math387.Sin, fDst.Sin );
        Add ('Cos', VAL1, CVAL1, Math387.Cos, Math387.Cos, fDst.Cos );
        Add ('Exp', VAL1, CVAL1, Math387.Exp, Math387.Exp, fDst.Exp );
        Add ('Ln', VAL1, CVAL1,  Math387.Ln, Math387.Ln, fDst.Ln );

    {$ELSE}

        {$IFDEF TTDOUBLE}  //define this, if sizeof(TSample) = 8, MtxVec runs in double precision

        Add ('Sin', VAL1, CVAL1, {$IFDEF D23} System.{$ENDIF}Sin, Math387.Sin, fDst.Sin );
        Add ('Cos', VAL1, CVAL1, {$IFDEF D23} System.{$ENDIF}Cos, Math387.Cos, fDst.Cos );
        Add ('Exp', VAL1, CVAL1, {$IFDEF D23} System.{$ENDIF}Exp, Math387.Exp, fDst.Exp );
        Add ('Ln', VAL1, CVAL1,  {$IFDEF D23} System.{$ENDIF}Ln, Math387.Ln, fDst.Ln );

        {$ELSE}

        //There is no single precision of System.Sin, System.Cos, etc... for 64bit

//        Add ('Sin', VAL1, CVAL1, Sin, Math387.Sin, fDst.Sin);
//        Add ('Cos', VAL1, CVAL1, Cos, Math387.Cos, fDst.Cos);
//        Add ('Exp', VAL1, CVAL1, Exp, Math387.Exp, fDst.Exp);
//        Add ('Ln', VAL1, CVAL1,  Ln, Math387.Ln, fDst.Ln);

        {$ENDIF}

    {$ENDIF}

  Add ('Log10', VAL1, CVAL1, Math387.Log10, Math387.Log10, fDst.Log10);
  Add ('Tan', VAL1, CVAL1, Math387.Tan, Math387.Tan, fDst.Tan);

  Add ('ArcSin', VAL1, CVAL1, Math387.ArcSin, Math387.ArcSin, fDst.ArcSin);
  Add ('ArcCos', VAL1, CVAL1, Math387.ArcCos, Math387.ArcCos, fDst.ArcCos);

  {$IFDEF CPUX64}
  Add( 'ArcTan', VAL1, CVAL1, {$IFDEF D23}System.{$ENDIF}ArcTan, Math387.ArcTan, fDst.ArcTan);
  {$ELSE}
  Add( 'ArcTan', VAL1, CVAL1, {$IFDEF D23}Math387.{$ENDIF}ArcTan, Math387.ArcTan, fDst.ArcTan);
  {$ENDIF}

  Add ('Sinh', VAL1, CVAL1, Math387.Sinh, Math387.Sinh, fDst.Sinh);
  Add ('Cosh', VAL1, CVAL1, Math387.Cosh, Math387.Cosh, fDst.Cosh);
  Add ('Tanh', VAL1, CVAL1, Math387.Tanh, Math387.Tanh, fDst.Tanh);

  Add ('ArcSinh', VAL1, CVAL1, Math387.ArcSinh, Math387.ArcSinh, fDst.ArcSinh);
  Add ('ArcCosh', VAL1, CVAL1, Math387.ArcCosh, Math387.ArcCosh, fDst.ArcCosh);
  Add ('ArcTanh', VAL1, CVAL1, Math387.ArcTanh, Math387.ArcTanh, fDst.ArcTanh);

  {$ELSE} //CLR

  Add ('Sin', VAL1, CVAL1, Sin, Math387.Sin, fDst.Sin);
  Add ('Cos', VAL1, CVAL1, Cos, Math387.Cos, fDst.Cos);
  Add ('Exp', VAL1, CVAL1, Exp, Math387.Exp, fDst.Exp);
  Add ('Ln', VAL1, CVAL1, Ln, Math387.Ln, fDst.Ln);

  Add ('Log10', VAL1, CVAL1, Math387.Log10, Math387.Log10, fDst.Log101);
  Add ('Tan', VAL1, CVAL1, Math387.Tan, Math387.Tan, fDst.Tan1);
//  Add ('ArcTan', VAL1, CVAL1, Math387.ArcTan, Math387.ArcTan, fDst.ArcTan1);
  Add ('ArcSin', VAL1, CVAL1, Math387.ArcSin, Math387.ArcSin, fDst.ArcSin1);
  Add ('ArcCos', VAL1, CVAL1, Math387.ArcCos, Math387.ArcCos, fDst.ArcCos1);

  Add ('ArcTanh', VAL1, CVAL1, Math387.ArcTanh, Math387.ArcTanh, fDst.ArcTanh1);
  Add ('ArcSinh', VAL1, CVAL1, Math387.ArcSinh, Math387.ArcSinh, fDst.ArcSinh1);
//  Add ('ArcCosh', VAL1, CVAL1, Math387.ArcCosh, Math387.ArcCosh, fDst.ArcCosh);

  Add ('Tanh', VAL1, CVAL1, Math387.Tanh, Math387.Tanh, fDst.Tanh1);
  Add ('Sinh', VAL1, CVAL1, Math387.Sinh, Math387.Sinh, fDst.Sinh1);
  Add ('Cosh', VAL1, CVAL1, Math387.Cosh, Math387.Cosh, fDst.Cosh1);

  {$ENDIF}
end;

procedure TBenchmarkFramework.InitSmplVecs (const val: TSample);
begin
  fSrc.Size (VectorLength, FALSE);
  fSrc.SetVal (val);
  FSrc.CopyToArray(FSrca);
  fDst.Size (VectorLength, FALSE);
  fDst.SetZero;
  FDst.SizeToArray(FDsta);
end;

procedure TBenchmarkFramework.InitCplxVecs (const cval: TCplx);
begin
  fSrc.Size (VectorLength, TRUE);
  fSrc.SetVal (cval);
  FSrc.CopyToArray(FSrcac);
  fDst.Size (VectorLength, TRUE);
  fDst.SetZero;
  FDst.SizeToArray(FDstac);
end;

procedure TBenchmarkFramework.Run(const func_name: string; var results: TBenchmarkResults);
var
  smpl_vec_ticks, cplx_vec_ticks, smpl_func_ticks, cplx_func_ticks: double;
begin
  fSelectedFunc:= fFuncs[FindFuncByName(func_name)];

  InitSmplVecs (fSelectedFunc.smpl_val);
  smpl_vec_ticks:= DoUnderTimer (CalcVector);

  InitCplxVecs (fSelectedFunc.cplx_val);
  cplx_vec_ticks:= DoUnderTimer (CalcVector);

  InitSmplVecs (fSelectedFunc.smpl_val);
  smpl_func_ticks:= DoUnderTimer (CalcSample);

  InitCplxVecs (fSelectedFunc.cplx_val);
  cplx_func_ticks:= DoUnderTimer (CalcComplex);

  results.Add (func_name, VectorLength, IterationCount,
    smpl_vec_ticks, cplx_vec_ticks, smpl_func_ticks, cplx_func_ticks);
end;

procedure TBenchmarkFramework.CalcVector;
var
  i: integer;
  vec_method: TVecMethod;
begin
  vec_method:= fSelectedFunc.vec_method;
  for i:= 1 to fIterationCount do
    vec_method(fSrc);
end;

procedure TBenchmarkFramework.CalcSample;
var
  i,j: integer;
  smpl_func: TDoubleFunc;
begin
  smpl_func:= fSelectedFunc.smpl_func;
  for i:= 1 to fIterationCount do
    for j:= 0 to fDst.Length-1 do
      fDsta[j]:= smpl_func (fSrca[j]);
end;

procedure TBenchmarkFramework.CalcComplex;
var
  i,j: integer;
  cplx_func: TCplxFunc;
begin
  cplx_func:= fSelectedFunc.cplx_func;
  for i:= 1 to fIterationCount do
    for j:= 0 to fDst.Length-1 do
      fDstac[j]:= cplx_func (fSrcac[j]);
end;

function TBenchmarkFramework.DoUnderTimer(calc_proc: TCalcProc): double;
begin
  StartTimer;
  calc_proc;
  Result:= StopTimer*1000;
end;

function TBenchmarkFramework.RecalcIterationCount: integer;
var
  ticks: DWORD;
  delta: integer;
  a,b: TVec;
  n: integer;
begin
  CreateIt (a,b);
  try
    a.Size (VectorLength, FALSE);
    b.Size (VectorLength, FALSE);

    n:= 0;
//    delta:= 0;
    ticks:= GetTickCount;
    while (TRUE) do begin
      b.Sin(a);
      Inc(n);
      delta:= GetTickCount - ticks;
      if delta > 1000 then
        break;
    end;

    Result:= n div 4;  // iterations per 1/4 second

  finally
    FreeIt (a,b)
  end;
end;

end.
