//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "MtxVecThreading.h"
#include <MtxVecEdit.hpp>
#include <AbstractMtxVec.hpp>
#include <clMtxExpr.hpp>
#include <MtxVecInt.hpp>
#if (__BORLANDC__ >= 0x0720)
#include <System.Threading.hpp>
#endif
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TMtxVecThreadingForm *MtxVecThreadingForm;
//---------------------------------------------------------------------------
__fastcall TMtxVecThreadingForm::TMtxVecThreadingForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fhkl(TOpenCLVector *F_, TOpenCLVector *h_, TOpenCLVector *k_,
                                           TOpenCLVector *l_, TOpenCLVector *x_, TOpenCLVector *y_,
                                           TOpenCLVector *z_)
{
  TOpenCLKernel *AKernel = Device->Kernels->Locate("Fhkl");
  AKernel->SetArgBuffer(0, F_->CData);
  AKernel->SetArgInt32(1, F_->CDataIndex(0));
  AKernel->SetArgBuffer(2, h_->SData);
  AKernel->SetArgInt32(3, h_->SDataIndex(0));
  AKernel->SetArgBuffer(4, k_->SData);
  AKernel->SetArgInt32(5, k_->SDataIndex(0));
  AKernel->SetArgBuffer(6, l_->SData);
  AKernel->SetArgInt32(7, l_->SDataIndex(0));
  AKernel->SetArgInt32(8, h_->Length);
  AKernel->SetArgBuffer(9, x_->SData);
  AKernel->SetArgInt32(10, x_->SDataIndex(0));
  AKernel->SetArgBuffer(11, y_->SData);
  AKernel->SetArgInt32(12, y_->SDataIndex(0));
  AKernel->SetArgBuffer(13, z_->SData);
  AKernel->SetArgInt32(14, z_->SDataIndex(0));
  AKernel->SetArgInt32(15, z_->Length);

  // Auto local work size and no CPU adjust
  AKernel->Enqueue(h_->CmdQueue, h_->Length, false);
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::CreateCustomKernels()
{
  if (Device->Programs->Count > 1) Device->Programs->Delete(1);
  TOpenCLProgram *AProgram = Device->Programs->Add();
  AnsiString BinFileName = AProgram->BinaryFileName("XRD.c");

  TStringList *SourceCode = new TStringList();
  try {
    SourceCode->Add(" __kernel void Fhkl (                          ");
    SourceCode->Add("  __global float *vf, const int vfIdx,        ");
    SourceCode->Add("  __global const float *vh, const int vhIdx,  ");
    SourceCode->Add("  __global const float *vk, const int vkIdx,  ");
    SourceCode->Add("  __global const float *vl, const int vlIdx,  ");
    SourceCode->Add("  const int nhkl,                             ");
    SourceCode->Add("  __global const float *vx, const int vxIdx,  ");
    SourceCode->Add("  __global const float *vy, const int vyIdx,  ");
    SourceCode->Add("  __global const float *vz, const int vzIdx,  ");
    SourceCode->Add("  const int nxyz)                             ");
    SourceCode->Add("{                                             ");
    SourceCode->Add("  for (int ix = get_global_id(0); ix < nhkl; ix += get_global_size(0))");
    SourceCode->Add("  {                                                                   ");
    SourceCode->Add("    const float TWOPI = 6.2831853071795862;                           ");
    SourceCode->Add("    const float h=TWOPI*vh[ix + vhIdx];                               ");
    SourceCode->Add("    const float k=TWOPI*vk[ix + vkIdx];                               ");
    SourceCode->Add("    const float l=TWOPI*vl[ix + vlIdx];                               ");
    SourceCode->Add("    float x, y, z, tmp;                                               ");
    SourceCode->Add("    float fr=0, fi=0;                                                 ");
    SourceCode->Add("                                                                      ");
    SourceCode->Add("    for(int i=0; i<nxyz; i++)                                         ");
    SourceCode->Add("    {                                                                 ");
    SourceCode->Add("      x=vx[i + vxIdx];                                                ");
    SourceCode->Add("      y=vy[i + vyIdx];                                                ");
    SourceCode->Add("      z=vz[i + vzIdx];                                                ");
    SourceCode->Add("      tmp=h*x + k*y + l*z;                                            ");
    SourceCode->Add("      fr += native_cos(tmp);                                          ");
    SourceCode->Add("      fi += native_sin(tmp);                                          ");
    SourceCode->Add("    }                                                                 ");
    SourceCode->Add("                                                                      ");
    SourceCode->Add("    vf[2*(ix + vfIdx)] = fr;                                          ");
    SourceCode->Add("    vf[2*(ix + vfIdx)+1] = fi;                                        ");
    SourceCode->Add("  }                                                                   ");
    SourceCode->Add("}                                                                     ");
    SourceCode->Add(" ");
    AProgram->LoadProgram(BinFileName, SourceCode, "", "", true);
  } __finally {
    delete SourceCode;
  }
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::SetupOpenCL(int VectorLen)
{
  if (FirstRun)
  {
    FirstRun = false;
    clPlatform()->UnMarkThreads();
    clPlatform()->LoadProgramsForDevices(false, false, true, false, false);
    Device = clPlatform()->GetFirstGPUDevice();
    VectorLen = 2 * x.Length;
    Device->Cache->SetCacheSize(15, VectorLen, 15, 15);
    (*Device->CommandQueue)[0]->MarkThread();
    CreateCustomKernels();
  }
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fcpu()
{
  CalcName = "CPU - using pure pascal code, one CPU core";
  StartTimer();
  int nhkl_l = h.Length;
  int nxyz_l = x.Length;
  for (int i = 0; i < nhkl_l; i++)
  {
    F[i] = C_ZERO;
    for (int j = 0; j < nxyz_l; j++)
      F[i] = F[i] + Expj(TWOPI * (h[i] * x[j] + k[i] * y[j] + l[i] * z[j]));
  }
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fmv()
{
  CalcName = "CPU - using MtxVec with expressions, one CPU core";
  StartTimer();
  sVector vxl, vyl, vzl, Res;
  vxl.CopyFromArray(x);
  vyl.CopyFromArray(y);
  vzl.CopyFromArray(z);
  int nhkl_l = h.Length;
  for (int i = 0; i < nhkl_l; i++)
  {
    Res = Expj(TWOPI * (h[i] * vxl + k[i] * vyl + l[i] * vzl));
    F[i] = Res.Sumc();
  }
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fmvb()
{
  CalcName = "CPU - using MtxVec with blocks";
  MtxVecBlockSize = 500;
  StartTimer();
  sVector vxl, vyl, vzl, Res;
  vxl.CopyFromArray(x);
  vyl.CopyFromArray(y);
  vzl.CopyFromArray(z);
  int nhkl_l = h.Length;
  for (int i = 0; i < nhkl_l; i++)
  {
    vxl.BlockInit();
    vyl.BlockInit();
    vzl.BlockInit();
    while (!vxl.BlockEnd)
    {
      Res.Expj(TWOPI * (h[i] * vxl + k[i] * vyl + l[i] * vzl));
      F[i] = F[i] + Res.Sumc();
      vxl.BlockNext();
      vyl.BlockNext();
      vzl.BlockNext();
    }
  }
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fmvbb()
{
  CalcName = "CPU - using MtxVec with hand-written blocks";
  MtxVecBlockSize = 1000;
  StartTimer();
  sVector vxl, vyl, vzl, Res, temp;
  vxl.CopyFromArray(x);
  vyl.CopyFromArray(y);
  vzl.CopyFromArray(z);
  int nhkl_l = h.Length;
  for (int i = 0; i < nhkl_l; i++)
  {
    vxl.BlockInit();
    vyl.BlockInit();
    vzl.BlockInit();
    while (!vxl.BlockEnd)
    {
      temp.Mul(vxl, h[i] * TWOPI);
      temp.AddScaled(vyl, k[i] * TWOPI);
      temp.AddScaled(vzl, l[i] * TWOPI);
      Res.Expj(temp);
      F[i] = F[i] + Res.Sumc();
      vxl.BlockNext();
      vyl.BlockNext();
      vzl.BlockNext();
    }
  }
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
// Threaded code using TMtxForLoop
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::MyLoop(int LoopIndex, const TObjectArray Context, int ThreadingIndex)
{
  int i = LoopIndex;
  sVector Res;
  Res = Expj(TWOPI * (h[i] * vx + k[i] * vy + l[i] * vz));
  F[i] = Res.Sumc();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fmvt()
{
  CalcName = "CPU - using MtxVec (threaded (naive))";
  mtxThreadPool->ThreadCount = cpuCores;
  StartTimer();

  int nhkl_l = h.Length;
  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  DoForLoop(0, nhkl_l - 1, &MyLoop, NULL, OPENARRAY(TObject*, ((TObject*)NULL)));
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::MyLoopB(int IdxMin, int IdxMax, const TObjectArray Context, int ThreadingIndex)
{
  sVector Res, vxb, vyb, vzb;
  vxb.BlockInit(vx);
  vyb.BlockInit(vy);
  vzb.BlockInit(vz);
  while (!vxb.BlockEnd)
  {
    for (int i = IdxMin; i <= IdxMax; i++)
    {
      Res = Expj(TWOPI * (h[i] * vxb + k[i] * vyb + l[i] * vzb));
      F[i] = F[i] + Res.Sumc();
    }
    vxb.BlockNext();
    vyb.BlockNext();
    vzb.BlockNext();
  }
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fmvtb()
{
  CalcName = "CPU - using MtxVec (threaded, with blocks)";
  mtxThreadPool->ThreadCount = cpuCores;
  int nhkl_l = h.Length;

  StartTimer();
  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  DoForLoop(0, nhkl_l - 1, &MyLoopB, NULL, OPENARRAY(TObject*, ((TObject*)NULL)));
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
// Pascal source uses an inline anonymous procedure; the body is identical to MyLoopB.
// In BCB, reuse MyLoopB to keep the demo equivalent.
void __fastcall TMtxVecThreadingForm::Fmvtba()
{
  CalcName = "CPU - using MtxVec (threaded, blocks, DoForLoop, Annonymous method)";
  mtxThreadPool->ThreadCount = cpuCores;
  int nhkl_l = h.Length;

  StartTimer();
  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  DoForLoop(0, nhkl_l - 1, &MyLoopB, NULL, OPENARRAY(TObject*, ((TObject*)NULL)));
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::MyLoopB2(int IdxMin, int IdxMax, const TObjectArray Context, int ThreadingIndex)
{
  sVector Res, temp, vxb, vyb, vzb;
  vxb.BlockInit(vx);
  vyb.BlockInit(vy);
  vzb.BlockInit(vz);
  while (!vxb.BlockEnd)
  {
    for (int i = IdxMin; i <= IdxMax; i++)
    {
      temp.Mul(vxb, h[i] * TWOPI);
      temp.AddScaled(vyb, k[i] * TWOPI);
      temp.AddScaled(vzb, l[i] * TWOPI);
      Res.Expj(temp);
      F[i] = F[i] + Res.Sumc();
    }
    vxb.BlockNext();
    vyb.BlockNext();
    vzb.BlockNext();
  }
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fmvtbb()
{
  CalcName = "CPU - using MtxVec (threaded, hand written blocks, DoForLoop)";
  mtxThreadPool->ThreadCount = cpuCores;
  int nhkl_l = h.Length;

  StartTimer();
  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  DoForLoop(0, nhkl_l - 1, &MyLoopB2, NULL, OPENARRAY(TObject*, ((TObject*)NULL)));
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::InternalFmvtbd(int aIndex, int aThreadCount, TVec *vh, TVec *vk, TVec *vl)
{
  // Split the work domain among all threads
  int k_div = nhkl / aThreadCount;
  int IdxMin = k_div * aIndex;
  int IdxMax = k_div * (aIndex + 1);
  if ((aIndex + 1) == aThreadCount) IdxMax = nhkl - 1;

  sVector Res, vxb, vyb, vzb;
  vxb.BlockInit(vx);
  vyb.BlockInit(vy);
  vzb.BlockInit(vz);
  while (!vxb.BlockEnd)
  {
    for (int i = IdxMin; i <= IdxMax; i++)
    {
      Res = Expj(TWOPI * (vh->Values[i] * vxb + vk->Values[i] * vyb + vl->Values[i] * vzb));
      F[i] = F[i] + Res.Sumc();
    }
    vxb.BlockNext();
    vyb.BlockNext();
    vzb.BlockNext();
  }
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::ParBody(TObject *Sender, int aIndex)
{
  Controller->MarkThread();
  InternalFmvtbd(aIndex, fParThreadCount, fParVh, fParVk, fParVl);
  Controller->UnMarkThread();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fmvtbd()
{
#if (__BORLANDC__ >= 0x0720)
  CalcName = "CPU - using MtxVec (threaded, blocks, TParallel.For)";
  fParThreadCount = cpuCores;
  sVector vh, vk, vl;

  StartTimer();
  vx.CopyFromArray(x);
  vy.CopyFromArray(y);
  vz.CopyFromArray(z);

  vh.CopyFromArray(h);
  vk.CopyFromArray(k);
  vl.CopyFromArray(l);

  fParVh = vh;
  fParVk = vk;
  fParVl = vl;

  TParallel::For(this, 0, fParThreadCount - 1, ParBody);

  CalcTime = StopTimer();

  // Compiler bug workaround (XE9): explicit Adopt(nil) to avoid leak when
  // anonymous method is present in function body.
  vh.Adopt(NULL);
  vk.Adopt(NULL);
  vl.Adopt(NULL);
#else
  CalcName = "CPU - using MtxVec (threaded, TParallel.For), Berlin (10.1, PV24) or later required";
  CalcTime = 0;
#endif
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fclv()
{
  CalcName = "GPU - using OpenCL (clVector)";
  SetupOpenCL(2 * x.Length);

  StartTimer();
  clVector cx, cy, cz, Res;
  cx.CopyFromArray(x);
  cy.CopyFromArray(y);
  cz.CopyFromArray(z);

  int nhkl_l = h.Length;
  for (int i = 0; i < nhkl_l; i++)
  {
    Res = Expj(TWOPI * (h[i] * cx + k[i] * cy + l[i] * cz));
    F[i] = Res.Sumc();
  }
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Fclk()
{
  CalcName = "GPU - using OpenCL (custom kernel)";
  SetupOpenCL(2 * x.Length);

  StartTimer();
  clVector vF, vh, vk, vl, cx, cy, cz;
  vh.CopyFromArray(h);
  vk.CopyFromArray(k);
  vl.CopyFromArray(l);
  cx.CopyFromArray(x);
  cy.CopyFromArray(y);
  cz.CopyFromArray(z);

  vF.Size(vh.Length, clFloat, true);
  vF.SetZero();

  // Call the kernel function on the GPU
  Fhkl(vF, vh, vk, vl, cx, cy, cz);

  // Copy data from GPU to CPU memory
  vF.CopyToArray(F);
  CalcTime = StopTimer();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::FormCreate(TObject *Sender)
{
  RichEdit1->Lines->Clear();
  RichEdit1->Lines->Add(
    "The example tests several multithreading designs and compares to Open CL version of the same algorithm."
    "The algorithm tested is best suitable for Open CL acceleration, but it also serves great "
    "to show different approaches when applying multithreading to MtxVec based code running on CPU. Check out "
    "the source of this form for details about what is being compared.");
  RichEdit1->Lines->Add("For an in-depth analysis of the results please have look at the \"MtxVec Users Guide.pdf\". "
                        "(MtxVec needs to run in single precision to be directly comparable to Open CL results.)");
  RichEdit1->Lines->Add("");
  RichEdit1->Lines->Add("The algorithm tested is a real world example kindly given by Matthew Wormington in use by www.jsvmi.com and takes roghly 5 lines of code.");
  RichEdit1->Lines->Add("The algorithm is based on the article: Fast computation of scattering maps of nanostrctures using graphical processing units. "
                        "Published in Journal of Applied Crystalography, Vol. 44, part 3, 2011.");

  FirstRun = true;
  cpuCores = Controller->CpuCores;
  // Create the global threads (created only once)
  if (mtxThreadPool == NULL) mtxThreadPool = new TMtxForLoop();

  Controller->ThreadDimension = cpuCores + 2;
  mtxThreadPool->ThreadCount = cpuCores;

#if (__BORLANDC__ >= 0x0720)
  // Required (!!) to achieve good results with TParallel.For (Berlin/PV24+).
  TThreadPool::Default->SetMaxWorkerThreads(mtxThreadPool->ThreadCount);
  TThreadPool::Default->SetMinWorkerThreads(mtxThreadPool->ThreadCount);
#endif
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::FormDestroy(TObject *Sender)
{
  if (mtxThreadPool != NULL) { delete mtxThreadPool; mtxThreadPool = NULL; }
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::Benchmark(TCalcMethod CalcF)
{
  // Create arrays of 3D coordinates, 30 x 30 x 30 cells
  nx = 30;
  ny = 30;
  nz = 30;
  nxyz = nx * ny * nz;
  x.Length = nxyz;
  y.Length = nxyz;
  z.Length = nxyz;

  int ixyz = 0;
  for (int ix = 0; ix < nx; ix++)
    for (int iy = 0; iy < ny; iy++)
      for (int iz = 0; iz < nz; iz++)
      {
        x[ixyz] = ix;
        y[ixyz] = iy;
        z[ixyz] = iz;
        ixyz++;
      }

  // Create arrays of HKL coordinates
  nh = 30;
  nk = 30;
  nl = 30;
  nhkl = nh * nk * nl;
  h.Length = nhkl;
  k.Length = nhkl;
  l.Length = nhkl;

  int ihkl = 0;
  for (int ih = 0; ih < nh; ih++)
    for (int ik = 0; ik < nk; ik++)
      for (int il = 0; il < nl; il++)
      {
        h[ihkl] = 0.01 + (0.5 - 0.01) * Random();
        k[ihkl] = 0.01 + (0.5 - 0.01) * Random();
        l[ihkl] = 2.01 + (2.5 - 2.01) * Random();
        ihkl++;
      }

  // Do the calculation
  F.Length = 0;
  F.Length = nhkl; // zero out array
  CalcF();

  // Compare to analytical formula
  Fgold.Length = nhkl;
  for (int i = 0; i < nhkl; i++)
  {
    Fgold[i] =
      (Expj(PI * h[i] * (nx - 1)) * Math387::Sin(PI * h[i] * nx) / Math387::Sin(PI * h[i])) *
      (Expj(PI * k[i] * (ny - 1)) * Math387::Sin(PI * k[i] * ny) / Math387::Sin(PI * k[i])) *
      (Expj(PI * l[i] * (nz - 1)) * Math387::Sin(PI * l[i] * nz) / Math387::Sin(PI * l[i]));
  }

  Math387::TSampleArray AbsFgold, dAbsFgold;
  Math387::aSetLength(AbsFgold, nhkl);
  Math387::aSetLength(dAbsFgold, nhkl);
  for (int i = 0; i < nhkl; i++)
  {
    AbsFgold[i] = CAbs(Fgold[i]);
    dAbsFgold[i] = CAbs(F[i] - Fgold[i]);
  }
  sVector vA, vD;
  vA.CopyFromArray(AbsFgold);
  vD.CopyFromArray(dAbsFgold);
  double FOM = vD.Mean() / vA.Mean();

  String S = CalcName + ": " + FormatFloat("0.00", CalcTime) + " s";
  if (FOM > 0.01) S = S + " ERROR!";

  Memo->Lines->Add(S);
  Application->ProcessMessages();
}
//---------------------------------------------------------------------------
void __fastcall TMtxVecThreadingForm::btnBenchmarkClick(TObject *Sender)
{
  if (Controller->Pool[0]->Vec->CacheSize == 0)
    Caption = "MtxVec is running in Debug mode!";
  ShowMessage("This test could run 1-5 minutes!");

  Benchmark(Fcpu);   // Too slow
  Benchmark(Fmv);
  Benchmark(Fmvb);
  Benchmark(Fmvbb);
  Benchmark(Fmvt);
  Benchmark(Fmvtb);
  Benchmark(Fmvtba); // using anonymous method
  Benchmark(Fmvtbb); // Hand written block threaded
  Benchmark(Fmvtbd); // Threaded, Delphi

//  Benchmark(Fclv);
//  Benchmark(Fclk);
}
//---------------------------------------------------------------------------
