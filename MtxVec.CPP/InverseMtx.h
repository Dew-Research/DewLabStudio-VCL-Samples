//---------------------------------------------------------------------------

#ifndef InverseMtxH
#define InverseMtxH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TInvMtx : public TBasicForm2
{
__published:	// IDE-managed Components
  TTrackBar *TrackBar1;
  TLabel *Label1;
  TLabel *Label2;
  TStringGrid *StringGrid1;
  TBitBtn *Button1;
  TBitBtn *Button2;
  TButton *Button3;
  TLabel *Label3;
  TStringGrid *StringGrid2;
  TLabel *Label4;
  void __fastcall TrackBar1Change(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall Button3Click(TObject *Sender);
private: // User declarations
  int DimMtx;
  Mtxvec::TMatrix *A, *B, *C;
public:		// User declarations
  __fastcall TInvMtx(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TInvMtx *InvMtx;
//---------------------------------------------------------------------------
#endif
