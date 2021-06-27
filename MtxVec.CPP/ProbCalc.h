//---------------------------------------------------------------------------

#ifndef ProbCalcH
#define ProbCalcH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <MtxVecInt.hpp>

#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TProb1 : public TBasicForm2
{
__published:	// IDE-managed Components
  TChart *Chart1;
  TBitBtn *Button1;
  TBitBtn* Button2;
  TLineSeries *Series1;
  TPanel *Panel4;
  TRadioGroup* RadioGroup1;
  TLabel *Label1;
  TLabel *Label5;
  TEdit *Edit1;
  TEdit *Edit5;
  TEdit *Edit2;
  TEdit *Edit6;
  TLabel *Label6;
  TLabel *Label2;
  TLabel *Label3;
  TCheckBox *CheckBox1;
  TEdit *Edit3;
  TLabel *Label4;
  TEdit *Edit4;
  TLabel *Label7;
  TTrackBar *TrackBar1;
  TLabel *Label8;
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall Edit1Enter(TObject *Sender);
  void __fastcall Edit6Enter(TObject *Sender);
private:	// User declarations
  int Decimals;
  Mtxvec::TVector *XVec, *YVec;
  Mtxvecint::TVecInt *XVecInt;
public:		// User declarations
  __fastcall TProb1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TProb1 *Prob1;
//---------------------------------------------------------------------------
#endif
