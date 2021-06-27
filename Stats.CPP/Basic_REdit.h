//---------------------------------------------------------------------------

#ifndef Basic_REditH
#define Basic_REditH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmBaseRichEdit : public TForm
{
__published:	// IDE-managed Components
	TRichEdit *RichEdit1;
private:	// User declarations
	void __fastcall InitRichEditURLDetection(TRichEdit* re);
public:		// User declarations
	__fastcall TfrmBaseRichEdit(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBaseRichEdit *frmBaseRichEdit;
//---------------------------------------------------------------------------
#endif
