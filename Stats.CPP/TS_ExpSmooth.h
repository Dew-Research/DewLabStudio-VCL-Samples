//---------------------------------------------------------------------------

#ifndef TS_ExpSmoothH
#define TS_ExpSmoothH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Chart.h"
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecTee.hpp>
#include <StatTimeSerAnalysis.hpp>
//---------------------------------------------------------------------------
class TfrmExpSmooth : public TfrmBasicChart
{
__published:	// IDE-managed Components
	TButton *Button2;
	TButton *Button3;
	TEdit *Edit1;
	TGroupBox *GroupBox1;
	TLabel *Label2;
	TEdit *EditAlphaS;
	TGroupBox *GroupBox2;
	TLabel *Label3;
	TLabel *Label4;
	TEdit *EditAlphaD;
	TEdit *EditGammaD;
	TGroupBox *GroupBox3;
	TLabel *Label5;
	TLabel *Label6;
	TLabel *Label7;
	TLabel *Label8;
	TEdit *EditAlphaT;
	TEdit *EditBetaT;
	TEdit *EditGammaT;
	TEdit *EditPeriod;
	TLabel *Label1;
	TUpDown *UpDown1;
	TLineSeries *Series1;
	TLineSeries *Series2;
	TLineSeries *Series3;
	TLineSeries *Series4;
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall Chart1AfterDraw(TObject *Sender);
private:	// User declarations
	sVector Data,YHat;

	int T;
	AnsiString singletext, doubletext,tripletext;
	void __fastcall ResetForecast();
	void __fastcall Smooth();
	void __fastcall ResetChart();
public:		// User declarations
	__fastcall TfrmExpSmooth(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmExpSmooth *frmExpSmooth;
//---------------------------------------------------------------------------
#endif
