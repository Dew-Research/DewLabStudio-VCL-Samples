//---------------------------------------------------------------------------

#ifndef NLin_TestsH
#define NLin_TestsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <StatTools.hpp>
#include <Math387.hpp>
#include <MtxVecTee.hpp>
//---------------------------------------------------------------------------
class TfrmNonLinTest : public TfrmBasic
{
__published:	// IDE-managed Components
	TPanel *Panel2;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label5;
	TSpeedButton *SpeedButton1;
	TLabel *Label6;
	TLabel *Label4;
	TComboBox *ComboBox1;
	TEdit *Edit1;
	TUpDown *UpDown1;
	TComboBox *ComboBox2;
	TEdit *Edit3;
	TCheckBox *CheckBox1;
	TEdit *Edit4;
	TEdit *Edit2;
	TPanel *Panel3;
	TMemo *Memo2;
	TChart *Chart1;
	TPointSeries *Series1;
	TLineSeries *Series2;
	void __fastcall FormShow(TObject *Sender);
	void __fastcall ComboBox1Change(TObject *Sender);
	void __fastcall ComboBox2Change(TObject *Sender);
	void __fastcall SpeedButton1Click(TObject *Sender);
	void __fastcall Edit3Change(TObject *Sender);
	void __fastcall Edit1Change(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall CheckBox1Click(TObject *Sender);
	void __fastcall Edit4Change(TObject *Sender);
	void __fastcall Edit2Change(TObject *Sender);
private:	// User declarations
	TMtxNonLinReg *MtxNonLinReg;
	void __fastcall FillData(int Index);
	void __fastcall ResetEstimates(int Index);
	void __fastcall DisplayInfo(int Index);
	void __fastcall WriteToLog(DWord Elapsed);

public:		// User declarations
	__fastcall TfrmNonLinTest(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmNonLinTest *frmNonLinTest;
//---------------------------------------------------------------------------
#endif
