//---------------------------------------------------------------------------

#ifndef GOF_KSH
#define GOF_KSH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include <VCLTee.StatChar.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <Mtxexpr.hpp>
#include <Statistics.hpp>
#include <MtxVecTee.hpp>
#include <StatRandom.hpp>
//---------------------------------------------------------------------------
class TfrmGOFKS : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	THistogramSeries *Series1;
	TLineSeries *Series2;
	TPanel *Panel2;
	TPanel *Panel3;
	TButton *Button1;
	TRadioGroup *RadioGroup1;
	TMemo *Memo2;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall RadioGroup1Click(TObject *Sender);
private:	// User declarations
	sVector Data;
	sVector X,ECDF,TCDF;
	TSample DStat;
	void __fastcall DoTest(TSample Alpha);
	void __fastcall Tests();
	void __fastcall RefreshChart();
public:		// User declarations
	__fastcall TfrmGOFKS(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmGOFKS *frmGOFKS;
//---------------------------------------------------------------------------
#endif
