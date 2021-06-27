//---------------------------------------------------------------------------

#ifndef Basic_QCH
#define Basic_QCH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.EditChar.hpp>
#include <StatSeries.hpp>
#include <Mtxexpr.hpp>
#include <MtxVecEdit.hpp>
//---------------------------------------------------------------------------
class TfrmBasicQC : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	TPanel *Panel2;
	TLabel *Label1;
	TEdit *Edit1;
	TButton *Button1;
	TButton *Button2;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall Edit1Change(TObject *Sender);
private:	// User declarations
public:		// User declarations
	TQCSeries* Series1;
	sMatrix Data;
	sVector DrawVec;
	TSample DeltaInt;
	TSample Confidence;
	__fastcall TfrmBasicQC(TComponent* Owner);
protected:
	virtual void __fastcall Recalculate();
	virtual void __fastcall BeforeRecalculate() = 0;
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBasicQC *frmBasicQC;
//---------------------------------------------------------------------------
#endif
