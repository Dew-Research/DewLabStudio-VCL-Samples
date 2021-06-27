//---------------------------------------------------------------------------

#ifndef Unit22H
#define Unit22H
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include "MtxBaseComp.hpp"
#include "MtxParseExpr.hpp"
#include "MtxVecTools.hpp"
#include "SignalAnalysis.hpp"
#include "SignalProcessing.hpp"
#include "SignalTools.hpp"
#include "SignalToolsTee.hpp"
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VclTee.TeeGDIPlus.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TForm22 : public TForm
{
__published:	// IDE-managed Components
	TMtxOptimization *MtxOptimization1;
	TSignalInterpolator *SignalInterpolator1;
	TCrossSpectrumAnalyzer *CrossSpectrumAnalyzer1;
	TSignalChart *SignalChart1;
	TMtxFunctionEvaluator *MtxFunctionEvaluator1;
private:	// User declarations
public:		// User declarations
	__fastcall TForm22(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm22 *Form22;
//---------------------------------------------------------------------------
#endif
