//---------------------------------------------------------------------------

#ifndef QuickSH
#define QuickSH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VclTee.TeeGDIPlus.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TQStart : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations               
public:		// User declarations
  __fastcall TQStart(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TQStart *QStart;
//---------------------------------------------------------------------------
#endif
