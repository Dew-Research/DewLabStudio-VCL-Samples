//---------------------------------------------------------------------------

#ifndef Basic1H
#define Basic1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <MtxVec.hpp>
#include <Math387.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//#include "MtxBaseComp.hpp"
//#include "MtxParseExpr.hpp"
//#include "MtxVecEdit.hpp"
//#include "MtxVecDBTools.hpp"
//---------------------------------------------------------------------------
class TBasicForm1 : public TForm
{
__published:	// IDE-managed Components
  TPanel *Panel1;
  TPanel *Panel2;
  TCheckBox *CheckDownSample;
  TRichEdit *RichEdit1;
  TChart *Chart1;
  void __fastcall CheckDownSampleClick(TObject *Sender);
private:	// User declarations
  bool FDownSize;
  void __fastcall SetDownSize(bool Value);
public:		// User declarations
  DWORD TimeCheck, TimeElapsed;
  __property bool DownSize = {read = FDownSize, write = SetDownSize};
  __fastcall TBasicForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TBasicForm1 *BasicForm1;
//---------------------------------------------------------------------------
#endif
