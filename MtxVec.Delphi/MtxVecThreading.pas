unit MtxVecThreading;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Math387, MtxForLoop, MtxExpr, clMtxVec,
  ComCtrls, ExtCtrls, MtxVec;

  {$I bdsppdefs.inc}                                      

type                                             
  TCalcMethod = procedure of object;

  TMtxVecThreadingForm = class(TForm)
    Memo: TMemo;
    btnBenchmark: TButton;
    RichEdit1: TRichEdit;
    Label5: TLabel;
    procedure btnBenchmarkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    nx, ny, nz, nxyz: Integer;
    nh, nk, nl, nhkl: Integer;
    h, k, l: TSampleArray;
    x, y, z: TSampleArray;
    vx, vy, vz: Vector;
    F, Fgold: TCplxArray;
    CalcName: string;
    CalcTime: Double;
    FirstRun: boolean;
    Device: TOpenCLDevice;
    cpuCores: integer;
    procedure Fcpu;
    procedure Fmv;
    procedure Fmvb;
    procedure Fmvt;
    procedure Fmvtb;
    procedure Fclv;
    procedure Fclk;
    procedure Benchmark(CalcF: TCalcMethod);
    procedure Fmvbb;
    procedure Fmvtbb;
    procedure MyLoop(LoopIndex: Integer; const Context: TObjectArray; ThreadingIndex: integer);
    procedure MyLoopB(IdxMin, IdxMax: Integer;  const Context: TObjectArray; ThreadingIndex: integer);
    procedure MyLoopB2(IdxMin, IdxMax: Integer;  const Context: TObjectArray; ThreadingIndex: integer);
    procedure SetupOpenCL(VectorLen: integer);
    procedure CreateCustomKernels;
    procedure Fhkl(F, h, k, l, x, y, z: TOpenCLVector);
    procedure Fmvtbd;
    procedure Fmvtba;
    procedure InternalFmvtbd(aIndex: integer; aThreadCount: integer; vh, vk, vl: TVec);
  public
    { Public declarations }
  end;

var
  MtxVecThreadingForm: TMtxVecThreadingForm;

implementation

uses MtxVecEdit, AbstractMtxVec, clMtxExpr, Math, MtxVecInt, StringVar
     {$IFDEF D19} ,System.Types {$ELSE} ,Types {$ENDIF}
     {$IFDEF D21}
     ,System.Threading
     {$ENDIF}
      ;

{$R *.dfm}

procedure TMtxVecThreadingForm.Fhkl(F, h, k, l, x, y, z: TOpenCLVector);
var AKernel: TOpenCLKernel;
begin
  AKernel := Device.Kernels.Locate('Fhkl');
  AKernel.SetArgBuffer(0, F.CData);

  AKernel.SetArgInt32(1, F.CDataIndex(0));   // DataIndex typically does not return 0 (!!)
  AKernel.SetArgBuffer(2, h.SData);
  AKernel.SetArgInt32(3, h.SDataIndex(0));
  AKernel.SetArgBuffer(4, k.SData);
  AKernel.SetArgInt32(5, k.SDataIndex(0));
  AKernel.SetArgBuffer(6, l.SData);
  AKernel.SetArgInt32(7, l.SDataIndex(0));
  AKernel.SetArgInt32(8, h.Length);
  AKernel.SetArgBuffer(9, x.SData);
  AKernel.SetArgInt32(10, x.SDataIndex(0));
  AKernel.SetArgBuffer(11, y.SData);
  AKernel.SetArgInt32(12, y.SDataIndex(0));
  AKernel.SetArgBuffer(13, z.SData);
  AKernel.SetArgInt32(14, z.SDataIndex(0));
  AKernel.SetArgInt32(15, z.Length);

  // Auto local work size and no CPU adjust
  AKernel.Enqueue(h.CmdQueue, h.Length, false);
end;

procedure TMtxVecThreadingForm.CreateCustomKernels;
var  BinFileName: string;
      SourceCode: StringList;
        AProgram: TOpenCLProgram;
