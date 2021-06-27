//---------------------------------------------------------------------------

#ifndef Basic_WizardH
#define Basic_WizardH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmBasicWizard : public TForm
{
__published:	// IDE-managed Components
	TPageControl *PageControl;
	TPanel *Panel1;
	TButton *btnHelp;
	TButton *btnBack;
	TButton *btnNext;
	TButton *btnCancel;
	TPanel *Panel2;
	TLabel *lblHeader;
	void __fastcall btnCancelClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall btnNextClick(TObject *Sender);
	void __fastcall btnBackClick(TObject *Sender);
private:	// User declarations
	int DefTabWidth;
	AnsiString FFormatString;
	void __fastcall SetFormatString(AnsiString Value);
public:		// User declarations
	__fastcall TfrmBasicWizard(TComponent* Owner);
	__property AnsiString FormatString = {read=FFormatString, write=SetFormatString};
	void __fastcall SetupTabs(int NumTabs, TRichEdit *RichEdit);
protected:
	int chartindex;
  bool movebackward;
  bool moveforward;
  virtual void __fastcall RefreshWizardControls();
  virtual void __fastcall DoMoveForward();
  virtual void __fastcall DoMoveBackward();

};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBasicWizard *frmBasicWizard;
//---------------------------------------------------------------------------
#endif
