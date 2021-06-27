//---------------------------------------------------------------------------

#ifndef Unit22H
#define Unit22H
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include "MtxBaseComp.hpp"
#include "StatTools.hpp"
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VclTee.TeeGDIPlus.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TForm22 : public TForm
{
__published:	// IDE-managed Components
	TMtxNonLinReg *MtxNonLinReg1;
	TChart *Chart1;
private:	// User declarations
public:		// User declarations
	__fastcall TForm22(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm22 *Form22;
//---------------------------------------------------------------------------
#endif
