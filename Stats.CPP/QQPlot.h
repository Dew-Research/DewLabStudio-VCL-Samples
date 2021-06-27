//---------------------------------------------------------------------------

#ifndef QQPlotH
#define QQPlotH
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
#include <VclTee.TeeGDIPlus.hpp>
#include <Mtxexpr.hpp>
#include <StatSeries.hpp>
#include <MtxVecTee.hpp>
#include <StatProbPlots.hpp>
//---------------------------------------------------------------------------
class TfrmQQPlot : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	TPanel *Panel2;
	TButton *Button1;
	TButtonPen *ButtonPen1;
	TButton *Button2;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
private:	// User declarations
	sVector XData,YData;
	sVector X,Y;
	TSample MinX,MaxX,MinY,MaxY;
	TStatProbSeries *ProbSeries;
	void __fastcall Recalc();
public:		// User declarations
	__fastcall TfrmQQPlot(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmQQPlot *frmQQPlot;
//---------------------------------------------------------------------------
#endif
