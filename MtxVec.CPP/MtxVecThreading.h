//---------------------------------------------------------------------------
#ifndef MtxVecThreadingH
#define MtxVecThreadingH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>

#include <Math387.hpp>
#include <MtxForLoop.hpp>
#include <MtxExpr.hpp>
#include <clMtxVec.hpp>
#include <MtxVec.hpp>
//---------------------------------------------------------------------------
class TMtxVecThreadingForm : public TForm
{
__published:	// IDE-managed Components
  TMemo *Memo;
  TButton *btnBenchmark;
  TRichEdit *RichEdit1;
  TLabel *Label5;
  void __fastcall btnBenchmarkClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
private:
  int nx, ny, nz, nxyz;
  int nh, nk, nl, nhkl;
  Math387::TSampleArray h, k, l;
  Math387::TSampleArray x, y, z;
  sVector vx, vy, vz;
  Math387::TCplxArray F, Fgold;
  String CalcName;
  double CalcTime;
  bool FirstRun;
  TOpenCLDevice *Device;
  int cpuCores;

  typedef void __fastcall (__closure *TCalcMethod)();

  void __fastcall Fcpu();
  void __fastcall Fmv();
  void __fastcall Fmvb();
  void __fastcall Fmvt();
  void __fastcall Fmvtb();
  void __fastcall Fclv();
  void __fastcall Fclk();
  void __fastcall Benchmark(TCalcMethod CalcF);
  void __fastcall Fmvbb();
  void __fastcall Fmvtbb();
  void __fastcall MyLoop(int LoopIndex, const TObjectArray Context, int ThreadingIndex);
  void __fastcall MyLoopB(int IdxMin, int IdxMax, const TObjectArray Context, int ThreadingIndex);
  void __fastcall MyLoopB2(int IdxMin, int IdxMax, const TObjectArray Context, int ThreadingIndex);
  void __fastcall SetupOpenCL(int VectorLen);
  void __fastcall CreateCustomKernels();
  void __fastcall Fhkl(TOpenCLVector *F, TOpenCLVector *h, TOpenCLVector *k, TOpenCLVector *l,
                      TOpenCLVector *x, TOpenCLVector *y, TOpenCLVector *z);
  void __fastcall Fmvtbd();
  void __fastcall Fmvtba();
  void __fastcall InternalFmvtbd(int aIndex, int aThreadCount, TVec *vh, TVec *vk, TVec *vl);
  // Per-iteration body of Fmvtbd, called by TParallel::For
  TVec *fParVh, *fParVk, *fParVl;
  int fParThreadCount;
  void __fastcall ParBody(TObject *Sender, int aIndex);
public:
  __fastcall TMtxVecThreadingForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMtxVecThreadingForm *MtxVecThreadingForm;
//---------------------------------------------------------------------------
#endif
