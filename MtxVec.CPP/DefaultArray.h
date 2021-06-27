//---------------------------------------------------------------------------

#ifndef DefaultArrayH
#define DefaultArrayH
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
class TDefArray : public TBasicForm2
{
__published:	// IDE-managed Components
  TBitBtn *Button1;
  TLabel *Label1;
  TLabel *Label2;
  TTrackBar *TrackBar1;
  TRadioGroup *RadioGroup1;
  TChart *Chart1;
  TLineSeries *Series1;
  TLineSeries *Series2;
  TLineSeries *Series3;
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
        void __fastcall RadioGroup1Click(TObject *Sender);
private:	// User declarations
   int Len;
   sVector TestVec;
   sMatrix TestMtx;
   void __fastcall CumulativeSum(sVector& A);
   void __fastcall CumulativeSumFast(sVector& A);
   void __fastcall CumulativeSum(sMatrix& A);
   void __fastcall CumulativeSumFast(sMatrix& A);
   void __fastcall CumulativeSumFast1(sMatrix& A);
public:		// User declarations
  __fastcall TDefArray(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDefArray *DefArray;
//---------------------------------------------------------------------------
#endif
