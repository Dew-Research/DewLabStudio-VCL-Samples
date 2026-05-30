//---------------------------------------------------------------------------
#ifndef Optim_LPH
#define Optim_LPH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <Grids.hpp>

#include <MtxVecTools.hpp>
#include <MtxBaseComp.hpp>
#include <MtxComCtrls.hpp>
#include <MtxGrid.hpp>
//---------------------------------------------------------------------------
class TfrmLP : public TBasicForm2
{
__published:	// IDE-managed Components
  TMtxLP *MtxLP1;
  TLabel *Label1;
  TComboBox *ComboBox1;
  TCheckBox *CheckBox1;
  TCheckBox *CheckBox2;
  TGroupBox *GroupBox1;
  TLabel *Label2;
  TLabel *Label3;
  TMtxFloatEdit *MtxFloatEdit1;
  TMtxFloatEdit *MtxFloatEdit2;
  TButton *Button1;
  TPanel *Panel4;
  TPanel *Panel5;
  TPanel *Panel6;
  TSplitter *Splitter1;
  TMemo *Memo1;
  TMtxVecGrid *MtxVecGrid1;
  TMtxVecGrid *MtxVecGrid2;
  TMtxVecGrid *MtxVecGrid3;
  TLabel *LabelA;
  TLabel *Label5;
  TLabel *Label4;
  TLabel *Label6;
  TEdit *EditRelations;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall ComboBox1Change(TObject *Sender);
  void __fastcall CheckBox1Click(TObject *Sender);
  void __fastcall MtxFloatEdit1Change(TObject *Sender);
  void __fastcall MtxFloatEdit2Change(TObject *Sender);
  void __fastcall CheckBox2Click(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall EditRelationsChange(TObject *Sender);
private:
  bool formCreating;
public:
  __fastcall TfrmLP(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmLP *frmLP;
//---------------------------------------------------------------------------
#endif
