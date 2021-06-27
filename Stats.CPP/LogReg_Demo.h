//---------------------------------------------------------------------------

#ifndef LogReg_DemoH
#define LogReg_DemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include <ExtCtrls.hpp>
#include "MtxBaseComp.hpp"
#include "MtxVecEdit.hpp"
#include "StatTools.hpp"
//---------------------------------------------------------------------------
class TfrmLogReg : public TfrmBasic
{
__published:	// IDE-managed Components
	TMtxLogistReg *MtxLogReg;
	TMemo *Memo2;
	TPanel *Panel2;
	TButton *Button1;
	TButton *Button2;
	TButton *Button3;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
	void __fastcall Report();
public:		// User declarations
	__fastcall TfrmLogReg(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmLogReg *frmLogReg;
//---------------------------------------------------------------------------
#endif