begin
    if (Device.Programs.Count > 1) then  Device.Programs.Delete(1);
    AProgram := Device.Programs.Add;

    BinFileName:= aProgram.BinaryFileName('XRD.c');

    SourceCode.Add(' __kernel void Fhkl (                          ');
    SourceCode.Add('  __global float *vf, const int vfIdx,        ');
    SourceCode.Add('  __global const float *vh, const int vhIdx,  ');
    SourceCode.Add('  __global const float *vk, const int vkIdx,  ');
    SourceCode.Add('  __global const float *vl, const int vlIdx,  ');
    SourceCode.Add('  const int nhkl,                             ');
    SourceCode.Add('  __global const float *vx, const int vxIdx,  ');
    SourceCode.Add('  __global const float *vy, const int vyIdx,  ');
    SourceCode.Add('  __global const float *vz, const int vzIdx,  ');
    SourceCode.Add('  const int nxyz)                             ');
    SourceCode.Add('{                                             ');
    SourceCode.Add('  for (int ix = get_global_id(0); ix < nhkl; ix += get_global_size(0))');
    SourceCode.Add('  {                                                                   ');
    SourceCode.Add('    const float TWOPI = 6.2831853071795862;                           ');
    SourceCode.Add('    const float h=TWOPI*vh[ix + vhIdx];                               ');
    SourceCode.Add('    const float k=TWOPI*vk[ix + vkIdx];                               ');
    SourceCode.Add('    const float l=TWOPI*vl[ix + vlIdx];                               ');
    SourceCode.Add('    float x, y, z, tmp;                                               ');
    SourceCode.Add('    float fr=0, fi=0;                                                 ');
    SourceCode.Add('                                                                      ');
    SourceCode.Add('    for(int i=0; i<nxyz; i++)                                         ');
    SourceCode.Add('    {                                                                 ');
    SourceCode.Add('      x=vx[i + vxIdx];                                                ');
    SourceCode.Add('      y=vy[i + vyIdx];                                                ');
    SourceCode.Add('      z=vz[i + vzIdx];                                                ');
    SourceCode.Add('      tmp=h*x + k*y + l*z;                                            ');
    SourceCode.Add('      fr += native_cos(tmp);                                          ');
    SourceCode.Add('      fi += native_sin(tmp);                                          ');
    SourceCode.Add('    }                                                                 ');
    SourceCode.Add('                                                                      ');
    SourceCode.Add('    vf[2*(ix + vfIdx)] = fr;                                          ');
    SourceCode.Add('    vf[2*(ix + vfIdx)+1] = fi;                                        ');
    SourceCode.Add('  }                                                                   ');
    SourceCode.Add('}                                                                     ');
    SourceCode.Add(' ');

    AProgram.LoadProgram(binFileName, SourceCode, '', '', true);
end;

procedure TMtxVecThreadingForm.SetupOpenCL(VectorLen: integer);
begin
  if FirstRun then
  begin
      FirstRun := false;
      clPlatform.UnmarkThreads;
      clPlatform.LoadProgramsForDevices(false, false, true, false, false);


      Device := clPlatform.GetFirstGPUDevice;
      VectorLen := 2*Length(x);
      Device.Cache.SetCacheSize(15, VectorLen, 15, 15);
      Device.CommandQueue[0].MarkThread;
      CreateCustomKernels;
  end;
end;

procedure TMtxVecThreadingForm.Fcpu;
var i, j: Integer;
    nhkl, nxyz: Integer;
begin
  CalcName := 'CPU - using pure pascal code, one CPU core';

  StartTimer;
  nhkl := Length(h);
  nxyz := Length(x);

  for i := 0 to nhkl-1 do
  begin
      F[i] := C_ZERO;
      for j := 0 to nxyz-1 do
          F[i] := F[i] + Expj(TWOPI * (h[i]*x[j] + k[i]*y[j] + l[i]*z[j]));
  end;

  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.Fmv;
var
  i: Integer;
  nhkl: Integer;
  vx, vy, vz, Res: MtxExpr.Vector;
