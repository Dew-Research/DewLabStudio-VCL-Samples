//---------------------------------------------------------------------------

#ifndef CopyCompareH
#define CopyCompareH
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
#include <MtxExpr.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TCopyComp : public TBasicForm2
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TTrackBar *TrackBar1;
  TLabel *Label2;
  TBitBtn *Button1;
  TChart *Chart1;
  TBarSeries *Series1;
  TBarSeries *Series2;
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
  int Dim;
  sMatrix A;
  sMatrix B;
  void __fastcall CopyMtxVec(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B);
  void __fastcall CopyBCB(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B);
  void __fastcall TranspMtxVec(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B);
  void __fastcall TranspBCB(Mtxvec::TMatrix *A, Mtxvec::TMatrix *B);
public:		// User declarations
  __fastcall TCopyComp(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TCopyComp *CopyComp;
//---------------------------------------------------------------------------
#endif
