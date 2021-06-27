//---------------------------------------------------------------------------

#ifndef Basic1H
#define Basic1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <VCLTee.Chart.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
//---------------------------------------------------------------------------
class TBasicForm1 : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TRichEdit *RichEdit1;
	TPanel *Panel2;
	TCheckBox *CheckDownSample;
	TChart *Chart1;
	void __fastcall CheckDownSampleClick(TObject *Sender);
private:	// User declarations
	bool FDownSize;
	void __fastcall SetDownSize(bool Value);
public:		// User declarations
	DWORD TimeCheck, TimeElapse;
	__fastcall TBasicForm1(TComponent* Owner);
	__property bool DownSize = {read = FDownSize, write = SetDownSize};
};
//---------------------------------------------------------------------------
extern PACKAGE TBasicForm1 *BasicForm1;
//---------------------------------------------------------------------------
#endif
