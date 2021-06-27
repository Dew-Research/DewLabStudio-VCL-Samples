//---------------------------------------------------------------------------

#ifndef Basic_ChartH
#define Basic_ChartH
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
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeEngine.hpp>
//---------------------------------------------------------------------------
class TfrmBasicChart : public TfrmBasic
{
__published:	// IDE-managed Components
	TChart *Chart1;
	TPanel *Panel2;
	TButton *Button1;
	void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TfrmBasicChart(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBasicChart *frmBasicChart;
//---------------------------------------------------------------------------
#endif
