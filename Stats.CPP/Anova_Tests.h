//---------------------------------------------------------------------------

#ifndef Anova_TestsH
#define Anova_TestsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic_Form.h"
#include "MtxBaseComp.hpp"
#include "StatTools.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TfrmANOVATest : public TfrmBasic
{
__published:	// IDE-managed Components
	TPanel *Panel2;
	TLabel *Label1;
	TStringGrid *StringGrid1;
	TPanel *Panel3;
	TLabel *Label2;
	TSpeedButton *SpeedButton1;
	TComboBox *ComboBox1;
	TRichEdit *RichEdit1;
	TMtxAnova *MtxAnova;
	void __fastcall FormShow(TObject *Sender);
	void __fastcall SpeedButton1Click(TObject *Sender);
	void __fastcall ComboBox1Change(TObject *Sender);
private:	// User declarations
	void __fastcall FillData();
public:		// User declarations
	__fastcall TfrmANOVATest(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmANOVATest *frmANOVATest;
//---------------------------------------------------------------------------
#endif
