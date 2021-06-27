//---------------------------------------------------------------------------

#ifndef PCAWizardH
#define PCAWizardH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Wizard.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.TeeComma.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeBoxPlot.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecEdit.hpp>
#include <MtxVecTee.hpp>
#include "MtxBaseComp.hpp"
#include "StatTools.hpp"
//---------------------------------------------------------------------------
class TfrmPCAWiz : public TfrmBasicWizard
{
__published:	// IDE-managed Components
	TMtxPCA *MtxPCA;
	TTabSheet *tsInputData;
	TGroupBox *GroupBox2;
	TLabel *Label4;
	TEdit *EditFmtString;
	TGroupBox *GroupBox3;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *Label5;
	TEdit *EditCols;
	TEdit *EditRows;
	TButton *BtnEditData;
	TComboBox *CBoxPCAMode;
	TTabSheet *tsReportConfig;
	TGroupBox *GroupBox1;
	TCheckBox *ChkBoxDescStat;
	TCheckBox *ChkBoxCorrMtx;
	TCheckBox *ChkBoxEigValues;
	TCheckBox *ChkBoxPrinComp;
	TCheckBox *ChkBoxZScores;
	TCheckBox *ChkBoxBarlett;
	TTabSheet *tsTextReport;
	TRichEdit *RichEdit;
	TTabSheet *tsChart;
	TChart *Chart;
	TTeeCommander *TeeCommander1;
	void __fastcall BtnEditDataClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall EditColsChange(TObject *Sender);
	void __fastcall EditFmtStringChange(TObject *Sender);
	void __fastcall CBoxPCAModeChange(TObject *Sender);
private:	// User declarations
	sVector tmpVec;
	sMatrix tmpMtx;
	void __fastcall TextReport();
	void __fastcall DescStatReport();
	void __fastcall CorrMtxReport();
	void __fastcall EigValuesReport();
	void __fastcall PrinCompReport();
	void __fastcall ZScoresReport();
	void __fastcall BarlettReport();
	void __fastcall ChartReport(int AIndex);
public:		// User declarations
	__fastcall TfrmPCAWiz(TComponent* Owner);
protected:
	virtual void __fastcall RefreshWizardControls();
	virtual void __fastcall DoMoveBackward();
	virtual void __fastcall DoMoveForward();

};
//---------------------------------------------------------------------------
extern PACKAGE TfrmPCAWiz *frmPCAWiz;
//---------------------------------------------------------------------------
#endif
