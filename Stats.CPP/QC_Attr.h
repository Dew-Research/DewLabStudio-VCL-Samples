//---------------------------------------------------------------------------

#ifndef QC_AttrH
#define QC_AttrH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_QC.h"
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <StatControlCharts.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecEdit.hpp>
#include <MtxVecTee.hpp>
#include "Basic_Form.h"
//---------------------------------------------------------------------------
class TfrmQCAttr : public TfrmBasicQC
{
__published:	// IDE-managed Components
	TRadioGroup *RadioGroup1;
	TLabel *Label3;
	TEdit *Edit2;
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Edit2Change(TObject *Sender);
	void __fastcall RadioGroup1Click(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
private:	// User declarations
	sVector DataVec;
	int SampleSize;
public:		// User declarations
	__fastcall TfrmQCAttr(TComponent* Owner);
protected:
	virtual void __fastcall BeforeRecalculate();
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmQCAttr *frmQCAttr;
//---------------------------------------------------------------------------
#endif
