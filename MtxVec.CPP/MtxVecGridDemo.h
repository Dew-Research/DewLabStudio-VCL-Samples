//---------------------------------------------------------------------------
#ifndef MtxVecGridDemoH
#define MtxVecGridDemoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>

#include <MtxGrid.hpp>
#include <MtxExpr.hpp>
//---------------------------------------------------------------------------
class TfrmGridDemo : public TBasicForm2
{
__published:	// IDE-managed Components
  TPanel *Panel4;
  TGroupBox *GroupBox1;
  TCheckBox *CheckBox1;
  TCheckBox *CheckBox2;
  TCheckBox *CheckBox3;
  TCheckBox *CheckBox4;
  TGroupBox *GroupBox2;
  TCheckBox *CheckBox5;
  TLabel *Label1;
  TEdit *Edit1;
  TLabel *Label2;
  TComboBox *ComboBox1;
  TButton *Button1;
  TButton *Button2;
  TCheckBox *CheckBox6;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormShow(TObject *Sender);
  void __fastcall CheckBox1Click(TObject *Sender);
  void __fastcall CheckBox2Click(TObject *Sender);
  void __fastcall CheckBox3Click(TObject *Sender);
  void __fastcall CheckBox4Click(TObject *Sender);
  void __fastcall CheckBox5Click(TObject *Sender);
  void __fastcall CheckBox6Click(TObject *Sender);
  void __fastcall Edit1Change(TObject *Sender);
  void __fastcall ComboBox1Change(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall Button2Click(TObject *Sender);
private:	// User declarations
  TMtxVecGrid *Grid;
  sMatrix testMatrix;
  sVector testVector;
public:		// User declarations
  __fastcall TfrmGridDemo(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmGridDemo *frmGridDemo;
//---------------------------------------------------------------------------
#endif
