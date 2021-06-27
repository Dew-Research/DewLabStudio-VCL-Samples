//---------------------------------------------------------------------------

#ifndef MLRegWizardH
#define MLRegWizardH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Wizard.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <VCLTee.TeeComma.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.StatChar.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecTee.hpp>
#include <StatTools.hpp>
#include <StatSeries.hpp>
#include <StatProbPlots.hpp>
//---------------------------------------------------------------------------
class TfrmMulLinRegWiz : public TfrmBasicWizard
{
__published:	// IDE-managed Components
	TTabSheet *tsInputData;
	TGroupBox *GroupBox1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label4;
	TLabel *Label5;
	TBitBtn *BitBtnA;
	TBitBtn *BitBtnY;
	TBitBtn *BitBtnW;
	TEdit *Edit1;
	TEdit *Edit2;
	TGroupBox *GroupBox2;
	TLabel *Label6;
	TLabel *Label7;
	TCheckBox *ChkBoxUseWeights;
	TCheckBox *ChkBoxRemoveInt;
	TEdit *Edit4;
	TEdit *Edit3;
	TTabSheet *tsReportConfig;
	TGroupBox *GroupBox3;
	TCheckBox *ChkBoxCorr;
	TCheckBox *ChkBoxDescStat;
	TCheckBox *ChkBoxRegCoeff;
	TCheckBox *ChkBoxRes;
	TCheckBox *ChkBoxRegStats;
	TCheckBox *ChkBoxSerCorr;
	TCheckBox *ChkBoxNormality;
	TTabSheet *tsTextReport;
	TRichEdit *RichEdit;
	TTabSheet *tsChart;
	TTeeCommander *TeeCommander1;
	TChart *Chart1;
	void __fastcall BitBtnAClick(TObject *Sender);
	void __fastcall ChkBoxUseWeightsClick(TObject *Sender);
	void __fastcall ChkBoxRemoveIntClick(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall Edit4Change(TObject *Sender);
	void __fastcall Edit1Change(TObject *Sender);
	void __fastcall Edit3Change(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);


private:	// User declarations
		TMtxAnova *MtxAnova;
		sMatrix tmpMtx;
		sVector tmpVec;
		void __fastcall TextReport();
		void __fastcall ChartReport(int AIndex);
		void __fastcall CorrMtxReport();
		void __fastcall DescStatReport();
		void __fastcall RegCoeffReport();
		void __fastcall ResidualReport();
		void __fastcall BasicRegStatReport();
		void __fastcall SerCorrReport();
		void __fastcall NormalityReport();

public:		// User declarations
		TMtxMulLinReg *MtxMulLinReg;
	__fastcall TfrmMulLinRegWiz(TComponent* Owner);
protected:
	virtual void __fastcall RefreshWizardControls();
	virtual void __fastcall DoMoveBackward();
	virtual void __fastcall DoMoveForward();
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMulLinRegWiz *frmMulLinRegWiz;
//---------------------------------------------------------------------------
#endif
