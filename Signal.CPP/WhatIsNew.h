//---------------------------------------------------------------------------

#ifndef WhatIsNewH
#define WhatIsNewH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic3.h"
#include <ComCtrls.hpp>
#include "CoreAudioSignal.hpp"
#include "MtxBaseComp.hpp"
#include "SignalTools.hpp"
//---------------------------------------------------------------------------
class TWhatIsNewForm : public TBasicForm3
{
__published:	// IDE-managed Components
private:	// User declarations
public:		// User declarations
	__fastcall TWhatIsNewForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TWhatIsNewForm *WhatIsNewForm;
//---------------------------------------------------------------------------
#endif
