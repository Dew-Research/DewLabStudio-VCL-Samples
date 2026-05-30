//---------------------------------------------------------------------------
#ifndef MtxFastLineDemoH
#define MtxFastLineDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic1.h"
#include <ComCtrls.hpp>

#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <VclTee.TeeGDIPlus.hpp>

#include <MtxComCtrls.hpp>
#include <MtxExpr.hpp>
//---------------------------------------------------------------------------
class TMtxFastLineForm : public TBasicForm1
{
__published:	// IDE-managed Components
  TTimer *Timer1;
  TMtxFloatEdit *MtxFloatEdit;
  TLabel *Label1;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall MtxFloatEditChange(TObject *Sender);
private:	// User declarations
  TChartSeries *normalFast;
  TChartSeries *mtxFast;
  sVector Data;
public:		// User declarations
  __fastcall TMtxFastLineForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMtxFastLineForm *MtxFastLineForm;
//---------------------------------------------------------------------------
#endif
