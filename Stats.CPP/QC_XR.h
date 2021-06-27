//---------------------------------------------------------------------------

#ifndef QC_XRH
#define QC_XRH
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
#include "Basic_Form.h"
//---------------------------------------------------------------------------
class TfrmQCXR : public TfrmBasicQC
{
__published:	// IDE-managed Components
	TRadioGroup *RadioGroup1;
	void __fastcall RadioGroup1Click(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TfrmQCXR(TComponent* Owner);
protected:
	virtual void __fastcall BeforeRecalculate();
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmQCXR *frmQCXR;
//---------------------------------------------------------------------------
#endif
