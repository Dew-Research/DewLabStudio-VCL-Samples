//---------------------------------------------------------------------------

#ifndef NIST_IntroductionH
#define NIST_IntroductionH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TfrmNISTIntro : public TForm
{
__published:	// IDE-managed Components
	TMemo *Memo1;
private:	// User declarations
public:		// User declarations
	__fastcall TfrmNISTIntro(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmNISTIntro *frmNISTIntro;
//---------------------------------------------------------------------------
#endif
