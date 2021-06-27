//---------------------------------------------------------------------------

#ifndef YuleLevinsonH
#define YuleLevinsonH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>        
#include "Basic1.h"
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <MtxExpr.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TYuleLev : public TBasicForm1
{
__published:	// IDE-managed Components
  TFastLineSeries *Series1;
  TFastLineSeries *Series2;
  TPanel *Panel3;
  TRadioGroup *RadioGroup1;
  TTrackBar *TrackBar1;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TLabel *Label5;
  TLabel *Label6;
  TTrackBar *TrackBar2;
  TBitBtn *Button1;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall TrackBar2Change(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
private:	// User declarations
  sVector x, y, spec, corr;
  int CorrLen, ZeroPadding, LPCCoef;
public:		// User declarations
  __fastcall TYuleLev(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TYuleLev *YuleLev;
//---------------------------------------------------------------------------
#endif
 