begin
  CalcName := 'CPU - using MtxVec, one CPU core';

  StartTimer;
  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  nhkl := Length(h);
  for i := 0 to nhkl-1 do
  begin
    Res := Expj(TWOPI * (h[i]*vx + k[i]*vy + l[i]*vz));
    F[i] := Res.Sumc;
  end;

  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.Fmvb;
var i: Integer;
    nhkl: Integer;
    vx, vy, vz, Res: MtxExpr.Vector;
begin
  CalcName := 'CPU - using MtxVec with blocks';

  MtxVecBlockSize := 500;

  StartTimer;

  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  nhkl := Length(h);
  for i := 0 to nhkl-1 do
  begin
      vx.BlockInit;
      vy.BlockInit;
      vz.BlockInit;

      while not vx.BlockEnd do
      begin
        Res.Expj(TWOPI * (h[i]*vx + k[i]*vy + l[i]*vz));
        F[i] := F[i] + Res.Sumc;

        vx.BlockNext;
        vy.BlockNext;
        vz.BlockNext;
      end;
  end;

  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.Fmvbb;
var i: Integer;
    nhkl: Integer;
    vx, vy, vz, Res: MtxExpr.Vector;
    temp: MtxExpr.Vector;
begin
  CalcName := 'CPU - using MtxVec with hand-written blocks';

  MtxVecBlockSize := 1000;
  StartTimer;

  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  nhkl := Length(h);
  for i := 0 to nhkl-1 do
  begin
      vx.BlockInit;
      vy.BlockInit;
      vz.BlockInit;

      while not vx.BlockEnd do
      begin
        temp.Mul(vx, h[i]*TWOPI);
        temp.AddScaled(vy, k[i]*TWOPI);
        temp.AddScaled(vz, l[i]*TWOPI);
        Res.Expj(temp);

        F[i] := F[i] + Res.Sumc;

        vx.BlockNext;
        vy.BlockNext;
        vz.BlockNext;
      end;
  end;

  CalcTime := StopTimer;
end;

// Threaded code using TMtxForLoop

procedure TMtxVecThreadingForm.MyLoop(LoopIndex: Integer; const Context: TObjectArray; ThreadingIndex: integer);
var
  i: Integer;
  Res: MtxExpr.Vector;
begin
  i := LoopIndex;

  Res := Expj(TWOPI * (h[i]*vx + k[i]*vy + l[i]*vz));
  F[i] := Res.Sumc;
end;

procedure TMtxVecThreadingForm.Fmvt;
var nhkl: Integer;
begin
  CalcName := 'CPU - using MtxVec (threaded (naive))';
  GlobalThreads.ThreadCount := CpuCores;
  StartTimer;

  nhkl := Length(h);
  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  // Start the threads
  DoForLoop(0, nhkl-1, MyLoop, nil, []);  // Code execution will not continue until all threads have finished.
  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.MyLoopB(IdxMin, IdxMax: Integer; const Context: TObjectArray; ThreadingIndex: integer);
var
  i: Integer;
  Res: MtxExpr.Vector;
  vxb, vyb, vzb: MtxExpr.Vector;
begin
  vxb.BlockInit(vx);
  vyb.BlockInit(vy);
  vzb.BlockInit(vz);

  while not vxb.BlockEnd do
  begin
    for i := IdxMin to IdxMax do
    begin
      Res := Expj(TWOPI * (h[i]*vxb + k[i]*vyb+ l[i]*vzb));
      F[i] := F[i] + Res.Sumc;
    end;

    vxb.BlockNext;
    vyb.BlockNext;
    vzb.BlockNext;
  end;
end;

procedure TMtxVecThreadingForm.Fmvtb;
var  nhkl: Integer;
begin
  CalcName := 'CPU - using MtxVec (threaded, with blocks)';
  GlobalThreads.ThreadCount := CpuCores;
  nhkl := Length(h);

  StartTimer;

  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  // Start the threads
  DoForLoop(0, nhkl-1, MyLoopB, nil, []);  // Code execution will not continue until all threads have finished.
  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.Fmvtba; //using anonymous method
