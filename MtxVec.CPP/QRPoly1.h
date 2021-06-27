//---------------------------------------------------------------------------

#ifndef QRPoly1H
#define QRPoly1H
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
#include <MtxExpr.hpp>
#include <VclTee.TeeGDIPlus.hpp>
//---------------------------------------------------------------------------
class TLQRPoly : public TBasicForm1
{
__published:	// IDE-managed Components
  TTrackBar *TrackBar1;                                          
  TLabel *Label1;
  TLabel *Label2;
  TPointSeries *Series1;
  TLineSeries *Series2;
  TButton *Button1;
  TTrackBar *TrackBar2;
  TLabel *Label3;
  TLabel *Label4;
  TLabel *Label5;
  TLabel *Label6;
  TButton *Button2;
  TButton *Button3;
  TLineSeries *Series3;
  TLineSeries *Series4;
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall TrackBar2Change(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall CheckDownSampleClick(TObject *Sender);
  void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
  int PolyOrder, DegF;
  int Factor;

  sVector Coeff, Delta;
  sVector X, Y, intX, intY;
  sMatrix R;
  
  double L2R;
public:		// User declarations
  __fastcall TLQRPoly(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TLQRPoly *LQRPoly;
//---------------------------------------------------------------------------
#endif
