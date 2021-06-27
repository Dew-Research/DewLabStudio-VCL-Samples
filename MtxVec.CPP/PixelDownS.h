//---------------------------------------------------------------------------

#ifndef PixelDownSH
#define PixelDownSH
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
class TDownS : public TBasicForm2
{
__published:	// IDE-managed Components                          
  TChart *Chart1;
  TChart *Chart2;
  TFastLineSeries *Series1;
  TFastLineSeries *Series2;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TTrackBar *TrackBar1;
  TLabel *Label5;
  TLabel *Label6;
  TBitBtn *Button1;
        TSpeedButton *SpeedButton1;
        TSpeedButton *SpeedButton2;
  void __fastcall FormResize(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall TrackBar1Change(TObject *Sender);
        void __fastcall SpeedButton1Click(TObject *Sender);
        void __fastcall SpeedButton2Click(TObject *Sender);
private:	// User declarations
  sVector TestVec, PY;
  int NumPoints;
  void __fastcall FillRandomPoints(void);
public:		// User declarations
  __fastcall TDownS(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDownS *DownS;
//---------------------------------------------------------------------------
#endif