var  nhkl: Integer;
begin
  CalcName := 'CPU - using MtxVec (threaded, blocks, DoForLoop, Annonymous method)';
  GlobalThreads.ThreadCount := CpuCores;
  nhkl := Length(h);

  StartTimer;

  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  {$IFDEF D16}
  // Start the threads
  DoForLoop(0, nhkl-1, procedure (IdxMin, IdxMax: Integer; Context: TObjectArray; ThreadingIndex: integer)
                       var i: Integer;
                            Res: MtxExpr.Vector;
                            vxb, vyb, vzb: MtxExpr.Vector;
                       begin
                            vxb.BlockInit(vx);
                            vyb.BlockInit(vy);
                            vzb.BlockInit(vz);

                            while not vxb.BlockEnd do
                            begin
                              for i := IdxMin to IdxMax do
                              begin
                                Res := Expj(TWOPI * (h[i]*vxb + k[i]*vyb+ l[i]*vzb));
                                F[i] := F[i] + Res.Sumc;
                              end;

                              vxb.BlockNext;
                              vyb.BlockNext;
                              vzb.BlockNext;
                            end;
                        end

                       , nil, []);  // Code execution will not continue until all threads have finished.
  {$ELSE}
  CalcName := 'CPU - using MtxVec (threaded, blocks, DoForLoop with Annonymous method), Delphi XE2 required';  
  {$ENDIF}

  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.MyLoopB2(IdxMin, IdxMax: Integer; const Context: TObjectArray; ThreadingIndex: integer);
var i: Integer;
    Res, temp: MtxExpr.Vector;
    vxb, vyb, vzb: MtxExpr.Vector;
begin
  vxb.BlockInit(vx);
  vyb.BlockInit(vy);
  vzb.BlockInit(vz);

  while not vxb.BlockEnd do //with hand-written block
  begin
    for i := IdxMin to IdxMax do
    begin
      temp.Mul(vxb, h[i]*TWOPI);
      temp.AddScaled(vyb, k[i]*TWOPI);
      temp.AddScaled(vzb, l[i]*TWOPI);
      Res.Expj(temp);

      F[i] := F[i] + Res.Sumc;
    end;

    vxb.BlockNext;
    vyb.BlockNext;
    vzb.BlockNext;
  end;
end;

procedure TMtxVecThreadingForm.Fmvtbb;
var nhkl: Integer;
begin
  CalcName := 'CPU - using MtxVec (threaded, hand written blocks, DoForLoop)';
  GlobalThreads.ThreadCount := CpuCores;
  nhkl := Length(h);

  StartTimer;

  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  // Start the threads
  DoForLoop(0, nhkl-1, MyLoopB2, nil, []);  // Code execution will not continue until all threads have finished.
  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.InternalFmvtbd(aIndex: integer; aThreadCount: integer; vh, vk, vl: TVec);
var IdxMin, IdxMax: integer;
    i, k: Integer;
    Res: MtxExpr.Vector;
    vxb, vyb, vzb: MtxExpr.Vector;
begin  //Split the work domain among all threads:
    k := nhkl div aThreadCount;
    IdxMin := k*(aIndex);
    IdxMax := k*(aIndex+1);
    if (aIndex+1) = aThreadCount then IdxMax := nhkl-1;

    vxb.BlockInit(vx);
    vyb.BlockInit(vy);
    vzb.BlockInit(vz);

    while not vxb.BlockEnd do
    begin
        for i := IdxMin to IdxMax do
        begin
            Res := Expj(TWOPI * (vh[i]*vxb + vk[i]*vyb+ vl[i]*vzb));
            F[i] := F[i] + Res.Sumc;
        end;

        vxb.BlockNext;
        vyb.BlockNext;
        vzb.BlockNext;
    end;
end;

