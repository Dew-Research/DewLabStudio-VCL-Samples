//---------------------------------------------------------------------------

#ifndef ANOVA1_BoxH
#define ANOVA1_BoxH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeBoxPlot.hpp>
#include <VCLTee.EditChar.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecTee.hpp>
#include <MtxBaseComp.hpp>
#include <StatTools.hpp>
//---------------------------------------------------------------------------
class TfrmANOVA1Box : public TfrmBasic
{
__published:	// IDE-managed Components
	TMtxAnova *MtxAnova;
	TChart *Chart1;
	TPanel *Panel2;
	TLabel *Label1;
	TButton *Button1;
	TEdit *Edit1;
	TButton *Button2;
	TButton *Button3;
	TStringGrid *StringGrid1;
	void __fastcall Edit1Change(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TfrmANOVA1Box(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmANOVA1Box *frmANOVA1Box;
//---------------------------------------------------------------------------
#endif
