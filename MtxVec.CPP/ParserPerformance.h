//---------------------------------------------------------------------------
#ifndef ParserPerformanceH
#define ParserPerformanceH
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

#include <MtxComCtrls.hpp>
#include <MtxParseClass.hpp>
#include <MtxParseExpr.hpp>
#include <MtxVec.hpp>
#include <Math387.hpp>
#include <MtxExpr.hpp>
//---------------------------------------------------------------------------
class TfrmParserPerformance : public TBasicForm2
{
__published:	// IDE-managed Components
  TChart *Chart1;
  TEdit *FormulaEdit;
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TBevel *Bevel1;
  TRadioGroup *ComputationGroup;
  TButton *UpdateButton;
  TFastLineSeries *Series1;
  TButton *BenchmarkButtom;
  TLabel *StandardLabel;
  TLabel *vectorLabel;
  TLabel *RatioLabel;
  TMtxFloatEdit *StartXEdit;
  TMtxFloatEdit *StopXEdit;
  TMtxFloatEdit *StepXEdit;
  void __fastcall BenchmarkButtomClick(TObject *Sender);
  void __fastcall UpdateButtonClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall StepXEditChange(TObject *Sender);
  void __fastcall StopXEditChange(TObject *Sender);
  void __fastcall StartXEditChange(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
private:
  void __fastcall UpdateX();
public:
  sVector x, y;
  TVec *yResult;
  TMtxExpression *Expr;
  TValueRec *x1, *y1;
  __fastcall TfrmParserPerformance(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmParserPerformance *frmParserPerformance;
//---------------------------------------------------------------------------
#endif