procedure TMtxVecThreadingForm.Fmvtbd;
{$IFDEF D21}
var aThreadCount: integer;
    vh, vk, vl: Vector;
{$ENDIF}
begin
  CalcName := 'CPU - using MtxVec (threaded, blocks, TParallel.For)';

  {$IFDEF D21}
  aThreadCount := cpuCores; //Controller.CpuCores;

  StartTimer;

  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  vh.CopyFromArray(h);
  vk.CopyFromArray(k);
  vl.CopyFromArray(l);


  TParallel.For(0, aThreadCount-1,

                      procedure (aIndex: Integer)
                      begin
                          Controller.MarkThread;  //uses separate memory pools per thread for Vector/TVec, assumes each index is triggered by separate thread only once
                          InternalFmvtbd(aIndex, aThreadCount, vh, vk, vl);
                          Controller.UnMarkThread;
                      end

                      );

  CalcTime := StopTimer;

  //compiler bug when anonymous function is present in the function body:

  vh.Adopt(nil);
  vk.Adopt(nil);
  vl.Adopt(nil);

  //this needs to be freed explicitely or memory leak will occure.
  //Bug report filed for XE9.

  {$ELSE}

  CalcTime := 0;
  CalcName := 'CPU - using MtxVec (threaded, TParallel.For), Delphi XE7 required';

  {$ENDIF}
end;

procedure TMtxVecThreadingForm.Fclv;
var
  i: Integer;
  nhkl: Integer;
  cx, cy, cz, Res: clVector;
begin
  CalcName := 'GPU - using OpenCL (clVector)';
  SetupOpenCL(2*Length(x));

  StartTimer;
  // Copy data from CPU memory to GPU memory

  cx.CopyFromArray(x);
  cy.CopyFromArray(y);
  cz.CopyFromArray(z);

  nhkl := Length(h);
  for i := 0 to nhkl-1 do
  begin
      Res := ExpJ(TWOPI * (h[i]*cx + k[i]*cy + l[i]*cz));
      F[i] := Res.Sumc;
  end;

  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.Fclk;
var
  vF: clVector;
  vh, vk, vl: clVector;
  cx, cy, cz: clVector;
begin
  CalcName := 'GPU - using OpenCL (custom kernel)';
  SetupOpenCL(2*Length(x));

  StartTimer;

  // Copy data from CPU to GPU memory
  vh.CopyFromArray(h);
  vk.CopyFromArray(k);
  vl.CopyFromArray(l);

  cx.CopyFromArray(x);
  cy.CopyFromArray(y);
  cz.CopyFromArray(z);

  vF.Size(vh.Length, clFloat, True);
  vF.SetZero;

  // Call the kernel function on the GPU
  Fhkl(vF, vh, vk, vl, cx, cy, cz);

  // Copy data from GPU to CPU memory
  vF.CopyToArray(F);

  CalcTime := StopTimer;
end;

procedure TMtxVecThreadingForm.FormCreate(Sender: TObject);
begin
  With RichEdit1.Lines, RichEdit1 do
  begin
    Clear;
    Add('The example tests several multithreading designs and compares to Open CL version of the same algorithm.' +
        'The algorithm tested is best suitable for Open CL acceleration, but it also serves great ' +
        'to show different approaches when applying multithreading to MtxVec based code running on CPU. Check out ' +
        'the source of this form for details about what is being compared.');
    Add('For an in-depth analysis of the results please have look at the "MtxVec Users Guide.pdf". ' +
        '(MtxVec needs to run in single precision to be directly comparable to Open CL results.)');
    Add('');
    Add('The algorithm tested is a real world example kindly given by Matthew Wormington in use by www.jsvmi.com and takes roghly 5 lines of code.');
    Add('The algorithm is based on the article: Fast computation of scattering maps of nanostrctures using graphical processing units. ' +
        'Published in Journal of Applied Crystalography, Vol. 44, part 3, 2011.');
  end;

  FirstRun := True;

  cpucores := Controller.CpuCores;
  // Create the global threads
  if not Assigned(GlobalThreads) then     //created only once
    GlobalThreads := TMtxForLoop.Create;

  //Required (!!) to achieve good results with TParallel.For

  {$IFDEF D21} //TThreadPool was introduced with XE7
  TThreadPool.Default.SetMaxWorkerThreads(GlobalThreads.ThreadCount);
  TThreadPool.Default.SetMinWorkerThreads(GlobalThreads.ThreadCount);
  {$ENDIF}
end;


procedure TMtxVecThreadingForm.FormDestroy(Sender: TObject);
begin
    if Assigned(GlobalThreads) then  FreeAndNil(GlobalThreads);
