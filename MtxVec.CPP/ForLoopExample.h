//---------------------------------------------------------------------------
#ifndef ForLoopExampleH
#define ForLoopExampleH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>

#include <MtxForLoop.hpp>
#include <MtxVec.hpp>
#include <MtxExpr.hpp>
#include <Math387.hpp>
//---------------------------------------------------------------------------
class TForLoopExampleForm : public TForm
{
__published:	// IDE-managed Components
  TTimer *Timer1;
  TPanel *Panel1;
  TLabel *Label1;
  TCheckBox *MultiThreadedBox;
  TButton *Button2;
  TChart *Chart;
  TFastLineSeries *Series1;
  TFastLineSeries *Series2;
  TChart *Chart1;
  TFastLineSeries *FastLineSeries1;
  TSplitter *Splitter1;
  TLabel *Label5;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall Timer1Timer(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall FormResize(TObject *Sender);
private:
  void __fastcall OnComputationEnded2(TObject *Sender);
public:
  void __fastcall MyLoop3(int LoopIndex, const TObjectArray Context, int ThreadIndex);
  Math387::T2DDoubleArray TimingResults;
  __fastcall TForLoopExampleForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
class TForLoopExampleThread : public TThread
{
protected:
  virtual void __fastcall Execute();
public:
  __fastcall TForLoopExampleThread(bool CreateSuspended) : TThread(CreateSuspended) {}
};
//---------------------------------------------------------------------------
extern PACKAGE TForLoopExampleForm *ForLoopExampleForm;
//---------------------------------------------------------------------------
#endif
