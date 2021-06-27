//---------------------------------------------------------------------------

#ifndef Interp1H
#define Interp1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic1.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>

#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>

#include <Polynoms.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TInterpolating1 : public TBasicForm1
{                                                                 
__published:	// IDE-managed Components
  TLabel *Label1;
  TComboBox *ComboBox1;
  TLabel *Label2;
  TLabel *Label3;
  TTrackBar *TrackBar1;
  TStaticText *StaticText2;
  TLabel *Label4;
  TTrackBar *TrackBar2;
  TStaticText *StaticText3;
  TButton *Button1;
  TLabel *Label5;
  TFastLineSeries *Series2;
  TPointSeries *Series1;
  void __fastcall ComboBox1Change(TObject *Sender);
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall TrackBar2Change(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
  TInterpolationType intMethod;
  int NumPoints, Factor;
public:		// User declarations
  __fastcall TInterpolating1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TInterpolating1 *Interpolating1;
//---------------------------------------------------------------------------
#endif
