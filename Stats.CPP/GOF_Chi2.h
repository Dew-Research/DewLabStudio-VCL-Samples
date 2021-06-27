//---------------------------------------------------------------------------

#ifndef GOF_Chi2H
#define GOF_Chi2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Chart.h"
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.StatChar.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecTee.hpp>
#include <StatRandom.hpp>
#include <Statistics.hpp>
#include <MtxBaseComp.hpp>
#include <StatTools.hpp>
#include <StatSeries.hpp>
//---------------------------------------------------------------------------
class TfrmGOFChi2 : public TfrmBasicChart
{
__published:	// IDE-managed Components
	TMemo *Memo2;
	TGroupBox *GroupBox1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label4;
	TComboBox *ComboBox1;
	TEdit *Edit1;
	TUpDown *UpDown1;
	TButton *Button3;
	TEdit *Edit2;
	TGroupBox *GroupBox2;
	TLabel *Label3;
	TLabel *lblDistName;
	TLabel *lblPar1;
	TLabel *lblPar2;
	TButton *Button2;
	TComboBox *ComboBox2;
	TEdit *EditPar1;
	TEdit *EditPar2;
	THistogramSeries *Series1;
	TLineSeries *Series2;
	void __fastcall ComboBox1Change(TObject *Sender);
	void __fastcall Edit1Change(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall ComboBox2Change(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall Edit2Change(TObject *Sender);
private:	// User declarations
	int numBins;
	sVector DataVec;
	AnsiString DistName;
	TSample Alpha;
	void __fastcall DrawDataHistogram();
	void __fastcall DoChi2Test();
public:		// User declarations
	__fastcall TfrmGOFChi2(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmGOFChi2 *frmGOFChi2;
//---------------------------------------------------------------------------
#endif
