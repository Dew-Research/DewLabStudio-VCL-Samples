//---------------------------------------------------------------------------
#ifndef SuperConductiveH
#define SuperConductiveH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <SyncObjs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>

#include <MtxBaseComp.hpp>
#include <MtxDialogs.hpp>
#include <MtxExpr.hpp>
#include <MtxComCtrls.hpp>
#include <Math387.hpp>
#include <MtxVecBase.hpp>
#include <MtxVec.hpp>
#include <AbstractMtxVec.hpp>
#include <MtxForLoop.hpp>
//---------------------------------------------------------------------------
enum TTestMethod { tmGetMem, tmTVec, tmVector, tmVectorGlobal };

class TSuperConductiveForm : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Thread1Label;
  TLabel *Label41;
  TLabel *Thread2Label;
  TLabel *Label31;
  TBevel *Bevel1;
  TButton *FullRunButton;
  TCheckBox *MultithreadBox;
  TMtxFloatEdit *VectorLenEdit;
  TComboBox *TestBox;
  TCheckBox *SuperConductiveMMBox;
  TMtxProgressDialog *Thread1;
  TChart *Chart;
  TButton *SingleRunButton;
  TLabel *Label3;
  TLabel *Label4;
  TLabel *Thread4Label;
  TLabel *Thread3Label;
  TLabel *Label5;
  void __fastcall Thread1Compute(TObject *Sender);
  void __fastcall Thread1ProgressUpdate(TObject *Sender, TMtxProgressEvent Event);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall SingleRunButtonClick(TObject *Sender);
  void __fastcall FullRunButtonClick(TObject *Sender);
private:
  bool Working;
  DynamicArray<__int64> TimeStart;
  Math387::TDoubleArray TimedThread;
  TTestMethod FTestMethod;
  int cpuCores;
  void __fastcall SetTestMethod(TTestMethod Value);
public:
  DynamicArray<Math387::T2DDoubleArray> Timings;
  DynamicArray<TMtxProgressDialog*> Threads;
  int ak, ac;
  int CacheIndex1, CacheIndex2;
  DynamicArray<sVector> av, bv, cv, dv;
  int VectorLen;
  int Stage;
  __property TTestMethod TestMethod = { read = FTestMethod, write = SetTestMethod };
  __fastcall TSuperConductiveForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TSuperConductiveForm *SuperConductiveForm;
//---------------------------------------------------------------------------
#endif
