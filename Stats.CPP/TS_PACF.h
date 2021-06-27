//---------------------------------------------------------------------------

#ifndef TS_PACFH
#define TS_PACFH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Chart.h"
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.CandleCh.hpp>
#include <VCLTee.StatChar.hpp>
#include <Mtxexpr.hpp>
#include <Statistics.hpp>
#include <MtxVecTee.hpp>
#include <MtxVecEdit.hpp>
//---------------------------------------------------------------------------
class TfrmTSPACF : public TfrmBasicChart
{
__published:	// IDE-managed Components
	TButton *Button2;
	TEdit *EditLags;
	TLabel *Label1;
	TRadioGroup *RadioGroupPT;
	TUpDown *UpDown1;
	TLineSeries *Series1;
	void __fastcall RadioGroupPTClick(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Chart1BeforeDrawSeries(TObject *Sender);
	void __fastcall EditLagsChange(TObject *Sender);
	void __fastcall Chart1AfterDraw(TObject *Sender);
private:	// User declarations
	sVector Data;
	sVector vACF, vPACF;

	int Lags;
	void __fastcall ToVolumeSeries();
	void __fastcall ToLineSeries();
	void __fastcall ToPointSeries();
	void __fastcall ToHistogramSeries();
public:		// User declarations
	__fastcall TfrmTSPACF(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmTSPACF *frmTSPACF;
//---------------------------------------------------------------------------
#endif
