//---------------------------------------------------------------------------

#ifndef TS_ARARH
#define TS_ARARH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Dialogs.hpp>
#include "Basic_Chart.h"
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecTee.hpp>
#include <StatTimeSerAnalysis.hpp>
//---------------------------------------------------------------------------
class TfrmARAR : public TfrmBasicChart
{
__published:	// IDE-managed Components
	TOpenDialog *OpenDialog;
	TButton *btnLoad;
	TCheckBox *chkShorten;
	TEdit *Edit1;
	TLabel *Label1;
	TMemo *MemoLog;
	TUpDown *UpDown1;
	TLineSeries *Series1;
	TLineSeries *Series2;
	void __fastcall btnLoadClick(TObject *Sender);
	void __fastcall chkShortenClick(TObject *Sender);
	void __fastcall Edit1Change(TObject *Sender);
private:	// User declarations
	int tau,noForecasts;
	int l1,l2,l3;
	TSample Sigma2;
	sVector timeSer; // original time series
	sVector sTS,Forecasts,Filter,Phi; // transformed time series
	sVector stdErrs;
	void __fastcall TransformSeries();
	void __fastcall DoForecasts();
	void __fastcall UpdateChart();
public:		// User declarations
	__fastcall TfrmARAR(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmARAR *frmARAR;
//---------------------------------------------------------------------------
#endif
