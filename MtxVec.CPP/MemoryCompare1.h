//---------------------------------------------------------------------------

#ifndef MemoryCompare1H
#define MemoryCompare1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>

#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TMemComp1 : public TBasicForm2                               
{
__published:	// IDE-managed Components
  TTrackBar *TrackBar1;
  TLabel *Label1;
  TMemo *Memo2;
  TLabel *Label2;
  TBitBtn *Button3;
  TChart *Chart1;
  TBarSeries *Series1;
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
  int Len;
  void __fastcall DoWithCreate(AnsiString ALabel);
  void __fastcall DoWithCreateIt(AnsiString ALabel, int Index, TColor AColor);
public:		// User declarations
  __fastcall TMemComp1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMemComp1 *MemComp1;
//---------------------------------------------------------------------------
#endif
