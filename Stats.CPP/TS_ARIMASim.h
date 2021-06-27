//---------------------------------------------------------------------------

#ifndef TS_ARIMASimH
#define TS_ARIMASimH
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
#include <Mtxexpr.hpp>
#include <MtxVecEdit.hpp>
#include <MtxVecTee.hpp>
#include <StatTimeSerAnalysis.hpp>
//---------------------------------------------------------------------------
class TfrmARIMASim : public TfrmBasicChart
{
__published:	// IDE-managed Components
	TButton *Button2;
	TButton *Button3;
	TButton *Button4;
	TButton *Button5;
	TEdit *EditAR;
	TEdit *EditD;
	TEdit *EditMA;
	TEdit *EditN;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TMemo *MemoLog;
	TRadioGroup *RadioGroupCT;
	TUpDown *UpDownAR;
	TUpDown *UpDownD;
	TUpDown *UpDownMA;
	TUpDown *UpDownN;
	TLineSeries *Series1;
	TLineSeries *Series2;
	void __fastcall EditARChange(TObject *Sender);
	void __fastcall EditMAChange(TObject *Sender);
	void __fastcall EditDChange(TObject *Sender);
	void __fastcall EditNChange(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall Button4Click(TObject *Sender);
	void __fastcall Button5Click(TObject *Sender);
	void __fastcall RadioGroupCTClick(TObject *Sender);
private:	// User declarations
	int d,n;
	sVector Phi,Theta,zinit,timeSer;
	void __fastcall Simulate();
	void __fastcall PlotSeries(int stype);
public:		// User declarations
	__fastcall TfrmARIMASim(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmARIMASim *frmARIMASim;
//---------------------------------------------------------------------------
#endif
