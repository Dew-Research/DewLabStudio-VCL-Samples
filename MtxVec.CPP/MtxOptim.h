//---------------------------------------------------------------------------

#ifndef MtxOptimH
#define MtxOptimH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "MtxBaseComp.hpp"
#include "MtxVecTools.hpp"
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TfrmMtxOptim : public TBasicForm2
{
__published:	// IDE-managed Components
    TMtxOptimization *MtxOptimization1;
    TCheckBox *CheckBox1;                                       
    TMemo *Memo2;
    TCheckBox *CheckBox2;
    TRadioGroup *RadioGroup1;
    TLabel *Label1;
    TTrackBar *TrackBar1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TTrackBar *TrackBar2;
    TLabel *Label12;
    TLabel *Label13;
    TTrackBar *TrackBar6;
    TLabel *Label10;
    TLabel *Label11;
    TTrackBar *TrackBar5;
    TLabel *Label5;
    TTrackBar *TrackBar3;
    TLabel *Label7;
    TLabel *Label6;
    TLabel *Label9;
    TTrackBar *TrackBar4;
    TLabel *Label8;
    TBitBtn *Button1;
    TBitBtn *Button2;
    TTrackBar *TrackBar7;
    TLabel *Label14;
    TLabel *Label15;
  void __fastcall CheckBox1Click(TObject *Sender);
  void __fastcall CheckBox2Click(TObject *Sender);
  void __fastcall RadioGroup1Click(TObject *Sender);
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall TrackBar2Change(TObject *Sender);
  void __fastcall TrackBar6Change(TObject *Sender);
  void __fastcall TrackBar5Change(TObject *Sender);
  void __fastcall TrackBar3Change(TObject *Sender);
  void __fastcall TrackBar4Change(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall TrackBar7Change(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TfrmMtxOptim(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMtxOptim *frmMtxOptim;
//---------------------------------------------------------------------------
#endif
