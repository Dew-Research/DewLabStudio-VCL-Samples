//---------------------------------------------------------------------------
#ifndef MtxGridSeries_DemoH
#define MtxGridSeries_DemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include "MtxVecTee.hpp"
#include "Sparse.hpp"
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TfrmMtxGridSeries : public TBasicForm2
{
__published:	// IDE-managed Components
    TChart *Chart1;
    TPanel *Panel4;
    TCheckBox *CheckBox2;
    TTimer *Timer1;
    TRadioGroup *RadioGroup1;
    TCheckBox *CheckBox1;
    TLabel *Label1;
        TButton *Button1;
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall Timer1Timer(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
  void __fastcall CheckBox2Click(TObject *Sender);
  void __fastcall Chart1GetAxisLabel(TChartAxis *Sender, TChartSeries *Series, int ValueIndex, String &LabelText);
  void __fastcall Chart1MouseMove(TObject *Sender, TShiftState Shift,  int X, int Y);
        void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
	Mtxvec::TMatrix *A;
	Mtxvec::TVector *v1, *v2;
	TSparseMtx *SparseA;
	TMtxGridSeries *GridSeries;
public:		// User declarations
  __fastcall TfrmMtxGridSeries(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMtxGridSeries *frmMtxGridSeries;
//---------------------------------------------------------------------------
#endif
