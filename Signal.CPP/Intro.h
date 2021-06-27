//---------------------------------------------------------------------------

#ifndef IntroH
#define IntroH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TIntroduction : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TRichEdit *RichEdit1;
private:	// User declarations
public:		// User declarations
	__fastcall TIntroduction(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TIntroduction *Introduction;
//---------------------------------------------------------------------------
#endif
