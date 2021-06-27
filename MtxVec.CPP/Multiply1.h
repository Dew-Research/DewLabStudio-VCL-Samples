//---------------------------------------------------------------------------

#ifndef Multiply1H
#define Multiply1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>

#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TMult1 : public TBasicForm2
{
__published:	// IDE-managed Components
  TTrackBar *TrackBar1;
  TLabel *Label1;                                       
  TStaticText *StaticText1;
  TButton *Button4;
  TRadioGroup *RadioGroup1;
  TChart *Chart1;
  TLineSeries *Series1;
  TLineSeries *Series2;
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall Button4Click(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
private:	// User declarations
		sMatrix A,B,C;       // MtxVec arrays
		int MtxDim;
		void __fastcall MulBCB(const int ADim);
		void __fastcall GenerateData(const int ADim);
public:		// User declarations
  __fastcall TMult1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMult1 *Mult1;
//---------------------------------------------------------------------------
#endif
