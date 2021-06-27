//---------------------------------------------------------------------------

#ifndef QC_ParetoH
#define QC_ParetoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Chart.h"
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecEdit.hpp>
#include <MtxVecTee.hpp>
#include <Statistics.hpp>
//---------------------------------------------------------------------------
class TfrmParetoChart : public TfrmBasicChart
{
__published:	// IDE-managed Components
	TButton *Button2;
	TRadioGroup *RadioGroup1;
	TBarSeries *Series1;
	TLineSeries *Series2;
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall RadioGroup1Click(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall Series2GetMarkText(TChartSeries *Sender, int ValueIndex,
          UnicodeString &MarkText);
private:	// User declarations
	sVector Data;
	TSample Factor;
	void __fastcall Recalc();
public:		// User declarations
	__fastcall TfrmParetoChart(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmParetoChart *frmParetoChart;
//---------------------------------------------------------------------------
#endif
