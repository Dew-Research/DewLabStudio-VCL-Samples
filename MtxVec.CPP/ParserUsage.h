//---------------------------------------------------------------------------
#ifndef ParserUsageH
#define ParserUsageH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include "Basic2.h"
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <Contnrs.hpp>

#include <ValueEditorForm.hpp>
#include <MtxParseClass.hpp>
#include <MtxParseExpr.hpp>
#include <MtxBaseComp.hpp>
//---------------------------------------------------------------------------
class TfrmParserUsage : public TBasicForm2
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TMemo *memoExpr;
  TLabel *Label4;
  TListBox *lbVars;
  TButton *btnAddVar;
  TButton *btnDelVar;
  TButton *btnClearVarList;
  TButton *btnSetVar;
  TLabel *Label5;
  TComboBox *cbExamples;
  TLabel *Label6;
  TListBox *lbResults;
  TMemo *memoErrMsg;
  TPageControl *PageControl1;
  TTabSheet *tsConstants;
  TTabSheet *tsFunctions;
  TTabSheet *tsOperators;
  TListBox *lbConstants;
  TListBox *lbFunctions;
  TListBox *lbOperators;
  TButton *btnDetect;
  TSpeedButton *btn0;
  TSpeedButton *btnDot;
  TSpeedButton *btn1;
  TSpeedButton *btn2;
  TSpeedButton *btn3;
  TSpeedButton *btn4;
  TSpeedButton *btn5;
  TSpeedButton *btn6;
  TSpeedButton *btn7;
  TSpeedButton *btn8;
  TSpeedButton *btn9;
  TSpeedButton *btnCloseBracket;
  TSpeedButton *btnOpenBracket;
  TSpeedButton *btnI;
  TButton *btnEvaluate;
  TButton *btnClearExpr;
  TSpeedButton *SpeedButton1;
  TSpeedButton *SpeedButton2;
  TSpeedButton *SpeedButton3;
  TSpeedButton *SpeedButton4;
  TMtxFunctionEvaluator *eval1;
  void __fastcall btnDetectClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall btnEvaluateClick(TObject *Sender);
  void __fastcall btnSetVarClick(TObject *Sender);
  void __fastcall btnAddVarClick(TObject *Sender);
  void __fastcall btnDelVarClick(TObject *Sender);
  void __fastcall btnClearVarListClick(TObject *Sender);
  void __fastcall lbVarsDblClick(TObject *Sender);
  void __fastcall lbVarsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
  void __fastcall btnSymClick(TObject *Sender);
  void __fastcall lbSymbolsDblClick(TObject *Sender);
  void __fastcall btnClearExprClick(TObject *Sender);
  void __fastcall cbExamplesChange(TObject *Sender);
  void __fastcall lbConstantsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
  void __fastcall lbFunctionsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
  void __fastcall lbOperatorsMouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
  void __fastcall FormCreate(TObject *Sender);
private:
  TVariableCollection *fVars;
  TStringList *fConstHelp;
  TStringList *fOperHelp;
  TStringList *fFuncHelp;
  TfmValueEditor *fValueEditor;

  void __fastcall InsertText(const AnsiString &txt);
  void __fastcall EnableControls(bool enabled);
  void __fastcall OnEditOk(TObject *Sender);
  void __fastcall OnEditCancel(TObject *Sender);
  void __fastcall cbExamplesChanged();
  void __fastcall ShowHelp(TListBox *lb, TStrings *help, int x, int y);
public:
  __fastcall TfrmParserUsage(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmParserUsage *frmParserUsage;
//---------------------------------------------------------------------------
#endif
