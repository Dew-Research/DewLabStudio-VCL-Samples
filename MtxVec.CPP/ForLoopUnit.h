//---------------------------------------------------------------------------
#ifndef ForLoopUnitH
#define ForLoopUnitH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>

#include <MtxVec.hpp>
#include <MtxVecEdit.hpp>
//---------------------------------------------------------------------------
class TForLoopForm : public TBasicForm2
{
__published:	// IDE-managed Components
  TButton *Button1;
  TTimer *Timer;
  TLabel *Label1;
  TCheckBox *ThreadedBox;
  TLabel *Label5;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall TimerTimer(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
private:
  void __fastcall OnComputationEnded(TObject *Sender);
public:
  __fastcall TForLoopForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
class TForLoopUnitThread : public TThread
{
protected:
  virtual void __fastcall Execute();
public:
  __fastcall TForLoopUnitThread(bool CreateSuspended) : TThread(CreateSuspended) {}
};
//---------------------------------------------------------------------------
extern PACKAGE TForLoopForm *ForLoopForm;
//---------------------------------------------------------------------------
#endif
