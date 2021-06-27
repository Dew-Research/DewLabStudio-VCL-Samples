//---------------------------------------------------------------------------
#ifndef ProgDialogH
#define ProgDialogH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "MtxBaseComp.hpp"
#include "MtxComCtrls.hpp"
#include "MtxDialogs.hpp"
#include <MtxExpr.hpp>
//---------------------------------------------------------------------------
class TfrmProgDialog : public TBasicForm2
{
__published:	// IDE-managed Components
    TLabel *Label1;
    TLabel *ProgressLabel;
    TLabel *Label2;                                         
    TLabel *Label3;
    TRadioGroup *IteratorGroup;
    TRadioGroup *LoopTypeGroup;
    TCheckBox *ShowFormBox;
    TComboBox *ThreadBox;
    TButton *StartButton;
    TButton *StopButton;
    TProgressBar *ProgressBar;
    TMtxFloatEdit *UpdateIntervalEdit;
    TGroupBox *GroupBox1;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TMtxFloatEdit *MinEdit;
    TMtxFloatEdit *MaxEdit;
    TMtxProgressDialog *MtxThread;
  void __fastcall ShowFormBoxClick(TObject *Sender);
  void __fastcall LoopTypeGroupClick(TObject *Sender);
  void __fastcall MtxThreadCompute(TObject *Sender);
  void __fastcall IteratorGroupClick(TObject *Sender);
  void __fastcall MinEditChange(TObject *Sender);
  void __fastcall MaxEditChange(TObject *Sender);
  void __fastcall UpdateIntervalEditChange(TObject *Sender);
  void __fastcall ThreadBoxChange(TObject *Sender);
  void __fastcall StartButtonClick(TObject *Sender);
  void __fastcall StopButtonClick(TObject *Sender);
  void __fastcall MtxThreadProgressUpdate(TObject *Sender,
          TMtxProgressEvent Event);
private:	// User declarations
  Mtxvec::TMatrix *A, *B, *C;
  void __fastcall WhileLoopInProcedure(int &Counter, bool &Cancel);
public:		// User declarations
  __fastcall TfrmProgDialog(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmProgDialog *frmProgDialog;
//---------------------------------------------------------------------------
#endif
