//---------------------------------------------------------------------------

#ifndef Random_GeneratorH
#define Random_GeneratorH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.StatChar.hpp>
#include <MtxVecTee.hpp>
#include <MtxExprInt.hpp>
#include <Statistics.hpp>
#include <StatRandom.hpp>
#include <RndImport.hpp>
//---------------------------------------------------------------------------
class TfrmRandomGen : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	THistogramSeries *Series1;
	TLineSeries *Series2;
	TPanel *Panel2;
	TLabel *Label1;
	TLabel *Label2;
	TSpeedButton *SpeedButton1;
	TLabel *Label3;
	TComboBox *CBRandomG;
	TEdit *EditNumber;
	TUpDown *UpDown1;
	TGroupBox *GroupBox1;
	TLabel *lblPar1;
	TLabel *lblPar2;
	TLabel *lblPar3;
	TEdit *Edit1;
	TEdit *Edit2;
	TEdit *Edit3;
	TEdit *Edit4;
	TUpDown *UpDown2;
	TCheckBox *CheckBox1;
	void __fastcall FormShow(TObject *Sender);
	void __fastcall SpeedButton1Click(TObject *Sender);
	void __fastcall CBRandomGChange(TObject *Sender);
	void __fastcall Chart1UndoZoom(TObject *Sender);
	void __fastcall CheckBox1Click(TObject *Sender);
private:	// User declarations
	VectorInt xInt;
	sVector v1,v2;
	sVector VecCount, VecBins;
	AnsiString MsgText;
	bool __fastcall Estimate(TVec* X);
public:		// User declarations
	__fastcall TfrmRandomGen(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmRandomGen *frmRandomGen;
//---------------------------------------------------------------------------
#endif
