//---------------------------------------------------------------------------
#ifndef NumInt1DH
#define NumInt1DH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>

#include <MtxParseClass.hpp>
#include <MtxParseExpr.hpp>
#include <MtxIntDiff.hpp>
#include <MtxExpr.hpp>
#include <Math387.hpp>
#include <MtxVec.hpp>
//---------------------------------------------------------------------------
class TfrmInt1D : public TBasicForm2
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TEdit *Edit1;
  TButton *Button1;
  TGroupBox *GroupBox1;
  TLabel *Label2;
  TEdit *Editlb;
  TLabel *Label3;
  TEdit *Editub;
  TChart *Chart1;
  TLineSeries *Series1;
  TLabel *Label4;
  TComboBox *ComboBox1;
  TLabel *Label5;
  TEdit *EditIntervals;
  TUpDown *UpDown1;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall Button1Click(TObject *Sender);
private:
  TMtxExpression *parser;
  bool __fastcall ExtractFormula(AnsiString &varname);
public:
  __fastcall TfrmInt1D(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmInt1D *frmInt1D;
//---------------------------------------------------------------------------
#endif
