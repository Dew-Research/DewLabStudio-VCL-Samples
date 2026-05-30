//---------------------------------------------------------------------------
#ifndef DewProbCalcH
#define DewProbCalcH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <ActnList.hpp>
#include <ToolWin.hpp>
#include <ActnMan.hpp>
#include <ActnCtrls.hpp>
#include <XPStyleActnCtrls.hpp>
#include <StdActns.hpp>
#include <ActnColorMaps.hpp>
#include <System.Actions.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <Vcl.XPMan.hpp>

#include "ProbEditor.h"
#include "DewProbWrapper.h"
#include <Math387.hpp>
//---------------------------------------------------------------------------
class TfrmProbCalc : public TForm
{
__published:	// IDE-managed Components
  TFrameDist *FrameDist1;
  TPageControl *PageControl1;
  TTabSheet *TabSheetResults;
  TTabSheet *TabSheetChart;
  TMemo *MemoResults;
  TChart *Chart1;
  TLineSeries *Series1;
  TPanel *Panel2;
  TPanel *Panel3;
  TCheckBox *CheckBox3;
  TCheckBox *CheckBox4;
  TActionManager *ActionManager1;
  TAction *aICDF;
  TAction *aCalc;
  TAction *aClearAll;
  TActionToolBar *ActionToolBar1;
  TActionToolBar *ActionToolBar2;
  TAction *aPDF;
  TAction *aCDF;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall aAdditionalInfoExecute(TObject *Sender);
  void __fastcall Chart1AfterDraw(TObject *Sender);
  void __fastcall FrameDist1RadioGroupOutClick(TObject *Sender);
  void __fastcall aCalcExecute(TObject *Sender);
  void __fastcall aICDFExecute(TObject *Sender);
  void __fastcall aClearAllExecute(TObject *Sender);
  void __fastcall aClearAllUpdate(TObject *Sender);
  void __fastcall aPDFExecute(TObject *Sender);
  void __fastcall aCDFExecute(TObject *Sender);
  void __fastcall CheckBox4Click(TObject *Sender);
private:
  TProbDistribution *Dist;
public:
  __fastcall TfrmProbCalc(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmProbCalc *frmProbCalc;
//---------------------------------------------------------------------------
#endif
