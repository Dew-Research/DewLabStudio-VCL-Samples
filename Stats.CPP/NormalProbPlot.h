//---------------------------------------------------------------------------

#ifndef NormalProbPlotH
#define NormalProbPlotH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.EditChar.hpp>
#include <Mtxexpr.hpp>
#include <StatSeries.hpp>
#include <MtxVecTee.hpp>
#include <StatProbPlots.hpp>

//---------------------------------------------------------------------------
class TfrmNormalProb : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	TPanel *Panel2;
	TButton *Button1;
	TButton *Button2;
	TButtonPen *ButtonPen1;
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
	sVector Data,X,Y;
	sVector StdErrs;
	sVector ub,lb;

	TSample MinX,MaxX, MinY, MaxY;
	TStatProbSeries *ProbSeries;
	TLineSeries *ubSeries;
	TLineSeries *lbSeries;
	void __fastcall Recalc();
public:		// User declarations
	__fastcall TfrmNormalProb(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmNormalProb *frmNormalProb;
//---------------------------------------------------------------------------
#endif
