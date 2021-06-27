//---------------------------------------------------------------------------

#ifndef EWMA_DemoH
#define EWMA_DemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <Statistics.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecEdit.hpp>
#include <MtxVecTee.hpp>
#include <StatSeries.hpp>
#include <StatControlCharts.hpp>
//---------------------------------------------------------------------------
class TfrmEWMA : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	TPanel *Panel2;
	TLabel *Label1;
	TLabel *Label2;
	TRadioGroup *RadioGroup1;
	TButton *Button1;
	TEdit *Edit1;
	TEdit *Edit2;
	void __fastcall RadioGroup1Click(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall Edit1Change(TObject *Sender);
	void __fastcall Edit2Change(TObject *Sender);
	void __fastcall Chart1AfterDraw(TObject *Sender);
private:	// User declarations
	sMatrix Data;
	sVector vucl,vlcl, DrawVec;
	TSample ucl,lcl,cl, r, Confidence;
public:		// User declarations
	__fastcall TfrmEWMA(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmEWMA *frmEWMA;
//---------------------------------------------------------------------------
#endif
