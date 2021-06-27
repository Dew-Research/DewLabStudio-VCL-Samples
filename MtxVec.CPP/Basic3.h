//---------------------------------------------------------------------------

#ifndef Basic3H
#define Basic3H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include "MtxBaseComp.hpp"
#include "MtxVecTools.hpp"
#include "MtxComCtrls.hpp"
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include "MtxVecTee.hpp"
#include <VclTee.TeeGDIPlus.hpp>
#include "MtxVecDBTools.hpp"
//---------------------------------------------------------------------------
class TBasicForm3 : public TForm
{
__published:	// IDE-managed Components
  TRichEdit *RichEdit1;
private:	// User declarations
public:		// User declarations
  __fastcall TBasicForm3(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBasicForm3 *BasicForm3;
//---------------------------------------------------------------------------
#endif