end;

procedure TMtxVecThreadingForm.Benchmark(CalcF: TCalcMethod);
var
  ix, iy, iz, ixyz: Integer;
  ih, ik, il, ihkl: Integer;
  i: Integer;
  dAbsFgold, AbsFgold: TSampleArray;
  FOM: TSample;
  S: string;
begin  // Create arrays of 3D coordinates, 40 x 40 x 40 cells
  nx := 30;
  ny := 30;
  nz := 30;
  nxyz := nx*ny*nz;
  SetLength(x, nxyz);
  SetLength(y, nxyz);
  SetLength(z, nxyz);

  ixyz := 0;
  for ix := 0 to nx-1 do
  for iy := 0 to ny-1 do
  for iz := 0 to nz-1 do
  begin
    x[ixyz] := ix;
    y[ixyz] := iy;
    z[ixyz] := iz;
    Inc(ixyz);
  end;

  // Create arrays of HKL coordinates
  nh := 30;
  nk := 30;
  nl := 30;
  nhkl := nh*nk*nl;
  SetLength(h, nhkl);
  SetLength(k, nhkl);
  SetLength(l, nhkl);

  ihkl := 0;
  for ih := 0 to nh-1 do
  for ik := 0 to nk-1 do
  for il := 0 to nl-1 do
  begin
      h[ihkl] := 0.01 + (0.5-0.01)*Random;
      k[ihkl] := 0.01 + (0.5-0.01)*Random;
      l[ihkl] := 2.01 + (2.5-2.01)*Random;
      Inc(ihkl);
  end;

  // Do the calculation
  SetLength(F, 0);
  SetLength(F, nhkl); //zero out array
  CalcF;

  // Compare to analytical formula
  SetLength(Fgold, nhkl);
  for i := 0 to nhkl-1 do
  begin
    Fgold[i] :=
      (Expj(pi*h[i]*(nx-1)) * Sin(pi*h[i]*nx) / Sin(pi*h[i])) *
      (Expj(pi*k[i]*(ny-1)) * Sin(pi*k[i]*ny) / Sin(pi*k[i])) *
      (Expj(pi*l[i]*(nz-1)) * Sin(pi*l[i]*nz) / Sin(pi*l[i]))
  end;

  SetLength(AbsFgold, nhkl);
  SetLength(dAbsFgold, nhkl);
  for i := 0 to nhkl-1 do
  begin
    AbsFgold[i] := CAbs(Fgold[i]);
    dAbsFgold[i] := CAbs(F[i] - Fgold[i]);
  end;
  FOM := Mean(dAbsFgold)/Mean(AbsFgold);

  S := Format('%s: %.2f s', [CalcName, CalcTime]);
  if (FOM > 0.01) then
    S := S + ' ERROR!';

  Memo.Lines.Add(S);
  Application.ProcessMessages;

  // print "%20s: %5d 10^3 reflections, %5d 10^3 atoms, speed=%7.3f 10^9 reflections.atoms/s  =>   <|GPU-analytical|> / <|analytical|>=%7.5f, %10s"%("fhkl",nh*nk*nl//1000,nx*ny*nz//1000,nx*ny*nz*nh*nk*nl/dt/1e9, tmp,s)
end;


procedure TMtxVecThreadingForm.btnBenchmarkClick(Sender: TObject);
begin
    if Controller.Pool[0].Vec.CacheSize = 0 then Caption := 'MtxVec is running in Debug mode!';
    ShowMessage('This test could run 1-5 minutes!');

    Benchmark(Fcpu);  //Too slow

    Benchmark(Fmv);
    Benchmark(Fmvb);

    Benchmark(Fmvbb);
    Benchmark(Fmvt);
    Benchmark(Fmvtb);
    Benchmark(Fmvtba); //using anonymous method
    Benchmark(Fmvtbb); //Hand written block threaded
    Benchmark(Fmvtbd); //Threaded,Delphi

    Benchmark(Fclv);
    Benchmark(Fclk);
end;

initialization
  RegisterClass(TMtxVecThreadingForm);

end.
